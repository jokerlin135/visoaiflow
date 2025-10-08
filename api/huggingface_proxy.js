// Simple Node.js proxy for Hugging Face API
// This protects the API token from being exposed in client-side code

const http = require('http');
const https = require('https');

const HF_TOKEN = process.env.HUGGINGFACE_API_TOKEN;
const PORT = 3000;

const server = http.createServer((req, res) => {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  if (req.method !== 'POST') {
    res.writeHead(405);
    res.end('Method Not Allowed');
    return;
  }

  let body = [];
  req.on('data', chunk => body.push(chunk));
  
  req.on('end', () => {
    try {
      const data = JSON.parse(Buffer.concat(body).toString());
      const { model, inputs, parameters, isBase64Image, isFaceSwap, sourceImage, targetImage } = data;

      if (!model) {
        res.writeHead(400);
        res.end(JSON.stringify({ error: 'Missing model' }));
        return;
      }

      // Determine content type and payload
      let contentType = 'application/json';
      let payload;

      if (isFaceSwap) {
        // Face swap requires both images
        if (!sourceImage || !targetImage) {
          res.writeHead(400);
          res.end(JSON.stringify({ error: 'Face swap requires both sourceImage and targetImage' }));
          return;
        }
        payload = JSON.stringify({
          source_image: sourceImage,
          target_image: targetImage,
        });
      } else if (isBase64Image) {
        // Convert base64 to binary for image-to-image models
        contentType = 'application/octet-stream';
        payload = Buffer.from(inputs, 'base64');
      } else {
        // Text input for text-to-image models
        if (!inputs) {
          res.writeHead(400);
          res.end(JSON.stringify({ error: 'Missing inputs' }));
          return;
        }
        payload = JSON.stringify({ 
          inputs, 
          ...(parameters && { parameters }) 
        });
      }

      // Call Hugging Face API
      const options = {
        hostname: 'api-inference.huggingface.co',
        port: 443,
        path: `/models/${model}`,
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${HF_TOKEN}`,
          'Content-Type': contentType,
        },
      };

      const hfReq = https.request(options, (hfRes) => {
        const chunks = [];
        
        hfRes.on('data', (chunk) => chunks.push(chunk));
        
        hfRes.on('end', () => {
          const buffer = Buffer.concat(chunks);
          
          if (hfRes.headers['content-type']?.includes('image')) {
            res.writeHead(200, { 'Content-Type': 'image/jpeg' });
            res.end(buffer);
          } else {
            res.writeHead(hfRes.statusCode, { 'Content-Type': 'application/json' });
            res.end(buffer);
          }
        });
      });

      hfReq.on('error', (error) => {
        console.error('HF API Error:', error);
        res.writeHead(500);
        res.end(JSON.stringify({ error: error.message }));
      });

      hfReq.write(payload);
      hfReq.end();

    } catch (error) {
      res.writeHead(400);
      res.end(JSON.stringify({ error: 'Invalid JSON' }));
    }
  });
});

server.listen(PORT, () => {
  console.log(`🚀 HuggingFace Proxy running on port ${PORT}`);
});
