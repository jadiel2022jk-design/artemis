create extension if not exists pgcrypto;

create table clients (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  pass_hash text not null,
  name text not null,
  plan text not null default 'Estándar',
  exp bigint not null,
  off boolean not null default false,
  gmail text,
  w_start bigint not null default 0,
  w_n int not null default 0,
  created bigint not null default (extract(epoch from now()) * 1000)::bigint
);
create unique index clients_gmail_uq on clients (lower(gmail)) where gmail is not null;

create table profiles (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references clients(id) on delete cascade,
  n text not null,
  a int not null default 0,
  c int not null default 0,
  p text not null default '',
  off boolean not null default false,
  created bigint not null default (extract(epoch from now()) * 1000)::bigint
);
create index on profiles (client_id);

create table projects (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id) on delete cascade,
  name text not null,
  ins text not null default ''
);
create index on projects (profile_id);

create table chats (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references profiles(id) on delete cascade,
  project_id uuid references projects(id) on delete set null,
  title text not null,
  ts bigint not null
);
create index on chats (profile_id, ts desc);

create table messages (
  id bigserial primary key,
  chat_id uuid not null references chats(id) on delete cascade,
  role text not null check (role in ('u','a')),
  text text not null,
  ts bigint not null
);
create index on messages (chat_id, id);

create table requests (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  whatsapp text,
  plan text,
  mail boolean not null default false,
  ts bigint not null
);

create table settings (key text primary key, value text not null);

-- Nadie puede leer estas tablas desde el navegador; solo tu servidor, con la service key.
alter table clients  enable row level security;
alter table profiles enable row level security;
alter table projects enable row level security;
alter table chats    enable row level security;
alter table messages enable row level security;
alter table requests enable row level security;
alter table settings enable row level security;
