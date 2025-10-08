# Hugging Face AI Proxy - Supabase Edge Function

## Deployment Instructions

### Option 1: Supabase Dashboard (Easiest)

1. Go to your Supabase Dashboard: https://supabase.com/dashboard
2. Select your project: `lfeyveflpbkrzsoscjcv`
3. Navigate to **Edge Functions** (in left sidebar)
4. Click **Create a new function**
5. Name: `huggingface-proxy`
6. Copy-paste the code from `index.ts`
7. Add environment variable:
   - Key: `HUGGINGFACE_API_TOKEN`
   - Value: Your Hugging Face token
8. Click **Deploy**

### Option 2: Supabase CLI

```bash
# Install Supabase CLI
npm install -g supabase

# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref lfeyveflpbkrzsoscjcv

# Set environment variable
supabase secrets set HUGGINGFACE_API_TOKEN=your_token_here

# Deploy function
supabase functions deploy huggingface-proxy

# Test the function
supabase functions invoke huggingface-proxy --body '{"model":"black-forest-labs/FLUX.1-schnell","inputs":"a cat"}'
```

## Endpoint URL

After deployment, your function will be available at:
```
https://lfeyveflpbkrzsoscjcv.supabase.co/functions/v1/huggingface-proxy
```

## Testing

```bash
curl -X POST https://lfeyveflpbkrzsoscjcv.supabase.co/functions/v1/huggingface-proxy \
  -H "Content-Type: application/json" \
  -d '{
    "model": "black-forest-labs/FLUX.1-schnell",
    "inputs": "a beautiful sunset"
  }'
```

## Features

- ✅ Secures Hugging Face API token server-side
- ✅ CORS enabled for web clients
- ✅ Supports text-to-image models
- ✅ Supports image-to-image models
- ✅ Supports face swap with dual images
- ✅ Automatic content type detection
- ✅ Error handling and logging
