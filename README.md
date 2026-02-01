# 🎾 Pickleball Club Management - Vợt Thủ Phố Núi

**Sinh viên**: Phạm Đình Minh Trưởng  
**MSSV**: xxxxx0705  
**Lớp**: CNTT 17-08

Hệ thống quản lý CLB Pickleball hoàn chỉnh với Backend (ASP.NET Core 8 Web API), Frontend (Flutter Mobile/Web), đã được deploy lên Production.

---

## 🌐 Live Demo

### 🔧 Backend API (Render)
- **Production URL**: https://pcm-truong.onrender.com
- **Swagger API Docs**: https://pcm-truong.onrender.com/swagger
- **Platform**: Render (Docker Container)

### 🎨 Frontend Web (Vercel)
- **Production URL**: https://mobile-flutter-1771020705-truong.vercel.app
- **Platform**: Vercel (Static CDN)

### 📦 Source Code
- **GitHub**: https://github.com/PDMtruong2k5/-MOBILE_FLUTTER_1771020705-truong

---

## 📁 Cấu trúc dự án

```
MOBILE_FLUTTER_1771020705-PHAM-DINH-MINH-TRUONG/
├── Backend/              # ASP.NET Core Web API 8.0
│   ├── Controllers/      # 10 API Controllers (incl. AdminController)
│   ├── Models/           # Entity Models
│   ├── Data/             # ApplicationDbContext + Seeder
│   ├── DTOs/             # Data Transfer Objects
│   ├── Hubs/             # SignalR Hub cho Real-time features
│   ├── Services/         # Background Services
│   ├── Dockerfile        # Docker configuration
│   ├── render.yaml       # Render deployment config
│   └── Program.cs        # Config CORS, JWT, Swagger, DI
└── Frontend/             # Flutter Mobile/Web App
    ├── lib/
    │   ├── models/       # Dart models
    │   ├── providers/    # State management (Provider)
    │   ├── screens/      # Màn hình chính (Admin, Booking, Wallet...)
    │   ├── services/     # API Service (Dio) + SignalR Service
    │   └── widgets/      # Reusable widgets & Charts
    ├── build/web/        # Flutter Web build output
    ├── vercel.json       # Vercel deployment config
    └── pubspec.yaml
```

---

## 🛠️ Tech Stack

### Backend
- **Framework**: ASP.NET Core 8 Web API
- **Database**: SQLite (Production) / PostgreSQL (Optional)
- **Authentication**: JWT Bearer Tokens
- **Real-time**: SignalR (WebSockets)
- **API Documentation**: Swagger/OpenAPI
- **Deployment**: Docker + Render.com

### Frontend
- **Framework**: Flutter 3.38.7 (Mobile & Web)
- **State Management**: Provider
- **Networking**: Dio (HTTP Client)
- **Real-time**: SignalR Client
- **Charts**: FL Chart (Admin Dashboard)
- **Storage**: Flutter Secure Storage
- **Deployment**: Vercel (Static CDN)

---

## 🚀 Deployment Architecture

```
┌─────────────┐         HTTPS          ┌──────────────┐
│   Browser   │ ───────────────────────▶│ Vercel CDN   │
│   (User)    │                         │ Flutter Web  │
└─────────────┘                         └──────┬───────┘
                                               │
                                               │ API Calls
                                               │ (HTTPS)
                                               ▼
                                        ┌──────────────┐
                                        │ Render.com   │
                                        │ Docker       │
                                        │ ASP.NET Core │
                                        └──────┬───────┘
                                               │
                                               ▼
                                        ┌──────────────┐
                                        │   SQLite     │
                                        │   Database   │
                                        └──────────────┘
```

### CI/CD Pipeline
- **GitHub** → Push code
- **Render** → Auto-build Docker image → Deploy Backend
- **Vercel** → Auto-deploy Flutter Web → Serve via CDN

---

## 🚀 Hướng dẫn chạy Local

### 1️⃣ Backend API

```bash
cd Backend

# Restore packages
dotnet restore

# Chạy API (Development mode)
dotnet run
```

✅ API URL: `http://localhost:5000`  
✅ Swagger UI: `http://localhost:5000/swagger`

### 2️⃣ Frontend Flutter

**Cấu hình API URL** (Development):
File `Frontend/lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://localhost:5000/api';
```

**Chạy App**:

```bash
cd Frontend

# Lấy dependencies
flutter pub get

# Chạy trên Chrome (Web)
flutter run -d chrome

# Hoặc chạy trên Windows Desktop
flutter run -d windows
```

---

## 👤 Tài khoản Demo

Hệ thống đã có sẵn dữ liệu mẫu. Sử dụng các tài khoản sau để đăng nhập:

