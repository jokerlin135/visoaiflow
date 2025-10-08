# 🚀 AI Features Setup Guide

## Bước 1: Pull Code Mới
```bash
cd F:\replitcode\visoaiflow
git pull origin main
```

## Bước 2: Deploy Supabase Edge Function

### 2.1. Cài Supabase CLI (nếu chưa có)
```powershell
scoop install supabase
```

### 2.2. Login
```bash
supabase login
```

### 2.3. Link project
```bash
supabase link --project-ref pmewibnkntbcaigkasnz
```

### 2.4. Lấy Hugging Face API Token
1. Truy cập: https://huggingface.co/settings/tokens
2. Tạo token mới (hoặc copy token hiện có)

### 2.5. Set Secret
```bash
supabase secrets set HUGGINGFACE_API_TOKEN=hf_your_actual_token_here
```

### 2.6. Deploy Function (QUAN TRỌNG: có flag --no-verify-jwt)
```bash
supabase functions deploy huggingface-proxy --no-verify-jwt
```

## Bước 3: Build APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```

## Bước 4: Test
1. Cài APK vào điện thoại
2. Mở app
3. Click "🧪 AI Test Lab" button trên homepage
4. Thử các tính năng:
   - AI Headshot (nhập prompt)
   - Face Swap (chọn 2 ảnh)
   - HD Enhancement (chọn 1 ảnh)
   - Fix Old Photo (chọn ảnh cũ)
   - AI Avatar (nhập prompt)

## ✅ Nếu thành công:
- Ảnh AI sẽ được generate và hiển thị
- Click "Download" để lưu vào gallery

## ❌ Nếu vẫn lỗi:
1. Check Edge Function có deploy đúng không:
   ```bash
   supabase functions list
   ```
   
2. Test Edge Function trực tiếp:
   ```bash
   curl -X POST https://pmewibnkntbcaigkasnz.supabase.co/functions/v1/huggingface-proxy \
     -H "Content-Type: application/json" \
     -d '{"model":"stabilityai/stable-diffusion-2-1","inputs":"a cat"}'
   ```

3. Check logs:
   ```bash
   supabase functions logs huggingface-proxy
   ```

## 📝 Ghi chú:
- Edge Function URL: `https://pmewibnkntbcaigkasnz.supabase.co/functions/v1/huggingface-proxy`
- HF API token được bảo mật server-side (không expose cho client)
- App không cần authentication để gọi Edge Function
