-- NexFit — Jalon 3 (sécurité) : empêcher l'auto-élévation de rôle
-- Contexte : les policies RLS de 0001 laissent chaque utilisateur mettre à jour
--            sa propre ligne `profiles` sans restreindre les colonnes. PostgREST
--            expose la table, donc un utilisateur connecté pourrait faire
--            PATCH /rest/v1/profiles { "role": "admin" } et passer admin.
-- Correctif : trigger BEFORE INSERT/UPDATE qui fige `role` pour tout appel
--             portant un jeton utilisateur (auth.uid() non nul). Le backend
--             (connexion pooler sans JWT, auth.uid() nul) conserve la capacité
--             de créer un admin issu de app_metadata.

create or replace function public.prevent_role_escalation()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is not null then
    if tg_op = 'INSERT' then
      new.role := 'user';
    elsif new.role is distinct from old.role then
      raise exception 'role cannot be modified by end users';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists trg_prevent_role_escalation_insert on public.profiles;
create trigger trg_prevent_role_escalation_insert
  before insert on public.profiles
  for each row execute function public.prevent_role_escalation();

drop trigger if exists trg_prevent_role_escalation_update on public.profiles;
create trigger trg_prevent_role_escalation_update
  before update on public.profiles
  for each row execute function public.prevent_role_escalation();
