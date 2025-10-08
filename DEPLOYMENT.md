# 🚀 Deployment Guide - Supabase Edge Function

## ⚠️ Required: Deploy Edge Function to Supabase

The AI features require a Supabase Edge Function to securely proxy Hugging Face API calls.

### Quick Deploy (Dashboard Method)

1. **Go to Supabase Dashboard**
   - URL: https://supabase.com/dashboard/project/pmewibnkntbcaigkasnz

2. **Navigate to Edge Functions**
   - Click "Edge Functions" in left sidebar
   - Click "Create a new function"

3. **Create Function**
   - Name: `huggingface-proxy`
   - Copy code from: `supabase/functions/huggingface-proxy/index.ts`
   - Paste into editor

4. **Add Environment Variable**
   - Click "Settings" tab
   - Add secret:
     - Key: `HUGGINGFACE_API_TOKEN`
     - Value: [Your Hugging Face token]

5. **Deploy**
   - Click "Deploy function"
   - Wait for deployment to complete

### Advanced Deploy (CLI Method)

```bash
# Install Supabase CLI
npm install -g supabase

# Login
supabase login

# Link to project
supabase link --project-ref pmewibnkntbcaigkasnz

# Set environment variable
supabase secrets set HUGGINGFACE_API_TOKEN=your_token_here

# Deploy
supabase functions deploy huggingface-proxy
```

### Verify Deployment

Test the endpoint:
```bash
curl -X POST https://pmewibnkntbcaigkasnz.supabase.co/functions/v1/huggingface-proxy \
  -H "Content-Type: application/json" \
  -d '{"model":"black-forest-labs/FLUX.1-schnell","inputs":"a cat"}'
```

Should return image data (binary).

## ✅ After Deployment

Once the Edge Function is deployed:

1. **Flutter Web App** - Already configured to use Supabase endpoint
2. **AI Features** - All AI features will work (Face Swap, Headshot, Enhancement, etc.)
3. **Test Page** - Visit `/ai_test` to test all features

## 📱 Mobile Apps (iOS/Android)

For mobile builds, ensure Supabase URL is configured:
- Build with: `flutter build ios --dart-define=SUPABASE_URL=https://pmewibnkntbcaigkasnz.supabase.co`
- Or set in environment before build

## 🔒 Security Notes

- ✅ Hugging Face token is stored securely in Supabase secrets
- ✅ Token never exposed to client-side code
- ✅ CORS enabled for web app access
- ✅ All API calls proxied through Supabase

## 📊 Monitoring

Monitor Edge Function:
- Supabase Dashboard → Edge Functions → `huggingface-proxy`
- View logs, metrics, and errors
- Free tier: 500k requests/month
