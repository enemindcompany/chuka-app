-- =========================================================
-- CHUKA PLATFORM — FOUNDATION DATABASE
-- =========================================================

create extension if not exists "pgcrypto";

-- =========================================================
-- ENUMS
-- =========================================================

create type verification_status as enum (
  'verified',
  'community_added',
  'pending',
  'reported',
  'closed'
);

create type listing_status as enum (
  'active',
  'draft',
  'paused',
  'sold',
  'closed',
  'removed'
);

-- =========================================================
-- PROFILES
-- =========================================================

create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  username text unique,
  phone text,
  avatar_url text,
  bio text,
  year_of_study int,
  course text,
  is_verified boolean default false,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- LOCATIONS
-- The central geographic directory.
-- =========================================================

create table locations (
  id uuid primary key default gen_random_uuid(),

  name text not null,
  slug text unique,

  category text not null,
  subcategory text,

  description text,

  address text,

  latitude double precision,
  longitude double precision,

  aliases text[] default '{}',

  phone text,
  whatsapp text,
  email text,
  website text,

  opening_hours jsonb,

  services text[] default '{}',

  price_info text,

  source text,

  verification_status verification_status
    default 'community_added',

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index locations_category_idx
on locations(category);

create index locations_status_idx
on locations(verification_status);

create index locations_coordinates_idx
on locations(latitude, longitude);

-- =========================================================
-- LOCATION PHOTOS
-- =========================================================

create table location_photos (
  id uuid primary key default gen_random_uuid(),

  location_id uuid not null
    references locations(id)
    on delete cascade,

  url text not null,

  caption text,

  uploaded_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now()
);

-- =========================================================
-- BUSINESSES
-- =========================================================

create table businesses (
  id uuid primary key default gen_random_uuid(),

  location_id uuid references locations(id)
    on delete set null,

  name text not null,

  category text not null,

  description text,

  phone text,
  whatsapp text,
  email text,
  website text,

  services text[] default '{}',

  price_range text,

  status listing_status default 'active',

  verification_status verification_status
    default 'community_added',

  owner_id uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index businesses_category_idx
on businesses(category);

-- =========================================================
-- ACCOMMODATION
-- =========================================================

create table accommodations (
  id uuid primary key default gen_random_uuid(),

  location_id uuid references locations(id)
    on delete set null,

  name text not null,

  accommodation_type text,

  description text,

  price_per_month numeric,

  price_per_day numeric,

  available_units int,

  amenities text[] default '{}',

  distance_from_campus text,

  phone text,
  whatsapp text,

  gender_policy text,

  status listing_status default 'active',

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- FOOD
-- =========================================================

create table food_listings (
  id uuid primary key default gen_random_uuid(),

  business_id uuid references businesses(id)
    on delete cascade,

  name text not null,

  description text,

  menu jsonb,

  delivery_available boolean default false,

  delivery_info text,

  price_range text,

  opening_hours jsonb,

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- STUDENT SERVICES
-- =========================================================

create table services (
  id uuid primary key default gen_random_uuid(),

  name text not null,

  category text not null,

  description text,

  location_id uuid references locations(id)
    on delete set null,

  contact_name text,
  phone text,
  whatsapp text,
  email text,

  requirements text[] default '{}',

  steps text[] default '{}',

  fees text,

  deadlines text,

  official_url text,

  verification_status verification_status
    default 'community_added',

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index services_category_idx
on services(category);

-- =========================================================
-- DOCUMENTS / RESOURCES
-- =========================================================

create table documents (
  id uuid primary key default gen_random_uuid(),

  title text not null,

  document_type text,

  category text,

  course_code text,

  department text,

  description text,

  drive_url text,

  file_url text,

  year text,

  uploaded_by uuid references profiles(id)
    on delete set null,

  verification_status verification_status
    default 'community_added',

  created_at timestamptz default now()
);

create index documents_course_idx
on documents(course_code);

-- =========================================================
-- COURSES
-- =========================================================

create table courses (
  id uuid primary key default gen_random_uuid(),

  code text unique,
  name text not null,

  department text,

  school text,

  description text,

  created_at timestamptz default now()
);

-- =========================================================
-- EVENTS
-- =========================================================

create table events (
  id uuid primary key default gen_random_uuid(),

  title text not null,

  description text,

  category text,

  location_id uuid references locations(id)
    on delete set null,

  start_time timestamptz,
  end_time timestamptz,

  organizer text,

  contact_phone text,
  contact_whatsapp text,

  image_url text,

  status listing_status default 'active',

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now()
);

create index events_start_time_idx
on events(start_time);

-- =========================================================
-- JOBS & GIGS
-- =========================================================

create table jobs (
  id uuid primary key default gen_random_uuid(),

  title text not null,

  description text,

  category text,

  company text,

  location text,

  pay text,

  application_url text,

  phone text,
  whatsapp text,
  email text,

  deadline timestamptz,

  status listing_status default 'active',

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now()
);

-- =========================================================
-- MARKETPLACE
-- =========================================================

create table marketplace_listings (
  id uuid primary key default gen_random_uuid(),

  seller_id uuid references profiles(id)
    on delete set null,

  title text not null,

  description text,

  category text,

  price numeric,

  negotiable boolean default true,

  condition text,

  location text,

  phone text,
  whatsapp text,

  status listing_status default 'active',

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index marketplace_category_idx
on marketplace_listings(category);

create index marketplace_status_idx
on marketplace_listings(status);

-- =========================================================
-- MARKETPLACE PHOTOS
-- =========================================================

create table marketplace_photos (
  id uuid primary key default gen_random_uuid(),

  listing_id uuid not null
    references marketplace_listings(id)
    on delete cascade,

  url text not null,

  created_at timestamptz default now()
);

-- =========================================================
-- STORIES
-- =========================================================

create table stories (
  id uuid primary key default gen_random_uuid(),

  author_id uuid references profiles(id)
    on delete set null,

  title text not null,

  content text not null,

  category text,

  is_anonymous boolean default false,

  status listing_status default 'draft',

  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- =========================================================
-- STORY ↔ LOCATION CONNECTION
-- A story can mention multiple places.
-- =========================================================

create table story_locations (
  story_id uuid references stories(id)
    on delete cascade,

  location_id uuid references locations(id)
    on delete cascade,

  primary key (story_id, location_id)
);

-- =========================================================
-- REVIEWS
-- =========================================================

create table reviews (
  id uuid primary key default gen_random_uuid(),

  user_id uuid references profiles(id)
    on delete cascade,

  location_id uuid references locations(id)
    on delete cascade,

  rating int check (rating between 1 and 5),

  comment text,

  status listing_status default 'active',

  created_at timestamptz default now(),

  unique(user_id, location_id)
);

-- =========================================================
-- CONNECTIONS / COMMUNITIES
-- =========================================================

create table communities (
  id uuid primary key default gen_random_uuid(),

  name text not null,

  description text,

  category text,

  whatsapp_link text,

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now()
);

create table community_members (
  community_id uuid references communities(id)
    on delete cascade,

  user_id uuid references profiles(id)
    on delete cascade,

  joined_at timestamptz default now(),

  primary key (community_id, user_id)
);

-- =========================================================
-- EFOOTBALL
-- =========================================================

create table efootball_players (
  id uuid primary key default gen_random_uuid(),

  user_id uuid references profiles(id)
    on delete set null,

  gamer_tag text not null,

  platform text,

  skill_level text,

  wins int default 0,
  losses int default 0,
  draws int default 0,

  created_at timestamptz default now()
);

create table efootball_tournaments (
  id uuid primary key default gen_random_uuid(),

  name text not null,

  description text,

  location_id uuid references locations(id)
    on delete set null,

  entry_fee numeric default 0,

  prize_description text,

  start_time timestamptz,

  status listing_status default 'draft',

  created_by uuid references profiles(id)
    on delete set null,

  created_at timestamptz default now()
);

-- =========================================================
-- USER SAVES
-- =========================================================

create table saved_locations (
  user_id uuid references profiles(id)
    on delete cascade,

  location_id uuid references locations(id)
    on delete cascade,

  created_at timestamptz default now(),

  primary key (user_id, location_id)
);

-- =========================================================
-- REPORTS
-- =========================================================

create table reports (
  id uuid primary key default gen_random_uuid(),

  reporter_id uuid references profiles(id)
    on delete set null,

  location_id uuid references locations(id)
    on delete cascade,

  reason text not null,

  details text,

  status text default 'pending',

  created_at timestamptz default now()
);

-- =========================================================
-- UPDATED_AT HELPER
-- =========================================================

create or replace function update_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_updated_at
before update on profiles
for each row execute function update_updated_at();

create trigger locations_updated_at
before update on locations
for each row execute function update_updated_at();

create trigger businesses_updated_at
before update on businesses
for each row execute function update_updated_at();

create trigger accommodations_updated_at
before update on accommodations
for each row execute function update_updated_at();

create trigger food_updated_at
before update on food_listings
for each row execute function update_updated_at();

create trigger services_updated_at
before update on services
for each row execute function update_updated_at();

create trigger marketplace_updated_at
before update on marketplace_listings
for each row execute function update_updated_at();

create trigger stories_updated_at
before update on stories
for each row execute function update_updated_at();