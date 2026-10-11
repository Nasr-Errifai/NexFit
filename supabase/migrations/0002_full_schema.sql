-- NexFit — Jalon 2 : schéma complet + RLS
-- Tables : sports_profiles, exercises, exercise_alternatives,
--          programs, program_days, program_exercises,
--          workouts, workout_sets, personal_records, goals, recommendation_logs

-- ============================================================
-- Updated_at trigger
-- ============================================================
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- ============================================================
-- sports_profiles (profil sportif privé)
-- ============================================================
create table if not exists public.sports_profiles (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  level text not null check (level in ('beginner','intermediate','advanced')),
  goal text not null check (goal in ('weight_loss','strength','hypertrophy','conditioning')),
  days_per_week int not null check (days_per_week between 1 and 7),
  session_duration_min int not null check (session_duration_min between 10 and 240),
  equipment text[] not null default '{}',
  preferences text,
  limitations text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_sports_profiles_updated_at
  before update on public.sports_profiles
  for each row execute function public.set_updated_at();

-- ============================================================
-- exercises (bibliothèque, contenu public géré par admin)
-- ============================================================
create table if not exists public.exercises (
  id uuid primary key default gen_random_uuid(),
  name_fr text not null,
  name_en text not null unique,
  muscle_group text not null check (muscle_group in ('chest','back','legs','shoulders','arms','core')),
  movement_type text not null check (movement_type in ('compound','isolation','isometric')),
  equipment text not null check (equipment in ('barbell','dumbbell','machine','cable','bodyweight','kettlebell')),
  difficulty text not null check (difficulty in ('beginner','intermediate','advanced')),
  exercise_type text not null check (exercise_type in ('free_weights','machine','bodyweight','cable')),
  instructions_fr jsonb not null default '[]',
  instructions_en jsonb not null default '[]',
  common_mistakes_fr text,
  common_mistakes_en text,
  image_path text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_exercises_updated_at
  before update on public.exercises
  for each row execute function public.set_updated_at();

create index if not exists idx_exercises_muscle_group on public.exercises (muscle_group);
create index if not exists idx_exercises_equipment on public.exercises (equipment);
create index if not exists idx_exercises_difficulty on public.exercises (difficulty);

-- ============================================================
-- exercise_alternatives (sécurité de substitution)
-- ============================================================
create table if not exists public.exercise_alternatives (
  id uuid primary key default gen_random_uuid(),
  exercise_id uuid not null references public.exercises(id) on delete cascade,
  alternative_id uuid not null references public.exercises(id) on delete cascade,
  reason_fr text,
  reason_en text,
  created_at timestamptz not null default now(),
  unique (exercise_id, alternative_id),
  check (exercise_id <> alternative_id)
);

create index if not exists idx_exercise_alternatives_exercise on public.exercise_alternatives (exercise_id);

-- ============================================================
-- programs
-- ============================================================
create table if not exists public.programs (
  id uuid primary key default gen_random_uuid(),
  name_fr text not null,
  name_en text not null,
  description_fr text,
  description_en text,
  split_type text not null check (split_type in ('ppl','upper_lower','full_body','custom')),
  days_per_week int not null check (days_per_week between 1 and 7),
  level text not null check (level in ('beginner','intermediate','advanced')),
  goal text not null check (goal in ('weight_loss','strength','hypertrophy','conditioning')),
  source text not null default 'predefined' check (source in ('predefined','rule_engine','custom')),
  created_by uuid references public.profiles(id) on delete set null,
  is_public boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_programs_updated_at
  before update on public.programs
  for each row execute function public.set_updated_at();

create index if not exists idx_programs_goal on public.programs (goal);
create index if not exists idx_programs_level on public.programs (level);
create index if not exists idx_programs_public on public.programs (is_public);

-- ============================================================
-- program_days
-- ============================================================
create table if not exists public.program_days (
  id uuid primary key default gen_random_uuid(),
  program_id uuid not null references public.programs(id) on delete cascade,
  day_index int not null check (day_index >= 0),
  name_fr text not null,
  name_en text not null,
  created_at timestamptz not null default now(),
  unique (program_id, day_index)
);

-- ============================================================
-- program_exercises
-- ============================================================
create table if not exists public.program_exercises (
  id uuid primary key default gen_random_uuid(),
  program_day_id uuid not null references public.program_days(id) on delete cascade,
  exercise_id uuid not null references public.exercises(id) on delete cascade,
  order_index int not null check (order_index >= 0),
  target_sets int not null check (target_sets between 1 and 20),
  target_reps text not null,
  rest_seconds int not null default 90 check (rest_seconds between 0 and 600),
  notes text,
  created_at timestamptz not null default now(),
  unique (program_day_id, order_index)
);

create index if not exists idx_program_exercises_day on public.program_exercises (program_day_id);

-- ============================================================
-- workouts (séances d'un utilisateur)
-- ============================================================
create table if not exists public.workouts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  program_id uuid references public.programs(id) on delete set null,
  program_day_id uuid references public.program_days(id) on delete set null,
  date date not null default current_date,
  status text not null default 'planned' check (status in ('planned','in_progress','completed','skipped')),
  started_at timestamptz,
  finished_at timestamptz,
  client_token uuid,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_workouts_updated_at
  before update on public.workouts
  for each row execute function public.set_updated_at();

create unique index if not exists idx_workouts_client_token
  on public.workouts (user_id, client_token) where client_token is not null;

create index if not exists idx_workouts_user_date on public.workouts (user_id, date);

-- ============================================================
-- workout_sets (journal des séries)
-- ============================================================
create table if not exists public.workout_sets (
  id uuid primary key default gen_random_uuid(),
  workout_id uuid not null references public.workouts(id) on delete cascade,
  exercise_id uuid not null references public.exercises(id) on delete cascade,
  set_index int not null check (set_index >= 0),
  target_reps int,
  reps int,
  weight_kg numeric(6,2) check (weight_kg >= 0),
  is_warmup boolean not null default false,
  completed boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists idx_workout_sets_workout on public.workout_sets (workout_id);

-- ============================================================
-- personal_records
-- ============================================================
create table if not exists public.personal_records (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  exercise_id uuid not null references public.exercises(id) on delete cascade,
  record_type text not null check (record_type in ('max_weight','max_reps','best_volume')),
  value numeric(10,2) not null,
  workout_id uuid references public.workouts(id) on delete set null,
  achieved_at timestamptz not null default now(),
  unique (user_id, exercise_id, record_type)
);

create index if not exists idx_personal_records_user on public.personal_records (user_id);

-- ============================================================
-- goals
-- ============================================================
create table if not exists public.goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  type text not null check (type in ('workouts_per_week','weight','custom')),
  target numeric(10,2) not null,
  current numeric(10,2) not null default 0,
  start_date date not null default current_date,
  target_date date,
  status text not null default 'active' check (status in ('active','completed','abandoned')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_goals_updated_at
  before update on public.goals
  for each row execute function public.set_updated_at();

create index if not exists idx_goals_user on public.goals (user_id);

-- ============================================================
-- recommendation_logs (traçabilité des recommandations)
-- ============================================================
create table if not exists public.recommendation_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  input_snapshot jsonb not null default '{}',
  explanation text not null,
  accepted boolean,
  applied_program_id uuid references public.programs(id) on delete set null,
  created_at timestamptz not null default now()
);

create index if not exists idx_recommendation_logs_user on public.recommendation_logs (user_id);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

alter table public.sports_profiles enable row level security;
alter table public.exercises enable row level security;
alter table public.exercise_alternatives enable row level security;
alter table public.programs enable row level security;
alter table public.program_days enable row level security;
alter table public.program_exercises enable row level security;
alter table public.workouts enable row level security;
alter table public.workout_sets enable row level security;
alter table public.personal_records enable row level security;
alter table public.goals enable row level security;
alter table public.recommendation_logs enable row level security;

-- sports_profiles : propriétaire uniquement
create policy "sports_profiles_select_own" on public.sports_profiles
  for select using (auth.uid() = user_id);
create policy "sports_profiles_insert_own" on public.sports_profiles
  for insert with check (auth.uid() = user_id);
create policy "sports_profiles_update_own" on public.sports_profiles
  for update using (auth.uid() = user_id);
create policy "sports_profiles_delete_own" on public.sports_profiles
  for delete using (auth.uid() = user_id);

-- exercises : lecture publique (écriture via backend postgres uniquement)
create policy "exercises_public_read" on public.exercises
  for select using (true);

-- exercise_alternatives : lecture publique
create policy "exercise_alternatives_public_read" on public.exercise_alternatives
  for select using (true);

-- programs : public ou propriétaire
create policy "programs_select_public_or_own" on public.programs
  for select using (is_public = true or created_by = auth.uid());

-- program_days / program_exercises : lisibles si le programme l'est
create policy "program_days_select_visible" on public.program_days
  for select using (
    exists (
      select 1 from public.programs p
      where p.id = program_id
        and (p.is_public = true or p.created_by = auth.uid())
    )
  );

create policy "program_exercises_select_visible" on public.program_exercises
  for select using (
    exists (
      select 1 from public.program_days pd
      join public.programs p on p.id = pd.program_id
      where pd.id = program_day_id
        and (p.is_public = true or p.created_by = auth.uid())
    )
  );

-- workouts : propriétaire uniquement
create policy "workouts_select_own" on public.workouts
  for select using (auth.uid() = user_id);
create policy "workouts_insert_own" on public.workouts
  for insert with check (auth.uid() = user_id);
create policy "workouts_update_own" on public.workouts
  for update using (auth.uid() = user_id);
create policy "workouts_delete_own" on public.workouts
  for delete using (auth.uid() = user_id);

-- workout_sets : via workout propriétaire
create policy "workout_sets_select_own" on public.workout_sets
  for select using (
    exists (select 1 from public.workouts w where w.id = workout_id and w.user_id = auth.uid())
  );
create policy "workout_sets_insert_own" on public.workout_sets
  for insert with check (
    exists (select 1 from public.workouts w where w.id = workout_id and w.user_id = auth.uid())
  );
create policy "workout_sets_update_own" on public.workout_sets
  for update using (
    exists (select 1 from public.workouts w where w.id = workout_id and w.user_id = auth.uid())
  );
create policy "workout_sets_delete_own" on public.workout_sets
  for delete using (
    exists (select 1 from public.workouts w where w.id = workout_id and w.user_id = auth.uid())
  );

-- personal_records : propriétaire
create policy "personal_records_select_own" on public.personal_records
  for select using (auth.uid() = user_id);
create policy "personal_records_insert_own" on public.personal_records
  for insert with check (auth.uid() = user_id);
create policy "personal_records_update_own" on public.personal_records
  for update using (auth.uid() = user_id);
create policy "personal_records_delete_own" on public.personal_records
  for delete using (auth.uid() = user_id);

-- goals : propriétaire
create policy "goals_select_own" on public.goals
  for select using (auth.uid() = user_id);
create policy "goals_insert_own" on public.goals
  for insert with check (auth.uid() = user_id);
create policy "goals_update_own" on public.goals
  for update using (auth.uid() = user_id);
create policy "goals_delete_own" on public.goals
  for delete using (auth.uid() = user_id);

-- recommendation_logs : propriétaire
create policy "recommendation_logs_select_own" on public.recommendation_logs
  for select using (auth.uid() = user_id);
create policy "recommendation_logs_insert_own" on public.recommendation_logs
  for insert with check (auth.uid() = user_id);
