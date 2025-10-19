# 💳 Ödeme Sistemi Entegrasyonu

Bu dokümantasyon, AI Chat uygulamasında kullanılan ödeme sistemi entegrasyonunu açıklar.

## 🏗️ Sistem Mimarisi

### Backend (Flask)
- **Payment Model**: Ödeme kayıtları ve durumları
- **PremiumPlan Model**: Abonelik planları ve fiyatlandırma
- **UserSubscription Model**: Kullanıcı abonelik takibi
- **API Endpoints**: Ödeme işlemleri için REST API

### Frontend (React)
- **PaymentModal**: Ödeme formu ve işlem modal'ı
- **Premium Page**: Plan seçimi ve ödeme başlatma
- **PaymentTest**: Test ve geliştirme sayfası

## 🔧 Kurulum

### Backend Dependencies
```bash
pip install iyzipay==1.0.45
```

### Environment Variables
```env
# Iyzico API Keys (Sandbox)
IYZICO_API_KEY=your_api_key
IYZICO_SECRET_KEY=your_secret_key
IYZICO_BASE_URL=https://sandbox-api.iyzipay.com

# Production
IYZICO_BASE_URL=https://api.iyzipay.com
```

## 📊 Veritabanı Modelleri

### Payment Model
```python
class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    plan_id = db.Column(db.Integer, db.ForeignKey('premium_plan.id'))
    amount = db.Column(db.Float, nullable=False)
    currency = db.Column(db.String(3), default='TRY')
    status = db.Column(db.String(20), default='pending')
    payment_method = db.Column(db.String(50))
    payment_provider = db.Column(db.String(50))
    transaction_id = db.Column(db.String(100), unique=True)
    payment_url = db.Column(db.Text)
    billing_cycle = db.Column(db.String(10))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
```

### PremiumPlan Model
```python
class PremiumPlan(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    monthly_price = db.Column(db.Float, nullable=False)
    yearly_price = db.Column(db.Float, nullable=False)
    features = db.Column(db.Text)  # JSON string
    max_chats = db.Column(db.Integer, default=-1)
    max_messages_per_day = db.Column(db.Integer, default=-1)
    image_generation_limit = db.Column(db.Integer, default=0)
    video_generation_limit = db.Column(db.Integer, default=0)
    priority_support = db.Column(db.Boolean, default=False)
    advanced_models = db.Column(db.Boolean, default=False)
    is_active = db.Column(db.Boolean, default=True)
```

## 🚀 API Endpoints

### 1. Ödeme Oluştur
```http
POST /api/payment/create
Authorization: Bearer <token>
Content-Type: application/json

{
  "plan_id": 1,
  "billing_cycle": "monthly",
  "payment_method": "credit_card"
}
```

**Response:**
```json
{
  "payment_id": 123,
  "transaction_id": "TXN_1234567890_1",
  "amount": 100.0,
  "currency": "TRY",
  "payment_url": "https://sandbox-api.iyzipay.com/payment/3dsecure/initialize?token=TXN_1234567890_1",
  "status": "pending"
}
```

### 2. Ödeme Doğrula
```http
POST /api/payment/verify
Content-Type: application/json

{
  "transaction_id": "TXN_1234567890_1",
  "status": "success"
}
```

### 3. Ödeme Yöntemleri
```http
GET /api/payment/methods
```

**Response:**
```json
[
  {
    "id": "credit_card",
    "name": "Kredi Kartı",
    "description": "Visa, Mastercard, American Express",
    "icon": "credit-card",
    "available": true
  },
  {
    "id": "bank_transfer",
    "name": "Banka Havalesi",
    "description": "EFT/Havale ile ödeme",
    "icon": "building",
    "available": true
  }
]
```

## 💰 Fiyatlandırma Planları

### Basic Plan
- **Aylık**: ₺100
- **Yıllık**: ₺1,000 (%20 indirim)
- **Özellikler**:
  - Sınırsız sohbet
  - Günlük 100 mesaj
  - Aylık 10 görsel oluşturma
  - Temel AI modelleri
  - E-posta destek

