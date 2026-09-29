# Keuangan Sinar Abadi Baru
Web app statis (tanpa build) + Supabase (database) + jsPDF (laporan).

## Setup
1. **Supabase**: buat project → SQL Editor → jalankan seluruh isi `schema.sql`.
2. Edit `config.js` dengan Project URL dan **anon key** project Anda (Settings → API).
3. Push ke GitHub: `git init && git add . && git commit -m "init" && git remote add origin <repo> && git push -u origin main`
4. **Vercel**: Add New Project → import repo → Framework "Other", tanpa build command → Deploy.

## Login
Aplikasi ini pakai satu layar login dengan username dan password tetap (diatur langsung
di dalam `index.html`, cari variabel `AUTH_USER` dan `AUTH_PASS`). Login berlaku per
perangkat/peramban (disimpan di localStorage) sampai menekan "Keluar".

Untuk mengganti username/password, ubah nilai `AUTH_USER` dan `AUTH_PASS` di `index.html`,
lalu push ulang ke GitHub — Vercel akan otomatis deploy ulang.

## Catatan keamanan (penting)
Karena ini bukan akun per-pengguna, ada dua hal yang perlu Anda sadari:
- Username dan password ada di dalam kode halaman. Siapa pun yang melihat kode
  sumber halaman (klik kanan → View Source) bisa membacanya. Ini cukup untuk
  menahan orang iseng, tapi bukan keamanan tingkat bank.
- Karena tidak ada login Supabase, akses ke database dibuka untuk kunci "anon"
  publik (lihat `schema.sql`). Kunci ini juga terlihat di `config.js`/kode halaman.
  Artinya siapa pun yang menyalin kunci itu bisa membaca/mengubah data langsung
  lewat Supabase, tanpa melalui layar login sama sekali.

Untuk penggunaan internal tim kecil ini biasanya cukup aman selama link dan kode
tidak disebarluaskan. Kalau ke depannya perlu lebih aman (misalnya beberapa staf
dengan hak akses berbeda), sebaiknya kembali memakai Supabase Auth per akun.

## Menu Saldo & laporan tahunan
- Menu **Saldo**: isi *saldo awal kas usaha* sekali di awal. Saldo awal, pindahan, dan
  dipindahkan per pekan/bulan/tahun dihitung otomatis; isi kolomnya hanya untuk
  mengganti angka.
- Laporan tersedia pekanan, bulanan, tahunan, dan rentang tanggal.
