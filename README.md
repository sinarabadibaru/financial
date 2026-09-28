# Keuangan Sinar Abadi Baru
Web app statis (tanpa build) + Supabase (login & database) + jsPDF (laporan).

## Setup
1. **Supabase**: buat project → SQL Editor → jalankan isi `schema.sql`.
2. **Auth → Providers**: aktifkan *Email*. Untuk GitHub: buat OAuth App di GitHub
   (Settings → Developer settings), Callback URL = `https://<project-ref>.supabase.co/auth/v1/callback`,
   lalu tempel Client ID/Secret di Supabase → Providers → GitHub.
3. **Auth → URL Configuration**: isi *Site URL* dengan domain Vercel Anda (dan tambahkan ke Redirect URLs).
4. Edit `config.js` dengan Project URL dan anon key (Settings → API).
5. Push ke GitHub: `git init && git add . && git commit -m "init" && git remote add origin <repo> && git push -u origin main`
6. **Vercel**: Add New Project → import repo → Framework "Other", tanpa build command → Deploy.

## Catatan keamanan
Semua user yang login bisa melihat & mengubah data (data bersama satu usaha). Setelah akun tim dibuat,
matikan pendaftaran di Supabase (Auth → Sign In / Providers → nonaktifkan "Allow new users to sign up")
agar orang luar tidak bisa daftar.
