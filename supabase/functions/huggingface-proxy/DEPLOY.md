# Deploy Hugging Face Proxy Edge Function

## 🚀 Quick Deploy Guide

### Prerequisites
- Supabase account with project: `lfeyveflpbkrzsoscjcv`
- Hugging Face API token
- Supabase CLI installed

### Step 1: Install Supabase CLI (if not installed)

**Windows:**
```powershell
scoop install supabase
```

**Mac/Linux:**
```bash
brew install supabase/tap/supabase
```

### Step 2: Login to Supabase
```bash
supabase login
```

### Step 3: Link to Your Project
```bash
cd supabase/functions/huggingface-proxy
supabase link --project-ref lfeyveflpbkrzsoscjcv
```

### Step 4: Set Secret (Hugging Face Token)
```bash
supabase secrets set HUGGINGFACE_API_TOKEN=hf_your_token_here
```

### Step 5: Deploy Function
```bash
supabase functions deploy huggingface-proxy
```

### Step 6: Verify Deployment
The function should be available at:
```
https://lfeyveflpbkrzsoscjcv.supabase.co/functions/v1/huggingface-proxy
```

Test with curl:
```bash
curl -X POST \
  https://lfeyveflpbkrzsoscjcv.supabase.co/functions/v1/huggingface-proxy \
  -H "Content-Type: application/json" \
  -d '{
    "model": "stabilityai/stable-diffusion-2-1",
    "inputs": "a beautiful sunset over mountains"
  }'
```

## 📝 Environment Variables

Make sure these secrets are set in your Supabase project:
- `HUGGINGFACE_API_TOKEN` - Your Hugging Face API token

## ❓ Troubleshooting

### Error: Function not found
- Make sure you're in the correct directory
- Check project ref is correct: `lfeyveflpbkrzsoscjcv`

### Error: Unauthorized
- Verify your Supabase login: `supabase login`
- Check you have permissions on the project

### Error: HUGGINGFACE_API_TOKEN not set
- Run: `supabase secrets set HUGGINGFACE_API_TOKEN=your_token`

## 🔄 Update Function

To update after code changes:
```bash
supabase functions deploy huggingface-proxy --no-verify-jwt
```

## 🔗 Useful Links
- [Supabase Functions Docs](https://supabase.com/docs/guides/functions)
- [Hugging Face Inference API](https://huggingface.co/docs/api-inference/index)