### Pro Plan
- **Aylık**: ₺250
- **Yıllık**: ₺2,500 (%20 indirim)
- **Özellikler**:
  - Sınırsız sohbet
  - Sınırsız mesaj
  - Aylık 50 görsel + 10 video
  - Gelişmiş AI modelleri
  - Öncelikli destek
  - Gelişmiş analitik

### Enterprise Plan
- **Aylık**: ₺500
- **Yıllık**: ₺5,000 (%20 indirim)
- **Özellikler**:
  - Sınırsız her şey
  - Tüm AI modelleri
  - 7/24 öncelikli destek
  - Gelişmiş analitik
  - API erişimi
  - Özel entegrasyonlar

## 🔒 Güvenlik

### SSL/TLS
- Tüm ödeme işlemleri SSL ile şifrelenir
- Kart bilgileri güvenli şekilde işlenir

### 3D Secure
- Iyzico 3D Secure desteği
- Banka doğrulama sistemi

### Veri Koruma
- PCI DSS uyumlu ödeme işleme
- Kişisel verilerin korunması

## 🧪 Test

### Test Sayfası
```
http://localhost:3000/payment-test
```

### Test Senaryoları
1. **Başarılı Ödeme**: Simulated success response
2. **Başarısız Ödeme**: Simulated failure response
3. **Plan Değiştirme**: Mevcut abonelik iptal ve yeni plan
4. **Yıllık/Aylık Geçiş**: Farklı faturalandırma döngüleri

## 🔄 Ödeme Akışı

1. **Plan Seçimi**: Kullanıcı premium plan seçer
2. **Ödeme Modal**: Ödeme yöntemi ve kart bilgileri
3. **Ödeme Oluşturma**: Backend'de payment record oluşturulur
4. **3D Secure**: Iyzico ile güvenli ödeme
5. **Doğrulama**: Ödeme durumu kontrol edilir
6. **Abonelik**: Kullanıcı premium yapılır
7. **Bildirim**: Başarı/hata mesajı gösterilir

## 📱 Frontend Bileşenleri

### PaymentModal
- Ödeme formu
- Kart bilgileri girişi
- Ödeme yöntemi seçimi
- Güvenlik göstergeleri

### Premium Page
- Plan karşılaştırması
- Fiyat hesaplama
- Ödeme başlatma
- FAQ bölümü

## 🛠️ Geliştirme

### Yeni Ödeme Yöntemi Ekleme
1. Backend'de yeni payment method ekle
2. Frontend'de UI component oluştur
3. API endpoint'lerini güncelle
4. Test senaryolarını çalıştır

### Yeni Plan Ekleme
1. `create_premium_plans()` fonksiyonunu güncelle
2. Frontend'de plan kartını ekle
3. Fiyat hesaplamalarını kontrol et

## 📊 Monitoring

### Ödeme Metrikleri
- Başarılı ödeme oranı
- Ortalama ödeme tutarı
- Plan dağılımı
- Aylık/yıllık tercih oranı

### Hata Takibi
- Ödeme hataları
- API timeout'ları
- 3D Secure başarısızlıkları

## 🚀 Production Deployment

### Environment Setup
```bash
# Production environment variables
export IYZICO_API_KEY="prod_api_key"
export IYZICO_SECRET_KEY="prod_secret_key"
export IYZICO_BASE_URL="https://api.iyzipay.com"
```

### Database Migration
```bash
# Yeni modeller için migration
flask db migrate -m "Add payment system"
flask db upgrade
```

### SSL Certificate
- Production'da SSL sertifikası gerekli
- Iyzico production API kullanımı

## 📞 Destek

### Teknik Destek
- Backend API sorunları
- Frontend entegrasyon
- Ödeme işlem hataları

### Müşteri Destek
- Abonelik yönetimi
- Faturalandırma soruları
- Plan değişiklikleri

---

**Not**: Bu sistem şu anda simulated mode'da çalışmaktadır. Production'a geçiş için gerçek Iyzico API anahtarları ve SSL sertifikası gereklidir.
