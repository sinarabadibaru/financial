create table public.transactions (
  id uuid primary key default gen_random_uuid(),
  date date not null default current_date,
  type text not null check (type in ('in','out')),
  category text not null,
  description text,
  amount numeric(14,0) not null check (amount > 0),
  user_id uuid references auth.users default auth.uid(),
  created_at timestamptz default now()
);
create index on public.transactions (date);
alter table public.transactions enable row level security;
create policy "staff akses penuh" on public.transactions
  for all to authenticated using (true) with check (true);

create or replace function public.saldo_sebelum(d date)
returns numeric language sql stable as $$
  select coalesce(sum(case when type='in' then amount else -amount end),0)
  from public.transactions where date < d
$$;
