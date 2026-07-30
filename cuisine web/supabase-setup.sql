-- ============================================================
-- Massif Cuisines — Supabase setup
-- Run this once in your Supabase project's SQL Editor
-- (Project → SQL Editor → New query → paste → Run)
-- ============================================================

-- 1. Table storing every gallery photo shown on the public site
create table if not exists gallery_items (
  id uuid primary key default gen_random_uuid(),
  title text,
  category text not null check (category in (
    'cuisines',
    'portes-entree',
    'portes-chambres',
    'armoires',
    'dressings',
    'bureaux',
    'salle-de-bain'
  )),
  image_url text not null,
  sort_order int default 0,
  created_at timestamptz default now()
);

alter table gallery_items enable row level security;

-- Anyone (including the public website) can read the gallery
create policy "Public read access on gallery_items"
  on gallery_items for select
  using (true);

-- The admin page writes with the same public (anon) key, since it's
-- gated only by the PIN screen in admin.html, not real Supabase auth.
-- That means these policies allow ANYONE with your project URL + anon
-- key to write directly to this table via the API, bypassing the PIN.
-- Fine for an internal tool with a low-stakes table like this one —
-- just don't put anything sensitive in it. Ask if you'd rather switch
-- to real Supabase Auth later for a proper lock.
create policy "Public insert access on gallery_items"
  on gallery_items for insert
  with check (true);

create policy "Public update access on gallery_items"
  on gallery_items for update
  using (true);

create policy "Public delete access on gallery_items"
  on gallery_items for delete
  using (true);


-- 2. Storage bucket that holds the actual uploaded photo files
insert into storage.buckets (id, name, public)
values ('gallery', 'gallery', true)
on conflict (id) do nothing;

create policy "Public read access on gallery bucket"
  on storage.objects for select
  using (bucket_id = 'gallery');

create policy "Public upload access on gallery bucket"
  on storage.objects for insert
  with check (bucket_id = 'gallery');

create policy "Public delete access on gallery bucket"
  on storage.objects for delete
  using (bucket_id = 'gallery');
