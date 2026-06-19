-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 8.4.3 - MySQL Community Server - GPL
-- OS Server:                    Win64
-- HeidiSQL Versi:               12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Membuang struktur basisdata untuk kaido_kit
CREATE DATABASE IF NOT EXISTS `kaido_kit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kaido_kit`;

-- membuang struktur untuk table kaido_kit.articles
CREATE TABLE IF NOT EXISTS `articles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `published_at` timestamp NULL DEFAULT NULL,
  `featured_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `articles_slug_unique` (`slug`),
  KEY `articles_user_id_foreign` (`user_id`),
  KEY `articles_category_id_foreign` (`category_id`),
  KEY `articles_status_index` (`status`),
  KEY `articles_published_at_index` (`published_at`),
  KEY `articles_views_index` (`views`),
  KEY `articles_status_published_at_index` (`status`,`published_at`),
  CONSTRAINT `articles_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `articles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.articles: ~62 rows (lebih kurang)
DELETE FROM `articles`;
INSERT INTO `articles` (`id`, `user_id`, `title`, `slug`, `author_name`, `content`, `category`, `status`, `published_at`, `featured_image`, `views`, `created_at`, `updated_at`, `category_id`) VALUES
	(11, 109, 'Tips Merawat Laptop Kantor Agar Awet dan Optimal', 'tips-merawat-laptop-kantor-agar-awet-dan-optimal', 'Tim IT Support', '<p>Laptop adalah salah satu aset paling penting di lingkungan kerja. Perawatan rutin tidak hanya memperpanjang usia perangkat, tetapi juga memastikan pekerjaan tidak terhambat akibat kerusakan mendadak.</p>\n\n<h2>1. Bersihkan Layar dan Keyboard Secara Berkala</h2>\n<p>Gunakan kain microfiber yang sedikit dibasahi cairan pembersih khusus layar. Untuk keyboard, manfaatkan kuas halus atau blower kecil agar debu di sela-sela tombol tidak mengganggu fungsi tombol.</p>\n\n<h2>2. Hindari Meletakkan Laptop di Permukaan Lunak</h2>\n<p>Bantal, kasur, atau pangkuan dapat menutup ventilasi udara dan menyebabkan laptop cepat panas. Gunakan meja yang rata atau cooling pad ketika beban kerja tinggi.</p>\n\n<h2>3. Jaga Siklus Baterai</h2>\n<p>Lepas charger ketika baterai sudah penuh dan hindari membiarkan laptop benar-benar mati karena baterai habis. Untuk laptop yang lebih sering digunakan dengan adaptor, banyak vendor menyediakan mode <em>battery care</em> untuk menjaga kapasitas tetap pada 80%.</p>\n\n<h2>4. Update Sistem Operasi dan Antivirus</h2>\n<p>Pembaruan keamanan menutup celah yang dapat dimanfaatkan pelaku kejahatan siber. Pastikan Windows Update dan antivirus selalu aktif. Jika ragu, hubungi tim IT melalui sistem helpdesk.</p>\n\n<h2>5. Lapor Sejak Dini Jika Ada Gejala Aneh</h2>\n<p>Suara kipas yang nyaring, layar berkedip, atau performa yang melambat adalah tanda perangkat butuh perhatian. Buat tiket helpdesk dengan deskripsi jelas agar perbaikan bisa dilakukan sebelum kerusakan meluas.</p>\n\n<p><strong>Kesimpulan:</strong> perawatan kecil yang dilakukan rutin lebih efektif daripada perbaikan besar di kemudian hari. Laptop yang dirawat baik akan menemani pekerjaan Anda untuk waktu yang panjang.</p>', 'tips-tricks', 'published', '2026-03-29 01:35:11', NULL, 412, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 2),
	(12, 109, 'Cara Membuat Tiket Helpdesk yang Efektif', 'cara-membuat-tiket-helpdesk-yang-efektif', 'Tim IT Support', '<p>Tiket yang ditulis dengan baik mempercepat penyelesaian masalah. Sebaliknya, tiket yang singkat dan ambigu sering kali membuat teknisi harus bolak-balik bertanya, sehingga waktu penyelesaian molor.</p>\n\n<h2>Struktur Tiket yang Ideal</h2>\n<ol>\n    <li><strong>Subjek yang spesifik</strong> &mdash; misalnya <em>"Printer ruang Tata Usaha tidak mencetak dokumen"</em>, bukan sekadar <em>"Printer rusak"</em>.</li>\n    <li><strong>Kategori dan prioritas yang sesuai</strong> &mdash; pilih Hardware, Software, Jaringan, atau Printer. Tetapkan prioritas <em>Kritis</em> hanya untuk masalah yang menghentikan aktivitas kerja banyak orang.</li>\n    <li><strong>Deskripsi runtut</strong> &mdash; jelaskan kapan masalah mulai terjadi, apa yang sudah Anda coba, dan apa pesan error yang muncul.</li>\n    <li><strong>Lampiran pendukung</strong> &mdash; foto kerusakan, screenshot pesan error, atau berkas yang gagal dibuka membantu teknisi memetakan masalah.</li>\n</ol>\n\n<h2>Contoh Deskripsi yang Baik</h2>\n<blockquote>\n"Sejak pagi tadi (08.30) printer HP LaserJet di ruang Tata Usaha tidak merespons saat di-print dari laptop saya. Sudah saya coba restart printer, cek koneksi LAN, dan print dari laptop lain hasilnya sama. Lampu indikator berkedip kuning. Lampiran: foto status panel printer."\n</blockquote>\n\n<h2>Pantau Status Tiket Anda</h2>\n<p>Setelah tiket dibuat, pantau status melalui dashboard. Workflow umumnya: <strong>Open &rarr; In Progress &rarr; Waiting for User &rarr; Resolved &rarr; Closed</strong>. Apabila status berubah ke <em>Waiting for User</em>, segera berikan informasi tambahan yang diminta agar tiket dapat dilanjutkan.</p>\n\n<p>Dengan kebiasaan menulis tiket yang baik, masalah teknis dapat ditangani lebih cepat dan tepat sasaran.</p>', 'tutorial', 'published', '2026-04-03 01:35:11', NULL, 587, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 1),
	(13, 109, 'Panduan Membuat Password yang Kuat dan Mudah Diingat', 'panduan-membuat-password-yang-kuat-dan-mudah-diingat', 'Tim Keamanan Informasi', '<p>Password yang lemah adalah pintu paling sering dimanfaatkan oleh pelaku kejahatan siber. Kabar baiknya, password yang kuat tidak harus sulit diingat.</p>\n\n<h2>Ciri Password yang Kuat</h2>\n<ul>\n    <li>Panjang minimal 12 karakter.</li>\n    <li>Mengandung kombinasi huruf besar, huruf kecil, angka, dan simbol.</li>\n    <li>Tidak menggunakan informasi pribadi seperti tanggal lahir, NIP, atau nama anggota keluarga.</li>\n    <li>Berbeda untuk setiap layanan penting.</li>\n</ul>\n\n<h2>Teknik Frasa Sandi (Passphrase)</h2>\n<p>Gabungkan empat kata acak yang mudah Anda visualisasikan, tambahkan angka dan simbol di antaranya. Contoh:</p>\n<p><code>Kucing!Hujan7Sepeda#Kopi</code></p>\n<p>Frasa seperti ini lebih sulit dipecahkan dibanding <em>P@ssw0rd</em>, namun lebih mudah diingat.</p>\n\n<h2>Gunakan Password Manager</h2>\n<p>Aplikasi seperti Bitwarden atau KeePass dapat menyimpan dan mengisi password secara otomatis. Anda hanya perlu mengingat satu master password.</p>\n\n<h2>Aktifkan Two-Factor Authentication</h2>\n<p>Walau password kuat, lapis keamanan kedua tetap diperlukan. Aktifkan 2FA di sistem yang menyediakannya, termasuk akun email kantor dan portal administrasi.</p>\n\n<p>Ingat: keamanan dimulai dari kebiasaan kecil. Tidak ada sistem yang sepenuhnya aman tanpa partisipasi penggunanya.</p>', 'security', 'published', '2026-04-06 01:35:11', NULL, 734, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 4),
	(14, 109, 'Mengenali dan Menghindari Email Phishing', 'mengenali-dan-menghindari-email-phishing', 'Tim Keamanan Informasi', '<p>Phishing adalah upaya menipu korban agar memberikan data sensitif (kredensial login, nomor rekening, kode OTP) melalui email yang dibuat menyerupai komunikasi resmi.</p>\n\n<h2>Tanda-Tanda Email Phishing</h2>\n<ul>\n    <li><strong>Alamat pengirim mencurigakan.</strong> Periksa domainnya dengan teliti, misalnya <code>support@micros0ft.com</code> alih-alih <code>microsoft.com</code>.</li>\n    <li><strong>Bahasa yang menekan.</strong> "Akun Anda akan diblokir dalam 24 jam!" adalah taktik klasik untuk memancing keputusan terburu-buru.</li>\n    <li><strong>Tautan yang berbeda dengan teks tampilannya.</strong> Arahkan kursor (tanpa mengeklik) untuk melihat URL aslinya di pojok bawah peramban.</li>\n    <li><strong>Lampiran tidak terduga.</strong> File <code>.zip</code>, <code>.exe</code>, atau dokumen Office yang meminta mengaktifkan macro patut dicurigai.</li>\n    <li><strong>Salam sapaan generik.</strong> "Dear Customer" atau "Pengguna yang terhormat" tanpa menyebut nama Anda.</li>\n</ul>\n\n<h2>Apa yang Harus Dilakukan</h2>\n<ol>\n    <li>Jangan klik tautan atau buka lampiran apapun.</li>\n    <li>Jangan balas email tersebut.</li>\n    <li>Laporkan ke tim IT melalui tiket helpdesk dengan kategori <em>Keamanan / Security Incident</em>, sertakan tangkapan layar utuh termasuk header email.</li>\n    <li>Hapus email setelah dilaporkan.</li>\n</ol>\n\n<h2>Apabila Sudah Terlanjur Mengeklik</h2>\n<p>Segera ganti password akun terkait, putuskan koneksi internet pada perangkat yang dipakai, dan laporkan secepat mungkin. Semakin cepat respons, semakin kecil dampak yang dapat ditimbulkan.</p>\n\n<p>Kewaspadaan satu orang dapat menyelamatkan data seluruh organisasi.</p>', 'security', 'published', '2026-04-10 01:35:11', NULL, 658, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 4),
	(15, 109, 'Etika dan Prosedur Peminjaman Kendaraan Dinas Operasional', 'etika-dan-prosedur-peminjaman-kendaraan-dinas-operasional', 'Subbag Umum', '<p>Kendaraan Dinas Operasional (KDO) adalah aset bersama yang menunjang kelancaran tugas. Pengelolaan yang tertib memastikan KDO selalu siap saat dibutuhkan oleh siapa pun.</p>\n\n<h2>Sebelum Peminjaman</h2>\n<ul>\n    <li>Ajukan booking melalui sistem minimal H-1 dengan mengisi tujuan, keperluan, dan daftar penumpang.</li>\n    <li>Lampirkan nomor surat tugas/perjalanan dinas pada formulir booking.</li>\n    <li>Periksa kalender ketersediaan untuk menghindari konflik jadwal.</li>\n</ul>\n\n<h2>Saat Pengambilan Kendaraan</h2>\n<ul>\n    <li>Catat odometer awal dan level BBM di sistem.</li>\n    <li>Periksa kondisi fisik kendaraan: ban, lampu, kebersihan kabin.</li>\n    <li>Pastikan STNK dan SIM pengemudi masih berlaku.</li>\n</ul>\n\n<h2>Selama Penggunaan</h2>\n<ul>\n    <li>Gunakan kendaraan hanya untuk keperluan dinas yang tertera dalam pengajuan.</li>\n    <li>Patuhi peraturan lalu lintas. Pelanggaran menjadi tanggung jawab pengemudi.</li>\n    <li>Isi BBM minimal hingga level yang sama dengan saat diambil.</li>\n</ul>\n\n<h2>Saat Pengembalian</h2>\n<ul>\n    <li>Kembalikan kendaraan dalam kondisi bersih dan tepat waktu.</li>\n    <li>Catat odometer akhir dan level BBM.</li>\n    <li>Laporkan kerusakan atau insiden meskipun terlihat kecil &mdash; lebih baik melapor lebih awal.</li>\n</ul>\n\n<p>Kedisiplinan administrasi KDO membuat layanan transportasi dinas berjalan adil dan efisien bagi seluruh pegawai.</p>', 'tutorial', 'published', '2026-04-13 01:35:11', NULL, 321, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 1),
	(16, 109, '5 Cara Mempercepat Windows untuk Produktivitas Kerja', '5-cara-mempercepat-windows-untuk-produktivitas-kerja', 'Tim IT Support', '<p>Komputer yang lambat dapat memotong jam produktif Anda secara signifikan. Berikut langkah praktis yang dapat dilakukan tanpa harus install ulang sistem operasi.</p>\n\n<h2>1. Matikan Aplikasi Startup yang Tidak Perlu</h2>\n<p>Buka <strong>Task Manager &rarr; tab Startup</strong>. Disable aplikasi dengan dampak <em>High</em> yang tidak Anda gunakan saat boot. Spotify, Steam, dan aplikasi update vendor sering kali bisa dimatikan tanpa konsekuensi.</p>\n\n<h2>2. Bersihkan File Sementara</h2>\n<p>Tekan <kbd>Win</kbd> + <kbd>R</kbd>, ketik <code>%temp%</code>, lalu hapus isinya. Lanjutkan dengan menjalankan <em>Storage Sense</em> dari Settings untuk membersihkan cache sistem secara berkala.</p>\n\n<h2>3. Tambah RAM atau Ganti ke SSD</h2>\n<p>Apabila perangkat masih menggunakan HDD, peningkatan ke SSD adalah investasi paling terasa. Untuk laptop kantor, ajukan permintaan upgrade melalui tiket dengan menyebutkan beban kerja Anda.</p>\n\n<h2>4. Tutup Tab Browser yang Berlebihan</h2>\n<p>Setiap tab Chrome bisa memakan ratusan MB RAM. Manfaatkan ekstensi <em>The Great Suspender</em> alternatif modern atau fitur <em>Memory Saver</em> bawaan untuk membekukan tab yang tidak aktif.</p>\n\n<h2>5. Lakukan Restart Berkala</h2>\n<p>Sleep berhari-hari membuat memori dipenuhi residu aplikasi. Restart komputer minimal seminggu sekali agar sistem kembali segar.</p>\n\n<p>Jika setelah langkah-langkah di atas perangkat tetap lambat, kemungkinan ada masalah perangkat keras. Buat tiket dengan kategori Hardware untuk pemeriksaan lebih lanjut.</p>', 'tips-tricks', 'published', '2026-04-16 01:35:11', NULL, 902, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 2),
	(17, 109, 'Pentingnya Backup Data Rutin untuk Pegawai', 'pentingnya-backup-data-rutin-untuk-pegawai', 'Tim IT Support', '<p>Kerusakan hard disk, infeksi ransomware, atau laptop hilang adalah skenario yang dapat menghapus pekerjaan berbulan-bulan dalam hitungan detik. Backup rutin adalah polis asuransi termurah yang dapat Anda lakukan.</p>\n\n<h2>Aturan 3-2-1</h2>\n<ul>\n    <li><strong>3 salinan</strong> data penting.</li>\n    <li><strong>2 media penyimpanan berbeda</strong> (misalnya SSD laptop dan hard disk eksternal).</li>\n    <li><strong>1 salinan disimpan di lokasi terpisah</strong>, contohnya cloud storage instansi.</li>\n</ul>\n\n<h2>Apa Saja yang Perlu Di-backup?</h2>\n<ul>\n    <li>Dokumen kerja di folder <code>Documents</code>, <code>Desktop</code>, dan <code>Downloads</code>.</li>\n    <li>Konfigurasi email dan tanda tangan digital.</li>\n    <li>Bookmark dan ekstensi browser yang Anda gunakan untuk kerja.</li>\n</ul>\n\n<h2>Otomatisasi Lebih Baik Daripada Manual</h2>\n<p>Manfaatkan fitur <em>OneDrive</em> atau <em>Google Drive</em> yang sudah disediakan instansi. Atur folder kerja agar otomatis tersinkron, sehingga Anda tidak perlu mengingat kapan terakhir backup dilakukan.</p>\n\n<h2>Uji Hasil Backup Anda</h2>\n<p>Backup yang tidak pernah diuji sama saja dengan tidak punya backup. Sesekali, coba pulihkan satu file dari cadangan untuk memastikan prosesnya berjalan baik.</p>\n\n<p>Lima menit yang Anda alokasikan untuk backup hari ini bisa menyelamatkan berhari-hari pekerjaan di masa depan.</p>', 'tips-tricks', 'published', '2026-04-18 01:35:11', NULL, 245, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 2),
	(18, 109, 'Troubleshooting: Printer Tidak Terdeteksi di Jaringan Kantor', 'troubleshooting-printer-tidak-terdeteksi-di-jaringan-kantor', 'Tim IT Support', '<p>Printer jaringan yang tiba-tiba tidak terdeteksi adalah salah satu kasus paling sering dilaporkan ke helpdesk. Sebagian besar dapat diselesaikan sendiri dalam beberapa langkah.</p>\n\n<h2>Langkah Pemeriksaan Mandiri</h2>\n<ol>\n    <li><strong>Pastikan printer dalam keadaan menyala</strong> dan tidak menampilkan pesan error di panelnya.</li>\n    <li><strong>Cek lampu indikator jaringan</strong>. Lampu LAN yang mati bisa berarti kabel terlepas atau switch bermasalah.</li>\n    <li><strong>Lakukan ping ke alamat IP printer</strong> dari Command Prompt: <code>ping 192.168.x.x</code>. Jika gagal, masalah ada di jaringan, bukan komputer Anda.</li>\n    <li><strong>Restart antrean print</strong>. Tekan <kbd>Win</kbd> + <kbd>R</kbd>, ketik <code>services.msc</code>, cari <em>Print Spooler</em>, klik kanan &rarr; Restart.</li>\n    <li><strong>Hapus dan tambahkan ulang printer</strong> dari Settings &rarr; Bluetooth &amp; devices &rarr; Printers &amp; scanners.</li>\n</ol>\n\n<h2>Apabila Masalah Belum Teratasi</h2>\n<p>Buat tiket dengan kategori <em>Printer</em> dan sertakan informasi:</p>\n<ul>\n    <li>Merek dan model printer.</li>\n    <li>Lokasi fisik printer.</li>\n    <li>Pesan error yang muncul (sertakan screenshot).</li>\n    <li>Hasil <em>ping</em> ke IP printer.</li>\n</ul>\n\n<p>Informasi yang lengkap memungkinkan teknisi datang dengan persiapan yang tepat, sehingga pencetakan dapat segera kembali normal.</p>', 'troubleshooting', 'published', '2026-04-20 01:35:11', NULL, 478, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 3),
	(19, 109, 'Mengaktifkan Two-Factor Authentication (2FA) di Akun Anda', 'mengaktifkan-two-factor-authentication-2fa-di-akun-anda', 'Tim Keamanan Informasi', '<p>Two-Factor Authentication (2FA) menambahkan lapisan keamanan kedua di samping password. Walau kredensial Anda bocor, pelaku kejahatan tetap memerlukan kode OTP yang berubah setiap 30 detik.</p>\n\n<h2>Persiapan</h2>\n<ol>\n    <li>Pasang aplikasi authenticator di ponsel: <strong>Google Authenticator</strong>, <strong>Microsoft Authenticator</strong>, atau <strong>Authy</strong>.</li>\n    <li>Pastikan jam ponsel disinkronkan otomatis. Selisih waktu menyebabkan kode dianggap tidak valid.</li>\n</ol>\n\n<h2>Langkah Aktivasi</h2>\n<ol>\n    <li>Login ke akun Anda dan buka menu <strong>Profil &rarr; Keamanan</strong>.</li>\n    <li>Pilih <em>Aktifkan Two-Factor Authentication</em>.</li>\n    <li>Pindai kode QR yang muncul menggunakan aplikasi authenticator.</li>\n    <li>Masukkan kode 6 digit dari aplikasi sebagai verifikasi.</li>\n    <li><strong>Simpan kode pemulihan</strong> di tempat yang aman, misalnya brankas password manager.</li>\n</ol>\n\n<h2>Apa yang Terjadi Jika Kehilangan Ponsel?</h2>\n<p>Gunakan kode pemulihan yang Anda simpan untuk login. Setelah masuk, segera nonaktifkan 2FA pada perangkat lama dan aktifkan ulang pada perangkat baru. Apabila kode pemulihan juga hilang, hubungi admin sistem melalui tiket helpdesk dengan bukti identitas.</p>\n\n<p>Beberapa menit yang dihabiskan untuk konfigurasi 2FA sebanding dengan ketenangan jangka panjang akan keamanan akun Anda.</p>', 'security', 'published', '2026-04-22 01:35:11', NULL, 389, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 4),
	(20, 109, 'Sistem Inventaris IT: Mengapa Pencatatan Aset Itu Penting', 'sistem-inventaris-it-mengapa-pencatatan-aset-itu-penting', 'Subbag Umum', '<p>Pencatatan aset IT bukan sekadar tuntutan administrasi. Inventaris yang akurat adalah fondasi pengambilan keputusan strategis tim IT.</p>\n\n<h2>Manfaat Inventaris yang Tertib</h2>\n<ul>\n    <li><strong>Perencanaan anggaran</strong> &mdash; data umur perangkat membantu menyusun rencana penggantian.</li>\n    <li><strong>Pelacakan garansi</strong> &mdash; perangkat masih bergaransi seharusnya tidak diperbaiki dengan biaya sendiri.</li>\n    <li><strong>Pertanggungjawaban</strong> &mdash; setiap perangkat memiliki pengguna yang tercatat sehingga risiko kehilangan dapat ditekan.</li>\n    <li><strong>Analisis insiden</strong> &mdash; riwayat tiket per perangkat memunculkan pola, misalnya model laptop tertentu yang sering bermasalah.</li>\n</ul>\n\n<h2>Data Minimal yang Perlu Dicatat</h2>\n<ul>\n    <li>Tipe perangkat (Laptop, Desktop, Printer, dll).</li>\n    <li>Merek, model, dan nomor seri.</li>\n    <li>Spesifikasi singkat: prosesor, RAM, storage, OS.</li>\n    <li>Pengguna saat ini dan lokasi penempatan.</li>\n    <li>Tanggal pengadaan dan masa berakhir garansi.</li>\n    <li>Kondisi terkini.</li>\n</ul>\n\n<h2>Disiplin Update Data</h2>\n<p>Inventaris paling baik adalah yang selalu diperbarui. Setiap mutasi pegawai, perbaikan, atau penggantian komponen sebaiknya langsung tercatat di sistem agar data tidak menyimpang dari kondisi nyata.</p>\n\n<p>Aset yang tidak tercatat ibarat tidak ada &mdash; sulit dipertanggungjawabkan, sulit dirawat, dan rawan hilang.</p>', 'tutorial', 'published', '2026-04-24 01:35:11', NULL, 198, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 1),
	(21, 109, 'Manajemen File yang Rapi di Komputer Kantor', 'manajemen-file-yang-rapi-di-komputer-kantor', 'Tim IT Support', '<p>Folder Desktop yang penuh ikon dan nama berkas seperti <em>Final-Final-Revisi3.docx</em> adalah pemandangan yang familiar. Sedikit disiplin penamaan dan struktur folder akan menghemat banyak waktu pencarian.</p>\n\n<h2>Struktur Folder yang Konsisten</h2>\n<p>Buat hirarki sederhana berdasarkan tahun, kemudian unit kerja atau jenis dokumen. Contoh:</p>\n<pre>2026/\n&nbsp;&nbsp;&nbsp;|-- 01-Surat-Masuk/\n&nbsp;&nbsp;&nbsp;|-- 02-Surat-Keluar/\n&nbsp;&nbsp;&nbsp;|-- 03-Laporan/\n&nbsp;&nbsp;&nbsp;+-- 04-Anggaran/</pre>\n\n<h2>Konvensi Penamaan File</h2>\n<ul>\n    <li>Awali dengan tanggal format <code>YYYY-MM-DD</code> agar urut otomatis.</li>\n    <li>Gunakan tanda hubung (<code>-</code>) atau garis bawah (<code>_</code>) sebagai pemisah, hindari spasi.</li>\n    <li>Sertakan versi di akhir, misalnya <code>v1</code>, <code>v2-final</code>.</li>\n</ul>\n<p>Contoh: <code>2026-04-25_Laporan-Bulanan_v2.docx</code>.</p>\n\n<h2>Manfaatkan Cloud untuk Kolaborasi</h2>\n<p>Hindari mengirim dokumen besar via email berulang kali. Bagikan tautan dari OneDrive atau Google Drive sehingga semua kolaborator bekerja pada versi yang sama dan riwayat perubahannya terlacak.</p>\n\n<p>Disiplin kecil ini, bila diterapkan tim, dapat menyingkat rapat berjam-jam menjadi hitungan menit.</p>', 'tips-tricks', 'draft', NULL, NULL, 0, '2026-04-24 16:34:06', '2026-04-24 16:34:06', 2),
	(22, 109, 'Cara Aman Menggunakan WiFi Publik Saat Perjalanan Dinas', 'cara-aman-menggunakan-wifi-publik-saat-perjalanan-dinas', 'Tim Keamanan Informasi', '<p>WiFi gratis di bandara, hotel, dan kafe sangat membantu, tetapi juga menjadi medan favorit pelaku kejahatan siber. Berikut panduan agar perjalanan dinas Anda tetap produktif tanpa mengorbankan keamanan data.</p>\n\n<h2>Sebelum Terhubung</h2>\n<ul>\n    <li>Pastikan SSID benar-benar milik tempat tersebut. Tanyakan kepada staf, jangan menebak dari nama yang mirip.</li>\n    <li>Aktifkan firewall dan matikan <em>file sharing</em> di laptop.</li>\n    <li>Gunakan VPN instansi apabila tersedia.</li>\n</ul>\n\n<h2>Selama Terhubung</h2>\n<ul>\n    <li>Hindari mengakses portal administrasi atau internet banking pada jaringan publik.</li>\n    <li>Pastikan setiap situs yang Anda buka menggunakan HTTPS (terdapat ikon gembok).</li>\n    <li>Jangan mengizinkan komputer Anda <em>discoverable</em> oleh perangkat lain di jaringan.</li>\n</ul>\n\n<h2>Setelah Selesai</h2>\n<p>"Lupakan" jaringan tersebut dari daftar WiFi tersimpan agar laptop tidak otomatis tersambung kembali ketika berada di lokasi yang sama. Pertimbangkan untuk mengganti password akun-akun penting setibanya di kantor, terutama jika Anda merasa pernah login pada layanan sensitif.</p>\n\n<p>Kenyamanan dan keamanan dapat berjalan beriringan ketika Anda waspada pada hal-hal kecil seperti ini.</p>', 'security', 'draft', NULL, NULL, 0, '2026-04-24 16:34:06', '2026-04-24 16:34:06', 4),
	(23, 109, 'Pengumuman Lama: Migrasi Sistem Helpdesk ke Versi Baru', 'pengumuman-lama-migrasi-sistem-helpdesk-ke-versi-baru', 'Tim IT Support', '<p>Diberitahukan kepada seluruh pegawai bahwa sistem helpdesk lama telah dimigrasikan ke versi baru yang lebih responsif dan terintegrasi dengan modul inventaris perangkat.</p>\n\n<h2>Perubahan Utama</h2>\n<ul>\n    <li>Format nomor tiket baru: <code>TKT-YYYYMMDD-XXXX</code>.</li>\n    <li>Notifikasi real-time ke email pelapor dan teknisi.</li>\n    <li>Lampiran maksimal 5 berkas dengan total 25 MB.</li>\n    <li>Tiket terhubung otomatis dengan riwayat perangkat yang dilaporkan.</li>\n</ul>\n\n<p>Riwayat tiket lama tetap dapat diakses untuk keperluan referensi. Apabila ada kendala selama masa transisi, silakan hubungi tim IT.</p>\n\n<p><em>Pengumuman ini diarsipkan karena migrasi telah selesai. Disimpan untuk dokumentasi.</em></p>', 'news', 'archived', '2025-04-28 01:35:11', NULL, 1253, '2026-04-24 16:34:06', '2026-04-28 01:35:11', 5),
	(24, 109, 'Troubleshooting: Komputer Tidak Mau Menyala', 'troubleshooting-komputer-tidak-mau-menyala', 'Tim IT Support', '<p>Komputer yang tidak bereaksi sama sekali saat tombol power ditekan adalah masalah yang mengkhawatirkan. Namun sebagian besar penyebabnya dapat didiagnosis secara mandiri sebelum memanggil teknisi.</p>\n\n<h2>Langkah Diagnosis Mandiri</h2>\n<ol>\n  <li><strong>Periksa kabel power.</strong> Pastikan kabel terhubung ke stopkontak yang aktif. Coba stopkontak lain atau test dengan perangkat lain.</li>\n  <li><strong>Cek tombol power di casing.</strong> Pastikan tidak macet. Pada desktop, coba hubungkan langsung pin power di motherboard dengan obeng untuk memastikan tombol tidak bermasalah.</li>\n  <li><strong>Periksa indikator LED pada PSU atau motherboard.</strong> Jika lampu PSU tidak menyala sama sekali, kemungkinan besar PSU mati atau kabel longgar.</li>\n  <li><strong>Lepas semua perangkat eksternal</strong> (USB, monitor tambahan, dll.) lalu coba nyalakan kembali.</li>\n  <li><strong>Untuk laptop:</strong> lepas baterai dan coba hanya dengan adaptor, atau sebaliknya.</li>\n</ol>\n\n<h2>Penyebab Umum</h2>\n<ul>\n  <li>Kabel power longgar atau stopkontak mati.</li>\n  <li>PSU (Power Supply Unit) rusak.</li>\n  <li>Baterai laptop habis total (perlu charge minimal 10 menit).</li>\n  <li>Modul RAM tidak terpasang sempurna (bunyi beep saat menyala).</li>\n</ul>\n\n<h2>Kapan Harus Lapor ke IT?</h2>\n<p>Jika setelah semua langkah di atas komputer tetap tidak menyala, buat tiket dengan kategori <strong>Hardware</strong>, sertakan model perangkat, dan kronologi kejadian. Jangan mencoba membuka casing sendiri karena dapat menggugurkan garansi.</p>', 'troubleshooting', 'published', '2026-03-14 01:35:11', NULL, 621, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(25, 109, 'Troubleshooting: Layar Laptop Blank/Hitam saat Dinyalakan', 'troubleshooting-layar-laptop-blankhitam-saat-dinyalakan', 'Tim IT Support', '<p>Laptop menyala (kipas berputar, lampu LED aktif) tetapi layar tetap hitam adalah situasi yang membingungkan. Berikut cara menelusurinya secara sistematis.</p>\n\n<h2>Langkah Pemeriksaan</h2>\n<ol>\n  <li><strong>Tekan tombol <kbd>Fn</kbd> + tombol layar</strong> (biasanya F4, F5, atau F8 bergantung merek). Laptop mungkin berada di mode extended display atau layar dinonaktifkan.</li>\n  <li><strong>Hubungkan monitor eksternal via HDMI/VGA.</strong> Jika gambar muncul di monitor eksternal, masalah ada di layar atau koneksi kabel internal laptop.</li>\n  <li><strong>Sorot layar dengan senter.</strong> Jika samar-samar terlihat gambar, backlight layar mati â€” bukan masalah sistem operasi.</li>\n  <li><strong>Hard reset:</strong> tahan tombol power 10 detik hingga laptop mati, tunggu 30 detik, nyalakan kembali.</li>\n  <li><strong>Lepas semua perangkat USB</strong> dan coba boot tanpa aksesori.</li>\n</ol>\n\n<h2>Penyebab Umum</h2>\n<ul>\n  <li>Driver kartu grafis corrupt setelah update Windows.</li>\n  <li>Kabel fleksibel layar longgar (akibat engsel sering dibuka-tutup).</li>\n  <li>Backlight inverter rusak.</li>\n  <li>RAM tidak terpasang sempurna.</li>\n</ul>\n\n<p>Segera buat tiket helpdesk jika layar tetap hitam setelah langkah di atas. Sertakan hasil percobaan monitor eksternal dalam deskripsi tiket Anda.</p>', 'troubleshooting', 'published', '2026-03-15 01:35:11', NULL, 544, '2026-04-28 01:23:01', '2026-04-29 02:27:58', 3),
	(26, 109, 'Troubleshooting: Laptop Overheat dan Mati Mendadak', 'troubleshooting-laptop-overheat-dan-mati-mendadak', 'Tim IT Support', '<p>Laptop yang tiba-tiba mati saat digunakan, terutama ketika menjalankan aplikasi berat, sering kali disebabkan oleh suhu prosesor yang melampaui batas aman. Sistem mati paksa untuk mencegah kerusakan permanen.</p>\n\n<h2>Tanda-Tanda Overheat</h2>\n<ul>\n  <li>Bagian bawah laptop sangat panas saat disentuh.</li>\n  <li>Kipas berputar kencang terus-menerus.</li>\n  <li>Performa menurun drastis (throttling) sebelum mati.</li>\n  <li>Layar bergaris atau artefak sebelum shutdown.</li>\n</ul>\n\n<h2>Solusi Mandiri</h2>\n<ol>\n  <li><strong>Pastikan ventilasi tidak tersumbat.</strong> Gunakan alas keras (meja), bukan bantal atau kasur.</li>\n  <li><strong>Bersihkan ventilasi dengan blower kecil</strong> dari jarak 10 cm. Debu yang menumpuk di heatsink adalah penyebab paling umum.</li>\n  <li><strong>Gunakan cooling pad</strong> â€” terutama jika beban kerja tinggi (desain grafis, video call panjang).</li>\n  <li><strong>Tutup aplikasi yang tidak perlu.</strong> Buka Task Manager, urutkan berdasarkan CPU, dan tutup proses berbeban tinggi yang tidak dikenal.</li>\n  <li><strong>Hindari langsung menyalakan ulang</strong> setelah mati akibat panas. Tunggu 5-10 menit agar komponen dingin.</li>\n</ol>\n\n<h2>Perlu Perhatian Teknisi</h2>\n<p>Jika masalah berulang meski ventilasi bersih, pasta thermal prosesor mungkin perlu diganti. Hubungi IT melalui tiket helpdesk â€” jangan coba bongkar heatsink sendiri.</p>', 'troubleshooting', 'published', '2026-03-16 01:35:11', NULL, 489, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(27, 109, 'Troubleshooting: Keyboard Laptop Tidak Merespons atau Mengetik Karakter Salah', 'troubleshooting-keyboard-laptop-tidak-merespons-atau-mengetik-karakter-salah', 'Tim IT Support', '<p>Keyboard yang tidak merespons atau menampilkan karakter berbeda dari tombol yang ditekan bisa disebabkan oleh masalah software maupun hardware.</p>\n\n<h2>Pemeriksaan Awal</h2>\n<ol>\n  <li><strong>Coba keyboard eksternal via USB.</strong> Jika keyboard USB berfungsi normal, masalah ada di keyboard internal laptop.</li>\n  <li><strong>Periksa Filter Keys.</strong> Buka <em>Settings â†’ Accessibility â†’ Keyboard</em>, pastikan Filter Keys tidak aktif (dapat menyebabkan keyboard seperti lambat/tidak merespons).</li>\n  <li><strong>Cek pengaturan bahasa input.</strong> Tekan <kbd>Win</kbd> + <kbd>Space</kbd> untuk melihat layout aktif. Pastikan tidak berganti ke layout keyboard asing (AZERTY, Dvorak, dll.).</li>\n  <li><strong>Restart laptop.</strong> Kadang driver keyboard macet dan perlu diinisialisasi ulang.</li>\n  <li><strong>Periksa apakah ada tumpahan cairan.</strong> Cairan yang masuk ke sela keyboard dapat menyebabkan tombol lengket atau korsleting.</li>\n</ol>\n\n<h2>Update/Reinstall Driver</h2>\n<p>Buka <em>Device Manager â†’ Keyboards</em>, klik kanan driver keyboard, pilih <em>Uninstall device</em>, lalu restart. Windows akan menginstal ulang driver secara otomatis.</p>\n\n<h2>Tombol Tertentu Tidak Berfungsi</h2>\n<p>Jika hanya beberapa tombol yang tidak merespons, kemungkinan ada sambungan ribbon kabel internal yang longgar atau tombol fisik rusak. Ini memerlukan pemeriksaan teknisi.</p>', 'troubleshooting', 'published', '2026-03-17 01:35:11', NULL, 412, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(28, 109, 'Troubleshooting: Mouse Tidak Bergerak atau Kursor Hilang', 'troubleshooting-mouse-tidak-bergerak-atau-kursor-hilang', 'Tim IT Support', '<p>Kursor yang tiba-tiba berhenti bergerak atau menghilang dari layar dapat sangat mengganggu produktivitas. Berikut panduan penanganannya.</p>\n\n<h2>Untuk Mouse Eksternal (USB/Wireless)</h2>\n<ol>\n  <li><strong>Cabut dan pasang ulang</strong> receiver USB atau kabel mouse ke port yang berbeda.</li>\n  <li><strong>Ganti baterai</strong> jika mouse wireless. Baterai lemah sering menyebabkan kursor tidak stabil atau tidak merespons.</li>\n  <li><strong>Bersihkan sensor bagian bawah mouse</strong> dengan kain kering. Permukaan yang reflektif (kaca, logam mengkilap) dapat mengacaukan sensor optik.</li>\n  <li><strong>Coba di komputer lain</strong> untuk memastikan mouse-nya yang bermasalah, bukan portnya.</li>\n</ol>\n\n<h2>Untuk Touchpad Laptop</h2>\n<ol>\n  <li>Tekan <kbd>Fn</kbd> + tombol touchpad (biasanya F6 atau F9) â€” tombol ini toggle touchpad on/off.</li>\n  <li>Pastikan tidak ada mouse USB terpasang yang menonaktifkan touchpad secara otomatis (cek di pengaturan BIOS atau driver).</li>\n  <li>Perbarui driver touchpad melalui Device Manager.</li>\n</ol>\n\n<h2>Kursor Hilang saat di Atas Jendela Tertentu</h2>\n<p>Beberapa aplikasi menyembunyikan kursor default. Tekan <kbd>Esc</kbd> atau pindah ke aplikasi lain. Jika masalah berulang di satu aplikasi, reinstall aplikasi tersebut.</p>\n\n<p>Masalah yang tidak teratasi dengan langkah di atas kemungkinan memerlukan penggantian unit mouse atau pemeriksaan port USB pada motherboard. Buat tiket helpdesk dengan kategori Hardware.</p>', 'troubleshooting', 'published', '2026-03-18 01:35:11', NULL, 387, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(29, 109, 'Troubleshooting: Hard Disk Berbunyi Keras (Klik atau Gerinda)', 'troubleshooting-hard-disk-berbunyi-keras-klik-atau-gerinda', 'Tim IT Support', '<p>Bunyi klik berulang atau suara gerinda dari hard disk adalah tanda peringatan serius yang tidak boleh diabaikan. Hard disk yang berbunyi demikian berpotensi gagal total dalam waktu singkat.</p>\n\n<h2>âš ï¸ Langkah Pertama: Backup Segera</h2>\n<p>Sebelum melakukan apapun, salin semua file penting ke media lain (flashdisk, hard disk eksternal, atau cloud). Jangan menunda â€” data dapat hilang kapan saja.</p>\n\n<h2>Bedakan Jenis Bunyi</h2>\n<ul>\n  <li><strong>Klik-klik periodik:</strong> sering disebabkan head read/write yang gagal menemukan titik referensi (click of death). Tanda kerusakan mekanis serius.</li>\n  <li><strong>Gerinda atau desis:</strong> bearing motor mulai aus.</li>\n  <li><strong>Bunyi keras saat akses:</strong> bisa hanya getaran konektor longgar, tapi tetap perlu diperiksa.</li>\n</ul>\n\n<h2>Cek Kesehatan HDD</h2>\n<p>Jalankan <strong>CrystalDiskInfo</strong> (gratis) untuk melihat status S.M.A.R.T. hard disk. Status <em>Caution</em> berarti ada parameter yang tidak normal; status <em>Bad</em> berarti segera ganti.</p>\n\n<h2>Apa yang Harus Dilakukan Selanjutnya</h2>\n<p>Buat tiket helpdesk dengan kategori <strong>Hardware</strong> dan sertakan:</p>\n<ul>\n  <li>Jenis bunyi yang terdengar (klik/gerinda).</li>\n  <li>Screenshot hasil CrystalDiskInfo jika bisa dijalankan.</li>\n  <li>File penting apa saja yang ada di drive tersebut.</li>\n</ul>\n<p>Teknisi akan memprioritas penggantian HDD sebelum terjadi kegagalan total.</p>', 'troubleshooting', 'published', '2026-03-19 01:35:11', NULL, 534, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(30, 109, 'Troubleshooting: Flashdisk atau USB Tidak Terdeteksi', 'troubleshooting-flashdisk-atau-usb-tidak-terdeteksi', 'Tim IT Support', '<p>USB yang tidak muncul di File Explorer padahal sudah tertancap adalah masalah yang cukup umum dan umumnya bisa diatasi tanpa bantuan teknisi.</p>\n\n<h2>Langkah Pemeriksaan</h2>\n<ol>\n  <li><strong>Coba port USB lain.</strong> Port mungkin mati atau rusak. Coba juga di komputer lain untuk memastikan flashdisk-nya yang bermasalah.</li>\n  <li><strong>Buka Disk Management</strong> (<kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>diskmgmt.msc</code>). Jika USB terdeteksi di sini tapi tidak muncul di File Explorer, USB mungkin tidak memiliki drive letter â€” klik kanan â†’ <em>Change Drive Letter and Paths</em>.</li>\n  <li><strong>Update atau reinstall driver USB.</strong> Buka Device Manager, cari entri dengan tanda seru kuning di <em>Universal Serial Bus controllers</em>, lalu update driver.</li>\n  <li><strong>Nonaktifkan USB Selective Suspend.</strong> Buka Power Options â†’ Change plan settings â†’ Change advanced power settings â†’ USB settings â†’ USB selective suspend setting â†’ Disabled.</li>\n  <li><strong>Restart Windows Explorer.</strong> Buka Task Manager, cari <em>Windows Explorer</em>, klik kanan â†’ Restart.</li>\n</ol>\n\n<h2>USB Terdeteksi tapi Tidak Bisa Dibuka</h2>\n<p>Kemungkinan sistem file rusak. Jalankan: buka Command Prompt sebagai Administrator, ketik <code>chkdsk X: /f</code> (ganti X dengan letter drive USB). Proses ini akan memperbaiki error sistem file.</p>\n\n<p>Jika USB tetap tidak terdeteksi di berbagai komputer, kemungkinan besar unit flashdisk sudah rusak.</p>', 'troubleshooting', 'published', '2026-03-20 01:35:11', NULL, 445, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(31, 109, 'Troubleshooting: Monitor Menampilkan Resolusi atau Warna yang Salah', 'troubleshooting-monitor-menampilkan-resolusi-atau-warna-yang-salah', 'Tim IT Support', '<p>Monitor yang menampilkan resolusi rendah, warna aneh, atau tampilan "gepeng" biasanya disebabkan oleh masalah driver atau koneksi kabel, bukan kerusakan hardware.</p>\n\n<h2>Memperbaiki Resolusi</h2>\n<ol>\n  <li>Klik kanan desktop â†’ <em>Display settings</em>.</li>\n  <li>Pada <em>Display resolution</em>, pilih resolusi yang ditandai <em>(Recommended)</em>. Ini adalah resolusi native monitor.</li>\n  <li>Jika opsi resolusi terbatas (hanya sampai 1024Ã—768), kemungkinan driver kartu grafis belum terinstal atau corrupt.</li>\n</ol>\n\n<h2>Memperbaiki Driver Kartu Grafis</h2>\n<ol>\n  <li>Buka <em>Device Manager â†’ Display adapters</em>.</li>\n  <li>Jika tertulis <em>Microsoft Basic Display Adapter</em>, driver GPU belum terinstal.</li>\n  <li>Klik kanan â†’ <em>Update driver â†’ Search automatically</em>. Jika tidak berhasil, unduh driver dari situs resmi (NVIDIA, AMD, atau Intel) sesuai model GPU.</li>\n</ol>\n\n<h2>Masalah Warna (Terlalu Merah/Hijau/Biru)</h2>\n<ul>\n  <li>Periksa kabel VGA/HDMI â€” pin yang bengkok di konektor VGA dapat menyebabkan warna hilang.</li>\n  <li>Coba kabel berbeda atau port berbeda di monitor.</li>\n  <li>Reset pengaturan warna monitor melalui menu OSD (On-Screen Display) tombol fisik monitor.</li>\n</ul>', 'troubleshooting', 'published', '2026-03-21 01:35:11', NULL, 298, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(32, 109, 'Troubleshooting: Baterai Laptop Tidak Mau Mengisi Daya', 'troubleshooting-baterai-laptop-tidak-mau-mengisi-daya', 'Tim IT Support', '<p>Indikator charger menyala tapi persentase baterai tidak naik, atau laptop hanya bisa hidup saat dicolokan â€” ini tanda masalah pengisian daya yang perlu didiagnosis dengan cermat.</p>\n\n<h2>Diagnosa Langkah Demi Langkah</h2>\n<ol>\n  <li><strong>Periksa indikator LED charger.</strong> Jika lampu pada charger tidak menyala, adaptor bermasalah.</li>\n  <li><strong>Bersihkan pin konektor charger</strong> dari debu atau kotoran dengan kapas dan alkohol isopropil.</li>\n  <li><strong>Coba cabut baterai (laptop lama) dan jalankan hanya dari adaptor.</strong> Jika berhasil, baterai perlu diganti.</li>\n  <li><strong>Kalibrasi baterai:</strong> biarkan laptop mati total karena habis baterai, lalu charge tanpa dinyalakan selama 2 jam penuh.</li>\n  <li><strong>Update BIOS.</strong> Beberapa laptop membutuhkan update BIOS untuk mengenali baterai pengganti atau memperbaiki bug pengisian.</li>\n</ol>\n\n<h2>Pesan "Plugged in, not charging"</h2>\n<p>Buka Device Manager â†’ Batteries â†’ klik kanan <em>Microsoft ACPI-Compliant Control Method Battery</em> â†’ <em>Uninstall device</em>. Cabut adaptor, tunggu 30 detik, pasang kembali. Windows akan mendeteksi ulang baterai.</p>\n\n<h2>Baterai Sudah Tua</h2>\n<p>Jalankan <code>powercfg /batteryreport</code> di Command Prompt Administrator. Laporan akan menampilkan kapasitas desain vs kapasitas saat ini. Jika kurang dari 60%, pertimbangkan penggantian baterai.</p>', 'troubleshooting', 'published', '2026-03-22 01:35:11', NULL, 367, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(33, 109, 'Troubleshooting: Komputer Tidak Ada Suara (No Audio)', 'troubleshooting-komputer-tidak-ada-suara-no-audio', 'Tim IT Support', '<p>Suara yang tiba-tiba hilang bisa disebabkan hal sepele seperti volume yang di-mute, hingga masalah driver yang perlu penanganan lebih lanjut.</p>\n\n<h2>Pemeriksaan Cepat</h2>\n<ol>\n  <li><strong>Periksa volume.</strong> Klik ikon speaker di taskbar, pastikan tidak mute dan level volume cukup. Cek juga volume di aplikasi yang digunakan (YouTube, Media Player, dll.).</li>\n  <li><strong>Periksa perangkat output default.</strong> Klik kanan ikon speaker â†’ <em>Open Sound settings</em> â†’ pastikan output device yang benar dipilih (bukan perangkat yang tidak ada).</li>\n  <li><strong>Cabut headset jika terpasang.</strong> Beberapa sistem otomatis beralih ke headset sehingga speaker utama tidak berbunyi.</li>\n  <li><strong>Jalankan Audio Troubleshooter.</strong> Klik kanan ikon speaker â†’ <em>Troubleshoot sound problems</em>.</li>\n</ol>\n\n<h2>Reinstall Driver Audio</h2>\n<ol>\n  <li>Buka Device Manager â†’ <em>Sound, video and game controllers</em>.</li>\n  <li>Klik kanan driver audio â†’ <em>Uninstall device</em> â†’ centang hapus driver.</li>\n  <li>Restart komputer. Windows akan menginstal driver default.</li>\n  <li>Untuk driver optimal, unduh dari situs motherboard/laptop (Realtek, IDT, dll.).</li>\n</ol>\n\n<h2>Tidak Ada Suara Setelah Update Windows</h2>\n<p>Update Windows kadang menimpa driver audio. Solusi cepat: buka <em>Device Manager</em>, klik kanan driver audio â†’ <em>Update driver</em> â†’ <em>Browse my computer â†’ Let me pick</em> â†’ pilih versi driver sebelumnya.</p>', 'troubleshooting', 'published', '2026-03-23 01:35:11', NULL, 401, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(34, 109, 'Troubleshooting: Printer Kertas Macet (Paper Jam)', 'troubleshooting-printer-kertas-macet-paper-jam', 'Tim IT Support', '<p>Paper jam adalah masalah paling sering pada printer kantor. Penanganan yang salah justru dapat memperparah kerusakan. Ikuti langkah berikut dengan hati-hati.</p>\n\n<h2>Prosedur Pembersihan Paper Jam</h2>\n<ol>\n  <li><strong>Matikan printer terlebih dahulu.</strong> Jangan menarik kertas saat printer masih menyala.</li>\n  <li><strong>Buka semua cover akses</strong> yang tersedia (cover depan, belakang, dan tray). Periksa setiap jalur kertas secara visual.</li>\n  <li><strong>Tarik kertas perlahan searah jalur normal</strong> (biasanya ke bawah atau ke belakang). Jangan tarik berlawanan arah karena dapat merusak roller.</li>\n  <li><strong>Periksa sisa kertas robek.</strong> Potongan kecil kertas yang tersisa adalah penyebab paper jam berulang. Gunakan pinset jika diperlukan.</li>\n  <li><strong>Nyalakan kembali printer</strong> dan cetak halaman uji (test page) untuk memastikan printer berfungsi normal.</li>\n</ol>\n\n<h2>Pencegahan Paper Jam</h2>\n<ul>\n  <li>Kipas-kipaskan kertas sebelum dimasukkan ke tray agar tidak saling menempel.</li>\n  <li>Jangan isi tray melebihi batas maksimum yang tertera.</li>\n  <li>Gunakan kertas dengan gramasi sesuai spesifikasi printer (umumnya 70â€“90 gsm).</li>\n  <li>Bersihkan roller kertas dengan kain lembab setiap 3 bulan sekali.</li>\n</ul>\n\n<h2>Paper Jam Berulang</h2>\n<p>Jika paper jam terjadi terus-menerus meski prosedur di atas sudah dilakukan, roller kertas mungkin sudah aus dan perlu diganti. Laporkan ke IT melalui tiket helpdesk.</p>', 'troubleshooting', 'published', '2026-03-24 01:35:11', NULL, 523, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(35, 109, 'Troubleshooting: Hasil Cetak Printer Bergaris atau Buram', 'troubleshooting-hasil-cetak-printer-bergaris-atau-buram', 'Tim IT Support', '<p>Hasil cetak yang bergaris horizontal, buram, atau bercak menunjukkan masalah pada kartrid atau mekanisme cetak yang biasanya bisa diperbaiki tanpa memanggil teknisi.</p>\n\n<h2>Untuk Printer Inkjet</h2>\n<ol>\n  <li><strong>Jalankan Head Cleaning</strong> dari software printer (<em>Printer Properties â†’ Maintenance â†’ Head Cleaning</em>). Lakukan 2-3 kali jika perlu.</li>\n  <li><strong>Jalankan Nozzle Check</strong> untuk melihat pola mana yang tersumbat.</li>\n  <li><strong>Kocok kartrid tinta</strong> (untuk kartrid yang masih ada tinta tapi bermasalah). Keluarkan kartrid, kocok perlahan secara horizontal, pasang kembali.</li>\n  <li>Jika tinta habis, ganti kartrid. Gunakan kartrid original atau yang direkomendasikan untuk menghindari masalah lanjutan.</li>\n</ol>\n\n<h2>Untuk Printer Laser</h2>\n<ol>\n  <li><strong>Keluarkan toner cartridge</strong>, kocok perlahan dari kiri ke kanan untuk meratakan toner, pasang kembali. Ini sering memperpanjang usia toner yang hampir habis.</li>\n  <li><strong>Bersihkan drum unit</strong> dengan kain kering yang tidak berbulu.</li>\n  <li>Jika garis muncul di posisi yang sama pada setiap halaman, kemungkinan ada goresan pada drum â€” perlu penggantian drum atau toner.</li>\n</ol>\n\n<h2>Hasil Cetak Kabur/Berbayang</h2>\n<p>Pada printer laser, hasil kabur sering disebabkan fuser unit yang tidak memanaskan dengan baik. Ini memerlukan penggantian komponen oleh teknisi. Buat tiket helpdesk dengan menyertakan sampel hasil cetak bermasalah.</p>', 'troubleshooting', 'published', '2026-03-25 01:35:11', NULL, 334, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(36, 109, 'Troubleshooting: Proyektor Tidak Tampil saat Dihubungkan ke Laptop', 'troubleshooting-proyektor-tidak-tampil-saat-dihubungkan-ke-laptop', 'Tim IT Support', '<p>Situasi yang memalukan: proyektor sudah terpasang tapi layar tetap kosong saat presentasi. Dengan beberapa langkah sederhana, ini bisa diatasi dalam hitungan detik.</p>\n\n<h2>Langkah Cepat saat Presentasi</h2>\n<ol>\n  <li><strong>Tekan <kbd>Win</kbd> + <kbd>P</kbd></strong> dan pilih mode tampilan: <em>Duplicate</em> (sama dengan layar laptop), <em>Extend</em>, atau <em>Second screen only</em>.</li>\n  <li><strong>Periksa sumber input di proyektor.</strong> Tekan tombol <em>Source</em> atau <em>Input</em> di remote/panel proyektor dan pilih input yang sesuai (HDMI, VGA, atau lainnya).</li>\n  <li><strong>Periksa kabel.</strong> Kencangkan konektor di kedua ujung. Kabel VGA yang bengkok pinnya sering menyebabkan tidak ada sinyal.</li>\n  <li><strong>Restart proyektor.</strong> Matikan, tunggu 30 detik, nyalakan kembali.</li>\n</ol>\n\n<h2>Resolusi Tidak Cocok</h2>\n<p>Jika gambar muncul tapi terpotong atau tidak proporsional, atur resolusi laptop ke 1024Ã—768 atau 1280Ã—720 â€” resolusi yang umum didukung proyektor kantor. Ubah di <em>Display Settings â†’ Resolution</em>.</p>\n\n<h2>Menggunakan Adaptor</h2>\n<p>Jika laptop hanya memiliki USB-C atau Mini DisplayPort, pastikan adaptor yang digunakan berkualitas baik. Adaptor murah sering menjadi sumber masalah sinyal tidak stabil.</p>', 'troubleshooting', 'published', '2026-03-26 01:35:11', NULL, 456, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(37, 109, 'Troubleshooting: Webcam Tidak Bekerja di Aplikasi Video Call', 'troubleshooting-webcam-tidak-bekerja-di-aplikasi-video-call', 'Tim IT Support', '<p>Kamera yang tidak muncul saat video call bisa mengganggu rapat penting. Masalah ini umumnya berkaitan dengan izin akses aplikasi atau driver.</p>\n\n<h2>Periksa Izin Kamera Windows</h2>\n<ol>\n  <li>Buka <em>Settings â†’ Privacy & security â†’ Camera</em>.</li>\n  <li>Pastikan <em>Camera access</em> dalam kondisi <strong>On</strong>.</li>\n  <li>Gulir ke bawah dan pastikan aplikasi yang digunakan (Teams, Zoom, Google Meet) memiliki izin kamera.</li>\n</ol>\n\n<h2>Periksa Tutup Privasi Fisik</h2>\n<p>Banyak laptop modern memiliki penutup privasi fisik di atas webcam. Geser atau buka penutup tersebut jika ada.</p>\n\n<h2>Pilih Kamera yang Benar di Aplikasi</h2>\n<p>Di pengaturan video aplikasi, pilih kamera yang tepat. Jika tersambung beberapa kamera (webcam eksternal + internal), aplikasi mungkin memilih yang salah.</p>\n\n<h2>Reinstall Driver Webcam</h2>\n<ol>\n  <li>Buka <em>Device Manager â†’ Cameras</em> atau <em>Imaging devices</em>.</li>\n  <li>Klik kanan driver webcam â†’ <em>Uninstall device</em>.</li>\n  <li>Scan for hardware changes atau restart untuk instal ulang driver.</li>\n</ol>\n\n<h2>Konflik Aplikasi</h2>\n<p>Hanya satu aplikasi yang dapat mengakses webcam secara bersamaan. Tutup aplikasi lain yang mungkin menggunakan kamera (Skype, Teams di background, dll.) sebelum membuka aplikasi video call.</p>', 'troubleshooting', 'published', '2026-03-27 01:35:11', NULL, 378, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(38, 109, 'Troubleshooting: Komputer Restart Sendiri Berulang Kali', 'troubleshooting-komputer-restart-sendiri-berulang-kali', 'Tim IT Support', '<p>Komputer yang tiba-tiba restart sendiri â€” terutama tanpa peringatan â€” bisa disebabkan masalah hardware, driver, atau sistem operasi. Identifikasi penyebabnya sebelum mengambil tindakan.</p>\n\n<h2>Nonaktifkan Automatic Restart untuk Melihat Error</h2>\n<ol>\n  <li>Klik kanan <em>This PC â†’ Properties â†’ Advanced system settings</em>.</li>\n  <li>Di bagian <em>Startup and Recovery</em>, klik <em>Settings</em>.</li>\n  <li>Hapus centang <em>Automatically restart</em>. Sekarang jika terjadi crash, akan muncul BSOD dengan kode error yang bisa dilaporkan.</li>\n</ol>\n\n<h2>Penyebab dan Solusi Umum</h2>\n<ul>\n  <li><strong>Overheating</strong> â€” periksa suhu prosesor dengan HWMonitor. Bersihkan kipas dan ventilasi.</li>\n  <li><strong>Driver rusak</strong> â€” terutama driver kartu grafis atau chipset. Update atau rollback driver setelah update terbaru.</li>\n  <li><strong>RAM bermasalah</strong> â€” jalankan <em>Windows Memory Diagnostic</em> (cari di Start Menu) untuk memindai error memori.</li>\n  <li><strong>PSU tidak stabil</strong> â€” power supply yang lemah tidak mampu menyuplai daya saat beban puncak.</li>\n  <li><strong>Malware</strong> â€” jalankan full scan antivirus.</li>\n</ul>\n\n<h2>Cara Membaca Event Log</h2>\n<p>Buka <em>Event Viewer</em> (cari di Start Menu) â†’ <em>Windows Logs â†’ System</em>. Cari entri <em>Critical</em> atau <em>Error</em> dengan waktu tepat sebelum restart. Catat Event ID dan sertakan dalam tiket helpdesk jika perlu eskalasi.</p>', 'troubleshooting', 'published', '2026-03-28 01:35:11', NULL, 467, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(39, 109, 'Troubleshooting: Touchpad Laptop Tidak Responsif', 'troubleshooting-touchpad-laptop-tidak-responsif', 'Tim IT Support', '<p>Touchpad yang tidak merespons sentuhan atau tidak bergerak sama sekali seringkali dapat diselesaikan dalam beberapa langkah sederhana.</p>\n\n<h2>Pemeriksaan Cepat</h2>\n<ol>\n  <li><strong>Cek tombol Fn.</strong> Hampir semua laptop memiliki kombinasi <kbd>Fn</kbd> + tombol touchpad untuk mengaktifkan/menonaktifkan touchpad. Tekan sekali untuk toggle.</li>\n  <li><strong>Cabut mouse USB.</strong> Beberapa laptop menonaktifkan touchpad otomatis saat mouse terpasang. Cabut mouse dan periksa apakah touchpad aktif kembali.</li>\n  <li><strong>Restart laptop.</strong> Driver touchpad yang crash akan dipulihkan saat reboot.</li>\n  <li><strong>Periksa pengaturan touchpad.</strong> Settings â†’ Bluetooth & devices â†’ Touchpad â†’ pastikan toggle <em>Touchpad</em> dalam posisi On.</li>\n</ol>\n\n<h2>Update Driver Touchpad</h2>\n<p>Unduh driver touchpad terbaru dari situs resmi produsen laptop (Dell, HP, Lenovo, ASUS, dll.). Driver Synaptics atau ELAN yang sudah usang sering menyebabkan touchpad tidak responsif setelah update Windows.</p>\n\n<h2>Touchpad Bergerak Sendiri</h2>\n<p>Jika kursor bergerak sendiri tanpa disentuh, kemungkinan ada tekanan dari bagian bawah laptop (baterai mengembung) atau sensitivity touchpad terlalu tinggi. Kurangi sensitivity di Settings â†’ Touchpad â†’ Sensitivity.</p>', 'troubleshooting', 'published', '2026-03-29 01:35:11', NULL, 289, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(40, 109, 'Troubleshooting: Monitor Berkedip-kedip (Flicker)', 'troubleshooting-monitor-berkedip-kedip-flicker', 'Tim IT Support', '<p>Monitor yang berkedip dapat melelahkan mata dan mengganggu fokus. Penyebabnya bisa dari refresh rate, kabel, driver, atau kondisi fisik monitor itu sendiri.</p>\n\n<h2>Atur Refresh Rate yang Tepat</h2>\n<ol>\n  <li>Klik kanan desktop â†’ <em>Display settings â†’ Advanced display settings</em>.</li>\n  <li>Ubah <em>Refresh rate</em> ke nilai yang disarankan (biasanya 60Hz untuk monitor kantor standar, 75Hz untuk yang lebih baru).</li>\n</ol>\n\n<h2>Periksa Kabel</h2>\n<ul>\n  <li>Ganti kabel HDMI atau VGA dengan yang baru. Kabel yang rusak atau terlalu panjang dapat menyebabkan sinyal tidak stabil.</li>\n  <li>Hindari menekuk kabel secara tajam.</li>\n  <li>Coba port output yang berbeda di laptop/GPU.</li>\n</ul>\n\n<h2>Update Driver Grafis</h2>\n<p>Driver kartu grafis yang usang atau corrupt adalah penyebab flicker yang sering terlewatkan. Unduh dan instal driver terbaru dari NVIDIA, AMD, atau Intel sesuai GPU Anda.</p>\n\n<h2>Flicker Hanya di Satu Sisi atau Area Tertentu</h2>\n<p>Ini mengindikasikan backlight yang mulai rusak atau panel monitor bermasalah â€” bukan masalah software. Segera buat tiket helpdesk karena kerusakan dapat meluas jika dibiarkan.</p>', 'troubleshooting', 'published', '2026-03-30 01:35:11', NULL, 312, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(41, 109, 'Troubleshooting: Port HDMI Laptop Tidak Mengeluarkan Gambar', 'troubleshooting-port-hdmi-laptop-tidak-mengeluarkan-gambar', 'Tim IT Support', '<p>Port HDMI yang tidak berfungsi membuat Anda tidak bisa menghubungkan laptop ke monitor atau proyektor eksternal. Berikut cara mendiagnosisnya.</p>\n\n<h2>Langkah Diagnosis</h2>\n<ol>\n  <li><strong>Coba kabel HDMI berbeda.</strong> Kabel HDMI bisa rusak secara internal tanpa tanda fisik yang terlihat.</li>\n  <li><strong>Coba port HDMI berbeda di monitor/TV tujuan.</strong> Monitor biasanya memiliki lebih dari satu port HDMI.</li>\n  <li><strong>Tekan <kbd>Win</kbd>+<kbd>P</kbd></strong> dan pilih <em>Duplicate</em> atau <em>Second screen only</em>.</li>\n  <li><strong>Update driver kartu grafis.</strong> Driver yang usang sering menyebabkan HDMI tidak dideteksi.</li>\n  <li><strong>Periksa di Display Settings</strong> apakah monitor kedua terdeteksi. Jika ya, klik <em>Detect</em> atau atur tampilan secara manual.</li>\n</ol>\n\n<h2>Port HDMI Fisik Bermasalah</h2>\n<p>Jika konektor HDMI terasa longgar atau bergoyang saat dipasang, mungkin pin di dalam port bengkok atau solder di motherboard retak. Ini memerlukan perbaikan hardware oleh teknisi.</p>\n\n<h2>Alternatif Sementara</h2>\n<p>Gunakan adaptor USB-C to HDMI atau docking station sebagai solusi sementara sambil menunggu perbaikan. Hubungi IT untuk ketersediaan perangkat peminjaman.</p>', 'troubleshooting', 'published', '2026-03-31 01:35:11', NULL, 267, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(42, 109, 'Troubleshooting: Komputer Berbunyi Beep saat Dinyalakan', 'troubleshooting-komputer-berbunyi-beep-saat-dinyalakan', 'Tim IT Support', '<p>Bunyi beep saat POST (Power-On Self Test) adalah bahasa komunikasi motherboard tentang kerusakan yang ditemukannya. Pola bunyi membantu mengidentifikasi komponen yang bermasalah.</p>\n\n<h2>Tabel Pola Beep Umum (BIOS AMI/AWARD)</h2>\n<table style="border-collapse:collapse;width:100%">\n  <tr style="background:#f3f4f6"><th style="padding:8px;border:1px solid #ddd">Pola Beep</th><th style="padding:8px;border:1px solid #ddd">Kemungkinan Penyebab</th></tr>\n  <tr><td style="padding:8px;border:1px solid #ddd">1 beep pendek</td><td style="padding:8px;border:1px solid #ddd">POST berhasil â€” normal</td></tr>\n  <tr><td style="padding:8px;border:1px solid #ddd">1 beep panjang terus-menerus</td><td style="padding:8px;border:1px solid #ddd">Masalah RAM (tidak terpasang atau rusak)</td></tr>\n  <tr><td style="padding:8px;border:1px solid #ddd">1 panjang + 2 pendek</td><td style="padding:8px;border:1px solid #ddd">Masalah kartu grafis</td></tr>\n  <tr><td style="padding:8px;border:1px solid #ddd">3 beep berulang</td><td style="padding:8px;border:1px solid #ddd">Kegagalan RAM</td></tr>\n  <tr><td style="padding:8px;border:1px solid #ddd">5 beep</td><td style="padding:8px;border:1px solid #ddd">Masalah prosesor</td></tr>\n</table>\n\n<h2>Yang Bisa Dicoba Sendiri</h2>\n<ol>\n  <li><strong>Perbaiki posisi RAM.</strong> Matikan, cabut RAM dari slotnya, bersihkan konektor emas dengan penghapus pensil, pasang kembali dengan kencang.</li>\n  <li><strong>Coba satu stik RAM</strong> jika ada dua, bergantian, untuk mengetahui stik mana yang bermasalah.</li>\n  <li><strong>Cabut kartu grafis discrete</strong> (jika ada) dan coba boot dengan grafis onboard.</li>\n</ol>\n\n<p>Catat pola beep dengan teliti dan sertakan dalam tiket helpdesk â€” informasi ini sangat membantu teknisi menyiapkan komponen pengganti yang tepat.</p>', 'troubleshooting', 'published', '2026-04-01 01:35:11', NULL, 398, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(43, 109, 'Troubleshooting: Headset atau Mikrofon Tidak Terdeteksi', 'troubleshooting-headset-atau-mikrofon-tidak-terdeteksi', 'Tim IT Support', '<p>Headset yang tidak dikenali sistem dapat mengganggu rapat online dan komunikasi. Masalah ini umumnya mudah diselesaikan.</p>\n\n<h2>Headset Jack 3.5mm</h2>\n<ol>\n  <li><strong>Pastikan menggunakan port yang benar.</strong> Laptop modern sering menggabungkan port headphone dan mikrofon menjadi satu jack TRRS (4 kutub). Headset dengan konektor TRRS mungkin tidak berfungsi penuh di port TRS biasa â€” gunakan splitter jika perlu.</li>\n  <li><strong>Set sebagai default device.</strong> Klik kanan ikon speaker â†’ <em>Open Sound settings</em> â†’ pilih headset sebagai output dan input default.</li>\n  <li><strong>Periksa di Recording tab.</strong> Klik kanan ikon speaker â†’ <em>Sound</em> â†’ tab <em>Recording</em> â†’ klik kanan area kosong â†’ <em>Show Disabled Devices</em>. Aktifkan mikrofon headset jika tersembunyi.</li>\n</ol>\n\n<h2>Headset USB</h2>\n<ol>\n  <li>Coba port USB berbeda.</li>\n  <li>Buka <em>Device Manager â†’ Sound, video and game controllers</em> â€” pastikan headset USB muncul tanpa tanda error.</li>\n  <li>Update driver USB audio controller.</li>\n</ol>\n\n<h2>Izin Privasi Mikrofon</h2>\n<p>Buka <em>Settings â†’ Privacy & security â†’ Microphone</em> â†’ pastikan akses mikrofon dan izin untuk aplikasi yang Anda gunakan dalam kondisi On.</p>', 'troubleshooting', 'published', '2026-04-02 01:35:11', NULL, 276, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(44, 109, 'Troubleshooting: Charger Laptop Panas Berlebihan', 'troubleshooting-charger-laptop-panas-berlebihan', 'Tim IT Support', '<p>Adaptor charger yang panas wajar terjadi, tetapi panas berlebihan (terasa membakar saat disentuh) adalah tanda bahaya yang perlu segera ditangani.</p>\n\n<h2>Batas Normal vs Berbahaya</h2>\n<ul>\n  <li><strong>Hangat (~40-50Â°C):</strong> Normal saat mengisi daya.</li>\n  <li><strong>Panas (~55-65Â°C):</strong> Perlu diperhatikan. Pastikan ventilasi charger tidak tertutup.</li>\n  <li><strong>Sangat panas (&gt;70Â°C / tidak bisa dipegang):</strong> <strong>Berbahaya.</strong> Segera cabut dari stopkontak.</li>\n</ul>\n\n<h2>Penyebab Charger Terlalu Panas</h2>\n<ul>\n  <li>Charger terkubur di bawah bantal atau karpet yang menghambat disipasi panas.</li>\n  <li>Charger tidak original atau palsu â€” kualitas komponen lebih rendah.</li>\n  <li>Kabel atau konektor yang rusak menyebabkan hambatan listrik berlebih.</li>\n  <li>Charger berkapasitas tidak sesuai (watt terlalu rendah untuk laptop).</li>\n</ul>\n\n<h2>Tindakan yang Harus Dilakukan</h2>\n<ol>\n  <li>Letakkan charger di permukaan keras dengan ruang terbuka.</li>\n  <li>Periksa kabel â€” jika ada bagian yang terkelupas, bengkok, atau terbakar, <strong>hentikan penggunaan segera.</strong></li>\n  <li>Hubungi IT untuk penggantian charger original. Jangan gunakan charger yang tidak sesuai spesifikasi laptop karena berisiko merusak baterai dan motherboard.</li>\n</ol>', 'troubleshooting', 'published', '2026-04-03 01:35:11', NULL, 445, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(45, 109, 'Troubleshooting: RAM Tidak Terbaca Semua oleh Sistem', 'troubleshooting-ram-tidak-terbaca-semua-oleh-sistem', 'Tim IT Support', '<p>Windows melaporkan RAM lebih kecil dari yang terpasang? Ini masalah yang dapat terjadi karena berbagai alasan mulai dari setting BIOS hingga pembatasan sistem operasi.</p>\n\n<h2>Langkah Pemeriksaan</h2>\n<ol>\n  <li><strong>Cek di System Information.</strong> Tekan <kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>msinfo32</code>. Lihat <em>Installed Physical Memory (RAM)</em> vs <em>Total Physical Memory</em>. Perbedaan kecil (misalnya 16 GB terpasang, 15.9 GB tersedia) adalah normal karena digunakan oleh BIOS/GPU onboard.</li>\n  <li><strong>Periksa Windows edition.</strong> Windows Home 32-bit hanya mendukung maksimal 4 GB RAM. Pastikan Anda menggunakan edisi 64-bit.</li>\n  <li><strong>Cek Maximum Memory di MSCONFIG.</strong> Tekan <kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>msconfig</code> â†’ tab <em>Boot â†’ Advanced options</em> â†’ pastikan <em>Maximum memory</em> tidak dicentang atau nilainya benar.</li>\n  <li><strong>Periksa slot RAM.</strong> Buka Device Manager atau HWiNFO untuk melihat apakah semua slot terdeteksi. Slot yang rusak tidak akan menampilkan stik RAM yang terpasang di dalamnya.</li>\n</ol>\n\n<h2>Perbaikan di BIOS</h2>\n<p>Beberapa BIOS memiliki pengaturan memory remap atau iGPU memory yang mempengaruhi RAM yang terlihat sistem. Minta bantuan IT untuk menyesuaikan pengaturan BIOS â€” jangan mengubah BIOS sendiri tanpa pengetahuan memadai.</p>', 'troubleshooting', 'published', '2026-04-04 01:35:11', NULL, 223, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(46, 109, 'Troubleshooting: Scanner Tidak Mendeteksi Dokumen', 'troubleshooting-scanner-tidak-mendeteksi-dokumen', 'Tim IT Support', '<p>Scanner yang tidak merespons atau tidak mendeteksi dokumen dapat disebabkan oleh masalah koneksi, driver, atau konfigurasi software.</p>\n\n<h2>Pemeriksaan Dasar</h2>\n<ol>\n  <li><strong>Pastikan scanner dalam posisi Ready</strong> (lampu indikator hijau stabil, bukan berkedip).</li>\n  <li><strong>Periksa koneksi USB atau jaringan.</strong> Untuk scanner jaringan, pastikan IP address scanner masih sama â€” IP bisa berubah jika DHCP melakukan re-assign.</li>\n  <li><strong>Letakkan dokumen dengan benar.</strong> Pastikan tidak ada kertas miring yang memicu sensor keamanan. Beberapa scanner ADF memiliki sensor kecil yang harus tertutup dokumen.</li>\n</ol>\n\n<h2>Masalah Driver dan Software</h2>\n<ol>\n  <li>Buka <em>Devices and Printers</em> â€” scanner seharusnya terlihat. Jika ada tanda seru, klik kanan â†’ troubleshoot.</li>\n  <li>Reinstall software scanner dari CD bawaan atau situs resmi produsen (Canon, Epson, HP, dll.).</li>\n  <li>Restart layanan Windows Image Acquisition: <kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>services.msc</code> â†’ cari <em>Windows Image Acquisition (WIA)</em> â†’ Restart.</li>\n</ol>\n\n<h2>Scan dari Aplikasi Berbeda</h2>\n<p>Coba gunakan <em>Windows Fax and Scan</em> (bawaan Windows) sebagai pengganti software scanner. Jika berhasil di sini tapi tidak di aplikasi lain, masalah ada di software, bukan driver.</p>', 'troubleshooting', 'published', '2026-04-05 01:35:11', NULL, 198, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(47, 109, 'Troubleshooting: Windows Tidak Bisa Booting (Stuck di Loading)', 'troubleshooting-windows-tidak-bisa-booting-stuck-di-loading', 'Tim IT Support', '<p>Windows yang stuck di layar loading (logo Windows berputar terus) atau langsung restart loop setelah splash screen adalah salah satu kasus yang paling sering membutuhkan intervensi IT.</p>\n\n<h2>Langkah Pemulihan Mandiri</h2>\n<ol>\n  <li><strong>Boot ke Safe Mode.</strong> Restart komputer, tekan <kbd>F8</kbd> atau <kbd>Shift</kbd>+<kbd>F8</kbd> berulang saat logo muncul. Pilih <em>Safe Mode with Networking</em>. Jika berhasil masuk, penyebabnya adalah driver atau aplikasi startup yang rusak.</li>\n  <li><strong>Gunakan Startup Repair.</strong> Boot dari USB/DVD Windows â†’ pilih <em>Repair your computer â†’ Troubleshoot â†’ Advanced options â†’ Startup Repair</em>.</li>\n  <li><strong>Jalankan System Restore</strong> dari Advanced Options untuk kembali ke titik pemulihan sebelum masalah terjadi.</li>\n  <li><strong>Perbaiki Boot Record:</strong> di Command Prompt dari Advanced Options, jalankan:\n    <pre>bootrec /fixmbr\nbootrec /fixboot\nbootrec /rebuildbcd</pre>\n  </li>\n</ol>\n\n<h2>Penyebab Umum</h2>\n<ul>\n  <li>Windows Update yang gagal di tengah proses.</li>\n  <li>Driver yang tidak kompatibel terpasang.</li>\n  <li>File sistem Windows corrupt.</li>\n  <li>Hard disk/SSD mulai rusak.</li>\n</ul>\n\n<p>Jika semua langkah gagal, buat tiket dengan prioritas <strong>High</strong> â€” teknisi perlu membawa laptop untuk pemeriksaan lebih lanjut.</p>', 'troubleshooting', 'published', '2026-04-06 01:35:11', NULL, 678, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(48, 109, 'Troubleshooting: Blue Screen of Death (BSOD) pada Windows', 'troubleshooting-blue-screen-of-death-bsod-pada-windows', 'Tim IT Support', '<p>BSOD (layar biru dengan pesan error) terjadi ketika Windows mengalami kegagalan kritis yang tidak dapat ditangani. Kode error yang ditampilkan adalah kunci untuk diagnosis.</p>\n\n<h2>Kode BSOD yang Paling Umum</h2>\n<ul>\n  <li><code>DRIVER_IRQL_NOT_LESS_OR_EQUAL</code> â€” driver yang tidak kompatibel atau corrupt, paling sering driver jaringan atau GPU.</li>\n  <li><code>MEMORY_MANAGEMENT</code> â€” masalah RAM (fisik atau driver).</li>\n  <li><code>CRITICAL_PROCESS_DIED</code> â€” file sistem Windows corrupt.</li>\n  <li><code>SYSTEM_SERVICE_EXCEPTION</code> â€” driver pihak ketiga bermasalah.</li>\n  <li><code>NTFS_FILE_SYSTEM</code> â€” hard disk/SSD bermasalah.</li>\n</ul>\n\n<h2>Langkah Penanganan</h2>\n<ol>\n  <li><strong>Catat kode BSOD</strong> atau foto layar biru tersebut sebelum komputer restart.</li>\n  <li><strong>Periksa Windows Event Viewer</strong> (cari di Start) â†’ <em>Windows Logs â†’ System</em> â†’ filter event Critical untuk melihat log crash.</li>\n  <li><strong>Update semua driver</strong>, terutama driver GPU dan chipset.</li>\n  <li><strong>Jalankan SFC:</strong> buka Command Prompt Administrator, ketik <code>sfc /scannow</code>. Proses ini memeriksa dan memperbaiki file sistem Windows yang rusak.</li>\n  <li><strong>Jalankan Windows Memory Diagnostic</strong> untuk memeriksa RAM.</li>\n</ol>\n\n<h2>BSOD Terjadi Setelah Instal Hardware/Software Baru</h2>\n<p>Uninstal perangkat keras atau software tersebut dan periksa apakah BSOD berhenti. Buat tiket helpdesk dengan menyertakan kode BSOD dan foto layar biru untuk penanganan lebih lanjut.</p>', 'troubleshooting', 'published', '2026-04-07 01:35:11', NULL, 721, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(49, 109, 'Troubleshooting: Aplikasi Tiba-tiba Not Responding', 'troubleshooting-aplikasi-tiba-tiba-not-responding', 'Tim IT Support', '<p>Aplikasi yang tiba-tiba freeze dan menampilkan "(Not Responding)" di judul jendela bisa disebabkan oleh memori penuh, proses yang berbenturan, atau bug dalam aplikasi itu sendiri.</p>\n\n<h2>Penanganan Segera</h2>\n<ol>\n  <li><strong>Tunggu beberapa saat.</strong> Aplikasi mungkin sedang memproses tugas berat. Jangan klik berulang kali â€” itu justru menambah antrian perintah yang memperparah freeze.</li>\n  <li><strong>Force close melalui Task Manager.</strong> Tekan <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd>, klik kanan aplikasi bermasalah â†’ <em>End Task</em>. Simpan pekerjaan sebelumnya jika ada dialog recovery.</li>\n</ol>\n\n<h2>Mengatasi Masalah Berulang</h2>\n<ul>\n  <li><strong>Kosongkan RAM.</strong> Tutup aplikasi yang tidak perlu. Tambahkan RAM jika komputer sering kehabisan memori.</li>\n  <li><strong>Reinstall aplikasi</strong> jika hanya satu aplikasi yang sering hang. Hapus folder cache aplikasi sebelum reinstall.</li>\n  <li><strong>Perbarui aplikasi</strong> ke versi terbaru â€” bug yang menyebabkan freeze biasanya diperbaiki di update.</li>\n  <li><strong>Periksa hard disk.</strong> Aplikasi yang lambat membaca/menulis data dari disk yang hampir penuh atau bermasalah dapat menyebabkan not responding. Kosongkan space minimal 15% kapasitas total.</li>\n</ul>\n\n<h2>Aplikasi Office (Word/Excel) Not Responding</h2>\n<p>Matikan Add-in yang tidak perlu: <em>File â†’ Options â†’ Add-ins â†’ Manage: COM Add-ins â†’ Go</em> â†’ nonaktifkan add-in pihak ketiga satu per satu untuk menemukan penyebabnya.</p>', 'troubleshooting', 'published', '2026-04-08 01:35:11', NULL, 534, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(50, 109, 'Troubleshooting: Windows Update Gagal atau Stuck', 'troubleshooting-windows-update-gagal-atau-stuck', 'Tim IT Support', '<p>Windows Update yang gagal dengan kode error atau stuck di persentase tertentu adalah masalah umum. Berikut cara mengatasinya tanpa install ulang.</p>\n\n<h2>Cara 1: Windows Update Troubleshooter</h2>\n<p>Buka <em>Settings â†’ System â†’ Troubleshoot â†’ Other troubleshooters â†’ Windows Update â†’ Run</em>. Tool ini secara otomatis mendeteksi dan memperbaiki masalah update umum.</p>\n\n<h2>Cara 2: Reset Windows Update Components</h2>\n<p>Buka Command Prompt sebagai Administrator, jalankan perintah berikut satu per satu:</p>\n<pre>net stop wuauserv\nnet stop cryptSvc\nnet stop bits\nnet stop msiserver\nren C:\\Windows\\SoftwareDistribution SoftwareDistribution.old\nren C:\\Windows\\System32\\catroot2 Catroot2.old\nnet start wuauserv\nnet start cryptSvc\nnet start bits\nnet start msiserver</pre>\n<p>Restart komputer, lalu coba update kembali.</p>\n\n<h2>Cara 3: Manual Update via Catalog</h2>\n<p>Jika update tertentu terus gagal, unduh secara manual dari <em>catalog.update.microsoft.com</em> menggunakan nomor KB yang ditampilkan di detail error. Instal secara manual dengan klik dua kali file .msu yang diunduh.</p>\n\n<h2>Ruang Disk Tidak Cukup</h2>\n<p>Windows Update membutuhkan minimal 10-20 GB ruang kosong. Bersihkan disk dengan <em>Storage Sense</em> atau hapus file Temporary Windows Update yang lama dari <code>C:\\Windows\\SoftwareDistribution\\Download</code>.</p>', 'troubleshooting', 'published', '2026-04-09 01:35:11', NULL, 389, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(51, 109, 'Troubleshooting: Driver Perangkat Tidak Terinstal dengan Benar', 'troubleshooting-driver-perangkat-tidak-terinstal-dengan-benar', 'Tim IT Support', '<p>Tanda seru kuning di Device Manager menunjukkan driver yang bermasalah. Ini dapat menyebabkan perangkat tidak bekerja optimal atau sama sekali.</p>\n\n<h2>Cara Membaca Device Manager</h2>\n<ol>\n  <li>Klik kanan <em>This PC â†’ Properties â†’ Device Manager</em> atau cari "Device Manager" di Start.</li>\n  <li>Ikon tanda seru (!) kuning = driver error.</li>\n  <li>Ikon tanda tanya (?) = driver tidak dikenali.</li>\n  <li>Ikon panah bawah = perangkat dinonaktifkan.</li>\n</ol>\n\n<h2>Cara Menginstal Driver yang Benar</h2>\n<ol>\n  <li><strong>Update otomatis:</strong> klik kanan perangkat â†’ <em>Update driver â†’ Search automatically</em>. Cocok untuk driver umum.</li>\n  <li><strong>Download manual:</strong> cari tahu model perangkat (klik kanan â†’ Properties â†’ tab Details â†’ Hardware Ids), lalu unduh driver dari situs produsen.</li>\n  <li><strong>Gunakan software driver:</strong> untuk laptop merek tertentu, gunakan Dell Support Assist, HP Support Assistant, atau Lenovo Vantage yang otomatis mendeteksi dan menginstal driver yang diperlukan.</li>\n</ol>\n\n<h2>Setelah Windows Update</h2>\n<p>Windows Update kadang mengganti driver pihak ketiga dengan versi generic. Jika perangkat bermasalah setelah update, coba rollback driver: klik kanan perangkat â†’ Properties â†’ tab Driver â†’ <em>Roll Back Driver</em>.</p>', 'troubleshooting', 'published', '2026-04-10 01:35:11', NULL, 312, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(52, 109, 'Troubleshooting: Browser Tidak Bisa Membuka Halaman Web', 'troubleshooting-browser-tidak-bisa-membuka-halaman-web', 'Tim IT Support', '<p>"This site can\'t be reached" atau halaman error adalah gangguan yang bisa disebabkan oleh koneksi, DNS, atau konfigurasi browser itu sendiri.</p>\n\n<h2>Diagnosa Cepat</h2>\n<ol>\n  <li><strong>Cek koneksi internet.</strong> Buka Command Prompt, ketik <code>ping 8.8.8.8</code>. Jika ada reply, internet terhubung dan masalah ada di DNS atau browser.</li>\n  <li><strong>Coba browser lain</strong> (Edge, Firefox, Chrome). Jika berhasil di browser lain, masalah spesifik di browser tertentu.</li>\n  <li><strong>Buka dalam mode Incognito/Private.</strong> Jika berhasil, masalah ada di ekstensi atau cache browser.</li>\n</ol>\n\n<h2>Bersihkan Cache dan Cookie</h2>\n<p>Di Chrome: <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Delete</kbd> â†’ pilih rentang waktu <em>All time</em> â†’ centang Cached images/files dan Cookies â†’ Clear data.</p>\n\n<h2>Reset DNS</h2>\n<p>Buka Command Prompt Administrator:</p>\n<pre>ipconfig /flushdns\nipconfig /release\nipconfig /renew\nnetsh winsock reset</pre>\n<p>Restart komputer setelahnya.</p>\n\n<h2>Nonaktifkan Ekstensi Browser</h2>\n<p>Ekstensi VPN, ad-blocker, atau proxy yang salah konfigurasi dapat memblokir akses web. Nonaktifkan semua ekstensi di <em>Settings â†’ Extensions</em> dan coba kembali.</p>', 'troubleshooting', 'published', '2026-04-11 01:35:11', NULL, 498, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(53, 109, 'Troubleshooting: File Microsoft Word Rusak (Corrupt) Tidak Bisa Dibuka', 'troubleshooting-file-microsoft-word-rusak-corrupt-tidak-bisa-dibuka', 'Tim IT Support', '<p>Dokumen Word yang tiba-tiba tidak bisa dibuka atau menampilkan pesan error sering kali masih bisa dipulihkan dengan beberapa teknik berikut.</p>\n\n<h2>Metode Pemulihan Bawaan Word</h2>\n<ol>\n  <li>Buka Word (tanpa membuka file).</li>\n  <li>Klik <em>File â†’ Open â†’ Browse</em>, navigasi ke file yang bermasalah.</li>\n  <li>Klik panah kecil di sebelah tombol <em>Open</em> â†’ pilih <strong>Open and Repair</strong>.</li>\n</ol>\n\n<h2>Gunakan Fitur Text Recovery Converter</h2>\n<ol>\n  <li><em>File â†’ Open</em>, di dropdown tipe file pilih <em>Recover Text from Any File (*.*)</em>.</li>\n  <li>Pilih file yang rusak. Word akan mengekstrak teks semampunya, meski pemformatan mungkin hilang.</li>\n</ol>\n\n<h2>AutoRecover</h2>\n<p>Word secara otomatis menyimpan file sementara. Buka Word, klik <em>File â†’ Info â†’ Manage Document â†’ Recover Unsaved Documents</em>. Cari file dengan nama dan tanggal yang sesuai.</p>\n\n<h2>Gunakan Previous Versions</h2>\n<p>Klik kanan file di File Explorer â†’ <em>Properties â†’ Previous Versions</em>. Windows atau OneDrive mungkin memiliki versi cadangan sebelum file rusak.</p>\n\n<h2>Pencegahan</h2>\n<ul>\n  <li>Aktifkan AutoSave dan simpan ke OneDrive agar ada versi cloud yang selalu tersedia.</li>\n  <li>Jangan tutup paksa Word saat sedang menyimpan.</li>\n  <li>Cabut flashdisk dengan aman (Safely Remove) sebelum mencabut.</li>\n</ul>', 'troubleshooting', 'published', '2026-04-12 01:35:11', NULL, 445, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(54, 109, 'Troubleshooting: Excel Formula Tidak Menghasilkan Nilai yang Benar', 'troubleshooting-excel-formula-tidak-menghasilkan-nilai-yang-benar', 'Tim IT Support', '<p>Formula Excel yang menampilkan hasil salah, #ERROR, atau teks literal formula adalah masalah yang sangat umum di lingkungan kantor.</p>\n\n<h2>Formula Menampilkan Teks Literal (Tidak Dihitung)</h2>\n<ul>\n  <li>Sel mungkin diformat sebagai <em>Text</em>. Ubah format sel ke <em>General</em> atau <em>Number</em> melalui <em>Home â†’ Number Format</em>, lalu tekan <kbd>F2</kbd> â†’ <kbd>Enter</kbd> untuk memaksa kalkulasi ulang.</li>\n  <li>Pastikan formula dimulai dengan tanda sama dengan (<code>=</code>).</li>\n  <li>Cek apakah <em>Show Formulas</em> aktif: <kbd>Ctrl</kbd>+<kbd>`</kbd> (backtick) untuk toggle.</li>\n</ul>\n\n<h2>Kode Error Umum</h2>\n<ul>\n  <li><code>#DIV/0!</code> â€” pembagian dengan nol atau sel kosong. Gunakan <code>=IFERROR(A1/B1, 0)</code>.</li>\n  <li><code>#REF!</code> â€” referensi sel tidak valid (sel yang dirujuk dihapus). Perbarui formula.</li>\n  <li><code>#VALUE!</code> â€” tipe data tidak sesuai (teks di sel yang seharusnya angka). Periksa data sumber.</li>\n  <li><code>#N/A</code> â€” nilai tidak ditemukan (umum pada VLOOKUP). Pastikan nilai pencarian ada di tabel referensi.</li>\n  <li><code>#NAME?</code> â€” nama fungsi salah ketik. Periksa ejaan nama fungsi.</li>\n</ul>\n\n<h2>Calculation Mode Manual</h2>\n<p>Jika nilai tidak berubah meski data sudah diedit, periksa <em>Formulas â†’ Calculation Options â†’ Automatic</em>. Mode manual tidak menghitung ulang formula secara otomatis.</p>', 'troubleshooting', 'published', '2026-04-13 01:35:11', NULL, 367, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(55, 109, 'Troubleshooting: Outlook Tidak Bisa Mengirim atau Menerima Email', 'troubleshooting-outlook-tidak-bisa-mengirim-atau-menerima-email', 'Tim IT Support', '<p>Email yang terjebak di Outbox atau inbox yang tidak memperbarui pesan baru adalah gangguan produktivitas yang perlu diselesaikan segera.</p>\n\n<h2>Email Terjebak di Outbox</h2>\n<ol>\n  <li>Buka folder <em>Outbox</em>, pindahkan email ke <em>Drafts</em> (drag & drop) untuk menghentikan proses pengiriman yang macet.</li>\n  <li>Offline mode mungkin aktif: cek menu <em>Send/Receive â†’ Work Offline</em> â€” pastikan tidak ada tanda centang.</li>\n  <li>Periksa ukuran lampiran â€” batas ukuran email server biasanya 25 MB.</li>\n</ol>\n\n<h2>Inbox Tidak Memperbarui Pesan</h2>\n<ol>\n  <li>Tekan <kbd>F9</kbd> atau klik <em>Send/Receive All Folders</em> untuk paksa sinkronisasi.</li>\n  <li>Periksa indikator koneksi di pojok kanan bawah Outlook. Jika tertulis <em>Disconnected</em> atau <em>Trying to connect</em>, ada masalah koneksi ke server.</li>\n  <li>Restart Outlook dalam Safe Mode: <kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>outlook /safe</code>. Jika berhasil di Safe Mode, masalah disebabkan Add-in.</li>\n</ol>\n\n<h2>Repair Profil Outlook</h2>\n<p>Buka <em>Control Panel â†’ Mail â†’ Show Profiles â†’ pilih profil â†’ Properties â†’ Email Accounts â†’ Repair</em>. Ikuti wizard untuk memperbaiki konfigurasi akun secara otomatis.</p>\n\n<h2>Rebuild OST/PST File</h2>\n<p>File data Outlook yang besar atau corrupt perlu diperbaiki dengan SCANPST.EXE (cari di folder instalasi Office). Hubungi IT jika tidak menemukan tool ini.</p>', 'troubleshooting', 'published', '2026-04-14 01:35:11', NULL, 412, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(56, 109, 'Troubleshooting: Tidak Bisa Menginstal Aplikasi di Windows', 'troubleshooting-tidak-bisa-menginstal-aplikasi-di-windows', 'Tim IT Support', '<p>Pesan "You don\'t have permission to install" atau installer yang langsung menutup tanpa proses adalah masalah yang umumnya berkaitan dengan hak akses atau Group Policy.</p>\n\n<h2>Penyebab Umum dan Solusinya</h2>\n\n<h3>1. Kurang Hak Administrator</h3>\n<p>Klik kanan file installer â†’ <em>Run as administrator</em>. Jika diminta password, hubungi IT untuk proseskan instalasi.</p>\n\n<h3>2. UAC Memblokir Instalasi</h3>\n<p>User Account Control (UAC) dapat memblokir aplikasi tertentu. Pastikan Anda mengklik <em>Yes</em> pada prompt UAC yang muncul. Jika tidak muncul, mungkin aplikasi diblokir oleh Group Policy.</p>\n\n<h3>3. Windows SmartScreen Memblokir</h3>\n<p>Klik <em>More info â†’ Run anyway</em> jika Anda yakin aplikasi aman. SmartScreen hanya memblokir aplikasi tanpa sertifikat digital terverifikasi, bukan berarti selalu berbahaya.</p>\n\n<h3>4. Antivirus Memblokir</h3>\n<p>Nonaktifkan sementara perlindungan real-time antivirus, instal aplikasi, lalu aktifkan kembali. Atau tambahkan pengecualian untuk installer tersebut.</p>\n\n<h3>5. Ruang Disk Tidak Cukup</h3>\n<p>Pastikan drive C: memiliki ruang kosong yang cukup. Beberapa installer membutuhkan 2-3x ukuran aplikasi untuk sementara.</p>\n\n<p>Untuk instalasi software resmi kantor, selalu ajukan permintaan melalui tiket helpdesk agar IT dapat memproses dengan hak yang sesuai.</p>', 'troubleshooting', 'published', '2026-04-15 01:35:11', NULL, 289, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(57, 109, 'Troubleshooting: Koneksi VPN Gagal atau Terputus', 'troubleshooting-koneksi-vpn-gagal-atau-terputus', 'Tim IT Support', '<p>VPN yang tidak bisa terhubung atau sering putus dapat menghambat akses ke sistem dan resource internal kantor, terutama saat bekerja dari luar kantor.</p>\n\n<h2>Langkah Diagnosis</h2>\n<ol>\n  <li><strong>Verifikasi koneksi internet dasar.</strong> VPN tidak akan bisa terhubung jika internet utama bermasalah. Buka website eksternal dahulu untuk memastikan.</li>\n  <li><strong>Cek username dan password.</strong> Password akun mungkin sudah kadaluarsa atau berubah. Coba login ke portal internal lainnya dengan kredensial yang sama.</li>\n  <li><strong>Ganti server VPN</strong> jika tersedia beberapa pilihan. Server yang dipilih mungkin sedang dalam pemeliharaan.</li>\n  <li><strong>Nonaktifkan sementara firewall/antivirus</strong> untuk menguji apakah mereka yang memblokir koneksi VPN.</li>\n</ol>\n\n<h2>VPN Terhubung tapi Tidak Bisa Akses Resource Internal</h2>\n<ul>\n  <li>Pastikan <em>Split tunneling</em> dikonfigurasi dengan benar. Hubungi IT untuk cek konfigurasi rute.</li>\n  <li>Flush DNS setelah terhubung VPN: <code>ipconfig /flushdns</code> di Command Prompt.</li>\n</ul>\n\n<h2>Reinstall Klien VPN</h2>\n<p>Uninstal klien VPN, restart komputer, unduh versi terbaru dari portal IT internal, dan instal ulang. Backup konfigurasi koneksi sebelum uninstal.</p>', 'troubleshooting', 'published', '2026-04-16 01:35:11', NULL, 334, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(58, 109, 'Troubleshooting: Remote Desktop Tidak Bisa Terhubung', 'troubleshooting-remote-desktop-tidak-bisa-terhubung', 'Tim IT Support', '<p>Remote Desktop Protocol (RDP) yang gagal terhubung dengan pesan "cannot connect to the remote computer" bisa disebabkan oleh berbagai faktor di sisi klien maupun server.</p>\n\n<h2>Di Komputer Target (yang Ingin Diremote)</h2>\n<ol>\n  <li><strong>Aktifkan Remote Desktop:</strong> klik kanan <em>This PC â†’ Properties â†’ Remote settings â†’ Allow remote connections to this computer</em>.</li>\n  <li><strong>Pastikan komputer target menyala dan tidak sleep.</strong> Ubah pengaturan power agar komputer tidak sleep saat tidak aktif.</li>\n  <li><strong>Tambahkan pengguna yang diizinkan:</strong> di pengaturan Remote Desktop, klik <em>Select Users</em> dan tambahkan akun yang akan digunakan untuk koneksi.</li>\n</ol>\n\n<h2>Di Komputer Klien (yang Akan Meremote)</h2>\n<ol>\n  <li>Pastikan alamat IP atau hostname yang dimasukkan benar. Gunakan <code>ipconfig</code> di komputer target untuk memverifikasi IP.</li>\n  <li>Coba ping ke komputer target: <code>ping [IP-target]</code>. Jika gagal, masalah ada di jaringan/firewall.</li>\n</ol>\n\n<h2>Masalah Firewall</h2>\n<p>Windows Firewall mungkin memblokir port RDP (3389). Di komputer target, buka <em>Windows Defender Firewall â†’ Allow an app â†’ Remote Desktop</em> dan pastikan diizinkan. Untuk jaringan kantor, hubungi IT jika firewall jaringan memblokir koneksi.</p>', 'troubleshooting', 'published', '2026-04-17 01:35:11', NULL, 245, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(59, 109, 'Troubleshooting: Google Chrome Sering Crash atau Not Responding', 'troubleshooting-google-chrome-sering-crash-atau-not-responding', 'Tim IT Support', '<p>Chrome yang sering crash, tab yang menutup sendiri, atau pesan "Aw, Snap!" adalah gangguan yang menghambat pekerjaan berbasis web.</p>\n\n<h2>Solusi Bertahap</h2>\n<ol>\n  <li><strong>Perbarui Chrome.</strong> Klik menu â‹® â†’ <em>Help â†’ About Google Chrome</em>. Chrome akan otomatis cek dan instal update jika tersedia.</li>\n  <li><strong>Nonaktifkan semua ekstensi.</strong> Buka <code>chrome://extensions</code>, nonaktifkan semua, restart Chrome, dan cek apakah masalah hilang. Aktifkan kembali satu per satu untuk menemukan ekstensi bermasalah.</li>\n  <li><strong>Bersihkan cache:</strong> <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Delete</kbd> â†’ hapus Cached images/files dan Cookies untuk rentang waktu <em>All time</em>.</li>\n  <li><strong>Nonaktifkan Hardware Acceleration.</strong> Settings â†’ Advanced â†’ System â†’ matikan <em>Use hardware acceleration when available</em>. Restart Chrome.</li>\n  <li><strong>Reset Chrome ke default:</strong> Settings â†’ Advanced â†’ Reset and clean up â†’ <em>Restore settings to their original defaults</em>. Ini menghapus ekstensi dan reset pengaturan tapi tidak menghapus history/bookmark.</li>\n</ol>\n\n<h2>Chrome Kehabisan Memori</h2>\n<p>Chrome menggunakan banyak RAM. Jika RAM komputer terbatas (4 GB), batasi jumlah tab yang terbuka, gunakan fitur <em>Memory Saver</em> (chrome://settings â†’ Performance), atau pertimbangkan browser yang lebih ringan seperti Edge untuk penggunaan sehari-hari.</p>', 'troubleshooting', 'published', '2026-04-18 01:35:11', NULL, 467, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(60, 109, 'Troubleshooting: File PDF Tidak Bisa Dibuka atau Menampilkan Error', 'troubleshooting-file-pdf-tidak-bisa-dibuka-atau-menampilkan-error', 'Tim IT Support', '<p>File PDF yang tidak bisa dibuka, menampilkan blank putih, atau error "file is damaged" bisa disebabkan oleh file yang corrupt, reader yang bermasalah, atau file yang terproteksi.</p>\n\n<h2>Langkah Pertama: Coba Reader Lain</h2>\n<ul>\n  <li>Buka PDF di browser (Chrome/Edge mendukung PDF bawaan). Drag file ke jendela browser.</li>\n  <li>Jika berhasil di browser tapi tidak di Acrobat Reader, masalah ada di aplikasi PDF-nya.</li>\n</ul>\n\n<h2>Perbaiki Adobe Acrobat Reader</h2>\n<ol>\n  <li>Buka Acrobat Reader â†’ <em>Help â†’ Repair Installation</em>.</li>\n  <li>Jika masih gagal, uninstal dan unduh versi terbaru dari situs resmi Adobe.</li>\n</ol>\n\n<h2>File Terunduh Tidak Lengkap</h2>\n<p>PDF yang diunduh dari email atau web mungkin tidak selesai diunduh. Cek ukuran file â€” PDF yang terlalu kecil dibanding harapan biasanya tidak lengkap. Unduh ulang dari sumber aslinya.</p>\n\n<h2>PDF Terproteksi Password</h2>\n<p>Beberapa PDF memerlukan password untuk dibuka atau dicetak. Minta password dari pengirim dokumen. Jangan menggunakan tool untuk membobol password PDF â€” selain bermasalah secara etika, juga dapat melanggar ketentuan keamanan data instansi.</p>\n\n<h2>PDF dari Sistem Internal Tidak Bisa Dibuka</h2>\n<p>Jika PDF yang dihasilkan dari sistem internal tidak bisa dibuka, kemungkinan ada masalah pada konfigurasi aplikasi penghasil PDF. Buat tiket dengan menyertakan nama sistem dan pesan error yang muncul.</p>', 'troubleshooting', 'published', '2026-04-19 01:35:11', NULL, 298, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(61, 109, 'Troubleshooting: File Tidak Bisa Dihapus (Access Denied)', 'troubleshooting-file-tidak-bisa-dihapus-access-denied', 'Tim IT Support', '<p>Pesan "You need permission to perform this action" atau "File is open in another program" saat mencoba menghapus file adalah masalah yang cukup umum dan umumnya bisa diselesaikan.</p>\n\n<h2>File Sedang Digunakan Aplikasi Lain</h2>\n<ol>\n  <li>Tutup semua aplikasi yang mungkin membuka file tersebut.</li>\n  <li>Restart Windows Explorer: Task Manager â†’ klik kanan <em>Windows Explorer</em> â†’ Restart.</li>\n  <li>Gunakan <strong>Process Explorer</strong> (Sysinternals) atau <em>Resource Monitor â†’ CPU â†’ Associated Handles</em> untuk mencari proses yang mengunci file.</li>\n</ol>\n\n<h2>Masalah Izin (Permission)</h2>\n<ol>\n  <li>Klik kanan file â†’ Properties â†’ tab Security.</li>\n  <li>Klik <em>Edit</em> dan tambahkan akun Anda dengan izin <em>Full Control</em>.</li>\n  <li>Atau klik <em>Advanced â†’ Change owner</em> untuk mengambil kepemilikan file.</li>\n</ol>\n\n<h2>File di Direktori Sistem</h2>\n<p>File di folder Windows, Program Files, atau System32 memang sengaja diproteksi. Jangan hapus sembarangan â€” konsultasikan dengan IT terlebih dahulu.</p>\n\n<h2>Gunakan Safe Mode</h2>\n<p>Boot ke Safe Mode (minimal service yang berjalan) jika semua cara gagal. File yang biasanya dikunci oleh layanan sistem dapat dihapus saat Safe Mode.</p>', 'troubleshooting', 'published', '2026-04-20 01:35:11', NULL, 267, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(62, 109, 'Troubleshooting: Copy-Paste (Clipboard) Tidak Bekerja di Windows', 'troubleshooting-copy-paste-clipboard-tidak-bekerja-di-windows', 'Tim IT Support', '<p>Clipboard yang tidak berfungsi â€” paste menghasilkan teks lama, paste tidak bekerja sama sekali, atau konten hilang setelah copy â€” adalah gangguan kecil yang bisa sangat mengganggu.</p>\n\n<h2>Solusi Cepat</h2>\n<ol>\n  <li><strong>Restart Windows Explorer.</strong> Task Manager â†’ klik kanan Windows Explorer â†’ Restart. Seringkali ini langsung memperbaiki clipboard yang macet.</li>\n  <li><strong>Bersihkan clipboard:</strong> Command Prompt â†’ ketik <code>echo off | clip</code> untuk mengosongkan clipboard.</li>\n  <li><strong>Nonaktifkan sementara fitur Clipboard History.</strong> Settings â†’ System â†’ Clipboard â†’ matikan <em>Clipboard history</em>, tunggu sebentar, aktifkan kembali.</li>\n</ol>\n\n<h2>Aplikasi yang Mengakses Clipboard</h2>\n<p>Beberapa aplikasi (password manager, clipboard manager, remote desktop client) dapat berkonflik dengan clipboard Windows. Tutup aplikasi tersebut satu per satu untuk mengidentifikasi penyebabnya.</p>\n\n<h2>Masalah Clipboard di Remote Desktop</h2>\n<p>Clipboard antara komputer lokal dan remote desktop tidak berfungsi? Pastikan opsi <em>Clipboard</em> diaktifkan di pengaturan Remote Desktop Connection sebelum terhubung: tab <em>Local Resources â†’ Local devices and resources</em> â†’ centang Clipboard.</p>\n\n<h2>Restart rdpclip.exe</h2>\n<p>Saat menggunakan Remote Desktop, clipboard dikelola oleh proses <code>rdpclip.exe</code>. Buka Task Manager di komputer remote, cari proses ini, End Task, lalu jalankan kembali dari Run (<kbd>Win</kbd>+<kbd>R</kbd>) â†’ <code>rdpclip</code>.</p>', 'troubleshooting', 'published', '2026-04-21 01:35:11', NULL, 234, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(63, 109, 'Troubleshooting: Taskbar Windows Hilang atau Tidak Merespons', 'troubleshooting-taskbar-windows-hilang-atau-tidak-merespons', 'Tim IT Support', '<p>Taskbar yang menghilang atau tidak merespons klik memotong akses ke Start Menu, notifikasi, dan tombol aplikasi yang terbuka.</p>\n\n<h2>Solusi Langsung</h2>\n<ol>\n  <li><strong>Restart Windows Explorer.</strong> Tekan <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> untuk membuka Task Manager. Temukan <em>Windows Explorer</em>, klik kanan â†’ Restart. Taskbar biasanya muncul kembali.</li>\n  <li><strong>Jika Task Manager tidak bisa dibuka:</strong> tekan <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> â†’ pilih Task Manager dari menu.</li>\n</ol>\n\n<h2>Taskbar Tersembunyi Otomatis</h2>\n<p>Klik kanan area kosong taskbar â†’ <em>Taskbar settings</em> â†’ pastikan <em>Automatically hide the taskbar</em> dalam kondisi Off. Jika On, taskbar hanya muncul saat kursor mendekati bagian bawah layar.</p>\n\n<h2>Taskbar Berpindah ke Sisi Layar</h2>\n<p>Taskbar bisa diseret ke sisi kiri, kanan, atau atas layar secara tidak sengaja. Klik kanan taskbar â†’ <em>Taskbar settings â†’ Taskbar behaviors â†’ Taskbar alignment</em> â†’ pilih <em>Left</em> untuk posisi bawah kiri (Windows 11).</p>\n\n<h2>Perbaikan Lanjutan via PowerShell</h2>\n<p>Jika restart Explorer tidak membantu, buka PowerShell sebagai Administrator dan jalankan:</p>\n<pre>Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\\AppXManifest.xml"}</pre>\n<p>Perintah ini mendaftarkan ulang semua aplikasi UWP termasuk komponen Taskbar Windows.</p>', 'troubleshooting', 'published', '2026-04-22 01:35:11', NULL, 312, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(64, 109, 'Troubleshooting: Tidak Bisa Terhubung ke WiFi Kantor', 'troubleshooting-tidak-bisa-terhubung-ke-wifi-kantor', 'Tim IT Support', '<p>Tidak bisa terhubung ke jaringan WiFi kantor adalah masalah yang sering terjadi dan umumnya diselesaikan dalam beberapa langkah sederhana.</p>\n\n<h2>Pemeriksaan Bertahap</h2>\n<ol>\n  <li><strong>Pastikan WiFi adapter aktif.</strong> Periksa tombol fisik WiFi pada laptop atau kombinasi <kbd>Fn</kbd>+tombol WiFi. Ikon WiFi di taskbar harus menunjukkan jaringan tersedia, bukan dengan tanda X.</li>\n  <li><strong>"Forget" dan sambung ulang.</strong> Klik nama jaringan WiFi â†’ <em>Forget</em>, lalu sambungkan kembali dan masukkan password yang benar.</li>\n  <li><strong>Flush DNS dan reset TCP/IP:</strong>\n    <pre>netsh winsock reset\nnetsh int ip reset\nipconfig /release\nipconfig /flushdns\nipconfig /renew</pre>\n    Restart komputer setelah menjalankan perintah di atas.</li>\n  <li><strong>Update driver WiFi.</strong> Buka Device Manager â†’ <em>Network adapters</em> â†’ klik kanan adapter WiFi â†’ Update driver.</li>\n</ol>\n\n<h2>Terhubung tapi Tidak Ada Internet (Limited)</h2>\n<p>Kemungkinan masalah pada DHCP server atau IP address conflict. Coba atur IP manual atau hubungi IT untuk pemeriksaan infrastruktur jaringan.</p>\n\n<h2>WiFi Tidak Muncul dalam Daftar Jaringan</h2>\n<p>Pastikan router/access point dalam kondisi menyala. Jika jaringan lain muncul tapi jaringan kantor tidak, mungkin access point yang melayani area Anda sedang bermasalah â€” laporkan ke IT.</p>', 'troubleshooting', 'published', '2026-04-23 01:35:11', NULL, 534, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(65, 109, 'Troubleshooting: Koneksi Internet Terasa Lambat', 'troubleshooting-koneksi-internet-terasa-lambat', 'Tim IT Support', '<p>Internet yang lambat bisa disebabkan oleh banyak faktor â€” dari kondisi jaringan hingga perangkat pengguna itu sendiri. Diagnosis yang tepat menghindarkan salah langkah.</p>\n\n<h2>Ukur Kecepatan Aktual</h2>\n<p>Buka <em>fast.com</em> atau <em>speedtest.net</em> untuk mengukur kecepatan unduh dan unggah. Bandingkan dengan kecepatan yang seharusnya. Jika jauh di bawah normal, masalah ada di infrastruktur jaringan.</p>\n\n<h2>Periksa di Level Perangkat</h2>\n<ol>\n  <li><strong>Buka Task Manager â†’ tab Performance â†’ Ethernet/WiFi.</strong> Jika utilisasi jaringan mendekati 100%, ada proses yang mengkonsumsi bandwidth besar (update OS, backup cloud, dll.).</li>\n  <li><strong>Cek proses yang menggunakan jaringan:</strong> Task Manager â†’ tab App history atau gunakan <em>Resource Monitor â†’ Network</em>.</li>\n  <li><strong>Scan malware.</strong> Beberapa malware mengirimkan data secara diam-diam dan menghabiskan bandwidth.</li>\n</ol>\n\n<h2>Posisi dan Sinyal WiFi</h2>\n<p>Jarak jauh dari access point atau halangan fisik (dinding beton, lemari logam) melemahkan sinyal. Pindah ke posisi lebih dekat dengan access point atau minta IT untuk menambah titik WiFi di area bermasalah.</p>\n\n<h2>Internet Lambat Hanya di Satu Komputer</h2>\n<p>Jika komputer lain di ruangan sama berkecepatan normal, masalah ada di perangkat Anda. Coba restart adapter jaringan: Device Manager â†’ klik kanan adapter â†’ Disable â†’ Enable kembali.</p>', 'troubleshooting', 'published', '2026-04-24 01:35:11', NULL, 478, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(66, 109, 'Troubleshooting: DNS Error â€” Tidak Bisa Membuka Website Tertentu', 'troubleshooting-dns-error-tidak-bisa-membuka-website-tertentu', 'Tim IT Support', '<p>Pesan "DNS_PROBE_FINISHED_NXDOMAIN" atau "Server DNS address could not be found" menandakan masalah pada resolusi nama domain â€” komputer tidak bisa mengubah nama situs menjadi alamat IP.</p>\n\n<h2>Solusi Cepat</h2>\n<ol>\n  <li><strong>Flush DNS cache:</strong> Command Prompt Administrator â†’ <code>ipconfig /flushdns</code>. Berhasil mengatasi banyak kasus DNS error yang disebabkan cache kadaluarsa.</li>\n  <li><strong>Restart router/modem</strong> (jika memiliki akses). Tunggu 30 detik sebelum menyalakan kembali.</li>\n  <li><strong>Ganti DNS server secara manual:</strong>\n    <ul>\n      <li>Buka <em>Network settings â†’ Change adapter options</em>.</li>\n      <li>Klik kanan adapter â†’ Properties â†’ <em>Internet Protocol Version 4 (TCP/IPv4)</em>.</li>\n      <li>Masukkan DNS: <code>8.8.8.8</code> (Google) atau <code>1.1.1.1</code> (Cloudflare).</li>\n    </ul>\n  </li>\n</ol>\n\n<h2>Hanya Situs Tertentu yang Tidak Bisa Dibuka</h2>\n<p>Coba buka situs tersebut dengan browser berbeda dan dari jaringan mobile (hotspot HP). Jika bisa diakses dari hotspot tapi tidak dari jaringan kantor, kemungkinan situs tersebut diblokir oleh firewall kantor. Hubungi IT jika Anda memerlukan akses ke situs tersebut untuk keperluan kerja.</p>', 'troubleshooting', 'published', '2026-04-25 01:35:11', NULL, 356, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(67, 109, 'Troubleshooting: Konflik Alamat IP (IP Address Conflict)', 'troubleshooting-konflik-alamat-ip-ip-address-conflict', 'Tim IT Support', '<p>Notifikasi "There might be an IP address conflict" atau jaringan yang tiba-tiba putus dan tidak bisa terhubung kembali bisa jadi disebabkan dua perangkat menggunakan IP yang sama.</p>\n\n<h2>Mengapa Ini Terjadi?</h2>\n<p>IP address conflict terjadi ketika:</p>\n<ul>\n  <li>Komputer dikonfigurasi dengan IP statis yang sama dengan perangkat lain.</li>\n  <li>DHCP server mengalokasikan IP yang sudah dipakai perangkat dengan IP statis.</li>\n  <li>Perangkat baru terhubung ke jaringan dengan IP hardcoded yang sama.</li>\n</ul>\n\n<h2>Solusi Cepat</h2>\n<ol>\n  <li><strong>Gunakan IP otomatis (DHCP).</strong> Buka Network settings â†’ klik kanan adapter â†’ Properties â†’ IPv4 â†’ pilih <em>Obtain an IP address automatically</em>. Ini adalah pengaturan yang disarankan untuk perangkat kantor.</li>\n  <li><strong>Lepas dan sambung ulang kabel LAN / WiFi.</strong> DHCP server akan mengalokasikan IP baru.</li>\n  <li><strong>Jalankan perintah:</strong>\n    <pre>ipconfig /release\nipconfig /renew</pre>\n  </li>\n</ol>\n\n<h2>Jika IP Statis Diperlukan</h2>\n<p>Jika komputer Anda memang perlu IP statis (misalnya untuk kebutuhan tertentu), koordinasikan dengan IT untuk mendapatkan IP yang sudah dipesan dan tidak akan pernah di-assign ke perangkat lain.</p>', 'troubleshooting', 'published', '2026-04-26 01:35:11', NULL, 234, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(68, 109, 'Troubleshooting: Tidak Bisa Mengakses Shared Folder di Jaringan', 'troubleshooting-tidak-bisa-mengakses-shared-folder-di-jaringan', 'Tim IT Support', '<p>Folder bersama (shared folder) yang tiba-tiba tidak bisa diakses sementara orang lain masih bisa membukanya sering kali disebabkan masalah izin atau konfigurasi jaringan di komputer Anda.</p>\n\n<h2>Pemeriksaan Awal</h2>\n<ol>\n  <li><strong>Coba akses via path UNC langsung:</strong> tekan <kbd>Win</kbd>+<kbd>R</kbd>, ketik <code>\\\\NAMA-SERVER\\nama-folder</code> atau <code>\\\\192.168.x.x\\nama-folder</code>.</li>\n  <li><strong>Ping server:</strong> <code>ping nama-server</code> atau <code>ping [IP server]</code>. Jika tidak ada reply, masalah di koneksi jaringan, bukan izin folder.</li>\n  <li><strong>Masukkan kredensial secara manual.</strong> Dialog login mungkin muncul â€” masukkan username dan password akun domain atau akun lokal server.</li>\n</ol>\n\n<h2>Masalah Network Discovery</h2>\n<ol>\n  <li>Buka <em>Network and Sharing Center â†’ Change advanced sharing settings</em>.</li>\n  <li>Pastikan <em>Network discovery</em> dan <em>File and printer sharing</em> dalam kondisi <strong>On</strong> untuk profile jaringan yang aktif.</li>\n</ol>\n\n<h2>Hapus Kredensial Tersimpan yang Kadaluarsa</h2>\n<p>Buka <em>Control Panel â†’ Credential Manager â†’ Windows Credentials</em>. Hapus kredensial untuk server yang bermasalah, lalu coba akses ulang dan masukkan password terbaru.</p>\n\n<h2>SMB Version Mismatch</h2>\n<p>Windows 11 secara default menonaktifkan SMBv1 yang mungkin digunakan server lama. Hubungi IT untuk penanganan konfigurasi SMB â€” jangan mengaktifkan SMBv1 sendiri karena memiliki kerentanan keamanan serius.</p>', 'troubleshooting', 'published', '2026-04-27 01:35:11', NULL, 289, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(69, 109, 'Troubleshooting: Profil Pengguna Windows Corrupt (Temp Profile)', 'troubleshooting-profil-pengguna-windows-corrupt-temp-profile', 'Tim IT Support', '<p>Login ke Windows tapi muncul notifikasi "You have been logged on with a temporary profile" dan Desktop tampak kosong adalah tanda profil user corrupt.</p>\n\n<h2>Gejala Profil Corrupt</h2>\n<ul>\n  <li>Desktop kosong tanpa ikon yang biasa ada.</li>\n  <li>Pengaturan dan file tidak tersimpan setelah logout.</li>\n  <li>Notifikasi temporary profile di system tray.</li>\n</ul>\n\n<h2>Solusi: Perbaiki via Registry</h2>\n<ol>\n  <li>Login dengan akun Administrator lain (atau minta bantuan IT).</li>\n  <li>Buka Registry Editor (<kbd>Win</kbd>+<kbd>R</kbd> â†’ <code>regedit</code>).</li>\n  <li>Navigasi ke: <code>HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList</code>.</li>\n  <li>Cari subfolder yang berakhiran <code>.bak</code> atau memiliki nilai <code>ProfileImagePath</code> yang menunjuk ke profil Anda.</li>\n  <li>Ikuti panduan IT untuk mengubah nilai yang diperlukan â€” proses ini sensitif dan perlu dilakukan dengan hati-hati.</li>\n</ol>\n\n<h2>Solusi Alternatif: Buat Profil Baru</h2>\n<p>Jika perbaikan registry tidak berhasil, buat akun user baru dan pindahkan file dari profil lama (<code>C:\\Users\\[nama-lama]</code>) ke profil baru. Hubungi IT untuk bantuan proses ini agar tidak ada data penting yang tertinggal.</p>', 'troubleshooting', 'published', '2026-03-12 01:35:11', NULL, 345, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(70, 109, 'Troubleshooting: Antivirus Memblokir Aplikasi yang Seharusnya Aman', 'troubleshooting-antivirus-memblokir-aplikasi-yang-seharusnya-aman', 'Tim IT Support', '<p>Antivirus terkadang mendeteksi aplikasi sah sebagai ancaman (false positive), terutama aplikasi buatan lokal atau tools IT yang jarang dikenal oleh database antivirus.</p>\n\n<h2>Langkah Verifikasi Sebelum Mengizinkan</h2>\n<ol>\n  <li><strong>Periksa sumber aplikasi.</strong> Apakah diunduh dari sumber resmi? Jika dari email atau link tidak jelas, jangan langsung percaya.</li>\n  <li><strong>Scan file di VirusTotal.</strong> Buka <em>virustotal.com</em>, upload file tersebut. Jika hanya 1-2 antivirus yang mendeteksinya sebagai ancaman dari 70+ engine, kemungkinan besar false positive.</li>\n</ol>\n\n<h2>Cara Menambahkan Pengecualian (Exclusion)</h2>\n<p>Untuk Windows Defender:</p>\n<ol>\n  <li>Buka <em>Windows Security â†’ Virus & threat protection â†’ Manage settings</em>.</li>\n  <li>Gulir ke <em>Exclusions â†’ Add or remove exclusions â†’ Add an exclusion</em>.</li>\n  <li>Pilih file atau folder yang ingin dikecualikan dari pemindaian.</li>\n</ol>\n\n<p>Untuk antivirus pihak ketiga (Bitdefender, Kaspersky, dll.), prosedur serupa ada di menu Settings atau Exceptions.</p>\n\n<h2>Laporkan False Positive</h2>\n<p>Laporkan false positive ke vendor antivirus melalui portal resmi mereka. Database antivirus akan diperbarui sehingga aplikasi tersebut tidak lagi terdeteksi di komputer lain.</p>', 'troubleshooting', 'published', '2026-03-11 01:35:11', NULL, 267, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(71, 109, 'Troubleshooting: File Hilang Setelah Restart Komputer', 'troubleshooting-file-hilang-setelah-restart-komputer', 'Tim IT Support', '<p>File yang tersimpan dan tiba-tiba menghilang setelah restart bisa sangat membingungkan dan mengkhawatirkan. Namun file tersebut sering kali tidak benar-benar hilang.</p>\n\n<h2>Cari File yang "Hilang"</h2>\n<ol>\n  <li><strong>Periksa Recycle Bin.</strong> File mungkin terhapus secara tidak sengaja.</li>\n  <li><strong>Gunakan Search Windows.</strong> Tekan <kbd>Win</kbd>+<kbd>S</kbd>, ketik nama file (jika masih ingat). Atur filter pencarian ke lokasi <em>This PC</em>.</li>\n  <li><strong>Periksa folder Downloads, Documents, dan Desktop</strong> karena browser dan aplikasi sering menyimpan file di lokasi default yang berbeda.</li>\n  <li><strong>Cek di OneDrive atau Google Drive</strong> jika sync aktif. File mungkin dipindah oleh proses sync.</li>\n</ol>\n\n<h2>Previous Versions</h2>\n<p>Klik kanan folder tempat file terakhir disimpan â†’ <em>Properties â†’ Previous Versions</em>. Jika System Restore aktif, mungkin ada snapshot folder sebelum file hilang.</p>\n\n<h2>Profil Sementara (Temp Profile)</h2>\n<p>Jika file hilang bersamaan dengan munculnya notifikasi "logged in with temporary profile", lihat artikel tentang Profil Pengguna Corrupt untuk panduan pemulihan.</p>\n\n<h2>Simpan ke Lokasi Aman</h2>\n<p>Hindari menyimpan file penting hanya di Desktop atau folder Temp. Gunakan folder Documents yang tersinkron ke OneDrive sehingga file selalu ada cadangannya di cloud.</p>', 'troubleshooting', 'published', '2026-03-10 01:35:11', NULL, 423, '2026-04-28 01:23:01', '2026-04-28 01:35:11', 3),
	(72, 109, 'Troubleshooting: Koneksi LAN (Kabel) Tidak Terdeteksi', 'troubleshooting-koneksi-lan-kabel-tidak-terdeteksi', 'Tim IT Support', '<p>Koneksi LAN melalui kabel ethernet lebih stabil dari WiFi, namun ketika tidak terdeteksi, diagnosisnya memerlukan pemeriksaan dari beberapa titik.</p>\n\n<h2>Pemeriksaan Fisik</h2>\n<ol>\n  <li><strong>Periksa lampu indikator di port LAN laptop/komputer.</strong> Seharusnya ada lampu hijau (terhubung) dan oranye berkedip (ada aktivitas). Tidak ada lampu = tidak ada koneksi fisik.</li>\n  <li><strong>Periksa konektor RJ-45.</strong> Dengarkan bunyi "klik" saat memasukkan konektor. Klip pengunci yang patah menyebabkan kabel mudah longgar.</li>\n  <li><strong>Coba kabel LAN berbeda.</strong> Kabel yang rusak secara internal tidak selalu terlihat dari luar.</li>\n  <li><strong>Coba port switch yang berbeda.</strong> Port switch yang mati dapat menyebabkan tidak ada koneksi.</li>\n</ol>\n\n<h2>Pemeriksaan Software</h2>\n<ol>\n  <li>Buka Device Manager â†’ <em>Network adapters</em>. Pastikan adapter LAN tidak di-disable dan tidak ada tanda error.</li>\n  <li>Klik kanan adapter LAN â†’ <em>Enable device</em> jika dalam kondisi disabled.</li>\n  <li>Update driver ethernet adapter dari situs produsen (Realtek, Intel, dll.).</li>\n</ol>\n\n<h2>Tidak Ada Port LAN di Laptop Modern</h2>\n<p>Laptop ultrabook sering tidak memiliki port LAN. Gunakan adaptor USB-to-Ethernet atau docking station. Hubungi IT untuk peminjaman jika diperlukan untuk pekerjaan yang membutuhkan koneksi stabil.</p>', 'troubleshooting', 'published', '2026-03-09 01:35:11', NULL, 322, '2026-04-28 01:23:01', '2026-06-01 12:03:12', 3);

-- membuang struktur untuk table kaido_kit.breezy_sessions
CREATE TABLE IF NOT EXISTS `breezy_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `authenticatable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `authenticatable_id` bigint unsigned NOT NULL,
  `panel_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guard` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `expires_at` timestamp NULL DEFAULT NULL,
  `two_factor_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `breezy_sessions_authenticatable_type_authenticatable_id_index` (`authenticatable_type`,`authenticatable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.breezy_sessions: ~0 rows (lebih kurang)
DELETE FROM `breezy_sessions`;

-- membuang struktur untuk table kaido_kit.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.cache: ~40 rows (lebih kurang)
DELETE FROM `cache`;
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('17ba0791499db908433b80f37c5fbc89b870084b', 'i:1;', 1770193218),
	('17ba0791499db908433b80f37c5fbc89b870084b:timer', 'i:1770193218;', 1770193218),
	('booking_badge_11_admin', 's:1:"1";', 1770195128),
	('booking_badge_12_user', 'N;', 1769162865),
	('booking_badge_13_user', 'N;', 1770183057),
	('booking_badge_65_user', 'N;', 1770183834),
	('booking_badge_79_user', 'N;', 1770183831),
	('booking_badge_color_11_admin', 's:7:"success";', 1770195128),
	('booking_badge_color_12_user', 's:7:"success";', 1769162843),
	('booking_badge_color_13_user', 's:7:"success";', 1770183047),
	('booking_badge_color_65_user', 's:7:"success";', 1770183834),
	('booking_badge_color_79_user', 's:7:"success";', 1770183829),
	('device_stats_widget', 'a:7:{s:12:"totalDevices";i:98;s:13:"activeDevices";i:98;s:18:"maintenanceDevices";i:0;s:14:"retiredDevices";i:0;s:20:"poorConditionDevices";i:0;s:17:"unassignedDevices";i:96;s:11:"noIpAddress";i:1;}', 1770193325),
	('livewire-rate-limiter:100671c7397d07b42b133ce42a93f560dc22d05d', 'i:1;', 1768793871),
	('livewire-rate-limiter:100671c7397d07b42b133ce42a93f560dc22d05d:timer', 'i:1768793871;', 1768793871),
	('livewire-rate-limiter:58894e52f1bb0105f2b87be0cedf82bb88fe3eb3', 'i:1;', 1768993414),
	('livewire-rate-limiter:58894e52f1bb0105f2b87be0cedf82bb88fe3eb3:timer', 'i:1768993414;', 1768993414),
	('livewire-rate-limiter:59d6ad626907b5a0341aba51c3754cd265bffec5', 'i:2;', 1770184193),
	('livewire-rate-limiter:59d6ad626907b5a0341aba51c3754cd265bffec5:timer', 'i:1770184193;', 1770184193),
	('spatie.permission.cache', 'a:3:{s:5:"alias";a:4:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";s:1:"r";s:5:"roles";}s:11:"permissions";a:103:{i:0;a:4:{s:1:"a";i:1;s:1:"b";s:12:"view_article";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:1;a:4:{s:1:"a";i:2;s:1:"b";s:16:"view_any_article";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:2;a:4:{s:1:"a";i:3;s:1:"b";s:14:"create_article";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:3;a:4:{s:1:"a";i:4;s:1:"b";s:14:"update_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:4;a:4:{s:1:"a";i:5;s:1:"b";s:15:"restore_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:5;a:4:{s:1:"a";i:6;s:1:"b";s:19:"restore_any_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:6;a:4:{s:1:"a";i:7;s:1:"b";s:17:"replicate_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:7;a:4:{s:1:"a";i:8;s:1:"b";s:15:"reorder_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:8;a:4:{s:1:"a";i:9;s:1:"b";s:14:"delete_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:9;a:4:{s:1:"a";i:10;s:1:"b";s:18:"delete_any_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:10;a:4:{s:1:"a";i:11;s:1:"b";s:20:"force_delete_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:11;a:4:{s:1:"a";i:12;s:1:"b";s:24:"force_delete_any_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:12;a:4:{s:1:"a";i:13;s:1:"b";s:22:"article:create_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:13;a:4:{s:1:"a";i:14;s:1:"b";s:22:"article:update_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:14;a:4:{s:1:"a";i:15;s:1:"b";s:22:"article:delete_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:15;a:4:{s:1:"a";i:16;s:1:"b";s:26:"article:pagination_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:16;a:4:{s:1:"a";i:17;s:1:"b";s:22:"article:detail_article";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:17;a:4:{s:1:"a";i:18;s:1:"b";s:13:"view_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:18;a:4:{s:1:"a";i:19;s:1:"b";s:17:"view_any_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:19;a:4:{s:1:"a";i:20;s:1:"b";s:15:"create_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:20;a:4:{s:1:"a";i:21;s:1:"b";s:15:"update_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:21;a:4:{s:1:"a";i:22;s:1:"b";s:16:"restore_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:22;a:4:{s:1:"a";i:23;s:1:"b";s:20:"restore_any_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:23;a:4:{s:1:"a";i:24;s:1:"b";s:18:"replicate_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:24;a:4:{s:1:"a";i:25;s:1:"b";s:16:"reorder_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:25;a:4:{s:1:"a";i:26;s:1:"b";s:15:"delete_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:26;a:4:{s:1:"a";i:27;s:1:"b";s:19:"delete_any_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:27;a:4:{s:1:"a";i:28;s:1:"b";s:21:"force_delete_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:28;a:4:{s:1:"a";i:29;s:1:"b";s:25:"force_delete_any_category";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:29;a:4:{s:1:"a";i:30;s:1:"b";s:11:"view_device";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:30;a:4:{s:1:"a";i:31;s:1:"b";s:15:"view_any_device";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:31;a:4:{s:1:"a";i:32;s:1:"b";s:13:"create_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:32;a:4:{s:1:"a";i:33;s:1:"b";s:13:"update_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:33;a:4:{s:1:"a";i:34;s:1:"b";s:13:"delete_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:34;a:4:{s:1:"a";i:35;s:1:"b";s:17:"delete_any_device";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:35;a:4:{s:1:"a";i:36;s:1:"b";s:22:"view_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:36;a:4:{s:1:"a";i:37;s:1:"b";s:26:"view_any_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:37;a:4:{s:1:"a";i:38;s:1:"b";s:24:"create_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:38;a:4:{s:1:"a";i:39;s:1:"b";s:24:"update_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:39;a:4:{s:1:"a";i:40;s:1:"b";s:24:"delete_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:40;a:4:{s:1:"a";i:41;s:1:"b";s:28:"delete_any_device::attribute";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:41;a:4:{s:1:"a";i:42;s:1:"b";s:9:"view_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:42;a:4:{s:1:"a";i:43;s:1:"b";s:13:"view_any_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:43;a:4:{s:1:"a";i:44;s:1:"b";s:11:"create_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:44;a:4:{s:1:"a";i:45;s:1:"b";s:11:"update_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:45;a:4:{s:1:"a";i:46;s:1:"b";s:11:"delete_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:46;a:4:{s:1:"a";i:47;s:1:"b";s:15:"delete_any_role";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:47;a:4:{s:1:"a";i:48;s:1:"b";s:11:"view_ticket";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:48;a:4:{s:1:"a";i:49;s:1:"b";s:15:"view_any_ticket";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:49;a:4:{s:1:"a";i:50;s:1:"b";s:13:"create_ticket";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:50;a:4:{s:1:"a";i:51;s:1:"b";s:13:"update_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:51;a:4:{s:1:"a";i:52;s:1:"b";s:13:"delete_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:52;a:4:{s:1:"a";i:53;s:1:"b";s:17:"delete_any_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:53;a:4:{s:1:"a";i:54;s:1:"b";s:13:"assign_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:54;a:4:{s:1:"a";i:55;s:1:"b";s:14:"resolve_ticket";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:55;a:4:{s:1:"a";i:56;s:1:"b";s:10:"view_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:56;a:4:{s:1:"a";i:57;s:1:"b";s:14:"view_any_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:57;a:4:{s:1:"a";i:58;s:1:"b";s:12:"create_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:58;a:4:{s:1:"a";i:59;s:1:"b";s:12:"update_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:59;a:4:{s:1:"a";i:60;s:1:"b";s:13:"restore_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:60;a:4:{s:1:"a";i:61;s:1:"b";s:17:"restore_any_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:61;a:4:{s:1:"a";i:62;s:1:"b";s:15:"replicate_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:62;a:4:{s:1:"a";i:63;s:1:"b";s:13:"reorder_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:63;a:4:{s:1:"a";i:64;s:1:"b";s:12:"delete_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:64;a:4:{s:1:"a";i:65;s:1:"b";s:16:"delete_any_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:65;a:4:{s:1:"a";i:66;s:1:"b";s:18:"force_delete_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:66;a:4:{s:1:"a";i:67;s:1:"b";s:22:"force_delete_any_token";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:67;a:4:{s:1:"a";i:68;s:1:"b";s:9:"view_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:68;a:4:{s:1:"a";i:69;s:1:"b";s:13:"view_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:69;a:4:{s:1:"a";i:70;s:1:"b";s:11:"create_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:70;a:4:{s:1:"a";i:71;s:1:"b";s:11:"update_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:71;a:4:{s:1:"a";i:72;s:1:"b";s:12:"restore_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:72;a:4:{s:1:"a";i:73;s:1:"b";s:16:"restore_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:73;a:4:{s:1:"a";i:74;s:1:"b";s:14:"replicate_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:74;a:4:{s:1:"a";i:75;s:1:"b";s:12:"reorder_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:75;a:4:{s:1:"a";i:76;s:1:"b";s:11:"delete_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:76;a:4:{s:1:"a";i:77;s:1:"b";s:15:"delete_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:77;a:4:{s:1:"a";i:78;s:1:"b";s:17:"force_delete_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:78;a:4:{s:1:"a";i:79;s:1:"b";s:21:"force_delete_any_user";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:79;a:4:{s:1:"a";i:80;s:1:"b";s:12:"view_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:80;a:4:{s:1:"a";i:81;s:1:"b";s:16:"view_any_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:81;a:4:{s:1:"a";i:82;s:1:"b";s:14:"create_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:82;a:4:{s:1:"a";i:83;s:1:"b";s:14:"update_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:83;a:4:{s:1:"a";i:84;s:1:"b";s:14:"delete_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:84;a:4:{s:1:"a";i:85;s:1:"b";s:18:"delete_any_vehicle";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:85;a:4:{s:1:"a";i:86;s:1:"b";s:21:"view_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:86;a:4:{s:1:"a";i:87;s:1:"b";s:25:"view_any_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:87;a:4:{s:1:"a";i:88;s:1:"b";s:23:"create_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:88;a:4:{s:1:"a";i:89;s:1:"b";s:23:"update_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:89;a:4:{s:1:"a";i:90;s:1:"b";s:23:"delete_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:90;a:4:{s:1:"a";i:91;s:1:"b";s:27:"delete_any_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:91;a:4:{s:1:"a";i:92;s:1:"b";s:23:"return_vehicle::booking";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:92;a:4:{s:1:"a";i:93;s:1:"b";s:18:"page_ManageSetting";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:93;a:4:{s:1:"a";i:94;s:1:"b";s:20:"page_VehicleCalendar";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:94;a:4:{s:1:"a";i:95;s:1:"b";s:11:"page_Themes";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:95;a:4:{s:1:"a";i:96;s:1:"b";s:18:"page_MyProfilePage";s:1:"c";s:3:"web";s:1:"r";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:96;a:4:{s:1:"a";i:97;s:1:"b";s:26:"widget_VehicleBookingStats";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:97;a:4:{s:1:"a";i:98;s:1:"b";s:34:"widget_VehicleAvailabilityCalendar";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:98;a:4:{s:1:"a";i:99;s:1:"b";s:23:"widget_MyActiveBookings";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:99;a:4:{s:1:"a";i:100;s:1:"b";s:24:"widget_DeviceStatsWidget";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:100;a:4:{s:1:"a";i:101;s:1:"b";s:24:"widget_TicketStatsWidget";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:101;a:4:{s:1:"a";i:102;s:1:"b";s:26:"widget_RecentTicketsWidget";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}i:102;a:4:{s:1:"a";i:103;s:1:"b";s:17:"page_TicketReport";s:1:"c";s:3:"web";s:1:"r";a:2:{i:0;i:1;i:1;i:3;}}}s:5:"roles";a:3:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:11:"super_admin";s:1:"c";s:3:"web";}i:1;a:3:{s:1:"a";i:2;s:1:"b";s:6:"Member";s:1:"c";s:3:"web";}i:2;a:3:{s:1:"a";i:3;s:1:"b";s:5:"Admin";s:1:"c";s:3:"web";}}}', 1770268702),
	('ticket_badge_11_admin', 'i:1;', 1770195128),
	('ticket_badge_12_user', 'N;', 1769162865),
	('ticket_badge_13_user', 'N;', 1770183057),
	('ticket_badge_65_user', 'i:1;', 1770183833),
	('ticket_badge_79_admin', 'i:1;', 1770183828),
	('ticket_badge_79_user', 'N;', 1770182656),
	('ticket_badge_color_11_admin', 's:7:"success";', 1770195128),
	('ticket_badge_color_12_user', 's:7:"success";', 1769162843),
	('ticket_badge_color_13_user', 's:7:"success";', 1770183047),
	('ticket_badge_color_65_user', 's:7:"success";', 1770183834),
	('ticket_badge_color_79_admin', 's:7:"success";', 1770183828),
	('ticket_badge_color_79_user', 's:7:"success";', 1770182619),
	('ticket_stats_widget', 'a:8:{s:10:"newTickets";i:0;s:17:"inProgressTickets";i:1;s:18:"waitingUserTickets";i:0;s:17:"unassignedTickets";i:0;s:16:"highPriorityOpen";i:0;s:17:"resolvedThisMonth";i:0;s:12:"todayTickets";i:1;s:14:"monthlyTickets";i:1;}', 1770182377),
	('ticket_stats_widget_admin', 'a:8:{s:10:"newTickets";i:0;s:17:"inProgressTickets";i:1;s:18:"waitingUserTickets";i:0;s:17:"unassignedTickets";i:0;s:16:"highPriorityOpen";i:0;s:17:"resolvedThisMonth";i:0;s:12:"todayTickets";i:1;s:14:"monthlyTickets";i:1;}', 1770193262),
	('ticket_stats_widget_user_65', 'a:8:{s:10:"newTickets";i:0;s:17:"inProgressTickets";i:1;s:18:"waitingUserTickets";i:0;s:17:"unassignedTickets";i:0;s:16:"highPriorityOpen";i:0;s:17:"resolvedThisMonth";i:0;s:12:"todayTickets";i:1;s:14:"monthlyTickets";i:1;}', 1770183200),
	('vehicle_booking_stats_11_admin', 'a:5:{s:14:"activeBookings";i:1;s:11:"needsReturn";i:0;s:15:"monthlyBookings";i:1;s:17:"availableVehicles";i:5;s:13:"totalVehicles";i:5;}', 1770193264),
	('vehicle_booking_stats_12_user', 'a:5:{s:14:"activeBookings";i:0;s:11:"needsReturn";i:0;s:15:"monthlyBookings";i:0;s:17:"availableVehicles";i:0;s:13:"totalVehicles";i:0;}', 1769162930),
	('vehicle_booking_stats_13_user', 'a:5:{s:14:"activeBookings";i:0;s:11:"needsReturn";i:0;s:15:"monthlyBookings";i:0;s:17:"availableVehicles";i:0;s:13:"totalVehicles";i:0;}', 1770182795),
	('vehicle_booking_stats_65_user', 'a:5:{s:14:"activeBookings";i:0;s:11:"needsReturn";i:0;s:15:"monthlyBookings";i:0;s:17:"availableVehicles";i:0;s:13:"totalVehicles";i:0;}', 1770183205),
	('vehicle_booking_stats_79_user', 'a:5:{s:14:"activeBookings";i:0;s:11:"needsReturn";i:0;s:15:"monthlyBookings";i:0;s:17:"availableVehicles";i:0;s:13:"totalVehicles";i:0;}', 1770182762);

-- membuang struktur untuk table kaido_kit.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.cache_locks: ~0 rows (lebih kurang)
DELETE FROM `cache_locks`;

-- membuang struktur untuk table kaido_kit.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.categories: ~5 rows (lebih kurang)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'Tutorial', 'tutorial', 'Panduan langkah demi langkah seputar penggunaan sistem dan perangkat IT.', 1, '2026-04-24 16:34:06', '2026-04-24 16:34:06'),
	(2, 'Tips & Trik', 'tips-trik', 'Tips praktis untuk produktivitas, perawatan perangkat, dan pengelolaan administrasi.', 1, '2026-04-24 16:34:06', '2026-04-24 16:34:06'),
	(3, 'Troubleshooting', 'troubleshooting', 'Solusi masalah teknis yang umum dihadapi pengguna kantor.', 1, '2026-04-24 16:34:06', '2026-04-24 16:34:06'),
	(4, 'Keamanan', 'keamanan', 'Edukasi keamanan informasi, akun, dan data instansi.', 1, '2026-04-24 16:34:06', '2026-04-24 16:34:06'),
	(5, 'Berita', 'berita', 'Pengumuman dan informasi terbaru seputar layanan IT.', 1, '2026-04-24 16:34:06', '2026-04-24 16:34:06');

-- membuang struktur untuk table kaido_kit.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.contacts: ~10 rows (lebih kurang)
DELETE FROM `contacts`;
INSERT INTO `contacts` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Dr. Oswald Kozey', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(2, 'Mrs. Chanel Harber', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(3, 'Dan Hill', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(4, 'Vilma Schultz', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(5, 'Moshe Cartwright IV', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(6, 'Lindsay Kulas II', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(7, 'Claudie Kihn', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(8, 'Geovanny Pacocha', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(9, 'Merritt Armstrong', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(10, 'Miss Estel Doyle DDS', '2026-01-06 20:23:51', '2026-01-06 20:23:51');

-- membuang struktur untuk table kaido_kit.devices
CREATE TABLE IF NOT EXISTS `devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` enum('laptop','desktop','all-in-one','workstation','printer','scanner','router','switch','access-point','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'desktop',
  `hostname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `processor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ram` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_type` enum('SSD','HDD','NVMe','Hybrid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_capacity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `printer_connection` enum('USB','Network','Wireless','Bluetooth') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `printer_function` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `warranty_expiry` date DEFAULT NULL,
  `condition` enum('excellent','good','fair','poor','broken') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `status` enum('active','inactive','maintenance','retired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `responsible_section` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asset_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `unit_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `devices_serial_number_unique` (`serial_number`),
  UNIQUE KEY `devices_asset_tag_unique` (`asset_tag`),
  KEY `devices_user_id_foreign` (`user_id`),
  KEY `devices_status_index` (`status`),
  KEY `devices_condition_index` (`condition`),
  KEY `devices_type_index` (`type`),
  KEY `devices_location_index` (`location`),
  KEY `devices_user_id_index` (`user_id`),
  KEY `devices_created_at_index` (`created_at`),
  KEY `devices_created_at_id_index` (`created_at`,`id`),
  KEY `devices_unit_id_foreign` (`unit_id`),
  CONSTRAINT `devices_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL,
  CONSTRAINT `devices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.devices: ~114 rows (lebih kurang)
DELETE FROM `devices`;
INSERT INTO `devices` (`id`, `user_id`, `type`, `hostname`, `ip_address`, `mac_address`, `os`, `os_version`, `processor`, `ram`, `storage_type`, `storage_capacity`, `printer_connection`, `printer_function`, `brand`, `model`, `serial_number`, `purchase_date`, `warranty_expiry`, `condition`, `status`, `notes`, `location`, `responsible_section`, `asset_tag`, `created_at`, `updated_at`, `unit_id`) VALUES
	(1, 11, 'desktop', 'PC150421PKD99', '10.9.1.203', NULL, 'Windows', 'Windows 11', NULL, NULL, 'SSD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, NULL, 'desktop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 39, 'desktop', 'NB150421BGU69', '10.9.1.194', NULL, 'Windows 11', NULL, NULL, NULL, 'SSD', '256 GB', NULL, NULL, 'iCherry', 'iCherry ID 77', NULL, NULL, NULL, 'good', 'active', NULL, 'Pengawasan 5', NULL, NULL, '2026-02-03 21:52:32', '2026-02-03 21:52:32', NULL),
	(105, NULL, 'desktop', 'PC150421PW307', '10.9.1.44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(106, NULL, 'desktop', 'PC150421PW110', '10.9.1.177', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(107, 119, 'desktop', 'PC150421FPY08', '10.9.1.204', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(108, NULL, 'desktop', 'PC150421PW209', '10.9.1.95', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(109, NULL, 'desktop', 'PC150421PPP05', '10.9.1.34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(110, 99, 'desktop', 'DESKTOP-OFG8H1O', '10.9.1.186', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(111, 115, 'laptop', 'NB150421BGU73', '10.9.1.57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(112, 60, 'desktop', 'PC150421PKD01', '10.9.1.5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(113, 105, 'laptop', 'NB150421PLY11', '10.9.1.116', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(114, NULL, 'desktop', 'PC150421PLY33', '10.9.1.13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(115, 74, 'desktop', 'PC150421BGU30', '10.9.1.37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(116, NULL, 'desktop', 'PC150421PW304', '10.9.1.83', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(117, 46, 'laptop', 'NB150421BGU94', '10.9.1.156', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(118, NULL, 'desktop', 'PC150421PW105', '10.9.1.140', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(119, 73, 'desktop', 'PC150421BGU21', '10.9.1.11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(120, NULL, 'desktop', 'PC150421PLY25', '10.9.1.98', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(121, 103, 'desktop', 'PC150421PC01', '10.9.1.74', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(122, 19, 'laptop', 'NB150421BGU87', '10.9.1.159', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(123, 81, 'desktop', 'PC150421PKD21', '10.9.1.170', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(124, 84, 'laptop', 'NB150421BGU76', '10.9.1.40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(125, NULL, 'desktop', 'PC150421PW204', '10.9.1.125', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(126, 100, 'desktop', 'PC1050421PLY28', '10.9.1.187', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(127, 44, 'laptop', 'PC150421BGU89', '10.9.1.32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(128, 58, 'desktop', 'PC150421KEP01', '10.9.1.1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:21:52', NULL),
	(129, 117, 'laptop', 'NB150421FGS12', '10.9.1.174', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(130, NULL, 'desktop', 'PC150421PPP08', '10.9.1.117', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(131, NULL, 'desktop', 'PC150421PW608', '10.9.1.24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(132, 124, 'desktop', 'PC150421BGU11', '10.9.1.129', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(133, 90, 'desktop', 'PC150421PKD09', '10.9.1.160', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(134, NULL, 'desktop', 'PC150421PLY03', '10.9.1.155', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(135, NULL, 'desktop', 'PC150421PW106', '10.9.1.89', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(136, NULL, 'desktop', 'PC150421PW501', '10.9.1.50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(137, NULL, 'desktop', 'PC150421PW301', '10.9.1.157', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(138, 77, 'laptop', 'NB150421BGU12', '10.9.1.167', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(139, NULL, 'desktop', 'PC150421PKD77', '10.9.1.111', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(140, NULL, 'desktop', 'PC150PKD02', '10.9.1.64', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(141, NULL, 'desktop', 'PC150421PW510', '10.9.1.21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(142, NULL, 'desktop', 'PC150421PLY27', '10.9.1.137', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(143, 59, 'desktop', 'PC150421PLY01', '10.9.1.121', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(144, 123, 'desktop', 'PC150421BGU07', '10.9.1.30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(145, 86, 'laptop', 'NB150421BGU79', '10.9.1.141', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(146, NULL, 'desktop', 'PC150421PW103', '10.9.1.28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(147, NULL, 'desktop', 'PC150421PW104', '10.9.1.86', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(148, NULL, 'laptop', 'PC150421PW208', '10.9.1.135', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(149, 98, 'laptop', 'DESKTOP-CHTIG8K', '10.9.1.59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(150, 68, 'desktop', 'PC150421BGU19', '10.9.1.110', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(151, NULL, 'desktop', 'PC150421PLY11', '10.9.1.46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(152, 116, 'laptop', 'NB150421BGU81', '10.9.1.173', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(153, 33, 'laptop', 'NB150421PW403', '10.9.1.115', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(154, NULL, 'desktop', 'PC150421PW613', '10.9.1.126', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(155, NULL, 'desktop', 'PC150421PW313', '10.9.1.60', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(156, 54, 'laptop', 'NB150421BGU77', '10.9.1.108', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(157, 75, 'desktop', 'PC150421BGU212', '10.9.1.69', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(158, NULL, 'desktop', 'PC150421PW312', '10.9.1.171', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(159, 83, 'laptop', 'NB150421BGU11', '10.9.1.30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(160, NULL, 'desktop', 'PC150421PW206', '10.9.1.23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(161, NULL, 'desktop', 'PC150421PW207', '10.9.1.27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(162, NULL, 'desktop', 'PC150421PW211', '10.9.1.38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(163, 40, 'laptop', 'NB150421BGU98', '10.9.1.109', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(164, 35, 'laptop', 'NB150421BGU96', '10.9.1.153', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(165, NULL, 'desktop', 'PC150421PLY66', '10.9.1.49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(166, NULL, 'desktop', 'PC150421PW410', '10.9.1.42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(167, NULL, 'desktop', 'PC150421PW512', '10.9.1.70', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(168, 71, 'desktop', 'Pajak', '192.168.100.15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:30', '2026-02-04 01:19:30', NULL),
	(169, NULL, 'desktop', 'PC150421BGU22', '10.9.1.48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(170, 122, 'laptop', 'NB150421BGU35', '10.9.1.123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:22:48', NULL),
	(171, 113, 'laptop', 'NB150421BGU68', '10.9.1.175', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(172, 101, 'laptop', 'NB150421BGU26', '10.9.1.8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:23:44', NULL),
	(173, NULL, 'desktop', 'PC150421PLY17', '10.9.1.56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(174, NULL, 'desktop', 'PC150421PW511', '10.9.1.165', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(175, 53, 'laptop', 'NB150421BGU78', '192.168.1.232', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(176, NULL, 'desktop', 'PC150421PW401', '10.9.1.87', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(177, 18, 'desktop', 'PC150421PW109', '10.9.1.67', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:22:23', NULL),
	(178, 57, 'desktop', 'PC150421PPP10', '10.9.1.169', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:24:15', NULL),
	(179, NULL, 'desktop', 'PC150421PW609', '10.9.1.16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(180, 32, 'laptop', 'NB150421BGU99', '10.9.1.143', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(181, NULL, 'desktop', 'PC150421PPP06', '10.9.1.53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(182, 29, 'laptop', 'NB150421BGU37', '10.9.1.92', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(183, 70, 'desktop', 'DESKTOP-8R9R30V', '10.9.1.113', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(184, 76, 'laptop', 'NB150421PLY21', '10.9.1.39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(185, 92, 'laptop', 'NB1510421BGU83', '10.9.1.152', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(186, NULL, 'desktop', 'PC150421PW601', '10.9.1.3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(187, NULL, 'desktop', 'PC150421PLY18', '10.9.1.151', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(188, 111, 'laptop', 'NB150421FNG07', '10.9.1.72', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(189, NULL, 'desktop', 'PC150421PW305', '10.9.1.79', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(190, 114, 'laptop', 'NB150421FGSO5', '10.9.1.98', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(191, 79, 'laptop', 'NB150421PKD04', '10.9.1.6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(192, 96, 'laptop', 'NB150421PLY34', '192.168.1.220', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(193, NULL, 'desktop', 'PC150421PW308', '10.9.1.29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(194, NULL, 'desktop', 'PC150421PW111', '10.9.1.168', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(195, NULL, 'desktop', 'PC150421PPP01', '10.9.1.25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(196, 34, 'laptop', 'NB150421BGU97', '10.9.1.184', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(197, 102, 'laptop', 'NB150421WK213', '192.168.1.132', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(198, 25, 'laptop', 'NW150421BGU50', '10.9.1.76', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(199, 45, 'laptop', 'NB150421BGU82', '10.9.1.130', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'good', 'active', NULL, NULL, NULL, NULL, '2026-02-04 01:19:31', '2026-02-04 01:19:31', NULL),
	(200, 109, 'laptop', 'LAPTOP-KPP001', '10.9.1.101', '00:1A:2B:3C:4D:01', 'Windows 11 Pro', '22H2', 'Intel Core i5-1235U', '16GB DDR4', 'SSD', '512GB', NULL, NULL, 'Lenovo', 'ThinkPad E14 Gen 4', 'SN-LNV-2024-001', '2024-01-15', '2027-01-15', 'excellent', 'active', NULL, 'Lantai 2', 'Seksi PDI', 'AST-2024-001', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(201, 66, 'desktop', 'PC-KPP-PDI-01', '10.9.1.102', '00:1A:2B:3C:4D:02', 'Windows 10 Pro', '22H2', 'Intel Core i7-12700', '32GB DDR4', 'NVMe', '1TB', NULL, NULL, 'Dell', 'OptiPlex 7010', 'SN-DEL-2023-001', '2023-06-01', '2026-06-01', 'good', 'active', NULL, 'Lantai 1', 'Seksi Pelayanan', 'AST-2024-002', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(202, 118, 'desktop', 'PC-KPP-UMUM-01', '10.9.1.103', '00:1A:2B:3C:4D:03', 'Windows 10 Pro', '21H2', 'Intel Core i5-12500', '8GB DDR4', 'SSD', '256GB', NULL, NULL, 'HP', 'ProDesk 400 G9', 'SN-HP-2023-002', '2022-03-10', '2025-03-10', 'fair', 'active', NULL, 'Lantai 1', 'Bagian Umum', 'AST-2024-003', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(203, 19, 'all-in-one', 'AIO-KPP-KASUB-01', '10.9.1.110', 'A4:83:E7:AB:CD:EF', 'macOS Sequoia', '15.3', 'Apple M3 8-core', '16GB Unified', 'SSD', '512GB', NULL, NULL, 'Apple', 'iMac 24" M3', 'SN-APL-2024-001', '2024-03-01', '2027-03-01', 'excellent', 'active', NULL, 'Lantai 3', 'Ruang Pimpinan', 'AST-2024-004', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(204, 83, 'workstation', 'WS-KPP-IT-01', '10.9.1.115', '00:1A:2B:3C:4D:05', 'Windows 11 Pro', '23H2', 'Intel Xeon W-2223', '64GB DDR4 ECC', 'NVMe', '2TB', NULL, NULL, 'HP', 'Z4 G4 Workstation', 'SN-HP-2022-WS01', '2022-09-15', '2025-09-15', 'good', 'active', NULL, 'Lantai 2', 'Ruang IT', 'AST-2024-005', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(205, 110, 'laptop', 'LAPTOP-KPP-RUSAK', NULL, NULL, 'Windows 10 Home', '21H1', 'Intel Core i3-8130U', '4GB DDR4', 'HDD', '500GB', NULL, NULL, 'Acer', 'Aspire 5', 'SN-ACR-2019-001', '2019-04-20', '2022-04-20', 'broken', 'maintenance', 'Layar retak, keyboard tidak berfungsi. Menunggu anggaran perbaikan.', 'Lantai 2', 'Ruang IT (Gudang)', 'AST-2024-006', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(206, NULL, 'printer', 'PRINTER-LT2-01', '10.9.1.201', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Network', 'Print, Scan, Copy', 'Canon', 'imageCLASS MF445dw', 'SN-CAN-2023-PR01', '2023-02-10', '2026-02-10', 'good', 'active', NULL, 'Lantai 2', 'Area Umum', 'AST-2024-101', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(207, NULL, 'printer', 'PRINTER-LT1-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'USB', 'Print, Scan, Copy, Fax', 'Epson', 'EcoTank ET-4850', 'SN-EPS-2022-PR01', '2022-07-05', '2025-07-05', 'fair', 'active', 'Tinta warna cyan sering habis.', 'Lantai 1', 'Seksi Pelayanan', 'AST-2024-102', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(208, NULL, 'printer', 'PRINTER-LT3-01', '10.9.1.202', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Network', 'Print', 'HP', 'LaserJet Pro M404dn', 'SN-HP-2023-PR01', '2023-08-20', '2026-08-20', 'excellent', 'active', NULL, 'Lantai 3', 'Ruang Pimpinan', 'AST-2024-103', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(209, NULL, 'scanner', 'SCANNER-IT-01', '10.9.1.203', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Wireless', 'Scan', 'Fujitsu', 'ScanSnap iX1600', 'SN-FUJ-2023-SC01', '2023-11-01', '2026-11-01', 'excellent', 'active', NULL, 'Lantai 2', 'Ruang IT', 'AST-2024-104', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(210, NULL, 'router', 'RTR-KPP-CORE', '10.9.1.1', '2C:C8:1B:AB:CD:01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Mikrotik', 'RB4011iGS+RM', 'SN-MTK-2021-RT01', '2021-05-10', '2024-05-10', 'good', 'active', 'Router utama. Gateway: 10.9.1.1/24.', 'Lantai 1', 'Ruang Server', 'AST-2024-201', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(211, NULL, 'switch', 'SW-KPP-LT2-01', '10.9.1.2', '00:1E:BD:AB:CD:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Cisco', 'Catalyst 2960-X', 'SN-CSC-2020-SW01', '2020-11-20', '2023-11-20', 'good', 'active', '24-port managed switch untuk lantai 2.', 'Lantai 2', 'Ruang Server Mini', 'AST-2024-202', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(212, NULL, 'switch', 'SW-KPP-LT1-01', '10.9.1.3', '98:DA:C4:AB:CD:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TP-Link', 'TL-SG108E', 'SN-TPL-2022-SW01', '2022-01-10', '2025-01-10', 'good', 'active', NULL, 'Lantai 1', 'Ruang Server', 'AST-2024-203', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(213, NULL, 'access-point', 'AP-KPP-LT1-01', '10.9.1.11', '78:8A:20:AB:CD:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ubiquiti', 'UniFi AP AC Pro', 'SN-UBI-2022-AP01', '2022-03-15', '2025-03-15', 'good', 'active', NULL, 'Lantai 1', 'Lobby', 'AST-2024-204', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(214, NULL, 'access-point', 'AP-KPP-LT2-01', '10.9.1.12', '78:8A:20:AB:CD:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ubiquiti', 'UniFi AP AC Pro', 'SN-UBI-2022-AP02', '2022-03-15', '2025-03-15', 'good', 'active', NULL, 'Lantai 2', 'Area Tengah', 'AST-2024-205', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL),
	(215, NULL, 'access-point', 'AP-KPP-LT3-01', '10.9.1.13', '78:8A:20:AB:CD:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ubiquiti', 'UniFi AP AC Lite', 'SN-UBI-2023-AP03', '2023-01-08', '2026-01-08', 'excellent', 'active', NULL, 'Lantai 3', 'Ruang Pimpinan', 'AST-2024-206', '2026-04-24 03:43:29', '2026-04-24 03:43:29', NULL);

-- membuang struktur untuk table kaido_kit.device_attributes
CREATE TABLE IF NOT EXISTS `device_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('text','number','select','boolean','date','textarea') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `options` json DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_attributes_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.device_attributes: ~0 rows (lebih kurang)
DELETE FROM `device_attributes`;

-- membuang struktur untuk table kaido_kit.device_attribute_values
CREATE TABLE IF NOT EXISTS `device_attribute_values` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint unsigned NOT NULL,
  `device_attribute_id` bigint unsigned NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `device_attribute_values_device_id_device_attribute_id_unique` (`device_id`,`device_attribute_id`),
  KEY `device_attribute_values_device_attribute_id_foreign` (`device_attribute_id`),
  KEY `device_attribute_values_device_id_device_attribute_id_index` (`device_id`,`device_attribute_id`),
  CONSTRAINT `device_attribute_values_device_attribute_id_foreign` FOREIGN KEY (`device_attribute_id`) REFERENCES `device_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `device_attribute_values_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.device_attribute_values: ~0 rows (lebih kurang)
DELETE FROM `device_attribute_values`;

-- membuang struktur untuk table kaido_kit.exports
CREATE TABLE IF NOT EXISTS `exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exporter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exports_user_id_foreign` (`user_id`),
  CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.exports: ~0 rows (lebih kurang)
DELETE FROM `exports`;
INSERT INTO `exports` (`id`, `completed_at`, `file_disk`, `file_name`, `exporter`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, '2026-02-04 01:08:29', 'local', 'export-1-devices', 'App\\Filament\\Exports\\DeviceExporter', 3, 3, 3, 11, '2026-02-04 01:08:25', '2026-02-04 01:08:29');

-- membuang struktur untuk table kaido_kit.failed_import_rows
CREATE TABLE IF NOT EXISTS `failed_import_rows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data` json NOT NULL,
  `import_id` bigint unsigned NOT NULL,
  `validation_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `failed_import_rows_import_id_foreign` (`import_id`),
  CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.failed_import_rows: ~0 rows (lebih kurang)
DELETE FROM `failed_import_rows`;
INSERT INTO `failed_import_rows` (`id`, `data`, `import_id`, `validation_error`, `created_at`, `updated_at`) VALUES
	(1, '{"os": "", "ram": "", "type": "", "brand": "", "model": "", "notes": "", "status": "active", "hostname": "", "location": "", "asset_tag": "", "condition": "good", "processor": "", "ip_address": "", "os_version": "", "assigned_to": "", "mac_address": "", "storage_type": "", "purchase_date": "", "serial_number": "", "warranty_expiry": "", "storage_capacity": ""}', 3, 'The type field is required.', '2026-02-04 01:19:31', '2026-02-04 01:19:31');

-- membuang struktur untuk table kaido_kit.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.failed_jobs: ~0 rows (lebih kurang)
DELETE FROM `failed_jobs`;

-- membuang struktur untuk table kaido_kit.imports
CREATE TABLE IF NOT EXISTS `imports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `importer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `processed_rows` int unsigned NOT NULL DEFAULT '0',
  `total_rows` int unsigned NOT NULL,
  `successful_rows` int unsigned NOT NULL DEFAULT '0',
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `imports_user_id_foreign` (`user_id`),
  CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.imports: ~3 rows (lebih kurang)
DELETE FROM `imports`;
INSERT INTO `imports` (`id`, `completed_at`, `file_name`, `file_path`, `importer`, `processed_rows`, `total_rows`, `successful_rows`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, '2026-01-06 20:43:24', 'import_users.csv', 'A:\\proyek_magang\\proyek_magang\\storage\\app/private\\livewire-tmp/pNIUKexms46PYvQtYOrRqZcCN0J8Ub-metaaW1wb3J0X3VzZXJzLmNzdg==-.csv', 'App\\Filament\\Imports\\UserImporter', 113, 113, 113, 11, '2026-01-06 20:42:55', '2026-01-06 20:43:24'),
	(2, '2026-02-04 01:14:29', 'Book21.csv', 'A:\\proyek_magang\\edh-421\\storage\\app/private\\livewire-tmp/c3hacYR47oiUAyUCsK5oc3YeuhBWCe-metaQm9vazIxLmNzdg==-.csv', 'App\\Filament\\Imports\\DeviceImporter', 101, 101, 101, 11, '2026-02-04 01:14:25', '2026-02-04 01:14:29'),
	(3, '2026-02-04 01:19:31', 'Book21.csv', 'A:\\proyek_magang\\edh-421\\storage\\app/private\\livewire-tmp/K2Cgrxv15WkKD8bzQYYQuiIRwaUW8L-metaQm9vazIxLmNzdg==-.csv', 'App\\Filament\\Imports\\DeviceImporter', 96, 96, 95, 11, '2026-02-04 01:19:28', '2026-02-04 01:19:31');

-- membuang struktur untuk table kaido_kit.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.jobs: ~0 rows (lebih kurang)
DELETE FROM `jobs`;

-- membuang struktur untuk table kaido_kit.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.job_batches: ~4 rows (lebih kurang)
DELETE FROM `job_batches`;
INSERT INTO `job_batches` (`id`, `name`, `total_jobs`, `pending_jobs`, `failed_jobs`, `failed_job_ids`, `options`, `cancelled_at`, `created_at`, `finished_at`) VALUES
	('a0c6cf0b-66b8-4b20-91c9-c8089ce4bee1', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:3563:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:4:{s:9:"columnMap";a:5:{s:4:"name";s:4:"name";s:3:"nip";s:3:"nip";s:12:"phone_number";s:12:"phone_number";s:5:"email";s:5:"email";s:8:"password";s:8:"password";}s:6:"import";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Imports\\Models\\Import";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:13:"jobConnection";N;s:7:"options";a:0:{}}s:8:"function";s:2925:"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }";s:5:"scope";s:36:"Filament\\Tables\\Actions\\ImportAction";s:4:"this";N;s:4:"self";s:32:"0000000000000b470000000000000000";}";s:4:"hash";s:44:"XqpTg5Urk1UMiHhZ2fq5+KXYhlt9cl4LQ3+fUSgUZXA=";}}}}', NULL, 1767757376, 1767757404),
	('a0ff8191-6c4a-4d10-a3d4-121e6c607bd0', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:8052:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:1:{s:4:"next";O:46:"Filament\\Actions\\Exports\\Jobs\\ExportCompletion":7:{s:11:"\0*\0exporter";O:35:"App\\Filament\\Exports\\DeviceExporter":3:{s:9:"\0*\0export";O:38:"Filament\\Actions\\Exports\\Models\\Export":33:{s:13:"\0*\0connection";s:5:"mysql";s:8:"\0*\0table";N;s:13:"\0*\0primaryKey";s:2:"id";s:10:"\0*\0keyType";s:3:"int";s:12:"incrementing";b:1;s:7:"\0*\0with";a:0:{}s:12:"\0*\0withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:"\0*\0perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:"\0*\0escapeWhenCastingToString";b:0;s:13:"\0*\0attributes";a:8:{s:7:"user_id";i:11;s:8:"exporter";s:35:"App\\Filament\\Exports\\DeviceExporter";s:10:"total_rows";i:3;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-02-04 08:08:25";s:10:"created_at";s:19:"2026-02-04 08:08:25";s:2:"id";i:1;s:9:"file_name";s:16:"export-1-devices";}s:11:"\0*\0original";a:8:{s:7:"user_id";i:11;s:8:"exporter";s:35:"App\\Filament\\Exports\\DeviceExporter";s:10:"total_rows";i:3;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-02-04 08:08:25";s:10:"created_at";s:19:"2026-02-04 08:08:25";s:2:"id";i:1;s:9:"file_name";s:16:"export-1-devices";}s:10:"\0*\0changes";a:1:{s:9:"file_name";s:16:"export-1-devices";}s:11:"\0*\0previous";a:0:{}s:8:"\0*\0casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:"\0*\0classCastCache";a:0:{}s:21:"\0*\0attributeCastCache";a:0:{}s:13:"\0*\0dateFormat";N;s:10:"\0*\0appends";a:0:{}s:19:"\0*\0dispatchesEvents";a:0:{}s:14:"\0*\0observables";a:0:{}s:12:"\0*\0relations";a:0:{}s:10:"\0*\0touches";a:0:{}s:27:"\0*\0relationAutoloadCallback";N;s:26:"\0*\0relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:"\0*\0hidden";a:0:{}s:10:"\0*\0visible";a:0:{}s:11:"\0*\0fillable";a:0:{}s:10:"\0*\0guarded";a:0:{}}s:12:"\0*\0columnMap";a:24:{s:2:"id";s:2:"ID";s:9:"user.name";s:11:"Assigned To";s:4:"type";s:4:"Type";s:8:"hostname";s:8:"Hostname";s:10:"ip_address";s:10:"IP Address";s:11:"mac_address";s:11:"MAC Address";s:5:"brand";s:5:"Brand";s:5:"model";s:5:"Model";s:13:"serial_number";s:13:"Serial Number";s:9:"asset_tag";s:9:"Asset Tag";s:2:"os";s:16:"Operating System";s:10:"os_version";s:10:"OS Version";s:9:"processor";s:9:"Processor";s:3:"ram";s:3:"RAM";s:12:"storage_type";s:12:"Storage Type";s:16:"storage_capacity";s:16:"Storage Capacity";s:9:"condition";s:9:"Condition";s:6:"status";s:6:"Status";s:8:"location";s:8:"Location";s:13:"purchase_date";s:13:"Purchase Date";s:15:"warranty_expiry";s:15:"Warranty Expiry";s:5:"notes";s:5:"Notes";s:10:"created_at";s:10:"Created at";s:10:"updated_at";s:10:"Updated at";}s:10:"\0*\0options";a:0:{}}s:9:"\0*\0export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:"\0*\0columnMap";a:24:{s:2:"id";s:2:"ID";s:9:"user.name";s:11:"Assigned To";s:4:"type";s:4:"Type";s:8:"hostname";s:8:"Hostname";s:10:"ip_address";s:10:"IP Address";s:11:"mac_address";s:11:"MAC Address";s:5:"brand";s:5:"Brand";s:5:"model";s:5:"Model";s:13:"serial_number";s:13:"Serial Number";s:9:"asset_tag";s:9:"Asset Tag";s:2:"os";s:16:"Operating System";s:10:"os_version";s:10:"OS Version";s:9:"processor";s:9:"Processor";s:3:"ram";s:3:"RAM";s:12:"storage_type";s:12:"Storage Type";s:16:"storage_capacity";s:16:"Storage Capacity";s:9:"condition";s:9:"Condition";s:6:"status";s:6:"Status";s:8:"location";s:8:"Location";s:13:"purchase_date";s:13:"Purchase Date";s:15:"warranty_expiry";s:15:"Warranty Expiry";s:5:"notes";s:5:"Notes";s:10:"created_at";s:10:"Created at";s:10:"updated_at";s:10:"Updated at";}s:10:"\0*\0formats";a:2:{i:0;E:47:"Filament\\Actions\\Exports\\Enums\\ExportFormat:Csv";i:1;E:48:"Filament\\Actions\\Exports\\Enums\\ExportFormat:Xlsx";}s:10:"\0*\0options";a:0:{}s:7:"chained";a:1:{i:0;s:3677:"O:44:"Filament\\Actions\\Exports\\Jobs\\CreateXlsxFile":4:{s:11:"\0*\0exporter";O:35:"App\\Filament\\Exports\\DeviceExporter":3:{s:9:"\0*\0export";O:38:"Filament\\Actions\\Exports\\Models\\Export":33:{s:13:"\0*\0connection";s:5:"mysql";s:8:"\0*\0table";N;s:13:"\0*\0primaryKey";s:2:"id";s:10:"\0*\0keyType";s:3:"int";s:12:"incrementing";b:1;s:7:"\0*\0with";a:0:{}s:12:"\0*\0withCount";a:0:{}s:19:"preventsLazyLoading";b:0;s:10:"\0*\0perPage";i:15;s:6:"exists";b:1;s:18:"wasRecentlyCreated";b:1;s:28:"\0*\0escapeWhenCastingToString";b:0;s:13:"\0*\0attributes";a:8:{s:7:"user_id";i:11;s:8:"exporter";s:35:"App\\Filament\\Exports\\DeviceExporter";s:10:"total_rows";i:3;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-02-04 08:08:25";s:10:"created_at";s:19:"2026-02-04 08:08:25";s:2:"id";i:1;s:9:"file_name";s:16:"export-1-devices";}s:11:"\0*\0original";a:8:{s:7:"user_id";i:11;s:8:"exporter";s:35:"App\\Filament\\Exports\\DeviceExporter";s:10:"total_rows";i:3;s:9:"file_disk";s:5:"local";s:10:"updated_at";s:19:"2026-02-04 08:08:25";s:10:"created_at";s:19:"2026-02-04 08:08:25";s:2:"id";i:1;s:9:"file_name";s:16:"export-1-devices";}s:10:"\0*\0changes";a:1:{s:9:"file_name";s:16:"export-1-devices";}s:11:"\0*\0previous";a:0:{}s:8:"\0*\0casts";a:4:{s:12:"completed_at";s:9:"timestamp";s:14:"processed_rows";s:7:"integer";s:10:"total_rows";s:7:"integer";s:15:"successful_rows";s:7:"integer";}s:17:"\0*\0classCastCache";a:0:{}s:21:"\0*\0attributeCastCache";a:0:{}s:13:"\0*\0dateFormat";N;s:10:"\0*\0appends";a:0:{}s:19:"\0*\0dispatchesEvents";a:0:{}s:14:"\0*\0observables";a:0:{}s:12:"\0*\0relations";a:0:{}s:10:"\0*\0touches";a:0:{}s:27:"\0*\0relationAutoloadCallback";N;s:26:"\0*\0relationAutoloadContext";N;s:10:"timestamps";b:1;s:13:"usesUniqueIds";b:0;s:9:"\0*\0hidden";a:0:{}s:10:"\0*\0visible";a:0:{}s:11:"\0*\0fillable";a:0:{}s:10:"\0*\0guarded";a:0:{}}s:12:"\0*\0columnMap";a:24:{s:2:"id";s:2:"ID";s:9:"user.name";s:11:"Assigned To";s:4:"type";s:4:"Type";s:8:"hostname";s:8:"Hostname";s:10:"ip_address";s:10:"IP Address";s:11:"mac_address";s:11:"MAC Address";s:5:"brand";s:5:"Brand";s:5:"model";s:5:"Model";s:13:"serial_number";s:13:"Serial Number";s:9:"asset_tag";s:9:"Asset Tag";s:2:"os";s:16:"Operating System";s:10:"os_version";s:10:"OS Version";s:9:"processor";s:9:"Processor";s:3:"ram";s:3:"RAM";s:12:"storage_type";s:12:"Storage Type";s:16:"storage_capacity";s:16:"Storage Capacity";s:9:"condition";s:9:"Condition";s:6:"status";s:6:"Status";s:8:"location";s:8:"Location";s:13:"purchase_date";s:13:"Purchase Date";s:15:"warranty_expiry";s:15:"Warranty Expiry";s:5:"notes";s:5:"Notes";s:10:"created_at";s:10:"Created at";s:10:"updated_at";s:10:"Updated at";}s:10:"\0*\0options";a:0:{}}s:9:"\0*\0export";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Exports\\Models\\Export";s:2:"id";i:1;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:12:"\0*\0columnMap";a:24:{s:2:"id";s:2:"ID";s:9:"user.name";s:11:"Assigned To";s:4:"type";s:4:"Type";s:8:"hostname";s:8:"Hostname";s:10:"ip_address";s:10:"IP Address";s:11:"mac_address";s:11:"MAC Address";s:5:"brand";s:5:"Brand";s:5:"model";s:5:"Model";s:13:"serial_number";s:13:"Serial Number";s:9:"asset_tag";s:9:"Asset Tag";s:2:"os";s:16:"Operating System";s:10:"os_version";s:10:"OS Version";s:9:"processor";s:9:"Processor";s:3:"ram";s:3:"RAM";s:12:"storage_type";s:12:"Storage Type";s:16:"storage_capacity";s:16:"Storage Capacity";s:9:"condition";s:9:"Condition";s:6:"status";s:6:"Status";s:8:"location";s:8:"Location";s:13:"purchase_date";s:13:"Purchase Date";s:15:"warranty_expiry";s:15:"Warranty Expiry";s:5:"notes";s:5:"Notes";s:10:"created_at";s:10:"Created at";s:10:"updated_at";s:10:"Updated at";}s:10:"\0*\0options";a:0:{}}";}s:19:"chainCatchCallbacks";a:0:{}}}s:8:"function";s:266:"function (\\Illuminate\\Bus\\Batch $batch) use ($next) {\n                if (! $batch->cancelled()) {\n                    \\Illuminate\\Container\\Container::getInstance()->make(\\Illuminate\\Contracts\\Bus\\Dispatcher::class)->dispatch($next);\n                }\n            }";s:5:"scope";s:27:"Illuminate\\Bus\\ChainedBatch";s:4:"this";N;s:4:"self";s:32:"0000000000000b4d0000000000000000";}";s:4:"hash";s:44:"Ws9ouDObRgAwURwv1kfuxjgf54K44Qei8VWViK+6xr0=";}}}}', NULL, 1770192508, 1770192509),
	('a0ff83b1-530d-403e-be28-11a57ee1a790', '', 2, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:4108:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:4:{s:9:"columnMap";a:21:{s:4:"type";s:4:"type";s:11:"assigned_to";s:11:"assigned_to";s:8:"hostname";s:8:"hostname";s:10:"ip_address";s:10:"ip_address";s:11:"mac_address";s:11:"mac_address";s:5:"brand";s:5:"brand";s:5:"model";s:5:"model";s:13:"serial_number";s:13:"serial_number";s:9:"asset_tag";s:9:"asset_tag";s:2:"os";s:2:"os";s:10:"os_version";s:10:"os_version";s:9:"processor";s:9:"processor";s:3:"ram";s:3:"ram";s:12:"storage_type";s:12:"storage_type";s:16:"storage_capacity";s:16:"storage_capacity";s:9:"condition";s:9:"condition";s:6:"status";s:6:"status";s:8:"location";s:8:"location";s:13:"purchase_date";s:13:"purchase_date";s:15:"warranty_expiry";s:15:"warranty_expiry";s:5:"notes";s:5:"notes";}s:6:"import";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Imports\\Models\\Import";s:2:"id";i:2;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:13:"jobConnection";N;s:7:"options";a:0:{}}s:8:"function";s:2925:"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }";s:5:"scope";s:36:"Filament\\Tables\\Actions\\ImportAction";s:4:"this";N;s:4:"self";s:32:"00000000000011dc0000000000000000";}";s:4:"hash";s:44:"pKr0jd/m+uxgsJe0dzw+1Bk0RGGvrvEU10S8QrSfvHA=";}}}}', NULL, 1770192865, 1770192869),
	('a0ff8580-39aa-48ca-a3cb-d9409457fbfe', '', 1, 0, 0, '[]', 'a:2:{s:13:"allowFailures";b:1;s:7:"finally";a:1:{i:0;O:47:"Laravel\\SerializableClosure\\SerializableClosure":1:{s:12:"serializable";O:46:"Laravel\\SerializableClosure\\Serializers\\Signed":2:{s:12:"serializable";s:4108:"O:46:"Laravel\\SerializableClosure\\Serializers\\Native":5:{s:3:"use";a:4:{s:9:"columnMap";a:21:{s:4:"type";s:4:"type";s:11:"assigned_to";s:11:"assigned_to";s:8:"hostname";s:8:"hostname";s:10:"ip_address";s:10:"ip_address";s:11:"mac_address";s:11:"mac_address";s:5:"brand";s:5:"brand";s:5:"model";s:5:"model";s:13:"serial_number";s:13:"serial_number";s:9:"asset_tag";s:9:"asset_tag";s:2:"os";s:2:"os";s:10:"os_version";s:10:"os_version";s:9:"processor";s:9:"processor";s:3:"ram";s:3:"ram";s:12:"storage_type";s:12:"storage_type";s:16:"storage_capacity";s:16:"storage_capacity";s:9:"condition";s:9:"condition";s:6:"status";s:6:"status";s:8:"location";s:8:"location";s:13:"purchase_date";s:13:"purchase_date";s:15:"warranty_expiry";s:15:"warranty_expiry";s:5:"notes";s:5:"notes";}s:6:"import";O:45:"Illuminate\\Contracts\\Database\\ModelIdentifier":5:{s:5:"class";s:38:"Filament\\Actions\\Imports\\Models\\Import";s:2:"id";i:3;s:9:"relations";a:0:{}s:10:"connection";s:5:"mysql";s:15:"collectionClass";N;}s:13:"jobConnection";N;s:7:"options";a:0:{}}s:8:"function";s:2925:"function () use ($columnMap, $import, $jobConnection, $options) {\n                    $import->touch(\'completed_at\');\n\n                    event(new \\Filament\\Actions\\Imports\\Events\\ImportCompleted($import, $columnMap, $options));\n\n                    if (! $import->user instanceof \\Illuminate\\Contracts\\Auth\\Authenticatable) {\n                        return;\n                    }\n\n                    $failedRowsCount = $import->getFailedRowsCount();\n\n                    \\Filament\\Notifications\\Notification::make()\n                        ->title($import->importer::getCompletedNotificationTitle($import))\n                        ->body($import->importer::getCompletedNotificationBody($import))\n                        ->when(\n                            ! $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->success(),\n                        )\n                        ->when(\n                            $failedRowsCount && ($failedRowsCount < $import->total_rows),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->warning(),\n                        )\n                        ->when(\n                            $failedRowsCount === $import->total_rows,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->danger(),\n                        )\n                        ->when(\n                            $failedRowsCount,\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->actions([\n                                \\Filament\\Notifications\\Actions\\Action::make(\'downloadFailedRowsCsv\')\n                                    ->label(trans_choice(\'filament-actions::import.notifications.completed.actions.download_failed_rows_csv.label\', $failedRowsCount, [\n                                        \'count\' => \\Illuminate\\Support\\Number::format($failedRowsCount),\n                                    ]))\n                                    ->color(\'danger\')\n                                    ->url(route(\'filament.imports.failed-rows.download\', [\'import\' => $import], absolute: false), shouldOpenInNewTab: true)\n                                    ->markAsRead(),\n                            ]),\n                        )\n                        ->when(\n                            ($jobConnection === \'sync\') ||\n                                (blank($jobConnection) && (config(\'queue.default\') === \'sync\')),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification\n                                ->persistent()\n                                ->send(),\n                            fn (\\Filament\\Notifications\\Notification $notification) => $notification->sendToDatabase($import->user, isEventDispatched: true),\n                        );\n                }";s:5:"scope";s:36:"Filament\\Tables\\Actions\\ImportAction";s:4:"this";N;s:4:"self";s:32:"00000000000011dd0000000000000000";}";s:4:"hash";s:44:"JDjqjGdHSgpHxsK4K6Lltki848BNJOZShxEU0hl58lY=";}}}}', NULL, 1770193168, 1770193171);

-- membuang struktur untuk table kaido_kit.media
CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `conversions_disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `generated_conversions` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.media: ~0 rows (lebih kurang)
DELETE FROM `media`;

-- membuang struktur untuk table kaido_kit.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.migrations: ~40 rows (lebih kurang)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2022_12_14_083707_create_settings_table', 1),
	(5, '2024_12_04_025120_create_media_table', 1),
	(6, '2024_12_04_041953_create_breezy_sessions_table', 1),
	(7, '2025_01_01_120813_create_books_table', 1),
	(8, '2025_01_02_064819_create_permission_tables', 1),
	(9, '2025_01_03_114929_create_personal_access_tokens_table', 1),
	(10, '2025_01_04_125650_create_posts_table', 1),
	(11, '2025_01_08_152510_create_kaido_settings', 1),
	(12, '2025_01_08_233142_create_socialite_users_table', 1),
	(13, '2025_01_12_031340_create_notifications_table', 1),
	(14, '2025_01_12_031357_create_imports_table', 1),
	(15, '2025_01_12_031358_create_exports_table', 1),
	(16, '2025_01_12_031359_create_failed_import_rows_table', 1),
	(17, '2025_01_12_091355_create_contacts_table', 1),
	(18, '2026_01_04_000001_transform_books_to_articles', 1),
	(19, '2026_01_04_092628_create_devices_table', 1),
	(20, '2026_01_04_092629_create_device_attributes_table', 1),
	(21, '2026_01_05_081413_create_tickets_table', 1),
	(22, '2026_01_05_081513_create_ticket_responses_table', 1),
	(23, '2026_01_05_083705_create_ticket_attachments_table', 1),
	(24, '2026_01_06_015834_create_vehicles_table', 1),
	(25, '2026_01_06_015915_create_vehicle_bookings_table', 1),
	(26, '2026_01_06_085409_create_categories_table', 1),
	(27, '2026_01_06_085415_add_category_id_to_articles_table', 1),
	(28, '2026_01_08_052805_add_is_external_device_to_tickets_table', 2),
	(29, '2026_01_18_042126_add_performance_indexes', 3),
	(30, '2026_01_18_114618_add_more_performance_indexes', 4),
	(31, '2026_01_24_024936_add_file_data_to_ticket_attachments_table', 5),
	(32, '2026_02_04_085309_add_performance_indexes', 6),
	(33, '2026_04_24_094528_update_category_enum_in_tickets_table', 7),
	(34, '2026_04_24_102133_expand_type_enum_in_devices_table', 8),
	(35, '2026_04_24_103902_add_printer_fields_to_devices_table', 9),
	(36, '2026_04_25_000000_add_responsible_section_to_devices_table', 10),
	(37, '2026_04_28_000001_add_first_responded_at_to_tickets_table', 11),
	(38, '2026_04_28_000002_create_ticket_audit_logs_table', 11),
	(39, '2026_04_28_000003_add_sla_due_at_to_tickets_table', 12),
	(40, '2026_04_28_create_sla_settings', 12),
	(41, '2026_04_29_000000_add_email_verification_required_setting', 13),
	(42, '2026_05_06_031840_add_theme_gray_to_users_table', 14),
	(43, '2026_05_06_083853_add_theme_gray_level_to_users_table', 14),
	(44, '2026_05_26_020338_create_units_table', 15),
	(45, '2026_05_26_020342_add_unit_id_to_devices_table', 15),
	(46, '2026_05_26_create_navigation_settings', 15),
	(47, '2026_06_01_000001_add_admin_ui_theme_preferences_to_users_table', 16),
	(48, '2026_06_02_000000_remove_show_inventory_dashboard_setting', 17);

-- membuang struktur untuk table kaido_kit.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.model_has_permissions: ~0 rows (lebih kurang)
DELETE FROM `model_has_permissions`;

-- membuang struktur untuk table kaido_kit.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.model_has_roles: ~116 rows (lebih kurang)
DELETE FROM `model_has_roles`;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 11),
	(2, 'App\\Models\\User', 11),
	(3, 'App\\Models\\User', 11),
	(2, 'App\\Models\\User', 12),
	(2, 'App\\Models\\User', 13),
	(2, 'App\\Models\\User', 14),
	(2, 'App\\Models\\User', 15),
	(2, 'App\\Models\\User', 16),
	(2, 'App\\Models\\User', 17),
	(2, 'App\\Models\\User', 18),
	(2, 'App\\Models\\User', 19),
	(2, 'App\\Models\\User', 20),
	(2, 'App\\Models\\User', 21),
	(2, 'App\\Models\\User', 22),
	(2, 'App\\Models\\User', 23),
	(2, 'App\\Models\\User', 24),
	(2, 'App\\Models\\User', 25),
	(2, 'App\\Models\\User', 26),
	(2, 'App\\Models\\User', 27),
	(2, 'App\\Models\\User', 28),
	(2, 'App\\Models\\User', 29),
	(2, 'App\\Models\\User', 30),
	(2, 'App\\Models\\User', 31),
	(2, 'App\\Models\\User', 32),
	(2, 'App\\Models\\User', 33),
	(2, 'App\\Models\\User', 34),
	(2, 'App\\Models\\User', 35),
	(2, 'App\\Models\\User', 36),
	(2, 'App\\Models\\User', 37),
	(2, 'App\\Models\\User', 38),
	(2, 'App\\Models\\User', 39),
	(2, 'App\\Models\\User', 40),
	(2, 'App\\Models\\User', 41),
	(2, 'App\\Models\\User', 42),
	(2, 'App\\Models\\User', 43),
	(2, 'App\\Models\\User', 44),
	(2, 'App\\Models\\User', 45),
	(2, 'App\\Models\\User', 46),
	(2, 'App\\Models\\User', 47),
	(2, 'App\\Models\\User', 48),
	(2, 'App\\Models\\User', 49),
	(2, 'App\\Models\\User', 50),
	(2, 'App\\Models\\User', 51),
	(2, 'App\\Models\\User', 52),
	(2, 'App\\Models\\User', 53),
	(2, 'App\\Models\\User', 54),
	(2, 'App\\Models\\User', 55),
	(2, 'App\\Models\\User', 56),
	(2, 'App\\Models\\User', 57),
	(2, 'App\\Models\\User', 58),
	(2, 'App\\Models\\User', 59),
	(2, 'App\\Models\\User', 60),
	(2, 'App\\Models\\User', 61),
	(2, 'App\\Models\\User', 62),
	(2, 'App\\Models\\User', 63),
	(2, 'App\\Models\\User', 64),
	(2, 'App\\Models\\User', 65),
	(2, 'App\\Models\\User', 66),
	(2, 'App\\Models\\User', 67),
	(2, 'App\\Models\\User', 68),
	(2, 'App\\Models\\User', 69),
	(2, 'App\\Models\\User', 70),
	(2, 'App\\Models\\User', 71),
	(2, 'App\\Models\\User', 72),
	(2, 'App\\Models\\User', 73),
	(2, 'App\\Models\\User', 74),
	(2, 'App\\Models\\User', 75),
	(2, 'App\\Models\\User', 76),
	(2, 'App\\Models\\User', 77),
	(2, 'App\\Models\\User', 78),
	(2, 'App\\Models\\User', 79),
	(3, 'App\\Models\\User', 79),
	(2, 'App\\Models\\User', 80),
	(2, 'App\\Models\\User', 81),
	(2, 'App\\Models\\User', 83),
	(2, 'App\\Models\\User', 84),
	(2, 'App\\Models\\User', 85),
	(2, 'App\\Models\\User', 86),
	(2, 'App\\Models\\User', 87),
	(2, 'App\\Models\\User', 88),
	(2, 'App\\Models\\User', 89),
	(2, 'App\\Models\\User', 90),
	(2, 'App\\Models\\User', 91),
	(2, 'App\\Models\\User', 92),
	(2, 'App\\Models\\User', 93),
	(2, 'App\\Models\\User', 94),
	(2, 'App\\Models\\User', 95),
	(2, 'App\\Models\\User', 96),
	(2, 'App\\Models\\User', 97),
	(2, 'App\\Models\\User', 98),
	(2, 'App\\Models\\User', 99),
	(2, 'App\\Models\\User', 100),
	(2, 'App\\Models\\User', 101),
	(2, 'App\\Models\\User', 102),
	(2, 'App\\Models\\User', 103),
	(2, 'App\\Models\\User', 104),
	(2, 'App\\Models\\User', 105),
	(2, 'App\\Models\\User', 106),
	(2, 'App\\Models\\User', 107),
	(2, 'App\\Models\\User', 108),
	(2, 'App\\Models\\User', 109),
	(2, 'App\\Models\\User', 110),
	(2, 'App\\Models\\User', 111),
	(2, 'App\\Models\\User', 112),
	(2, 'App\\Models\\User', 113),
	(2, 'App\\Models\\User', 114),
	(2, 'App\\Models\\User', 115),
	(2, 'App\\Models\\User', 116),
	(2, 'App\\Models\\User', 117),
	(2, 'App\\Models\\User', 118),
	(2, 'App\\Models\\User', 119),
	(2, 'App\\Models\\User', 120),
	(2, 'App\\Models\\User', 121),
	(2, 'App\\Models\\User', 122),
	(2, 'App\\Models\\User', 123),
	(2, 'App\\Models\\User', 124);

-- membuang struktur untuk table kaido_kit.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` json NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.notifications: ~28 rows (lebih kurang)
DELETE FROM `notifications`;
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
	('07700251-10cc-4eb9-bce1-fd7095a9492d', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 119, '{"body": "Tiket TKT-20260429-0001 sedang ditangani oleh RIO ALVAREZ", "icon": "heroicon-o-wrench-screwdriver", "view": "filament-notifications::notification", "color": null, "title": "Tiket Anda Sedang Ditangani", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/14", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-04-29 02:42:32', '2026-04-29 02:42:32'),
	('0a80f66b-d206-4d18-b849-151c4e182d49', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 65, '{"body": "Tiket TKT-20260204-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/10", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-03 22:00:31', '2026-02-03 22:00:31'),
	('0b9b8370-e96b-490b-b577-fbc9b7131343', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 65, '{"body": "Tiket TKT-20260204-0001 sedang ditangani oleh RIO ALVAREZ", "icon": "heroicon-o-wrench-screwdriver", "view": "filament-notifications::notification", "color": null, "title": "Tiket Anda Sedang Ditangani", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/10", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-03 22:00:31', '2026-02-03 22:00:31'),
	('26823ad0-a55e-4ccb-be06-8dd63fc5b469', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 81, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/13", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-04-29 02:38:13', '2026-04-29 02:38:13'),
	('4017eee1-aadf-4993-a1ce-a63d69d8f4e4', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 45, '{"body": "Tiket TKT-20260204-0002 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-04 03:18:10', '2026-02-04 03:18:10'),
	('41d2d928-faaf-4f2e-90cf-0526118cd609', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 24, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/5", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-01-18 05:05:01', '2026-01-18 05:05:01'),
	('42e82bfc-078d-4ebd-89d1-131c6541c293', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 39, '{"body": "Peminjaman KDO-20260108-0002 untuk Mitsubishi Xpander (Matic) (D 1123 T) telah disetujui", "icon": "heroicon-o-check-circle", "view": "filament-notifications::notification", "color": null, "title": "Peminjaman KDO Disetujui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/vehicle-bookings/2", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-01-07 21:57:01', '2026-01-07 21:57:01'),
	('4d9a6dcb-c9df-4ff7-a20b-a4c05c234b22', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 119, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/14", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-04-29 02:43:29', '2026-04-29 02:43:29'),
	('5d7f5ffd-d5ce-4fb7-89b1-28e3126c6bc0', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 13, '{"body": "Tiket TKT-20260204-0003 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/12", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-23 18:21:38', '2026-02-23 18:21:38'),
	('5ea83c0a-f14d-45d3-ac81-0b5c2d48eba8', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 45, '{"body": "Tiket TKT-20260204-0002 sedang ditangani oleh UJANG WIJIONO EKA MEI", "icon": "heroicon-o-wrench-screwdriver", "view": "filament-notifications::notification", "color": null, "title": "Tiket Anda Sedang Ditangani", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-04 03:18:10', '2026-02-04 03:18:10'),
	('6a7c2c21-49bd-4ec1-9ac4-a2ebbe4271dd', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 24, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/5", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-01-23 02:27:57', '2026-01-23 02:27:57'),
	('6cc8cdd3-32b1-4cd7-9fa1-fd9f1596c836', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 39, '{"body": "Peminjaman KDO-20260108-0002 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Peminjaman KDO Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/vehicle-bookings/2", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-01-07 22:00:05', '2026-01-07 22:00:05'),
	('7681a3f9-ff88-4c04-b967-48bd39c9b98c', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 81, '{"body": "Peminjaman KDO-20260204-0001 untuk Mitsubishi Xpander (Matic) (D 1123 T) telah disetujui", "icon": "heroicon-o-check-circle", "view": "filament-notifications::notification", "color": null, "title": "Peminjaman KDO Disetujui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/vehicle-bookings/5", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-03 22:04:26', '2026-02-03 22:04:26'),
	('7a6d3d4a-1953-40a3-b1f5-3b870b46e7c1', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 99, '{"body": "Peminjaman KDO-20260204-0002 untuk Mitsubishi Xpander (Matic - Suki) (D 1121 T) telah disetujui", "icon": "heroicon-o-check-circle", "view": "filament-notifications::notification", "color": null, "title": "Peminjaman KDO Disetujui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/vehicle-bookings/6", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Detail", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-04 03:17:24', '2026-02-04 03:17:24'),
	('7d40d1fe-2b29-4c86-8f94-3dde21ec3f2c', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 45, '{"body": "Tiket TKT-20260204-0002 status berubah menjadi: Ditutup", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "gray"}', NULL, '2026-02-04 03:19:10', '2026-02-04 03:19:10'),
	('8ecd1712-cf3b-4052-a348-353b5901c618', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 79, '{"body": "Tiket TKT-20260204-0002 status berubah: Diproses ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-04 03:19:07', '2026-02-04 03:19:07'),
	('9438bb94-bf46-4357-8c3e-af04c51397f7', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 79, '{"body": "Anda ditugaskan untuk menangani tiket: TKT-20260204-0002", "icon": "heroicon-o-user-plus", "view": "filament-notifications::notification", "color": null, "title": "Tiket Ditugaskan ke Anda", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-04 03:18:10', '2026-02-04 03:18:10'),
	('96f817c9-b4dd-437e-a8d6-29ee1260d9d8', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 65, '{"body": "Tiket TKT-20260204-0001 sedang ditangani oleh UJANG WIJIONO EKA MEI", "icon": "heroicon-o-wrench-screwdriver", "view": "filament-notifications::notification", "color": null, "title": "Tiket Anda Sedang Ditangani", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/10", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-03 22:23:27', '2026-02-03 22:23:27'),
	('9a28f60e-271c-4bfe-8e41-9165b89db5ad', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 81, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/13", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-04-29 02:38:43', '2026-04-29 02:38:43'),
	('9e3c8958-ec31-4067-bd38-1497d260c00a', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 79, '{"body": "Tiket TKT-20260204-0002 status berubah: Dibuka ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-04 03:18:10', '2026-02-04 03:18:10'),
	('b100d507-b0e2-4cfb-8369-bdc5669b093a', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 79, '{"body": "Tiket TKT-20260204-0002 status berubah: Selesai ÃƒÂ¢Ã¢â‚¬Â Ã¢â‚¬â„¢ Ditutup", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "gray"}', NULL, '2026-02-04 03:19:10', '2026-02-04 03:19:10'),
	('b2c538e4-57dc-413d-8a40-f30208a4450d', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 81, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Ditutup", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/13", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "gray"}', NULL, '2026-04-29 02:38:49', '2026-04-29 02:38:49'),
	('b7f55d1b-9fcc-4f77-866e-0ebd3c47fb19', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 24, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Ditutup", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/5", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "gray"}', NULL, '2026-01-23 02:28:03', '2026-01-23 02:28:03'),
	('cc8d172c-3146-4f77-84df-d56487b5519f', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 28, '{"body": "Tiket TKT-20260118-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/tickets/4", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-01-17 23:34:17', '2026-01-17 23:34:17'),
	('f06cad19-7172-4a66-860d-b3032ed5ec90', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 79, '{"body": "Anda ditugaskan untuk menangani tiket: TKT-20260204-0001", "icon": "heroicon-o-user-plus", "view": "filament-notifications::notification", "color": null, "title": "Tiket Ditugaskan ke Anda", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/10", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-02-03 22:23:27', '2026-02-03 22:23:27'),
	('f2c95b93-ae2c-449c-aee3-212e5612acab', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 45, '{"body": "Tiket TKT-20260204-0002 status berubah menjadi: Selesai", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://localhost:8000/admin/tickets/11", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "success"}', NULL, '2026-02-04 03:19:07', '2026-02-04 03:19:07'),
	('f3641af5-a81e-49f4-b395-04084652bcd5', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 119, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Diproses", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/14", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "warning"}', NULL, '2026-04-29 02:42:32', '2026-04-29 02:42:32'),
	('f877181d-2777-4aa9-9ea3-2289f44f0752', 'Filament\\Notifications\\DatabaseNotification', 'App\\Models\\User', 119, '{"body": "Tiket TKT-20260429-0001 status berubah menjadi: Ditutup", "icon": "heroicon-o-arrow-path", "view": "filament-notifications::notification", "color": null, "title": "Status Tiket Diperbarui", "format": "filament", "status": null, "actions": [{"url": "http://127.0.0.1:8000/admin/tickets/14", "icon": null, "name": "view", "size": "sm", "view": "filament-actions::link-action", "color": null, "event": null, "label": "Lihat Tiket", "tooltip": null, "iconSize": null, "eventData": [], "isDisabled": false, "isOutlined": false, "shouldClose": false, "iconPosition": "before", "extraAttributes": [], "shouldMarkAsRead": true, "dispatchDirection": false, "shouldMarkAsUnread": false, "dispatchToComponent": null, "shouldOpenUrlInNewTab": false}], "duration": "persistent", "viewData": [], "iconColor": "gray"}', NULL, '2026-04-29 02:43:35', '2026-04-29 02:43:35');

-- membuang struktur untuk table kaido_kit.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `nip` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'NIP sebagai identifier',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.password_reset_tokens: ~0 rows (lebih kurang)
DELETE FROM `password_reset_tokens`;

-- membuang struktur untuk table kaido_kit.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.permissions: ~117 rows (lebih kurang)
DELETE FROM `permissions`;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'view_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(2, 'view_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(3, 'create_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(4, 'update_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(5, 'restore_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(6, 'restore_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(7, 'replicate_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(8, 'reorder_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(9, 'delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(10, 'delete_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(11, 'force_delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(12, 'force_delete_any_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(13, 'article:create_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(14, 'article:update_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(15, 'article:delete_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(16, 'article:pagination_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(17, 'article:detail_article', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(18, 'view_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(19, 'view_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(20, 'create_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(21, 'update_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(22, 'restore_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(23, 'restore_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(24, 'replicate_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(25, 'reorder_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(26, 'delete_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(27, 'delete_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(28, 'force_delete_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(29, 'force_delete_any_category', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(30, 'view_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(31, 'view_any_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(32, 'create_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(33, 'update_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(34, 'delete_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(35, 'delete_any_device', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(36, 'view_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(37, 'view_any_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(38, 'create_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(39, 'update_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(40, 'delete_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(41, 'delete_any_device::attribute', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(42, 'view_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(43, 'view_any_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(44, 'create_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(45, 'update_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(46, 'delete_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(47, 'delete_any_role', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(48, 'view_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(49, 'view_any_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(50, 'create_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(51, 'update_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(52, 'delete_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(53, 'delete_any_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(54, 'assign_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(55, 'resolve_ticket', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(56, 'view_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(57, 'view_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(58, 'create_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(59, 'update_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(60, 'restore_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(61, 'restore_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(62, 'replicate_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(63, 'reorder_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(64, 'delete_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(65, 'delete_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(66, 'force_delete_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(67, 'force_delete_any_token', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(68, 'view_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(69, 'view_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(70, 'create_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(71, 'update_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(72, 'restore_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(73, 'restore_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(74, 'replicate_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(75, 'reorder_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(76, 'delete_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(77, 'delete_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(78, 'force_delete_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(79, 'force_delete_any_user', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(80, 'view_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(81, 'view_any_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(82, 'create_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(83, 'update_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(84, 'delete_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(85, 'delete_any_vehicle', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(86, 'view_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(87, 'view_any_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(88, 'create_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(89, 'update_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(90, 'delete_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(91, 'delete_any_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(92, 'return_vehicle::booking', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(93, 'page_ManageSetting', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(94, 'page_VehicleCalendar', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(95, 'page_Themes', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(96, 'page_MyProfilePage', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(97, 'widget_VehicleBookingStats', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(98, 'widget_VehicleAvailabilityCalendar', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(99, 'widget_MyActiveBookings', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(100, 'widget_DeviceStatsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(101, 'widget_TicketStatsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(102, 'widget_RecentTicketsWidget', 'web', '2026-01-06 20:24:49', '2026-01-06 20:24:49'),
	(103, 'page_TicketReport', 'web', '2026-02-03 22:05:56', '2026-02-03 22:05:56'),
	(104, 'page_ManageModuleSettings', 'web', '2026-04-23 01:12:20', '2026-04-23 01:12:20'),
	(105, 'view_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(106, 'view_any_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(107, 'create_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(108, 'update_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(109, 'delete_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(110, 'delete_any_unit', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(111, 'page_DeviceDashboard', 'web', '2026-05-30 20:35:24', '2026-05-30 20:35:24'),
	(112, 'page_ManageNavigationSettings', 'web', '2026-05-30 20:35:25', '2026-05-30 20:35:25'),
	(113, 'page_ManageSlaSettings', 'web', '2026-05-30 20:35:25', '2026-05-30 20:35:25'),
	(114, 'page_ThemeColorPage', 'web', '2026-05-30 20:35:25', '2026-05-30 20:35:25'),
	(115, 'widget_WelcomeMessageWidget', 'web', '2026-05-30 20:35:25', '2026-05-30 20:35:25'),
	(116, 'page_MyDevices', 'web', '2026-06-01 00:11:47', '2026-06-01 00:11:47'),
	(117, 'page_KnowledgeManagement', 'web', '2026-06-01 02:33:02', '2026-06-01 02:33:02'),
	(118, 'page_ManajemenUser', 'web', '2026-06-01 02:33:02', '2026-06-01 02:33:02'),
	(119, 'reorder_device::attribute', 'web', '2026-06-02 03:16:03', '2026-06-02 03:16:03');

-- membuang struktur untuk table kaido_kit.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.personal_access_tokens: ~0 rows (lebih kurang)
DELETE FROM `personal_access_tokens`;

-- membuang struktur untuk table kaido_kit.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.posts: ~10 rows (lebih kurang)
DELETE FROM `posts`;
INSERT INTO `posts` (`id`, `title`, `content`, `created_at`, `updated_at`) VALUES
	(1, 'Suscipit voluptate id illum modi porro ipsa.', 'Saepe quo dolores et voluptatem voluptatem eos repellendus. Quia est perspiciatis sed. Quidem earum harum assumenda harum voluptatem. Harum soluta ut alias odit.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(2, 'Accusamus est cupiditate debitis sed.', 'Voluptatem quam sint vel deserunt. Eius vel veniam perferendis laborum. Expedita voluptas autem vel et. Assumenda sapiente autem et ut culpa aut doloremque doloremque.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(3, 'Perferendis eos necessitatibus consequatur quasi.', 'Minus dolorum saepe neque quasi quas ipsam natus. Quia sint molestiae repellendus vel magnam vel. Aspernatur incidunt nesciunt odio veritatis ullam non rerum. Dolorum recusandae totam rerum.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(4, 'Quo qui praesentium quae neque qui voluptate.', 'Autem voluptas dignissimos totam harum. Non numquam deserunt dolor dolorem unde. Qui cupiditate sint laboriosam nemo possimus. Aliquid quo quam et veritatis officiis.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(5, 'Error vel aut dolorum eveniet consequatur porro voluptas blanditiis.', 'Repellendus consequatur sit voluptas. In dicta et optio non et. In error necessitatibus odio ut.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(6, 'Temporibus rem sequi quis eos voluptate dignissimos libero.', 'Quasi sit rerum ut est error impedit nostrum quis. Veritatis eius qui et aliquid minima et. Sint accusantium quia nulla. In corrupti excepturi dolores dolorem.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(7, 'Vitae ut beatae ut.', 'Ratione debitis consequatur doloribus illo fugiat. Tempora eaque dignissimos voluptas. Aut excepturi similique sit quo. Eligendi consequuntur impedit voluptatem.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(8, 'Dolores adipisci accusamus non excepturi eum.', 'Quasi nulla magni odio aliquid quidem quia eos voluptate. Cum optio nobis quod facilis. Quam et est cupiditate veritatis.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(9, 'Laborum cum provident velit ipsum rerum esse deserunt.', 'Ipsum amet harum qui labore sunt. Ducimus harum qui quis. Quis inventore voluptates qui et voluptas maxime. Debitis consequatur saepe natus deleniti aspernatur eos.', '2026-01-06 20:23:51', '2026-01-06 20:23:51'),
	(10, 'Ea odio ut atque blanditiis omnis.', 'Alias ab autem aspernatur et placeat consequuntur rem. Voluptatem tempore in inventore nulla porro officia. Pariatur quasi totam omnis expedita sed.', '2026-01-06 20:23:51', '2026-01-06 20:23:51');

-- membuang struktur untuk table kaido_kit.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.roles: ~3 rows (lebih kurang)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'super_admin', 'web', '2026-01-06 20:24:48', '2026-01-06 20:24:48'),
	(2, 'Member', 'web', '2026-01-06 20:48:04', '2026-01-06 20:48:04'),
	(3, 'Admin', 'web', '2026-02-03 22:05:56', '2026-02-03 22:05:56');

-- membuang struktur untuk table kaido_kit.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.role_has_permissions: ~210 rows (lebih kurang)
DELETE FROM `role_has_permissions`;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(48, 1),
	(49, 1),
	(50, 1),
	(51, 1),
	(52, 1),
	(53, 1),
	(54, 1),
	(55, 1),
	(56, 1),
	(57, 1),
	(58, 1),
	(59, 1),
	(60, 1),
	(61, 1),
	(62, 1),
	(63, 1),
	(64, 1),
	(65, 1),
	(66, 1),
	(67, 1),
	(68, 1),
	(69, 1),
	(70, 1),
	(71, 1),
	(72, 1),
	(73, 1),
	(74, 1),
	(75, 1),
	(76, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(81, 1),
	(82, 1),
	(83, 1),
	(84, 1),
	(85, 1),
	(86, 1),
	(87, 1),
	(88, 1),
	(89, 1),
	(90, 1),
	(91, 1),
	(92, 1),
	(93, 1),
	(94, 1),
	(95, 1),
	(96, 1),
	(97, 1),
	(98, 1),
	(99, 1),
	(100, 1),
	(101, 1),
	(102, 1),
	(103, 1),
	(104, 1),
	(105, 1),
	(106, 1),
	(107, 1),
	(108, 1),
	(109, 1),
	(110, 1),
	(111, 1),
	(112, 1),
	(113, 1),
	(114, 1),
	(115, 1),
	(116, 1),
	(117, 1),
	(118, 1),
	(119, 1),
	(1, 2),
	(2, 2),
	(3, 2),
	(48, 2),
	(49, 2),
	(50, 2),
	(86, 2),
	(87, 2),
	(88, 2),
	(96, 2),
	(1, 3),
	(2, 3),
	(3, 3),
	(4, 3),
	(5, 3),
	(6, 3),
	(7, 3),
	(8, 3),
	(9, 3),
	(10, 3),
	(11, 3),
	(12, 3),
	(13, 3),
	(14, 3),
	(15, 3),
	(16, 3),
	(17, 3),
	(18, 3),
	(19, 3),
	(20, 3),
	(21, 3),
	(22, 3),
	(23, 3),
	(24, 3),
	(25, 3),
	(26, 3),
	(27, 3),
	(28, 3),
	(29, 3),
	(30, 3),
	(31, 3),
	(32, 3),
	(33, 3),
	(34, 3),
	(35, 3),
	(36, 3),
	(37, 3),
	(38, 3),
	(39, 3),
	(40, 3),
	(41, 3),
	(48, 3),
	(49, 3),
	(50, 3),
	(51, 3),
	(52, 3),
	(53, 3),
	(54, 3),
	(55, 3),
	(56, 3),
	(57, 3),
	(58, 3),
	(59, 3),
	(60, 3),
	(61, 3),
	(62, 3),
	(63, 3),
	(64, 3),
	(65, 3),
	(66, 3),
	(67, 3),
	(80, 3),
	(81, 3),
	(82, 3),
	(83, 3),
	(84, 3),
	(85, 3),
	(86, 3),
	(87, 3),
	(88, 3),
	(89, 3),
	(90, 3),
	(91, 3),
	(92, 3),
	(94, 3),
	(95, 3),
	(96, 3),
	(97, 3),
	(98, 3),
	(99, 3),
	(100, 3),
	(101, 3),
	(102, 3),
	(103, 3);

-- membuang struktur untuk table kaido_kit.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.sessions: ~9 rows (lebih kurang)
DELETE FROM `sessions`;
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('8CEz6MgMSt0iqYtuznsCF5x56QS8n2C3N590Zgsc', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZXdFa1VvdTd2eEt2WkQ3a1RvZXo1dnN3ZGFFR0lCMEh6TklaZmhOWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi90aWNrZXRzIjtzOjU6InJvdXRlIjtzOjM4OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMudGlja2V0cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl8zZGM3YTkxM2VmNWZkNGI4OTBlY2FiZTM0ODcwODU1NzNlMTZjZjgyIjtpOjExO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTAkVDkzU0J5T3hjY1VMUTVRZHJ4UXMzLkY1clk1R1J1cHEvbDJlMDJWV0dBRFFKUFl3T1JFRFciO3M6NjoidGFibGVzIjthOjI6e3M6NDA6ImZmNmVlMjA3Y2E1NmUzOTA1OGQ3Y2UxNzc3Y2MzYzhmX2ZpbHRlcnMiO2E6MTE6e3M6ODoiaG9zdG5hbWUiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMDoiaXBfYWRkcmVzcyI7YToxOntzOjU6InZhbHVlIjtOO31zOjExOiJicmFuZF9tb2RlbCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEzOiJzZXJpYWxfbnVtYmVyIjthOjE6e3M6NToidmFsdWUiO047fXM6NDoidHlwZSI7YToxOntzOjU6InZhbHVlIjtzOjM6ImFsbCI7fXM6Njoic3RhdHVzIjthOjE6e3M6NToidmFsdWUiO047fXM6OToiY29uZGl0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidXNlcl9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImxvY2F0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidW5pdF9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImFzc2lnbmVkIjthOjE6e3M6NToidmFsdWUiO047fX1zOjM3OiJmZjZlZTIwN2NhNTZlMzkwNThkN2NlMTc3N2NjM2M4Zl9zb3J0IjthOjI6e3M6NjoiY29sdW1uIjtzOjQ6InR5cGUiO3M6OToiZGlyZWN0aW9uIjtzOjM6ImFzYyI7fX19', 1780340615),
	('HNm3m4LjWjBRhs0M4aZwrDNQ3vPbBEcWASUt1dNi', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiRGp0QkpWT0dKQlROeHQ4d3V3amVuS0hHRXZSWVV3NDZpclpUTmJsOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbiI7czo1OiJyb3V0ZSI7czozMDoiZmlsYW1lbnQuYWRtaW4ucGFnZXMuZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzNkYzdhOTEzZWY1ZmQ0Yjg5MGVjYWJlMzQ4NzA4NTU3M2UxNmNmODIiO2k6MTE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMCRUOTNTQnlPeGNjVUxRNVFkcnhRczMuRjVyWTVHUnVwcS9sMmUwMlZXR0FEUUpQWXdPUkVEVyI7czo2OiJ0YWJsZXMiO2E6NDp7czo0MDoiNGIzMTNkMTZkNGZiODRkNmNhNTc2ZThlOWI2N2I4NjNfZmlsdGVycyI7YToxMTp7czo4OiJob3N0bmFtZSI7YToxOntzOjU6InZhbHVlIjtOO31zOjEwOiJpcF9hZGRyZXNzIjthOjE6e3M6NToidmFsdWUiO047fXM6MTE6ImJyYW5kX21vZGVsIjthOjE6e3M6NToidmFsdWUiO047fXM6MTM6InNlcmlhbF9udW1iZXIiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo0OiJ0eXBlIjthOjE6e3M6NToidmFsdWUiO047fXM6Njoic3RhdHVzIjthOjE6e3M6NToidmFsdWUiO047fXM6OToiY29uZGl0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidXNlcl9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImxvY2F0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidW5pdF9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImFzc2lnbmVkIjthOjE6e3M6NToidmFsdWUiO047fX1zOjM3OiI0YjMxM2QxNmQ0ZmI4NGQ2Y2E1NzZlOGU5YjY3Yjg2M19zb3J0IjthOjI6e3M6NjoiY29sdW1uIjtOO3M6OToiZGlyZWN0aW9uIjtOO31zOjQwOiJmZjZlZTIwN2NhNTZlMzkwNThkN2NlMTc3N2NjM2M4Zl9maWx0ZXJzIjthOjExOntzOjg6Imhvc3RuYW1lIjthOjE6e3M6NToidmFsdWUiO047fXM6MTA6ImlwX2FkZHJlc3MiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMToiYnJhbmRfbW9kZWwiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMzoic2VyaWFsX251bWJlciI7YToxOntzOjU6InZhbHVlIjtOO31zOjQ6InR5cGUiO2E6MTp7czo1OiJ2YWx1ZSI7czozOiJhbGwiO31zOjY6InN0YXR1cyI7YToxOntzOjU6InZhbHVlIjtOO31zOjk6ImNvbmRpdGlvbiI7YToxOntzOjU6InZhbHVlIjtOO31zOjc6InVzZXJfaWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo4OiJsb2NhdGlvbiI7YToxOntzOjU6InZhbHVlIjtOO31zOjc6InVuaXRfaWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo4OiJhc3NpZ25lZCI7YToxOntzOjU6InZhbHVlIjtOO319czozNzoiZmY2ZWUyMDdjYTU2ZTM5MDU4ZDdjZTE3NzdjYzNjOGZfc29ydCI7YToyOntzOjY6ImNvbHVtbiI7czo5OiJ1c2VyLm5hbWUiO3M6OToiZGlyZWN0aW9uIjtzOjQ6ImRlc2MiO319fQ==', 1780307651),
	('i8xQKVvryu0E3LohVdJwHQNqNXtEGPn18upXz8vb', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1RsdktJbnJtaWE4UDJjWXV6V1FUSWFpQTVmM0hFMkxaR0F3MkUzWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9sb2dpbiI7czo1OiJyb3V0ZSI7czoyNToiZmlsYW1lbnQuYWRtaW4uYXV0aC5sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1780330643),
	('kOWeeuATO8iFOE02FX5Dbyfru7vkVzC9CpVbeZh5', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoia2pUeGR4YVZrWHp2ZjdYTU1oRk1uWjlvMnI0UUxHZnZPTEJvZU5sYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi90aWNrZXQtcmVwb3J0IjtzOjU6InJvdXRlIjtzOjM0OiJmaWxhbWVudC5hZG1pbi5wYWdlcy50aWNrZXQtcmVwb3J0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl8zZGM3YTkxM2VmNWZkNGI4OTBlY2FiZTM0ODcwODU1NzNlMTZjZjgyIjtpOjExO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTAkVDkzU0J5T3hjY1VMUTVRZHJ4UXMzLkY1clk1R1J1cHEvbDJlMDJWV0dBRFFKUFl3T1JFRFciO3M6ODoiZmlsYW1lbnQiO2E6MDp7fXM6NjoidGFibGVzIjthOjI6e3M6NDA6ImZmNmVlMjA3Y2E1NmUzOTA1OGQ3Y2UxNzc3Y2MzYzhmX2ZpbHRlcnMiO2E6MTE6e3M6ODoiaG9zdG5hbWUiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMDoiaXBfYWRkcmVzcyI7YToxOntzOjU6InZhbHVlIjtOO31zOjExOiJicmFuZF9tb2RlbCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEzOiJzZXJpYWxfbnVtYmVyIjthOjE6e3M6NToidmFsdWUiO047fXM6NDoidHlwZSI7YToxOntzOjU6InZhbHVlIjtzOjM6ImFsbCI7fXM6Njoic3RhdHVzIjthOjE6e3M6NToidmFsdWUiO047fXM6OToiY29uZGl0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidXNlcl9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImxvY2F0aW9uIjthOjE6e3M6NToidmFsdWUiO047fXM6NzoidW5pdF9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjg6ImFzc2lnbmVkIjthOjE6e3M6NToidmFsdWUiO047fX1zOjM3OiJmZjZlZTIwN2NhNTZlMzkwNThkN2NlMTc3N2NjM2M4Zl9zb3J0IjthOjI6e3M6NjoiY29sdW1uIjtOO3M6OToiZGlyZWN0aW9uIjtOO319fQ==', 1780309992),
	('rRXavridPtDVHhQl1uJ6vN6G5hMZB01vVH5pqDb5', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiR0dZZzFkOG9NRjRuVmR5VTFQc3A3Znh3VTVQSXF6YnpOQXVwaWd0SSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vdGhlbWUtY29sb3IiO3M6NToicm91dGUiO3M6MzI6ImZpbGFtZW50LmFkbWluLnBhZ2VzLnRoZW1lLWNvbG9yIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzNkYzdhOTEzZWY1ZmQ0Yjg5MGVjYWJlMzQ4NzA4NTU3M2UxNmNmODIiO2k6MTE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMCRUOTNTQnlPeGNjVUxRNVFkcnhRczMuRjVyWTVHUnVwcS9sMmUwMlZXR0FEUUpQWXdPUkVEVyI7fQ==', 1780309827),
	('selknJIYWSxEXYKFyOHAkDqNoM6iRMGjG7msDhS9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; id-ID) WindowsPowerShell/5.1.26100.8457', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQUl0c2o2bXgwcFBUSktQaHA0bzROYWx3TDVMWHI4elB6RzFrVG9vciI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozOToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FkbWluL3RoZW1lLWNvbG9yIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9sb2dpbiI7czo1OiJyb3V0ZSI7czoyNToiZmlsYW1lbnQuYWRtaW4uYXV0aC5sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1780309729),
	('umkVkbP9uXBzn2V093bGGnXV3tZQgoDo6pOTsvz5', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiUTlYQTNjSXF6anNndnRwS1NwbFJVUmZaM0w4dHp5NWxlRzRicEFucSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi90aWNrZXRzIjtzOjU6InJvdXRlIjtzOjM4OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMudGlja2V0cy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfM2RjN2E5MTNlZjVmZDRiODkwZWNhYmUzNDg3MDg1NTczZTE2Y2Y4MiI7aToxMTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEwJFQ5M1NCeU94Y2NVTFE1UWRyeFFzMy5GNXJZNUdSdXBxL2wyZTAyVldHQURRSlBZd09SRURXIjtzOjY6InRhYmxlcyI7YToyOntzOjQwOiJmZjZlZTIwN2NhNTZlMzkwNThkN2NlMTc3N2NjM2M4Zl9maWx0ZXJzIjthOjExOntzOjg6Imhvc3RuYW1lIjthOjE6e3M6NToidmFsdWUiO047fXM6MTA6ImlwX2FkZHJlc3MiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMToiYnJhbmRfbW9kZWwiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMzoic2VyaWFsX251bWJlciI7YToxOntzOjU6InZhbHVlIjtOO31zOjQ6InR5cGUiO2E6MTp7czo1OiJ2YWx1ZSI7czozOiJhbGwiO31zOjY6InN0YXR1cyI7YToxOntzOjU6InZhbHVlIjtOO31zOjk6ImNvbmRpdGlvbiI7YToxOntzOjU6InZhbHVlIjtOO31zOjc6InVzZXJfaWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo4OiJsb2NhdGlvbiI7YToxOntzOjU6InZhbHVlIjtOO31zOjc6InVuaXRfaWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo4OiJhc3NpZ25lZCI7YToxOntzOjU6InZhbHVlIjtOO319czozNzoiZmY2ZWUyMDdjYTU2ZTM5MDU4ZDdjZTE3NzdjYzNjOGZfc29ydCI7YToyOntzOjY6ImNvbHVtbiI7TjtzOjk6ImRpcmVjdGlvbiI7Tjt9fX0=', 1780331200),
	('WQ46CH8Tzq5G70TofyH39ImtSMkp2NTpbz46H8ZS', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo4OntzOjY6Il90b2tlbiI7czo0MDoiVUl5ODRtZ2lBTEtWY0JlNlVLMUpvMnFleXA2Mmk2bGh6d2w0a0RxWSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9tYW5hZ2Utc2V0dGluZyI7czo1OiJyb3V0ZSI7czozNToiZmlsYW1lbnQuYWRtaW4ucGFnZXMubWFuYWdlLXNldHRpbmciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzNkYzdhOTEzZWY1ZmQ0Yjg5MGVjYWJlMzQ4NzA4NTU3M2UxNmNmODIiO2k6MTE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMCRUOTNTQnlPeGNjVUxRNVFkcnhRczMuRjVyWTVHUnVwcS9sMmUwMlZXR0FEUUpQWXdPUkVEVyI7czo4OiJmaWxhbWVudCI7YTowOnt9czo2OiJ0YWJsZXMiO2E6Mjp7czo0MDoiZmY2ZWUyMDdjYTU2ZTM5MDU4ZDdjZTE3NzdjYzNjOGZfZmlsdGVycyI7YToxMTp7czo4OiJob3N0bmFtZSI7YToxOntzOjU6InZhbHVlIjtOO31zOjEwOiJpcF9hZGRyZXNzIjthOjE6e3M6NToidmFsdWUiO047fXM6MTE6ImJyYW5kX21vZGVsIjthOjE6e3M6NToidmFsdWUiO047fXM6MTM6InNlcmlhbF9udW1iZXIiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo0OiJ0eXBlIjthOjE6e3M6NToidmFsdWUiO3M6MzoiYWxsIjt9czo2OiJzdGF0dXMiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo5OiJjb25kaXRpb24iO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo3OiJ1c2VyX2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6ODoibG9jYXRpb24iO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czo3OiJ1bml0X2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6ODoiYXNzaWduZWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9fXM6Mzc6ImZmNmVlMjA3Y2E1NmUzOTA1OGQ3Y2UxNzc3Y2MzYzhmX3NvcnQiO2E6Mjp7czo2OiJjb2x1bW4iO047czo5OiJkaXJlY3Rpb24iO047fX19', 1780338515),
	('YiIuDehySkxdO39r0RGXSoJFa7LPcmkSVrywMdUn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; id-ID) WindowsPowerShell/5.1.26100.8457', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiemhSVjBsU1lpMGhLVWFJa2xMYnZnbjY4d09HQW5McXd0ZGJJaUplYiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozOToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FkbWluL3RoZW1lLWNvbG9yIjt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9sb2dpbiI7czo1OiJyb3V0ZSI7czoyNToiZmlsYW1lbnQuYWRtaW4uYXV0aC5sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1780309714);

-- membuang struktur untuk table kaido_kit.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `payload` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_group_name_unique` (`group`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.settings: ~29 rows (lebih kurang)
DELETE FROM `settings`;
INSERT INTO `settings` (`id`, `group`, `name`, `locked`, `payload`, `created_at`, `updated_at`) VALUES
	(1, 'KaidoSetting', 'site_name', 0, '"Spatie"', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(2, 'KaidoSetting', 'site_active', 0, 'true', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(3, 'KaidoSetting', 'registration_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(4, 'KaidoSetting', 'login_enabled', 0, 'true', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(5, 'KaidoSetting', 'password_reset_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(6, 'KaidoSetting', 'sso_enabled', 0, 'false', '2026-01-06 20:23:49', '2026-01-06 20:27:12'),
	(8, 'modules', 'enable_vehicle_booking', 0, 'false', NULL, '2026-04-23 01:12:35'),
	(9, 'modules', 'enable_helpdesk_tickets', 0, 'true', NULL, '2026-04-23 01:12:35'),
	(10, 'modules', 'enable_inventory', 0, 'true', NULL, '2026-04-23 01:12:35'),
	(11, 'modules', 'enable_blog', 0, 'true', NULL, '2026-04-23 01:12:35'),
	(12, 'modules', 'enable_user_management', 0, 'true', NULL, '2026-04-23 01:12:35'),
	(14, 'sla', 'critical_hours', 0, '2', '2026-04-27 20:53:12', '2026-04-27 20:53:12'),
	(15, 'sla', 'high_hours', 0, '8', '2026-04-27 20:53:12', '2026-04-27 20:53:12'),
	(16, 'sla', 'medium_hours', 0, '24', '2026-04-27 20:53:12', '2026-04-27 20:53:12'),
	(17, 'sla', 'low_hours', 0, '72', '2026-04-27 20:53:12', '2026-04-27 20:53:12'),
	(18, 'KaidoSetting', 'email_verification_required', 0, 'false', NULL, NULL),
	(19, 'navigation', 'show_helpdesk_tickets', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(20, 'navigation', 'show_helpdesk_report', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(21, 'navigation', 'show_vehicle_master', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(22, 'navigation', 'show_vehicle_booking', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(23, 'navigation', 'show_vehicle_calendar', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(24, 'navigation', 'show_inventory_devices', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(26, 'navigation', 'show_inventory_attributes', 0, 'false', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(27, 'navigation', 'show_inventory_units', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(28, 'navigation', 'show_km_articles', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(29, 'navigation', 'show_km_categories', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(30, 'navigation', 'show_user_management', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35'),
	(31, 'navigation', 'show_role_management', 0, 'true', '2026-05-30 20:27:46', '2026-05-30 20:39:35');

-- membuang struktur untuk table kaido_kit.socialite_users
CREATE TABLE IF NOT EXISTS `socialite_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialite_users_provider_provider_id_unique` (`provider`,`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.socialite_users: ~0 rows (lebih kurang)
DELETE FROM `socialite_users`;

-- membuang struktur untuk table kaido_kit.tickets
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `device_id` bigint unsigned DEFAULT NULL,
  `is_external_device` tinyint(1) NOT NULL DEFAULT '0',
  `assigned_to` bigint unsigned DEFAULT NULL,
  `category` enum('incident_management','service_request','user_support','access_management','asset_management','change_management','network_support','security_support','documentation_kb') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'incident_management',
  `priority` enum('low','medium','high','critical') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('open','in_progress','waiting_for_user','resolved','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `resolution_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `first_responded_at` timestamp NULL DEFAULT NULL,
  `sla_due_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_ticket_number_unique` (`ticket_number`),
  KEY `tickets_user_id_foreign` (`user_id`),
  KEY `tickets_device_id_foreign` (`device_id`),
  KEY `tickets_assigned_to_foreign` (`assigned_to`),
  KEY `tickets_status_index` (`status`),
  KEY `tickets_priority_index` (`priority`),
  KEY `tickets_category_index` (`category`),
  KEY `tickets_created_at_index` (`created_at`),
  KEY `tickets_status_user_id_index` (`status`,`user_id`),
  KEY `tickets_status_assigned_to_index` (`status`,`assigned_to`),
  KEY `tickets_assigned_to_index` (`assigned_to`),
  CONSTRAINT `tickets_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.tickets: ~0 rows (lebih kurang)
DELETE FROM `tickets`;
INSERT INTO `tickets` (`id`, `ticket_number`, `user_id`, `device_id`, `is_external_device`, `assigned_to`, `category`, `priority`, `subject`, `description`, `status`, `resolution_notes`, `resolved_at`, `first_responded_at`, `sla_due_at`, `closed_at`, `created_at`, `updated_at`) VALUES
	(14, 'TKT-20260429-0001', 119, 107, 0, 11, 'incident_management', 'medium', 'Layar monitor blank', '<p>layar monitor tidak menyala setelah kabel power disambungkan</p>', 'closed', 'telah diproses secara langsung', '2026-04-29 02:43:27', NULL, '2026-04-30 02:42:19', '2026-04-29 02:43:35', '2026-04-29 02:42:19', '2026-04-29 02:43:35');

-- membuang struktur untuk table kaido_kit.ticket_attachments
CREATE TABLE IF NOT EXISTS `ticket_attachments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_attachments_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `ticket_attachments_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.ticket_attachments: ~0 rows (lebih kurang)
DELETE FROM `ticket_attachments`;

-- membuang struktur untuk table kaido_kit.ticket_audit_logs
CREATE TABLE IF NOT EXISTS `ticket_audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `event` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_audit_logs_ticket_id_foreign` (`ticket_id`),
  KEY `ticket_audit_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `ticket_audit_logs_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.ticket_audit_logs: ~5 rows (lebih kurang)
DELETE FROM `ticket_audit_logs`;
INSERT INTO `ticket_audit_logs` (`id`, `ticket_id`, `user_id`, `event`, `description`, `old_values`, `new_values`, `created_at`, `updated_at`) VALUES
	(5, 14, 11, 'created', 'Tiket TKT-20260429-0001 dibuat oleh pelapor.', NULL, '{"subject": "Layar monitor blank", "category": "incident_management", "priority": "medium"}', '2026-04-29 02:42:19', '2026-04-29 02:42:19'),
	(6, 14, 11, 'status_changed', 'Status berubah dari "Dibuka" menjadi "Diproses".', '{"status": "open"}', '{"status": "in_progress"}', '2026-04-29 02:42:31', '2026-04-29 02:42:31'),
	(7, 14, 11, 'assigned', 'Tiket ditugaskan ke RIO ALVAREZ.', '{"assigned_to": "Belum ditugaskan"}', '{"assigned_to": "RIO ALVAREZ"}', '2026-04-29 02:42:31', '2026-04-29 02:42:31'),
	(8, 14, 11, 'status_changed', 'Status berubah dari "Diproses" menjadi "Selesai".', '{"status": "in_progress"}', '{"status": "resolved"}', '2026-04-29 02:43:27', '2026-04-29 02:43:27'),
	(9, 14, 11, 'status_changed', 'Status berubah dari "Selesai" menjadi "Ditutup".', '{"status": "resolved"}', '{"status": "closed"}', '2026-04-29 02:43:35', '2026-04-29 02:43:35');

-- membuang struktur untuk table kaido_kit.ticket_responses
CREATE TABLE IF NOT EXISTS `ticket_responses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_internal_note` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_responses_ticket_id_foreign` (`ticket_id`),
  KEY `ticket_responses_user_id_foreign` (`user_id`),
  KEY `ticket_responses_ticket_id_index` (`ticket_id`),
  KEY `ticket_responses_user_id_index` (`user_id`),
  KEY `ticket_responses_ticket_id_created_at_index` (`ticket_id`,`created_at`),
  CONSTRAINT `ticket_responses_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_responses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.ticket_responses: ~0 rows (lebih kurang)
DELETE FROM `ticket_responses`;

-- membuang struktur untuk table kaido_kit.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `units_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.units: ~2 rows (lebih kurang)
DELETE FROM `units`;
INSERT INTO `units` (`id`, `name`, `code`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Seksi Pelayanan', 'PLY', 'Lantai 1 Back Office', '2026-05-30 20:53:23', '2026-05-30 20:53:23'),
	(2, 'Seksi Penjaminan Kualitas Data', 'PKD', 'Ruangan Utama', '2026-05-30 20:53:47', '2026-05-30 20:53:47');

-- membuang struktur untuk table kaido_kit.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '9 digit NIP untuk login',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nullable untuk SSO users',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'default',
  `theme_color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_gray` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'slate',
  `theme_gray_level` tinyint unsigned NOT NULL DEFAULT '1',
  `theme_sidebar_style` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `theme_navbar_style` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'clean',
  `theme_density` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'comfortable',
  `theme_radius` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `theme_content_width` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_nip_unique` (`nip`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.users: ~113 rows (lebih kurang)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `nip`, `email`, `phone_number`, `email_verified_at`, `password`, `avatar_url`, `theme`, `theme_color`, `theme_gray`, `theme_gray_level`, `theme_sidebar_style`, `theme_navbar_style`, `theme_density`, `theme_radius`, `theme_content_width`, `remember_token`, `created_at`, `updated_at`) VALUES
	(11, 'RIO ALVAREZ', '817931566', 'rio.alvarez@pajak.go.id', '089678286135', '2026-01-06 20:23:51', '$2y$10$T93SByOxccULQ5QdrxQs3.F5rY5GRupq/l2e02VWGADQJPYwOREDW', NULL, 'default', 'blue', 'slate', 1, 'default', 'glass', 'comfortable', 'default', 'wide', 'GvYa6EmkM9aCNGPUxaGnXIsKwDvfqjmmog93cQICFYjJPkDZfZNAzDIVJfCY', '2026-01-06 20:23:51', '2026-06-01 11:28:08'),
	(12, 'WAHYU KURNIAWAN', '060114428', NULL, '089678286135', '2026-01-07 03:52:32', '$2y$10$5KhV.DihGnqqh1BcTcEZK.4VGk6yqbhx8W.WJ5tCOFZDPVHHSQdya', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', 'OCLxx6y16QEtyYEp1E2dv95cnJ2ESFW6DVKProLrwduqy3RQE8Tlmexof0Ma', '2026-01-06 20:42:58', '2026-04-22 20:21:24'),
	(13, 'ARIS SUKO WIBOWO', '060116130', NULL, NULL, '2026-01-07 03:52:33', '$2y$10$XavUrSYUo9Wtt5AFRGkYQOvZJ4RW55u1EFUcNI8gqawMvUBXTXTOu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', 'YiOjPEsMxzCE5soCGRMkacuaqaG3tFB5TGWCVXcuMNxDMk2k05Gjd1FcnJdX', '2026-01-06 20:42:59', '2026-02-04 03:08:45'),
	(14, 'HARIS SUBEKTI', '060102726', NULL, NULL, '2026-01-07 03:52:34', '$2y$12$5HvUeIHx6NZtgDhPWcd0ruALzHon026x9F5TkMPjLPRyEi/i6cFb2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(15, 'FRANSISKA JAYANTI DWILESTARI', '930102288', NULL, NULL, '2026-01-07 03:52:34', '$2y$12$bDMtGN.Kk0tiTjCzNQyOs.JaR/ro8J.gyOzMuQDQy1Ik8.ZXoiT1m', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(16, 'SRI RAHAYU', '930102368', NULL, NULL, '2026-01-07 03:52:35', '$2y$12$scKJoE/Q9x/pfirSQUPxt.Ge3e04ppMPakKAk47q5P6vF9YVQM.x6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:42:59', '2026-01-06 20:42:59'),
	(17, 'ERVAN JANUARKO', '060115532', NULL, NULL, '2026-01-07 03:52:36', '$2y$12$t4seUzRHaNlzft3Ij4oB/epoU.5JKSqyJckveex9CwrkCnjgxoffy', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(18, 'REYNA DWI PRATIWI', '830602737', NULL, NULL, '2026-01-07 03:52:36', '$2y$12$ziNFvTfiuvVeWG7RCA/LqeTei900t5XICPxwBnVyxtIAI17PfNb3W', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(19, 'BUDI MUGIA RASPATI', '060080408', NULL, NULL, '2026-01-07 03:52:37', '$2y$12$qJ2dJ/SshY/c5anqJHr61.hBN7E59Z5T6WuHgKCgVUtKWRIZ5JYVi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(20, 'HENNY SAPTARIA', '060103775', NULL, NULL, '2026-01-07 03:52:37', '$2y$12$hUHhC1W2ms2VEZ6I1a4UuORNJXeal0/oDdp/lqptfPhRI6MCu4hAW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:00', '2026-01-06 20:43:00'),
	(21, 'CHRISTIANUS SETYO PRASTOWO', '060081902', NULL, NULL, '2026-01-07 03:52:38', '$2y$12$7H3TFwLVtGXSn5eXjEaCSe0YNdQKEFoVGIETt92uhIK/oLvs.0gSS', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(22, 'MELIA SINAGA', '830060484', NULL, NULL, '2026-01-07 03:52:39', '$2y$12$wNN6w7OypZSyF4xMD3FPCeyqyBd3tIS5enZYH1B1DuDhfkclegDby', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(23, 'MACHDAR ACHMEDY', '830600996', NULL, NULL, '2026-01-07 03:52:39', '$2y$12$KF3l3Z6ssnULqckMaE/ThOQp8SQC8zPOSO85vMTNBVaXQkXqAKYyC', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(24, 'AISYAH TASRI KHIYANINGRUM', '820480406', NULL, NULL, '2026-01-07 03:52:40', '$2y$12$kxOFoI0TSDeI2xJUUhxzROImGVJfx5eM/HvoIKjzqZlHNSWM7gB3u', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(25, 'YULI HENDRATNO', '060105892', NULL, NULL, '2026-01-07 03:52:41', '$2y$12$23vCGz8QoQ1yc.bTc8Q9y.9MdBmf9az4howX0Mqz1PNpD5X/B7YM2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:01', '2026-01-06 20:43:01'),
	(26, 'THIO RIZKI FAUZI YUDHISTIRA', '830450647', NULL, NULL, '2026-01-07 03:52:41', '$2y$12$9jQwCsmGwmFMxRMlmIlR5.MF8yNEq7ltXfjb/.AoBsQ.pGKcjTu1q', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(27, 'ARIO ANGLING NURVANDITO', '060108933', NULL, NULL, '2026-01-07 03:52:42', '$2y$12$mxifSZ3JohNo6Qu14YD1AuSFBUaeN.CR/wySQs0emua4V1GW8GlZu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(28, 'ADILAH NUR WIDYANI', '813300012', NULL, NULL, '2026-01-07 03:52:43', '$2y$12$tLGM3vVlmIH8BoqDZ3Ir4Oq37XVuo5xKzef3eL7bo4W.NvuYcHUc6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(29, 'RISI NURFAIDAH', '830602754', NULL, NULL, '2026-01-07 03:52:43', '$2y$12$q8afaPe5BfaNZ.jCP6YhPeY7kMFd/lYcN5/g.Y8OwLI6x.9GoTmdi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:02', '2026-01-06 20:43:02'),
	(30, 'VINA YULIA WIDYASTUTI', '813300993', NULL, NULL, '2026-01-07 03:52:44', '$2y$12$vuEctCqa.57Va1iZc3oF0.owEGAzpR11B4zCpC1haAZj6xeF.1lmW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(31, 'PAJARNO', '060100867', NULL, NULL, '2026-01-07 03:52:45', '$2y$12$p3HIGj0gobAut74gvz90KeNkexhpQhuY41OV1Gtu268uTrg4EpZzi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(32, 'RIESKA WIDIANI', '830290765', NULL, NULL, '2026-01-07 03:52:45', '$2y$12$4aXO5lfOMid8qds6kmVx2.apXUDNoCg0NYg5RXO.oaqtZtNggQNbW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(33, 'IRMA AGUSTIN LEONITA', '930102156', NULL, NULL, '2026-01-07 03:52:46', '$2y$12$yIRKB.i.I1Yu2ynY.B4ZEu4UlHOKY0/OoXcT.BXiZ7I9ZhoubgjHS', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:03', '2026-01-06 20:43:03'),
	(34, 'WIJAYATI', '808360312', NULL, NULL, '2026-01-07 03:52:49', '$2y$12$xy6K9SlGPIcu.a9YFBgd7O9xppBLHHHEjVpoMsCdhlg7BvSquB2Za', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(35, 'MOHAMAD ADNAN ABDULLAH', '830601177', NULL, NULL, '2026-01-07 03:52:50', '$2y$12$/zdhP9K8gRKzu5/CKT6SNe.am/xIzjpNjPfhzkQiW4DK5Fsbkd9gy', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(36, 'BRATADI WISESA', '830203120', NULL, NULL, '2026-01-07 03:52:51', '$2y$12$TxGYNuwYGn4K31.j1qSDBup6efKtLgIaEl4ILA8QklFnRb9./kv2K', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(37, 'YULIS RISMAWATI', '060096561', NULL, NULL, '2026-01-07 03:52:51', '$2y$12$D2J4C9rjeDAS7gF2aj5IW.wFRoRO/YFsf.onymHHZGl.oGZBScH/.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(38, 'NUR FITRIYAH', '060098757', NULL, NULL, '2026-01-07 03:52:52', '$2y$12$tX3vEO6OKWh8zzKPe4p3Du63JSdT03l7nOM3/RLGlJOXlO.RHufUq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:04', '2026-01-06 20:43:04'),
	(39, 'ADANG MOCHAMAD SUGIRI', '951550965', NULL, NULL, '2026-01-07 03:52:53', '$2y$10$T93SByOxccULQ5QdrxQs3.F5rY5GRupq/l2e02VWGADQJPYwOREDW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(40, 'MIFTAKHUL ANAS FAKHRIZA', '060106393', NULL, NULL, '2026-01-07 03:52:54', '$2y$12$WoMHu14yzWX/lIAxM3FMc.IZ3G1px3v2.793BC9JqP6mbvaNhIQN2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(41, 'WIDI HADIANSYAH', '060108709', NULL, NULL, '2026-01-07 03:52:54', '$2y$12$2sn5tvS.wxwRgw3uQkyYSuiod2P2m/0tcojO5XAyD/e3RfC/hhCgu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(42, 'RENA AIRIN AGUSNI', '808360353', NULL, NULL, '2026-01-07 03:52:56', '$2y$12$.jL2xV.EMtnDsgZjJ7XSju/yakojShnGnD4WHcjkreBY/xsNfb3tK', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:05', '2026-01-06 20:43:05'),
	(43, 'MUHAMMAD ANWAR SHUBHAN', '810360048', NULL, NULL, '2026-01-07 03:52:59', '$2y$12$xvpEN39ELNkTI0ytspd7suNHGxh5VzgU1koksgyuW6PZCUr/mtHb2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(44, 'DEDEN ADE SAEPULLAH', '060089355', NULL, NULL, '2026-01-07 03:53:02', '$2y$12$5stZLdzhEHZhK8pVuOAR3u7yaGsurj2KgqYZIHjuofXVTa4v.7hZq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(45, 'YUSTINA TRISEPTIANI RAHAYU', '060105659', NULL, NULL, '2026-01-07 03:53:03', '$2y$12$.waiWB1fgKiWfmzeGG2HaexjTlKJa2AQGYTfBViBw8nvXYYYZq3Ou', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(46, 'ARIS KRISNHA WIBAWA', '060112143', NULL, NULL, '2026-01-07 03:53:04', '$2y$12$g..EdSSSylEZehMAt5qmjeTb7bdLgSDE80HUyhxoESxs1j.SNlxlK', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(47, 'FRISKA ARDIANTI PUSPITASARI', '813300239', NULL, NULL, '2026-01-07 03:53:05', '$2y$12$8iRjusvW6.9pEejbgilzUeoCr9pqRbL1JlZsa6qjHn9SB22dtJGO.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:06', '2026-01-06 20:43:06'),
	(48, 'DEVITA PRADIANA KURNIA PUTRI', '820480331', NULL, NULL, '2026-01-07 03:53:06', '$2y$12$VsUgHl0jRFcNcUB8B.tStetT1M6R3Qz810m8XEZkC4LwTR/qujT8S', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(49, 'RHADYT BARA ICHFADHILLAH', '830602739', NULL, NULL, '2026-01-07 03:53:07', '$2y$12$pe./1PAiJ5WN3qdYMtqYJua5GrNA8uN84tR1leYDNw3Z5IGcQZF9W', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(50, 'MELLISA SEPANI EKATRIN', '917323204', NULL, NULL, '2026-01-07 03:53:08', '$2y$12$rpkXyaDXZyyI4cYdhSV6fOwZJGU98Qn.VNJ5EyiBXQlCMRN6Sq/XG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(51, 'LUKMAN AHMADISASTRA', '060110663', NULL, NULL, '2026-01-07 03:53:08', '$2y$12$9lkiDZUXWuodqn6JSEhGReMF0aUSpS5S0QSbDP6yGg8uO0gjUQiNG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:07', '2026-01-06 20:43:07'),
	(52, 'FADHIL DWI YULIAN', '817930614', NULL, NULL, '2026-01-07 03:53:09', '$2y$12$.ncqSXmQWeF159FbznqNgOBU/Krdg5nuvh25yeRbqB9Th3ZVJKNg2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(53, 'RENI SAFITRI', '830602733', NULL, NULL, '2026-01-07 03:53:10', '$2y$12$kUVQSEu6SWHoyDnklSrwIucKQPWLfBCj7btW.037bY7MwN5YYvNz2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(54, 'JUFRI HANDOKO SIJABAT', '817930733', NULL, NULL, '2026-01-07 03:53:10', '$2y$12$2KBuvZKfapn/RpW.U/yI0ukCmnVv.i0U.wasemg/Et9ZqqDOzSfny', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(55, 'DENI BASAR WIDJAYA', '060107310', NULL, NULL, '2026-01-07 03:53:11', '$2y$12$9Mzd9EbKNj9CWvRzK9Qq0.LF4e9kkJQFPm2ES/CSstwecUcentFWm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:08', '2026-01-06 20:43:08'),
	(56, 'ALIF ADIYUDHA PRATAMA', '958635280', NULL, NULL, '2026-01-07 03:53:11', '$2y$12$v79UJ3XqPv1S/wl5l2PEweWGIdF0Wnt18TZwRR5YAxxAXk54ChqFi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(57, 'REZA HERDIANA', '815100521', NULL, NULL, '2026-01-07 03:53:12', '$2y$12$Ks/cFx/bKlxu1y.4TneZcucXSNj1C8N96FnGxAcVIytFRoUTZGkAi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(58, 'DEDI KURNIAWAN', '060087002', NULL, NULL, '2026-01-07 03:53:15', '$2y$12$dVuihw9f0asytxlRbRe.6.mXwahLKtoHqwRnVItrNbITm8OhLG1CC', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(59, 'FAUZIAH RAHMADITA NINGRUM', '908203808', NULL, NULL, '2026-01-07 03:53:16', '$2y$12$f/b6fcvO1v.lfa8wD/Nn2uyFlp84tPJXf0vL0p6JHydOUazp8WdSy', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(60, 'ANNISA ARIFKA SARI', '827040710', NULL, NULL, '2026-01-07 03:53:18', '$2y$12$dyhVtSEm59oEB4tUSTAhru5jgPo/BBgBGONaherr4PfZ7fwkfnHHS', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:09', '2026-01-06 20:43:09'),
	(61, 'WARDANI RAHENDRA', '060100660', NULL, NULL, '2026-01-07 03:53:23', '$2y$12$CSzHkTSUrEpQz5jKkPmCu.WmO0R3VcHFYbERsOXzKkzuvogm/JuCG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(62, 'AEP SAEPULOH', '060093321', NULL, NULL, '2026-01-07 03:53:31', '$2y$12$fgk3K85LoX2q19TE1VamKOBFZ79nrLXFMm1SoYoRUApvPmOUMwVMq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(63, 'IWAN SETIADY', '060087364', NULL, NULL, '2026-01-07 03:53:33', '$2y$12$aQO3p0ImQJjrFcuHli2Rrut5nIUHqs.HXWoRnfEN6.eqKngDXEhf.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(64, 'ERWIN SIAHAAN', '060099976', NULL, NULL, '2026-01-07 03:53:34', '$2y$12$idsoyymkT4SGwPJfN7pZ.O9Sm0k0jMKLxOnhuFtypun/.fCmNxoHW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:10', '2026-01-06 20:43:10'),
	(65, 'RENNY TIURMA ELIDA', '060103505', NULL, NULL, '2026-01-07 03:53:35', '$2y$12$ACkGUA0cwZJi.qe0KFheq.v53vnPl2rXPYHcq3KG/Q73uTezN2Ywu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', 'lHzdtM8uoWWnJCwhoeIl5E6yUv0xJzl3n1wxKdG4snA1G5ucjuPXDgWhvbnq', '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(66, 'ERWIN HIDAYANTO', '060078537', NULL, NULL, '2026-01-07 03:53:36', '$2y$12$FyPABL8Nb/yNCQeWDaellOzB9ermFBZLMGCaFRqkkHBSvQ1ZEeKg6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(67, 'SOZARO ANDREAS FAMILYNARD MARUHAWA', '060083663', NULL, NULL, '2026-01-07 03:53:36', '$2y$12$ntgPoSAdGZAI2tHBrTnO4OMUunKnxjDLEedK.3Zxvm5oVFPfSE.wK', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(68, 'IIP TOIP', '060091011', NULL, NULL, '2026-01-07 03:53:37', '$2y$12$W2n08QPOXQbs1bRMFAN6Yew5Qq7RT2KIM1jHM.Qjy/osPBdxwOpKu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:11', '2026-01-06 20:43:11'),
	(69, 'FATHONATIN NADZIRA PRAJA', '958634930', NULL, NULL, '2026-01-07 03:53:37', '$2y$12$1BtaUoXYM4dCBy4kk4hCRO1hYfx63zEdzX4iRiH/WNinXiX.Tkaqi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(70, 'RISMA UMARSUDI', '060093388', NULL, NULL, '2026-01-07 03:53:38', '$2y$12$K.O8kH0wsu342ju3GLU/A.W.T1OZ3eFztxvrNksohlFKvOam56dvu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(71, 'PANJI SANDHA HERYANTO', '060115226', NULL, NULL, '2026-01-07 03:53:39', '$2y$12$bHxzOKo4.RwV0f3j4wz6UesuNM9Cri9m77QpDkllIZKNcIb6y2YmC', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(72, 'INTAN WULANDARI', '958635369', NULL, NULL, '2026-01-07 03:53:39', '$2y$12$8ECyVLypebgAIWhof1zC8OsAbtuLWcTfleMfgKTZNCsmPWVgIY0TO', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(73, 'ASTRI RAFIKA AL HUSNA', '815100707', NULL, NULL, '2026-01-07 03:53:40', '$2y$12$zOsmah2LZl0RfbQLhSUJj.xi1AXc9.IRd7JF/qNA6Q0J.vKnqbYOm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:12', '2026-01-06 20:43:12'),
	(74, 'ARFI RUMAISHA SHAFIRA', '817931513', NULL, NULL, '2026-01-07 03:53:40', '$2y$12$3tPSa.Sd0nKe42BYFyDP8eGyRy22k6Copg9FUHM3PX2GOgNY3GgGO', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(75, 'KANIA RAHMASARI', '817931543', NULL, NULL, '2026-01-07 03:53:41', '$2y$12$mjBEVK4MNQgVwv8RvG/0XuUwNFZp52t1Nb3Z3lBHwW.YjYkwBl1zC', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(76, 'SCIFO LUANSA', '817932257', NULL, NULL, '2026-01-07 03:53:41', '$2y$12$aX5cfv9BzetUJVDmNhhtAuj4QfogXQ80X6Be9cCa7Abp1Waf6urJa', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(77, 'EVANDO ON TAMBUNAN', '958631882', NULL, NULL, '2026-01-07 03:53:42', '$2y$12$gmSQrj.HoHnMgJzZCAF.9uPXe/ehg65AerRzpm2MOeHZslEfLttWe', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:13', '2026-01-06 20:43:13'),
	(78, 'MEINDRY MARINTAN REVIANTY PANDJAITAN', '060081666', NULL, NULL, '2026-01-07 03:53:43', '$2y$12$gttOMY0y3zu01o/XdSgQXOLUkC2Aa7zSDFVInIqfnOCIhq6O1jr3e', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(79, 'UJANG WIJIONO EKA MEI', '060095498', NULL, NULL, '2026-01-07 03:53:43', '$2y$10$8phFxUjAU2i7QYIaWvvnfOo4lE9yuKtOD2aAsPE9O3Yuif2Tef28y', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', 'n5QAKP05roLY5YYBxiWPoyjJH9EHUn34OmJz2eINaH2d4OX139gDjRsjpmea', '2026-01-06 20:43:14', '2026-02-04 03:22:58'),
	(80, 'FAISAL NURGHANI', '817931061', NULL, NULL, '2026-01-07 03:53:45', '$2y$12$e4T9ezrnznhCCmBlmZQKmOM.oEJ9aRJuCSZ9OgjmUR5NUSjbn16V2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(81, 'CAHYO KUSUMO', '910222613', 'cahyo.kusumo@pajak.go.id', NULL, '2026-01-07 03:51:31', '$2y$12$EYV83UonVtlDnZPcqDo2MeffoOZGb8B3UIzpt6MOPt0J3eL5C3qFG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', 'M1lFy40zpr7mecH9CqQQeU4Gxy3qfQJzilat6vpKoYTPLlhCPaGIArPf2zQu', '2026-01-06 20:43:14', '2026-01-06 20:43:14'),
	(83, 'KIKI WALUYA', '060081000', NULL, NULL, '2026-01-07 03:53:46', '$2y$12$3N2bQjE.WEvuLEBzjqWIZOyz0Qo8Hteb.SVRQIgo54zgfq33DF/XG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(84, 'CAHYO WIBOWO PALUPI', '060106173', NULL, NULL, '2026-01-07 03:53:47', '$2y$12$cmJeB7uOKpsZluTEb/FjNuQOj8B5oMKLYBw/YXmvRcLcxrLVohlIq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(85, 'RIO MUCHLIS', '060112290', NULL, NULL, '2026-01-07 03:53:58', '$2y$12$3B.B3eqYoHa5EJbnL0t.vez.5q8/oc1tirT8M1ctxsTHvILQkSyuq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(86, 'FITRI INDRIANI', '910222527', NULL, NULL, '2026-01-07 03:54:00', '$2y$12$sDGPO4nwCea9kUrcyJMS..cpRBx8bulG8i7IOKTBhyV4.kqrSwyNC', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:15', '2026-01-06 20:43:15'),
	(87, 'KARIMATUL `ULYA', '817931635', NULL, NULL, '2026-01-07 03:54:01', '$2y$12$xvrOsx8PsH7fMeXCdiv3ouSn7PlvmAtf/WTzeOjZR8moXfFA9b0tK', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(88, 'STEFANI LAKSITA NORMALADEWI', '958633367', NULL, NULL, '2026-01-07 03:54:02', '$2y$12$9J3ppIaOb99DtTma5hlmyeQbNI9b.BnvaWhV0N77RC5p1XmxYoZg.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(89, 'IRVAN ALQORNI', '958633825', NULL, NULL, '2026-01-07 03:54:02', '$2y$12$/JIdxud.GUqIXqQIV/ah8utRpVnUaQ.R8lKOOWiQvUhjTjP9xV2vS', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(90, 'DIKY PRIHANTONO', '060084984', NULL, NULL, '2026-01-07 03:54:03', '$2y$12$hRAIK4XSquWOuHrbfot1JOnNiTLUk8LaK4wjWSbo8nrYwm8hAKmsK', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:16', '2026-01-06 20:43:16'),
	(91, 'MOHAMAD ANDRY SURYONDARU', '060085353', NULL, NULL, '2026-01-07 03:54:03', '$2y$12$qST0DutBBM.J5zrdCwjnwOr8M2Ppkam5P3YXSsceZMxkOWQ38a9qO', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(92, 'SOEKMAJA', '060085605', NULL, NULL, '2026-01-07 03:54:04', '$2y$12$WjKDLzu0DpRSniyPLuU7weSx1p6co.4pZatu4oWuADdpxTzNLq9AO', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(93, 'DWI HERNOWO', '060091674', NULL, NULL, '2026-01-07 03:54:05', '$2y$12$cnjtOq6oLF71.gvxCKtKseb9DtalqoeW.ffC9tB5hRHJEr1PMRb8i', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(94, 'LENY DJUHAENI', '060094828', NULL, NULL, '2026-01-07 03:54:05', '$2y$12$5hABgNtTIgjx0.S4Kb84teKw0YCkd//yp7U5v/onahHeKBqpgf58m', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(95, 'BAYU ARGO', '060106234', NULL, NULL, '2026-01-07 03:54:06', '$2y$12$4bAjqkgQY.rjpeIL/grrhu2MtoJCxxBNN1jb0154obY1X5PuLaJPW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:17', '2026-01-06 20:43:17'),
	(96, 'UTAMY ARAFAH', '813300991', NULL, NULL, '2026-01-07 03:54:08', '$2y$12$VBiNhhLnM6KmqWq8vjUabe17J5uaoVmdVridthE3dKu6OSrWkiXyi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(97, 'ARBI DWI KURNIAWAN', '817930502', NULL, NULL, '2026-01-07 03:54:08', '$2y$12$gS4LCtIvGXc2a.M2.yTHk.mUfwFKoi9hGJPRk0F/ejR7F75VSbd/.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(98, 'HERLIANA NUR LAILY', '917318035', NULL, NULL, '2026-01-07 03:54:09', '$2y$12$.S.z.cbIrvEe7FL.SRolrOs1YKe5V7MYNc6wqaiBM3Y9eGLLW2IYm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(99, 'ALLAFTA NUZULA ZAHRA', '958635448', NULL, NULL, '2026-01-07 03:54:10', '$2y$12$GkTnurCcOmUAsrZw/nwGFuDgjhf9S/aKPAohpfncGvzzM4KwDQFOm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:18', '2026-01-06 20:43:18'),
	(100, 'CHRISTOFER', '815100020', NULL, NULL, '2026-01-07 03:54:10', '$2y$12$gXroV4gSTVOPpzSSUPwzZ.OdIviQ1fctftQjug3qCDdfSSz31q/mu', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(101, 'RD OKI TRESNA RAHMAWAN', '815101015', NULL, NULL, '2026-01-07 03:54:11', '$2y$12$Dtm0dMyD7w04IssPhIi.xON6ytiD7zZ6I0FG6CTiu31DajkvXCg6u', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(102, 'YESICA NATALIA SINAMBELA', '958633556', NULL, NULL, '2026-01-07 03:54:11', '$2y$12$uYM0jZfn/qIbGql9AEF5x.9oidPeWoMmH6yvRXl3sE4Pitwmj4ZFq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(103, 'BIMO RAMADHANI JATMIKO', '817931515', NULL, NULL, '2026-01-07 03:54:13', '$2y$12$bTEr2QhM7PXKSmI/VtE5LexapRwWDSpIkkZXD2BIFwd8nusJmPjxm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:19', '2026-01-06 20:43:19'),
	(104, 'FATHIMAH NAURATUL FIRDAUSI', '817931529', NULL, NULL, '2026-01-07 03:54:20', '$2y$12$011pN6zu4vBk9QedL3L.vez6LLnQw6pPEKnL5UhJAJk71jcOJVjSi', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(105, 'APRILIA DEWI NUR DIANTI', '958631413', NULL, NULL, '2026-01-07 03:54:20', '$2y$12$Ky5KkzQ/gd3ITNHn.OGZduIZREybTRKvbWnahqvO1hEhyQNJ3oCz2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(106, 'ISNANINGSIH', '958632282', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$LeYtuQy26dFriX4WNFfjwe7rYdCgiqsltld16.0XlPNmSK3YXkPTm', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(107, 'REGITA DUMARIA HUTAURUK', '958633064', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$XHxVHYmPvt751Dwk7sJft.rOj0i.nmL764E9vMHI7Ge8eNa1Q9oYq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(108, 'AZALIA TASYA NARISWARI', '958634709', NULL, NULL, '2026-01-07 03:54:19', '$2y$12$f3EzJhwmlUudZNatMaqbuOafjauHQ81ucQCEDPrzElK46VygmKk1a', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:20', '2026-01-06 20:43:20'),
	(109, 'ROJAKUM', '060077850', NULL, NULL, '2026-01-07 03:54:18', '$2y$12$W/b25cBwETuwSu8lWr6c.OUnjF5UFPasGzx/KkLdLV4Pj6AtNUNli', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(110, 'DANURI', '060081430', NULL, NULL, '2026-01-07 03:54:18', '$2y$12$tWnpu32933ogmqhUUO6IJuFcpxb2CdZJprK9F1T8LKc00orpvpvfy', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(111, 'SUPENDI NEMAN', '060101259', NULL, NULL, '2026-01-07 03:54:17', '$2y$12$Q8HYkYrbdWRV3WiOtDAiTuuXiIQm5D3Iant77A2vzhXVYOEma4csW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(112, 'GUNAWAN FEBRIANTO ANTHUR', '060088976', NULL, NULL, '2026-01-07 03:54:17', '$2y$12$ML36Q3oH4ZCzIJao9oTGXuxietcArSvdKMz1HibLVdkCB.KR9AZRO', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:21', '2026-01-06 20:43:21'),
	(113, 'PROEMNA LITA DINAMIYATI', '060100249', NULL, NULL, '2026-01-07 03:54:16', '$2y$12$7w2CYMQ2UfyC7NvDUUqpX.noSnCykAoiPfCCnU8PjBM.gbu.eOUk6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(114, 'TINO ARUS WAHYU JATI', '060110649', NULL, NULL, '2026-01-07 03:54:34', '$2y$12$OEce1XQJH4r4wtiJ4cHPs.quVtP6vGUAp56PLlqRB07ZZycvaEgPe', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(115, 'ALTORANA', '820340542', NULL, NULL, '2026-01-07 03:54:39', '$2y$12$OjcctpSU0EjmZDxygV.C6u3Y.8CyRzO1w7D833mow1gp9XFRirp6C', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(116, 'INTANNISA RAMADHINI', '860014263', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$2wdneAG3o0z40vMoaD.j9eq84cHgr3pLhjuQ9fbaFtHbvoZXuh73C', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:22', '2026-01-06 20:43:22'),
	(117, 'DEDY TARYOKO', '060116673', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$UVn8nRLCj28Chtoa2XOcQutcwJUQAdx7vImXmJEPGC6R942/xN/pG', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(118, 'HENRIZAL AMRAN', '060079621', NULL, NULL, '2026-01-07 03:54:38', '$2y$12$rknryW3OTvgBeIMRL5gW0OZFDtiJItAE8KR8ciJ8XE/uWqEHkoiBW', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(119, 'AHMAD AFRIZAL', '813300028', NULL, NULL, '2026-01-07 03:54:37', '$2y$12$11K6XNU8Or14./hIpqym8.fASEtLIA3XNjg56Bq2oVO4KRpqg80x6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(120, 'DANI ANWAR IBRAHIM', '813300124', NULL, NULL, '2026-01-07 03:54:37', '$2y$12$UM1n3ZCVkciNUJxBZWz46.en603olBo9ZWrFqRV3zi68R4RDFyTxq', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:23', '2026-01-06 20:43:23'),
	(121, 'WITARSA JAKA PERMANA', '830203672', NULL, NULL, '2026-01-07 03:54:36', '$2y$12$/HpptcFX8EaUk34Xqoxf.OK08dZwRS5ZxLmcpcqVdMFAQX1qPW94.', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(122, 'PEVI IDA NURLAELASARI', '930102149', NULL, NULL, '2026-01-07 03:54:36', '$2y$12$1T.eKGeDYtfmVasU9acaaOJgxnu5x.ygNLckvc6Vml/GXw81k5sCe', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(123, 'FAZA HASYIM ASYARIE', '958636039', NULL, NULL, '2026-01-07 03:54:35', '$2y$12$odUn9En.o9sfYwwTo2akQO5z6QuYeByqeWfdT.0jYsbTFmqmp.Tg2', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24'),
	(124, 'DIAN SEPTIANINGSIH', '958635323', NULL, NULL, '2026-01-07 03:54:16', '$2y$12$DzhNr9k4F0vPXZg/RhZXre4mP2EsFESCAhD/FuSDQzOP6Zcd8tcb6', NULL, 'default', NULL, 'slate', 1, 'default', 'clean', 'comfortable', 'default', 'normal', NULL, '2026-01-06 20:43:24', '2026-01-06 20:43:24');

-- membuang struktur untuk table kaido_kit.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` year DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` tinyint unsigned NOT NULL DEFAULT '4',
  `fuel_type` enum('bensin','solar','listrik') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bensin',
  `ownership` enum('dinas','sewa') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dinas',
  `condition` enum('excellent','good','fair','poor') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `status` enum('available','in_use','maintenance','retired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'available',
  `last_service_date` date DEFAULT NULL,
  `tax_expiry_date` date DEFAULT NULL,
  `inspection_expiry_date` date DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicles_plate_number_unique` (`plate_number`),
  KEY `vehicles_status_index` (`status`),
  KEY `vehicles_plate_number_index` (`plate_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.vehicles: ~5 rows (lebih kurang)
DELETE FROM `vehicles`;
INSERT INTO `vehicles` (`id`, `plate_number`, `brand`, `model`, `year`, `color`, `capacity`, `fuel_type`, `ownership`, `condition`, `status`, `last_service_date`, `tax_expiry_date`, `inspection_expiry_date`, `image`, `notes`, `created_at`, `updated_at`) VALUES
	(1, 'D 1027 T', 'Toyota', 'Grand New Kijang Innova', '2015', 'Putih', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:33:25', '2026-01-06 20:33:25'),
	(2, 'D 1123 T', 'Mitsubishi', 'Xpander (Matic)', '2019', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:34:21', '2026-01-06 20:34:21'),
	(3, 'D 1121 T', 'Mitsubishi', 'Xpander (Matic - Suki)', '2019', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:35:12', '2026-01-06 20:35:12'),
	(4, 'D 1127 T', 'Suzuki', 'Ertiga (Was 1)', '2020', 'Hitam', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:35:49', '2026-01-06 20:35:49'),
	(5, 'D 1692 D', 'Toyota', 'New Kijang Innova (Was 5 - Manual)', '2011', 'Silver', 4, 'bensin', 'dinas', 'good', 'available', NULL, NULL, NULL, NULL, NULL, '2026-01-06 20:36:55', '2026-01-06 20:36:55');

-- membuang struktur untuk table kaido_kit.vehicle_bookings
CREATE TABLE IF NOT EXISTS `vehicle_bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `booking_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `vehicle_id` bigint unsigned NOT NULL,
  `driver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passengers` json DEFAULT NULL,
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `departure_time` time DEFAULT NULL,
  `status` enum('approved','in_use','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'approved',
  `start_odometer` int unsigned DEFAULT NULL,
  `end_odometer` int unsigned DEFAULT NULL,
  `fuel_level` enum('empty','quarter','half','three_quarter','full') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `return_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `return_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `returned_at` timestamp NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancellation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_bookings_booking_number_unique` (`booking_number`),
  KEY `vehicle_bookings_user_id_foreign` (`user_id`),
  KEY `vehicle_bookings_vehicle_id_start_date_end_date_status_index` (`vehicle_id`,`start_date`,`end_date`,`status`),
  KEY `vehicle_bookings_status_index` (`status`),
  KEY `vehicle_bookings_user_id_index` (`user_id`),
  KEY `vehicle_bookings_vehicle_id_index` (`vehicle_id`),
  KEY `vehicle_bookings_start_date_index` (`start_date`),
  KEY `vehicle_bookings_end_date_index` (`end_date`),
  KEY `vehicle_bookings_status_user_id_index` (`status`,`user_id`),
  KEY `vehicle_bookings_status_end_date_returned_at_index` (`status`,`end_date`,`returned_at`),
  KEY `vehicle_bookings_vehicle_id_status_start_date_end_date_index` (`vehicle_id`,`status`,`start_date`,`end_date`),
  KEY `vehicle_bookings_dates_index` (`start_date`,`end_date`),
  CONSTRAINT `vehicle_bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vehicle_bookings_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Membuang data untuk tabel kaido_kit.vehicle_bookings: ~0 rows (lebih kurang)
DELETE FROM `vehicle_bookings`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
