-- NexFit — Migration initiale
-- Sera étendue au jalon 2 (schéma complet + RLS + seed)

-- Table profiles : liée à auth.users Supabase
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null default 'user' check (role in ('user', 'admin')),
  display_name text,
  avatar_path text,
  locale text not null default 'fr',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- RLS : chaque utilisateur ne voit que son propre profil
alter table public.profiles enable row level security;

create policy "Users can view own profile"
  on public.profiles for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on public.profiles for update
  using (auth.uid() = id);

create policy "Users can insert own profile"
  on public.profiles for insert
  with check (auth.uid() = id);
