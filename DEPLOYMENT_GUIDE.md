# Web Uygulamasını Yayınlama Rehberi

## 🚀 Hızlı Başlangıç - Ücretsiz Seçenekler

### 1. **Vercel (Önerilen - En Kolay)**
- **Frontend**: Otomatik deploy
- **Backend**: Serverless functions
- **Maliyet**: Ücretsiz
- **Kurulum**: 5 dakika

#### Adımlar:
1. [Vercel.com](https://vercel.com) hesabı oluştur
2. GitHub'a projeyi yükle
3. Vercel'e bağla
4. Otomatik deploy

### 2. **Netlify**
- **Frontend**: Otomatik deploy
- **Backend**: Netlify Functions
- **Maliyet**: Ücretsiz
- **Kurulum**: 10 dakika

### 3. **Railway**
- **Full-stack**: Frontend + Backend
- **Maliyet**: Ücretsiz (sınırlı)
- **Kurulum**: 15 dakika

## 💰 Ücretli Seçenekler (Profesyonel)

### 1. **DigitalOcean**
- **VPS**: $5/ay
- **Tam kontrol**
- **Kurulum**: 30 dakika

### 2. **AWS**
- **EC2**: $3-10/ay
- **S3 + RDS**: Ek maliyet
- **Kurulum**: 1 saat

### 3. **Google Cloud**
- **App Engine**: $0-10/ay
- **Cloud SQL**: Ek maliyet
- **Kurulum**: 45 dakika

## 🔧 Kurulum Hazırlığı

### 1. **Environment Variables**
```bash
# Frontend (.env)
REACT_APP_API_URL=https://your-backend-domain.com
REACT_APP_GOOGLE_CLIENT_ID=your-google-client-id

# Backend (.env)
DATABASE_URL=postgresql://user:pass@host:port/db
JWT_SECRET_KEY=your-secret-key
GOOGLE_CLIENT_ID=your-google-client-id
OPENAI_API_KEY=your-openai-key
```

### 2. **Database Migration**
- SQLite → PostgreSQL/MySQL
- Production database setup

### 3. **Domain Configuration**
- Custom domain setup
- SSL certificate
- DNS configuration

## 📋 Hangi Seçeneği Öneriyorum?

### **Başlangıç için**: Vercel + Railway
- Hızlı kurulum
- Ücretsiz
- Kolay yönetim

### **Profesyonel için**: DigitalOcean VPS
- Tam kontrol
- Uygun fiyat
- Ölçeklenebilir

## 🚀 Hemen Başlayalım!

Hangi seçeneği tercih ediyorsunuz? Size adım adım rehberlik edeyim!
