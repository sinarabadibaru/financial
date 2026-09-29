-- Jalankan seluruh isi file ini sekali di Supabase SQL Editor (Project > SQL Editor > New query).

create table public.transactions (
  id uuid primary key default gen_random_uuid(),
  date date not null default current_date,
  type text not null check (type in ('in','out')),
  category text not null,
  description text,
  amount numeric(14,0) not null check (amount > 0),
  created_at timestamptz default now()
);
create index on public.transactions (date);

create table public.app_settings (
  id int primary key default 1 check (id = 1),
  saldo_awal numeric(14,0) not null default 0
);
insert into public.app_settings (id) values (1);

create table public.saldo_periode (
  id uuid primary key default gen_random_uuid(),
  tipe text not null check (tipe in ('week','month','year')),
  mulai date not null,
  saldo_awal numeric(14,0),
  saldo_pindahan numeric(14,0),
  saldo_dipindahkan numeric(14,0),
  unique (tipe, mulai)
);

create or replace function public.saldo_sebelum(d date)
returns numeric language sql stable as $$
  select coalesce((select saldo_awal from public.app_settings where id=1),0)
       + coalesce(sum(case when type='in' then amount else -amount end),0)
  from public.transactions where date < d
$$;

-- Aplikasi ini memakai satu layar login sederhana (username & password tetap di
-- dalam kode), bukan akun per-pengguna Supabase. Karena itu semua akses ke
-- database di sini memakai kunci "anon" publik, dan tabel dibuka untuk kunci
-- tersebut. Lihat catatan keamanan di README sebelum memakainya untuk data
-- yang sangat sensitif.
alter table public.transactions enable row level security;
alter table public.app_settings enable row level security;
alter table public.saldo_periode enable row level security;

create policy "akses penuh" on public.transactions for all to anon, authenticated using (true) with check (true);
create policy "akses penuh" on public.app_settings for all to anon, authenticated using (true) with check (true);
create policy "akses penuh" on public.saldo_periode for all to anon, authenticated using (true) with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.transactions, public.app_settings, public.saldo_periode to anon, authenticated;
