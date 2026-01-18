# ACI-421 - Sistem Manajemen Administrasi Terintegrasi

[![Laravel](https://img.shields.io/badge/Laravel-12.0-FF2D20?style=flat-square&logo=laravel&logoColor=white)](https://laravel.com)
[![Filament](https://img.shields.io/badge/Filament-3.2-FFAA00?style=flat-square&logo=laravel&logoColor=white)](https://filamentphp.com)
[![PHP](https://img.shields.io/badge/PHP-8.2+-777BB4?style=flat-square&logo=php&logoColor=white)](https://php.net)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://mysql.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

---

## Deskripsi Proyek

**ACI-421** adalah sistem manajemen administrasi berbasis web yang dikembangkan menggunakan framework **Laravel 12** dengan **Filament 3.2** sebagai admin panel. Sistem ini dirancang untuk memenuhi kebutuhan organisasi dalam mengelola berbagai aspek operasional secara terintegrasi, meliputi:

- Manajemen inventaris perangkat IT
- Sistem helpdesk tiket dukungan teknis
- Peminjaman kendaraan dinas operasional (KDO)
- Manajemen artikel/konten
- Manajemen pengguna dengan role-based access control

Aplikasi ini dikembangkan sebagai bagian dari **Proyek Magang Industri** dengan tujuan memberikan solusi digitalisasi proses administrasi yang efisien, user-friendly, dan dapat diakses secara real-time.

---

## Daftar Isi

- [Fitur Utama](#fitur-utama)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Arsitektur Sistem](#arsitektur-sistem)
- [Instalasi](#instalasi)
- [Konfigurasi](#konfigurasi)
- [Penggunaan](#penggunaan)
- [Modul-Modul Sistem](#modul-modul-sistem)
- [API Documentation](#api-documentation)
- [Keamanan](#keamanan)
- [Performa](#performa)
- [Kontributor](#kontributor)

---

## Fitur Utama

### 1. Manajemen Inventaris Perangkat IT
- Pencatatan lengkap perangkat (Laptop, Desktop, All-in-One, Workstation)
- Tracking spesifikasi hardware (Processor, RAM, Storage, OS)
- Pengelolaan informasi jaringan (IP Address, MAC Address, Hostname)
- Monitoring garansi dan kondisi perangkat
- Sistem atribut dinamis yang dapat dikustomisasi
- Penugasan perangkat ke pengguna
- Import/Export data via Excel

### 2. Sistem Helpdesk & Tiket Dukungan
- Pembuatan tiket otomatis dengan nomor unik (TKT-YYYYMMDD-XXXX)
- Kategori tiket: Hardware, Software, Jaringan, Printer, Lainnya
- Level prioritas: Kritis, Tinggi, Sedang, Rendah
- Workflow status: Dibuka → Diproses → Menunggu User → Selesai → Ditutup
- Penugasan tiket ke teknisi IT
- Sistem lampiran file (foto kerusakan, dokumen pendukung)
- Notifikasi real-time untuk update status
- Chat/respons dalam tiket
- Dashboard statistik tiket

### 3. Peminjaman Kendaraan Dinas Operasional (KDO)
- Pendaftaran dan manajemen armada kendaraan
- Sistem booking dengan nomor unik (KDO-YYYYMMDD-XXXX)
- Validasi ketersediaan kendaraan real-time
- Pencatatan surat tugas/perjalanan dinas
- Tracking odometer dan level BBM
- Pelaporan kondisi kendaraan saat pengembalian
- Kalender visual ketersediaan kendaraan
- Monitoring masa berlaku pajak dan KIR
- Notifikasi untuk booking yang belum dikembalikan

### 4. Manajemen Artikel/Konten
- Editor konten dengan rich text
- Manajemen gambar featured dengan konversi otomatis
- Status artikel: Draft, Published, Archived
- Kategori artikel
- Statistik view/kunjungan
- SEO-friendly dengan auto-generate slug
- API endpoints untuk integrasi frontend

### 5. Manajemen Pengguna & Hak Akses
- Autentikasi berbasis NIP (Nomor Induk Pegawai)
- Login dengan Google OAuth
- Two-Factor Authentication (2FA)
- Role-Based Access Control (RBAC)
- Manajemen role dan permission
- User impersonation untuk admin
- Profil pengguna dengan avatar

### 6. Dashboard & Statistik
- Widget statistik tiket real-time
- Widget statistik peminjaman kendaraan
- Widget inventaris perangkat
- Kalender ketersediaan kendaraan
- Daftar tiket terbaru
- Booking aktif pengguna

---

## Teknologi yang Digunakan

### Backend
| Teknologi | Versi | Deskripsi |
|-----------|-------|-----------|
| PHP | 8.2+ | Bahasa pemrograman server-side |
| Laravel | 12.0 | Framework PHP untuk aplikasi web |
| Filament | 3.2 | Admin panel builder untuk Laravel |
| MySQL | 8.0 | Relational Database Management System |

### Frontend
| Teknologi | Deskripsi |
|-----------|-----------|
| Tailwind CSS | Utility-first CSS framework |
| Alpine.js | Lightweight JavaScript framework |
| Livewire | Full-stack framework untuk Laravel |
| Vite | Build tool dan dev server |

### Package Utama
| Package | Fungsi |
|---------|--------|
| `filament/filament` | Admin panel framework |
| `filament/spatie-laravel-media-library-plugin` | Manajemen media/gambar |
| `filament/spatie-laravel-settings-plugin` | Manajemen pengaturan aplikasi |
| `bezhansalleh/filament-shield` | Role & permission management |
| `jeffgreco13/filament-breezy` | Autentikasi & profil pengguna |
| `dutchcodingcompany/filament-socialite` | Social login (Google OAuth) |
| `laravel/sanctum` | API authentication |
| `spatie/laravel-permission` | RBAC system |
| `pxlrbt/filament-excel` | Import/Export Excel |
| `dedoc/scramble` | Auto-generate API documentation |
| `stechstudio/filament-impersonate` | User impersonation |
| `resend/resend-laravel` | Email service |

---

## Arsitektur Sistem

```
+---------------------------------------------------------------------+
|                         CLIENT LAYER                                 |
+---------------------------------------------------------------------+
|  Browser (Admin Panel)  |  Mobile App (API)  |  External System     |
+--------------+----------+---------+----------+-----------+----------+
               |                    |                      |
               v                    v                      v
+---------------------------------------------------------------------+
|                      APPLICATION LAYER                               |
+---------------------------------------------------------------------+
|  +-------------+    +-------------+    +-------------+              |
|  |  Filament   |    |   Livewire  |    |  REST API   |              |
|  |   Admin     |    |  Components |    |  Endpoints  |              |
|  +-------------+    +-------------+    +-------------+              |
+---------------------------------------------------------------------+
|  +-------------+    +-------------+    +-------------+              |
|  |  Resources  |    |   Widgets   |    |   Pages     |              |
|  +-------------+    +-------------+    +-------------+              |
+--------------+------------------------------------------------------+
               |
               v
+---------------------------------------------------------------------+
|                       BUSINESS LAYER                                 |
+---------------------------------------------------------------------+
|  +-------------+    +-------------+    +-------------+              |
|  |   Models    |    |  Observers  |    |   Policies  |              |
|  +-------------+    +-------------+    +-------------+              |
+---------------------------------------------------------------------+
|  +-------------+    +-------------+    +-------------+              |
|  |   Services  |    |    Jobs     |    |   Events    |              |
|  +-------------+    +-------------+    +-------------+              |
+--------------+------------------------------------------------------+
               |
               v
+---------------------------------------------------------------------+
|                        DATA LAYER                                    |
+---------------------------------------------------------------------+
|  +-------------+    +-------------+    +-------------+              |
|  |   MySQL     |    |    Cache    |    |   Storage   |              |
|  |  Database   |    |   (File)    |    |   (Media)   |              |
|  +-------------+    +-------------+    +-------------+              |
+---------------------------------------------------------------------+
```

### Entity Relationship Diagram (ERD) Sederhana

```
+----------------+         +----------------+         +----------------+
|     Users      |         |    Devices     |         |    Tickets     |
+----------------+         +----------------+         +----------------+
| id             |<--+     | id             |<--+     | id             |
| nip            |   |     | user_id        |---+     | ticket_number  |
| name           |   |     | type           |   +---->| user_id        |
| email          |   |     | hostname       |   |     | device_id      |
| phone          |   +-----| brand/model    |   |     | assigned_to    |
| avatar         |         | specs...       |   |     | category       |
| password       |         | status         |   |     | priority       |
+----------------+         +----------------+   |     | status         |
       |                                        |     +----------------+
       |                                        |            |
       |         +----------------+             |            |
       |         |    Vehicles    |             |            v
       |         +----------------+             |     +----------------+
       |         | id             |<--+         |     |TicketResponses |
       |         | plate_number   |   |         |     +----------------+
       |         | brand/model    |   |         |     | id             |
       |         | capacity       |   |         |     | ticket_id      |
       |         | status         |   |         |     | user_id        |
       |         +----------------+   |         |     | message        |
       |                              |         |     +----------------+
       |         +----------------+   |         |
       +-------->|VehicleBookings |   |         |
                 +----------------+   |         |
                 | id             |   |         |
                 | booking_number |   |         |
                 | user_id        |---+         |
                 | vehicle_id     |-------------+
                 | status         |
                 | start/end_date |
                 +----------------+
```

---

## Instalasi

### Prasyarat
- PHP >= 8.2
- Composer
- Node.js >= 18.x & NPM
- MySQL >= 8.0
- Git

### Langkah Instalasi

1. **Clone Repository**
   ```bash
   git clone https://github.com/username/aci-421.git
   cd aci-421
   ```

2. **Install Dependencies**
   ```bash
   composer install
   npm install
   ```

3. **Setup Environment**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Konfigurasi Database**

   Edit file `.env`:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=aci_421
   DB_USERNAME=root
   DB_PASSWORD=
   ```

5. **Jalankan Migrasi & Seeder**
   ```bash
   php artisan migrate --seed
   ```

6. **Setup Storage Link**
   ```bash
   php artisan storage:link
   ```

7. **Generate Shield Permissions**
   ```bash
   php artisan shield:generate --all --panel=admin
   ```

8. **Build Assets**
   ```bash
   npm run build
   ```

9. **Jalankan Server Development**
   ```bash
   composer run dev
   ```

10. **Akses Aplikasi**
    - URL: `http://localhost:8000`
    - Login dengan kredensial default (lihat seeder)

---

## Konfigurasi

### Environment Variables Penting

```env
# Aplikasi
APP_NAME="ACI - 421"
APP_ENV=local
APP_DEBUG=false
APP_URL=http://localhost:8000

# Database
DB_CONNECTION=mysql
DB_DATABASE=aci_421

# Cache & Session (Rekomendasi Production: redis)
CACHE_STORE=file
SESSION_DRIVER=file
QUEUE_CONNECTION=database

# Google OAuth (Opsional)
GOOGLE_CLIENT_ID=your-client-id
GOOGLE_CLIENT_SECRET=your-client-secret
GOOGLE_REDIRECT_URI=http://localhost:8000/admin/oauth/callback/google

# Email (Resend)
MAIL_MAILER=resend
RESEND_API_KEY=your-api-key
```

### Optimasi Production

```bash
# Cache konfigurasi
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan icons:cache

# Jalankan queue worker
php artisan queue:work
```

---

## Penggunaan

### Login Sistem

Sistem menggunakan **NIP (Nomor Induk Pegawai)** sebagai identitas login utama:

1. Masukkan NIP (9 digit)
2. Masukkan Password
3. Opsional: Gunakan "Login dengan Google"

### Role & Permission

| Role | Akses |
|------|-------|
| **Super Admin** | Akses penuh ke seluruh sistem |
| **Admin** | Manajemen tiket, perangkat, dan booking |
| **User** | Membuat tiket, booking kendaraan, melihat perangkat sendiri |

### Workflow Tiket

```
[User membuat tiket]
        |
        v
   +---------+
   |  OPEN   | <-- Tiket baru dibuat
   +----+----+
        |
        v (Admin assign)
   +-------------+
   | IN_PROGRESS | <-- Sedang ditangani
   +------+------+
          |
          v (Butuh info dari user)
   +------------------+
   | WAITING_FOR_USER | <-- Menunggu respons user
   +--------+---------+
            |
            v (Masalah terselesaikan)
       +----------+
       | RESOLVED | <-- Tiket selesai
       +----+-----+
            |
            v (Konfirmasi)
        +--------+
        | CLOSED | <-- Tiket ditutup
        +--------+
```

### Workflow Peminjaman Kendaraan

```
[User membuat booking]
        |
        v
   +----------+
   | APPROVED | <-- Booking disetujui
   +----+-----+
        |
        v (Kendaraan diambil)
     +--------+
     | IN_USE | <-- Kendaraan sedang digunakan
     +---+----+
         |
         v (Kendaraan dikembalikan)
   +-----------+
   | COMPLETED | <-- Peminjaman selesai
   +-----------+

        atau

   +-----------+
   | CANCELLED | <-- Dibatalkan dengan alasan
   +-----------+
```

---

## Modul-Modul Sistem

### 1. Modul Inventaris Perangkat

**Lokasi:** `app/Filament/Resources/DeviceResource.php`

**Fitur:**
- CRUD perangkat dengan form komprehensif
- Filter berdasarkan tipe, status, kondisi, pengguna
- Pencarian berdasarkan hostname, IP, serial number
- Relasi ke tiket (riwayat masalah perangkat)
- Atribut dinamis untuk fleksibilitas data
- Export/Import Excel

**Tabel Database:** `devices`, `device_attributes`, `device_attribute_values`

**Field Utama:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| type | enum | Laptop, Desktop, All-in-One, Workstation |
| hostname | string | Nama komputer dalam jaringan |
| ip_address | string | Alamat IP perangkat |
| mac_address | string | MAC Address network adapter |
| brand | string | Merek perangkat (Dell, HP, Lenovo, dll) |
| model | string | Model/seri perangkat |
| serial_number | string | Nomor seri unik |
| processor | string | Spesifikasi processor |
| ram | string | Kapasitas RAM |
| storage_type | enum | SSD, HDD, NVMe, Hybrid |
| storage_capacity | string | Kapasitas penyimpanan |
| os | string | Sistem operasi |
| condition | enum | Excellent, Good, Fair, Poor, Broken |
| status | enum | Active, Inactive, Maintenance, Retired |
| warranty_expiry | date | Tanggal berakhir garansi |

### 2. Modul Helpdesk Tiket

**Lokasi:** `app/Filament/Resources/TicketResource.php`

**Fitur:**
- Form tiket dengan rich text editor
- Upload lampiran (maks. 5 file @ 5MB)
- Pilihan perangkat terkait atau perangkat eksternal
- Quick actions: Tugaskan, Selesaikan, Tutup
- Navigation badge untuk tiket aktif
- Filter multi-kriteria
- Widget statistik di dashboard
- Notifikasi otomatis ke admin dan user

**Tabel Database:** `tickets`, `ticket_responses`, `ticket_attachments`

**Field Utama:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| ticket_number | string | Nomor tiket unik (auto-generate) |
| user_id | foreign | Pelapor tiket |
| device_id | foreign | Perangkat terkait (opsional) |
| assigned_to | foreign | Teknisi yang ditugaskan |
| category | enum | Hardware, Software, Network, Printer, Other |
| priority | enum | Critical, High, Medium, Low |
| subject | string | Judul/ringkasan masalah |
| description | text | Deskripsi detail masalah |
| status | enum | Open, In Progress, Waiting, Resolved, Closed |
| resolution_notes | text | Catatan penyelesaian |
| is_external_device | boolean | Flag untuk perangkat luar |

### 3. Modul Peminjaman Kendaraan

**Lokasi:** `app/Filament/Resources/VehicleBookingResource.php`

**Fitur:**
- Kalender visual ketersediaan
- Validasi konflik jadwal real-time
- Form booking dengan detail perjalanan
- Tracking odometer dan BBM
- Pelaporan kondisi saat pengembalian
- Notifikasi booking belum dikembalikan

**Tabel Database:** `vehicles`, `vehicle_bookings`

**Field Vehicle:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| plate_number | string | Nomor polisi kendaraan |
| brand | string | Merek kendaraan |
| model | string | Model kendaraan |
| year | integer | Tahun pembuatan |
| color | string | Warna kendaraan |
| capacity | integer | Kapasitas penumpang |
| fuel_type | enum | Petrol, Diesel, Electric |
| ownership | enum | Government, Rental |
| tax_expiry | date | Tanggal berakhir pajak |
| inspection_expiry | date | Tanggal berakhir KIR |
| condition | enum | Excellent, Good, Fair, Poor |
| status | enum | Available, In Use, Maintenance |

**Field Booking:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| booking_number | string | Nomor booking unik (auto-generate) |
| user_id | foreign | Peminjam kendaraan |
| vehicle_id | foreign | Kendaraan yang dipinjam |
| official_letter_number | string | Nomor surat tugas |
| destination | string | Tujuan perjalanan |
| purpose | text | Keperluan perjalanan |
| passenger_list | text | Daftar penumpang |
| driver_name | string | Nama pengemudi |
| start_date | datetime | Waktu mulai peminjaman |
| end_date | datetime | Waktu selesai peminjaman |
| departure_time | time | Jam keberangkatan |
| start_odometer | integer | KM awal |
| end_odometer | integer | KM akhir |
| fuel_level_start | enum | Level BBM awal |
| fuel_level_end | enum | Level BBM akhir |
| return_condition | text | Kondisi saat pengembalian |
| status | enum | Approved, In Use, Completed, Cancelled |

### 4. Modul Artikel/Konten

**Lokasi:** `app/Filament/Resources/ArticleResource.php`

**Fitur:**
- Rich text editor untuk konten
- Manajemen gambar dengan Spatie Media Library
- Konversi gambar otomatis (thumbnail, preview, featured)
- Kategori dan status artikel
- Counter view/kunjungan
- API endpoints untuk frontend

**Tabel Database:** `articles`, `categories`, `media`

**Field Utama:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| title | string | Judul artikel |
| slug | string | URL-friendly slug (auto-generate) |
| content | longtext | Isi artikel (rich text) |
| author_name | string | Nama penulis |
| category_id | foreign | Kategori artikel |
| status | enum | Draft, Published, Archived |
| published_at | datetime | Tanggal publikasi |
| views | integer | Jumlah kunjungan |
| featured_image | media | Gambar utama artikel |

### 5. Modul Manajemen Pengguna

**Lokasi:** `app/Filament/Resources/UserResource.php`

**Fitur:**
- CRUD pengguna dengan validasi NIP
- Upload avatar
- Penugasan role
- Export data pengguna
- Impersonation untuk troubleshooting

**Tabel Database:** `users`, `roles`, `permissions`, `model_has_roles`

**Field Utama:**
| Field | Tipe | Deskripsi |
|-------|------|-----------|
| nip | string(9) | Nomor Induk Pegawai (unik) |
| name | string | Nama lengkap |
| email | string | Alamat email |
| phone | string | Nomor telepon |
| avatar | string | Path foto profil |
| password | string | Password (hashed) |
| email_verified_at | datetime | Waktu verifikasi email |

---

## API Documentation

### Endpoint Tersedia

| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/articles` | List artikel dengan pagination |
| GET | `/api/articles/{id}` | Detail artikel |
| POST | `/api/articles` | Buat artikel baru |
| PATCH | `/api/articles/{id}` | Update artikel |
| DELETE | `/api/articles/{id}` | Hapus artikel |

### Autentikasi API

Menggunakan Laravel Sanctum dengan Bearer Token:

```bash
curl -X GET "http://localhost:8000/api/articles" \
     -H "Authorization: Bearer YOUR_API_TOKEN" \
     -H "Accept: application/json"
```

### Contoh Response

```json
{
  "data": [
    {
      "id": 1,
      "title": "Judul Artikel",
      "slug": "judul-artikel",
      "content": "Isi artikel...",
      "author_name": "John Doe",
      "status": "published",
      "views": 150,
      "published_at": "2026-01-15T10:00:00Z",
      "created_at": "2026-01-10T08:30:00Z"
    }
  ],
  "meta": {
    "current_page": 1,
    "last_page": 5,
    "per_page": 15,
    "total": 73
  }
}
```

### Dokumentasi Interaktif

Akses dokumentasi API otomatis di:
```
http://localhost:8000/docs/api
```

---

## Keamanan

### Fitur Keamanan Terimplementasi

1. **Autentikasi Multi-Layer**
   - Login berbasis NIP + Password
   - Two-Factor Authentication (2FA)
   - Social Login dengan OAuth 2.0
   - Rate limiting (5 percobaan login)

2. **Otorisasi Granular**
   - Role-Based Access Control (RBAC)
   - Permission per resource & action
   - Query scoping berdasarkan role

3. **Proteksi Data**
   - Password hashing dengan Bcrypt
   - CSRF protection
   - SQL injection prevention (Eloquent ORM)
   - XSS prevention (Blade escaping)

4. **Session Management**
   - Secure session handling
   - Session timeout
   - Remember me dengan token aman

---

## Performa

### Optimasi yang Diterapkan

1. **Database**
   - Index pada kolom yang sering di-query
   - Composite index untuk query kompleks
   - Eager loading untuk mencegah N+1 queries

2. **Caching**
   - Navigation badge caching (TTL: 2 menit)
   - Device attribute caching (TTL: 30 menit)
   - Config, route, dan view caching

3. **Frontend**
   - Asset minification dengan Vite
   - Chunk splitting untuk vendor libraries
   - Image conversion dengan queue

4. **Query Optimization**
   - Database transaction untuk operasi kritikal
   - Row locking untuk mencegah race condition
   - Pagination pada list data besar

---

## Struktur Direktori

```
aci-421/
|-- app/
|   |-- Filament/
|   |   |-- Pages/           # Custom pages (Login, Register, Settings)
|   |   |-- Resources/       # CRUD resources (Ticket, Device, Vehicle, dll)
|   |   +-- Widgets/         # Dashboard widgets
|   |-- Models/              # Eloquent models
|   |-- Observers/           # Model observers (Ticket, VehicleBooking)
|   +-- Providers/           # Service providers
|-- config/                  # Configuration files
|-- database/
|   |-- migrations/          # Database migrations
|   +-- seeders/             # Database seeders
|-- public/                  # Public assets
|-- resources/
|   |-- css/                 # Stylesheets
|   |-- js/                  # JavaScript
|   +-- views/               # Blade templates
|-- routes/                  # Route definitions
|-- storage/                 # File storage
+-- tests/                   # Test files
```

---

## Kontributor

| Nama | Role | Kontribusi |
|------|------|------------|
| [Nama Mahasiswa] | Developer | Pengembangan fitur utama |
| [Nama Pembimbing] | Supervisor | Bimbingan teknis |

---

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

## Referensi

- [Laravel Documentation](https://laravel.com/docs)
- [Filament Documentation](https://filamentphp.com/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Spatie Laravel Permission](https://spatie.be/docs/laravel-permission)
- [Spatie Laravel Media Library](https://spatie.be/docs/laravel-medialibrary)

---

## Acknowledgments

Proyek ini dikembangkan berdasarkan [Kaido Kit](https://github.com/siubie/kaido-kit) - FilamentPHP Starter Kit oleh [siubie](https://github.com/siubie).

---

**Dikembangkan sebagai Proyek Magang Industri**

*Dokumen ini terakhir diperbarui: Januari 2026*