| Email | Password | Role | Quyền hạn nổi bật |
|-------|----------|------|-------------------|
| `admin@pcm.com` | `Admin@123` | **Admin** | Truy cập **Admin Dashboard**, quản lý toàn bộ hệ thống |
| `treasurer@pcm.com` | `Treasurer@123` | **Treasurer** | Duyệt nạp tiền, xem **Revenue Chart** |
| `referee@pcm.com` | `Referee@123` | **Referee** | Cập nhật kết quả trận đấu |
| `member1@pcm.com` | `Member@123` | **Member** | Đặt sân, tham gia giải đấu, xem ví cá nhân |

*(Có tổng cộng 17 tài khoản Member từ `member1@pcm.com` đến `member17@pcm.com`)*

---

## 📱 Tính năng Chính

### 💼 Admin Dashboard
- **Tổng quan tài chính**: Xem tổng quỹ CLB, doanh thu tháng này
- **Biểu đồ doanh thu**: Chart trực quan theo dõi thu/chi 12 tháng gần nhất
- **Xét duyệt nạp tiền**: Approve/Reject các yêu cầu nạp tiền từ thành viên
- **Thống kê**: Số lượng thành viên theo hạng (Tier), số booking, giải đấu đang mở

### 🏆 Giải đấu & Booking
- **Đặt sân**: Lịch trực quan, chọn giờ trống, thanh toán bằng ví
- **Recurring Booking**: Đặt sân cố định hàng tuần (chỉ dành cho VIP/Diamond)
- **Giải đấu**:
  - Tự động tạo lịch thi đấu (Round Robin / Knockout)
  - Cập nhật tỉ số Real-time
  - Bảng xếp hạng DUPR

### 💰 Quản lý Ví (Wallet)
- **Nạp tiền**: Upload ảnh bằng chứng chuyển khoản
- **Lịch sử**: Xem chi tiết từng giao dịch (Deposit, Payment, Reward, Refund)
- **Hạng thành viên (Tier)**: Tích điểm để lên hạng (Standard → Silver → Gold → Diamond) để nhận ưu đãi giảm giá sân

### 🔔 Real-time & Tiện ích
- **Thông báo**: Nhận thông báo ngay lập tức khi booking được confirm, nạp tiền thành công, hoặc có lịch thi đấu mới
- **Auto Cancel**: Booking chưa thanh toán sẽ tự hủy sau 15 phút
- **Auto Remind**: Gửi email/notification nhắc lịch trước 24h

---

## � Docker & Deployment

### Build Docker Image

```bash
cd Backend
docker build -t pcm-backend:latest .
docker run -p 8080:8080 pcm-backend:latest
```

### Deploy lên Render

1. Push code lên GitHub
2. Tạo Web Service trên Render.com
3. Cấu hình:
   - **Runtime**: Docker
   - **Dockerfile Path**: `./Backend/Dockerfile`
   - **Docker Context**: `./Backend`
4. Thêm Environment Variables
5. Deploy!

### Deploy Flutter Web lên Vercel

```bash
cd Frontend
flutter build web --release

# Commit build output
git add -f Frontend/build/web
git commit -m "Add Flutter Web build"
git push

# Vercel tự động deploy
```

---

## 🔧 Environment Variables (Production)

### Backend (Render)
```
ASPNETCORE_ENVIRONMENT=Production
Jwt__Key=YourSuperSecretKeyThatIsAtLeast32CharactersLong!@#$%
Jwt__Issuer=PcmBackend
Jwt__Audience=PcmMobileApp
Jwt__ExpireMinutes=1440
ConnectionStrings__DefaultConnection=Data Source=Pcm734Database.db
```

---

## ⚠️ Lưu ý Production

### Render Free Tier
- ⏰ Service sleep sau 15 phút không hoạt động
- 🔄 Database SQLite sẽ reset khi redeploy hoặc sleep
- 💡 **Khuyến nghị**: Chuyển sang PostgreSQL cho persistent data

### Vercel
- 🚀 Auto-deploy mỗi khi push code lên GitHub
- 🌐 CDN global distribution
- ✅ HTTPS tự động

---

## 📚 Tài liệu

- [Hướng dẫn Deploy Backend (Render)](./TLU_Ebook_Flutter/docs/thuc_hanh/HUONG_DAN_DEPLOY_BACKEND.md)
- [API Documentation](https://pcm-truong.onrender.com/swagger)

---

## 🎓 Thông tin sinh viên

**Họ và tên**: Phạm Đình Minh Trưởng  
**MSSV**: 2121050705  
**Lớp**: CNTT 17-08  
**Năm**: 2026  
**Trường**: Đại học Thủy Lợi

---

## 📞 Liên hệ

- **Email**: truongpdm.b21cn705@stu.ptit.edu.vn
- **GitHub**: https://github.com/PDMtruong2k5
- **Project**: https://github.com/PDMtruong2k5/-MOBILE_FLUTTER_1771020705-truong

---

**🎉 Project đã được deploy thành công lên Production!**
