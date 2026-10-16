import { type ReactNode } from 'react'
import { Navigate, Route, Routes, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { setLanguage } from './i18n'
import { useAuth } from './context/AuthContext'
import LoginPage from './pages/auth/LoginPage'
import RegisterPage from './pages/auth/RegisterPage'
import OnboardingPage from './pages/onboarding/OnboardingPage'

function FullScreenLoader() {
  const { t } = useTranslation()
  return (
    <div className="min-h-screen flex items-center justify-center bg-surface-50">
      <span className="text-surface-500">{t('common.loading')}</span>
    </div>
  )
}

/** Nécessite une session. Redirige vers /login sinon. */
function RequireAuth({ children }: { children: ReactNode }) {
  const { session, loading } = useAuth()
  if (loading) return <FullScreenLoader />
  if (!session) return <Navigate to="/login" replace />
  return <>{children}</>
}

/** Pour les pages publiques : déjà connecté → hors de /login|/register. */
function RedirectIfAuthed({ children }: { children: ReactNode }) {
  const { session, loading, profile } = useAuth()
  if (loading) return <FullScreenLoader />
  if (session)
    return <Navigate to={profile?.has_sports_profile ? '/' : '/onboarding'} replace />
  return <>{children}</>
}

/** Onboarding : réservé à un connecté sans profil sportif. */
function OnboardingGuard({ children }: { children: ReactNode }) {
  const { session, loading, profile } = useAuth()
  if (loading) return <FullScreenLoader />
  if (!session) return <Navigate to="/login" replace />
  if (profile?.has_sports_profile) return <Navigate to="/" replace />
  return <>{children}</>
}

function LanguageSwitcher() {
  const { i18n } = useTranslation()
  const base = 'px-4 py-2 rounded-lg text-sm font-medium transition-colors'
  return (
    <div className="flex gap-3">
      <button
        onClick={() => setLanguage('fr')}
        className={`${base} ${
          i18n.language === 'fr'
            ? 'bg-primary-400 text-surface-900'
            : 'bg-surface-100 text-surface-600 hover:bg-surface-200'
        }`}
      >
        Français
      </button>
      <button
        onClick={() => setLanguage('en')}
        className={`${base} ${
          i18n.language === 'en'
            ? 'bg-primary-400 text-surface-900'
            : 'bg-surface-100 text-surface-600 hover:bg-surface-200'
        }`}
      >
        English
      </button>
    </div>
  )
}

/** Table de bord minimale provisoire (le vrai dashboard viendra plus tard). */
function Home() {
  const { t } = useTranslation()
  const { session, profile, signOut } = useAuth()
  const navigate = useNavigate()

  // session établie mais profil sportif absent → onboarding
  if (session && !profile?.has_sports_profile) {
    return <Navigate to="/onboarding" replace />
  }

  const handleSignOut = async () => {
    await signOut()
    navigate('/login')
  }

  return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-6 bg-surface-50 px-4">
      <div className="w-full max-w-md bg-white rounded-xl shadow-md p-8">
        <h1 className="text-3xl font-bold text-primary-700 tracking-tight">
          {t('app.name')}
        </h1>
        <p className="mt-2 text-surface-500">{t('app.tagline')}</p>

        {profile?.display_name && (
          <p className="mt-6 text-surface-700">
            {t('home.welcome', { name: profile.display_name })}
          </p>
        )}

        <div className="mt-4 inline-flex items-center gap-2 text-sm text-surface-500">
          <span className="inline-block w-2 h-2 rounded-full bg-primary-500" />
          {t('home.onboardingDone')}
        </div>

        <div className="mt-8 flex flex-col gap-3">
          <LanguageSwitcher />
          <button
            onClick={handleSignOut}
            className="w-full py-3 px-4 rounded-lg border border-surface-300 text-surface-700 font-medium hover:bg-surface-50 transition-colors"
          >
            {t('nav.logout')}
          </button>
        </div>
      </div>

      <p className="text-sm text-surface-400">
        {t('home.nextSteps')}
      </p>
    </div>
  )
}

export default function App() {
  return (
    <Routes>
      <Route
        path="/"
        element={
          <RequireAuth>
            <Home />
          </RequireAuth>
        }
      />
      <Route
        path="/login"
        element={
          <RedirectIfAuthed>
            <LoginPage />
          </RedirectIfAuthed>
        }
      />
      <Route
        path="/register"
        element={
          <RedirectIfAuthed>
            <RegisterPage />
          </RedirectIfAuthed>
        }
      />
      <Route
        path="/onboarding"
        element={
          <OnboardingGuard>
            <OnboardingPage />
          </OnboardingGuard>
        }
      />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  )
}
