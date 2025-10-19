# Google OAuth Kurulum Rehberi

## 🚀 Google OAuth Kurulum Rehberi

### 1. Google Cloud Console'da Proje Oluşturma

1. [Google Cloud Console](https://console.cloud.google.com/) adresine gidin
2. Yeni proje oluşturun veya mevcut projeyi seçin
3. Proje adı: "TurkGPT AI Chat" (veya istediğiniz isim)

## 2. OAuth Consent Screen Yapılandırması

1. Sol menüden "APIs & Services" > "OAuth consent screen" seçin
2. "External" seçin ve "Create" butonuna tıklayın
3. Gerekli bilgileri doldurun:
   - **App name**: TurkGPT AI Chat
   - **User support email**: Kendi email adresiniz
   - **Developer contact information**: Kendi email adresiniz
4. "Save and Continue" butonuna tıklayın
5. "Scopes" sayfasında "Save and Continue" butonuna tıklayın
6. "Test users" sayfasında kendi email adresinizi ekleyin
7. "Save and Continue" butonuna tıklayın

## 3. OAuth 2.0 Client ID Oluşturma

1. Sol menüden "APIs & Services" > "Credentials" seçin
2. "Create Credentials" > "OAuth 2.0 Client ID" seçin
3. Application type: "Web application" seçin
4. Name: "TurkGPT Web Client" (veya istediğiniz isim)
5. **Authorized JavaScript origins** ekleyin:
   - `http://localhost:3000`
   - `http://127.0.0.1:3000`
6. **Authorized redirect URIs** ekleyin:
   - `http://localhost:3000`
   - `http://127.0.0.1:3000`
7. "Create" butonuna tıklayın
8. **Client ID**'yi kopyalayın (örnek: `123456789-abcdefg.apps.googleusercontent.com`)

## 4. Environment Dosyası Oluşturma

Frontend klasöründe `.env` dosyası oluşturun:

```bash
# Google OAuth Configuration
REACT_APP_GOOGLE_CLIENT_ID=your-client-id-here

# Backend API URL
REACT_APP_API_URL=http://localhost:5001
```

## 5. Uygulamayı Yeniden Başlatma

```bash
# Frontend'i yeniden başlatın
cd frontend
npm start
```

## 6. Test Etme

1. `http://localhost:3000` adresine gidin
2. "Google ile Giriş" butonuna tıklayın
3. Google hesabınızla giriş yapın
4. Uygulama ana sayfasına yönlendirileceksiniz

## Sorun Giderme

### "This app isn't verified" Hatası
- OAuth consent screen'de "Publishing status" bölümünden "Publish app" butonuna tıklayın
- Veya test kullanıcısı olarak kendi email adresinizi ekleyin

### "redirect_uri_mismatch" Hatası
- Google Cloud Console'da Authorized redirect URIs'yi kontrol edin
- `http://localhost:3000` ve `http://127.0.0.1:3000` eklenmiş olmalı

### "invalid_client" Hatası
- Client ID'nin doğru kopyalandığından emin olun
- .env dosyasının frontend klasöründe olduğundan emin olun

## Güvenlik Notları

- Client ID'yi public repository'de paylaşmayın
- Production'da HTTPS kullanın
- Domain'i production domain'i ile güncelleyin
