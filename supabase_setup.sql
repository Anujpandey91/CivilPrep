-- CivilPrep: one JSON document per authenticated user.
-- Run this entire script in Supabase Dashboard > SQL Editor > New query.

create table if not exists public.civilprep_user_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.civilprep_user_data enable row level security;

-- A signed-in user can read only their own record.
create policy "Users can read their own CivilPrep data"
on public.civilprep_user_data
for select
 to authenticated
using (auth.uid() = user_id);

-- A signed-in user can create only a record belonging to themselves.
create policy "Users can insert their own CivilPrep data"
on public.civilprep_user_data
for insert
 to authenticated
with check (auth.uid() = user_id);

-- A signed-in user can update only their own record.
create policy "Users can update their own CivilPrep data"
on public.civilprep_user_data
for update
 to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- No anonymous access policy is created. Do not disable RLS.
