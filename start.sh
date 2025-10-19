#!/bin/bash

# TurkGPT Web Arayüzü Başlatma Scripti

echo "🚀 TurkGPT Web Arayüzü Başlatılıyor..."

# Backend'i arka planda başlat
echo "📡 Backend başlatılıyor..."
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py &
BACKEND_PID=$!

# Frontend'i başlat
echo "🎨 Frontend başlatılıyor..."
cd ../frontend
npm install
npm start &
FRONTEND_PID=$!

echo "✅ Uygulama başlatıldı!"
echo "🌐 Frontend: http://localhost:3000"
echo "📡 Backend: http://localhost:5000"
echo ""
echo "Durdurmak için Ctrl+C tuşlayın"

# Graceful shutdown
trap "echo '🛑 Uygulama durduruluyor...'; kill $BACKEND_PID $FRONTEND_PID; exit" INT

# Wait for processes
wait
