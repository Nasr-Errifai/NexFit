import { Routes, Route } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { setLanguage } from './i18n'

function Home() {
  const { t, i18n } = useTranslation()

  return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-6 bg-surface-50">
      <div className="text-center">
        <h1 className="text-5xl font-bold text-primary-600 tracking-tight">
          {t('app.name')}
        </h1>
        <p className="mt-3 text-lg text-surface-500">{t('app.tagline')}</p>
      </div>

      <div className="flex gap-3">
        <button
          onClick={() => setLanguage('fr')}
          className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
            i18n.language === 'fr'
              ? 'bg-primary-600 text-white'
              : 'bg-surface-100 text-surface-600 hover:bg-surface-200'
          }`}
        >
          Français
        </button>
        <button
          onClick={() => setLanguage('en')}
          className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
            i18n.language === 'en'
              ? 'bg-primary-600 text-white'
              : 'bg-surface-100 text-surface-600 hover:bg-surface-200'
          }`}
        >
          English
        </button>
      </div>

      <p className="text-sm text-surface-400">
        Jalon 1 — Scaffold en cours. Prochaines étapes : auth, onboarding, bibliothèque
        d'exercices.
      </p>
    </div>
  )
}

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
    </Routes>
  )
}
