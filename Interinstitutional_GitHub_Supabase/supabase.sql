-- Interinstitutional Dota 2: Supabase database
create table if not exists public.teams (
  id integer primary key,
  name text not null,
  logo text
);

create table if not exists public.matches (
  id text primary key,
  a integer,
  b integer,
  sa integer not null default 0,
  sb integer not null default 0
);

create table if not exists public.admins (
  id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

insert into public.teams (id,name,logo) values
(0,'Команда 1',null),(1,'Команда 2',null),(2,'Команда 3',null),(3,'Команда 4',null),
(4,'Команда 5',null),(5,'Команда 6',null),(6,'Команда 7',null),(7,'Команда 8',null)
on conflict (id) do nothing;

insert into public.matches (id,a,b) values
('U1',0,1),('U2',2,3),('U3',4,5),('U4',6,7),
('U5',null,null),('U6',null,null),('UF',null,null),
('L1',null,null),('L2',null,null),('L3',null,null),('L4',null,null),
('L5',null,null),('LF',null,null),('GF',null,null)
on conflict (id) do nothing;

alter table public.teams enable row level security;
alter table public.matches enable row level security;
alter table public.admins enable row level security;

drop policy if exists "Public can read teams" on public.teams;
create policy "Public can read teams" on public.teams for select using (true);

drop policy if exists "Public can read matches" on public.matches;
create policy "Public can read matches" on public.matches for select using (true);

drop policy if exists "Admins can update teams" on public.teams;
create policy "Admins can update teams" on public.teams for update to authenticated using (exists (select 1 from public.admins where admins.id = auth.uid())) with check (exists (select 1 from public.admins where admins.id = auth.uid()));

drop policy if exists "Admins can update matches" on public.matches;
create policy "Admins can update matches" on public.matches for update to authenticated using (exists (select 1 from public.admins where admins.id = auth.uid())) with check (exists (select 1 from public.admins where admins.id = auth.uid()));

-- After creating your ONLY admin user in Authentication → Users, replace the UUID below and run: 
-- insert into public.admins (id) values ('YOUR-AUTH-USER-UUID');

-- No INSERT/DELETE policies are intentionally created for teams/matches.
-- Public users can read data, but only users listed in admins can update it.
