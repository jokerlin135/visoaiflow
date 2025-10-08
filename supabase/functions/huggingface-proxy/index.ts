// Supabase Edge Function for Hugging Face API Proxy
// Deno runtime - secures HF token server-side

import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const HF_TOKEN = Deno.env.get('HUGGINGFACE_API_TOKEN')!
const CORS_HEADERS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: CORS_HEADERS })
  }

  try {
    const { model, inputs, parameters, isBase64Image, isFaceSwap, sourceImage, targetImage } = await req.json()

    if (!model) {
      return new Response(
        JSON.stringify({ error: 'Missing model parameter' }),
        { status: 400, headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' } }
      )
    }

    // Determine content type and payload
    let contentType = 'application/json'
    let payload: Uint8Array | string

    if (isFaceSwap) {
      // Face swap requires both images
      if (!sourceImage || !targetImage) {
        return new Response(
          JSON.stringify({ error: 'Face swap requires both sourceImage and targetImage' }),
          { status: 400, headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' } }
        )
      }
      payload = JSON.stringify({
        source_image: sourceImage,
        target_image: targetImage,
      })
    } else if (isBase64Image) {
      // Convert base64 to binary for image-to-image models
      contentType = 'application/octet-stream'
      const base64Data = inputs.replace(/^data:image\/\w+;base64,/, '')
      const binaryString = atob(base64Data)
      const bytes = new Uint8Array(binaryString.length)
      for (let i = 0; i < binaryString.length; i++) {
        bytes[i] = binaryString.charCodeAt(i)
      }
      payload = bytes
    } else {
      // Text input for text-to-image models
      if (!inputs) {
        return new Response(
          JSON.stringify({ error: 'Missing inputs parameter' }),
          { status: 400, headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' } }
        )
      }
      payload = JSON.stringify({
        inputs,
        ...(parameters && { parameters }),
      })
    }

    // Call Hugging Face API
    const hfResponse = await fetch(`https://api-inference.huggingface.co/models/${model}`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${HF_TOKEN}`,
        'Content-Type': contentType,
      },
      body: payload,
    })

    const hfData = await hfResponse.arrayBuffer()

    // Return image response
    if (hfResponse.headers.get('content-type')?.includes('image')) {
      return new Response(hfData, {
        status: 200,
        headers: {
          ...CORS_HEADERS,
          'Content-Type': 'image/jpeg',
        },
      })
    }

    // Return JSON response
    return new Response(hfData, {
      status: hfResponse.status,
      headers: {
        ...CORS_HEADERS,
        'Content-Type': 'application/json',
      },
    })

  } catch (error) {
    console.error('Edge Function Error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' } }
    )
  }
})
