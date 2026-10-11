# NexFit

Plateforme fitness tout-en-un — programmes d'entraînement, suivi de progression et recommandations explicables. Marché de lancement : Maroc.

## Stack

| Couche | Technologie |
|---|---|
| Frontend | React 18, Vite, TypeScript, Tailwind CSS v4, TanStack Query, react-i18next (FR/EN) |
| Backend | Python 3.11, FastAPI, SQLAlchemy async, asyncpg |
| Base de données | Supabase (PostgreSQL, Auth, Storage) |
| CI | GitHub Actions |

## Structure du dépôt

```
/
├── frontend/       # Application React
├── backend/        # API FastAPI
├── supabase/       # Migrations SQL + seed
└── .github/        # Workflows CI
```

## Démarrage rapide

### Prérequis

- Node.js ≥ 20
- Python 3.11+
- [Supabase CLI](https://supabase.com/docs/guides/cli)

### 1. Cloner et installer

```bash
git clone https://github.com/Nasr-Errifai/NexFit.git
cd NexFit
```

### 2. Frontend

```bash
cd frontend
cp .env.example .env        # remplir les valeurs Supabase
npm install
npm run dev                 # http://localhost:5173
```

### 3. Backend

```bash
cd backend
python -m venv .venv
.venv\Scripts\activate      # Windows
pip install -r requirements.txt
cp .env.example .env        # remplir DATABASE_URL et SUPABASE_JWT_SECRET
uvicorn app.main:app --reload  # http://localhost:8000
```

### 4. Base de données

```bash
supabase link --project-ref ordxvysxzyqwyxqmxwjg
supabase db push            # applique les migrations
```

## Variables d'environnement

### Frontend (`frontend/.env`)

| Variable | Description |
|---|---|
| `VITE_SUPABASE_URL` | URL du projet Supabase |
| `VITE_SUPABASE_PUBLISHABLE_KEY` | Clé publishable (safe côté client) |
| `VITE_API_URL` | URL de l'API FastAPI |

### Backend (`backend/.env`)

| Variable | Description |
|---|---|
| `DATABASE_URL` | Connection string Postgres (asyncpg) |
| `SUPABASE_URL` | URL du projet Supabase |
| `SUPABASE_JWT_SECRET` | Secret JWT (Settings → API) |
| `CORS_ORIGINS` | Liste JSON des origines autorisées |

> ⚠️ Les fichiers `.env` ne sont **jamais** commités (voir `.gitignore`).

## Tests

```bash
# Frontend
cd frontend && npm run lint && npm run build

# Backend
cd backend && python -m pytest tests/ -v
```

## CI

Chaque push/PR sur `main` déclenche :
- **Frontend** : lint + build TypeScript
- **Backend** : pytest

## Roadmap

- ✅ Jalon 1 — Scaffold monorepo, CI, migrations initiales
- ⬜ Jalon 2 — Schéma complet + RLS + seed exercices
- ⬜ Jalon 3 — Auth + onboarding
- ⬜ Jalon 4 — Bibliothèque d'exercices
- ⬜ Jalon 5 — Programmes
- ⬜ Jalon 6 — Mode entraînement (hors-ligne)
- ⬜ Jalon 7 — Progression + stats
- ⬜ Jalon 8 — Moteur de règles explicables
- ⬜ Jalon 9 — Admin + i18n + settings
- ⬜ Jalon 10 — Tests finaux + polish

## Licence

Projet privé — tous droits réservés.
