import { useState, type FormEvent } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { supabase } from '../../lib/supabase'

export default function RegisterPage() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [displayName, setDisplayName] = useState('')
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState(false)
  const [loading, setLoading] = useState(false)

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setError(null)
    setLoading(true)
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { display_name: displayName } },
    })
    setLoading(false)
    if (error) {
      setError(error.message)
      return
    }
    if (data.session) {
      navigate('/')
    } else {
      setSuccess(true)
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-surface-50 px-4 py-8">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <Link to="/" className="text-4xl font-bold text-primary-700 tracking-tight">
            {t('app.name')}
          </Link>
        </div>

        <div className="bg-white rounded-xl shadow-md p-8">
          <h1 className="text-2xl font-semibold text-surface-900 mb-6">{t('auth.register')}</h1>

          {success ? (
            <div className="p-4 rounded-lg bg-green-50 border border-green-200 text-green-800 text-sm">
              {t('auth.checkEmail')}
            </div>
          ) : (
            <>
              {error && (
                <div className="mb-4 p-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm">
                  {error}
                </div>
              )}

              <form onSubmit={onSubmit} className="space-y-4">
                <div>
                  <label htmlFor="name" className="block text-sm font-medium text-surface-700 mb-1">
                    {t('auth.displayName')}
                  </label>
                  <input
                    id="name"
                    type="text"
                    required
                    value={displayName}
                    onChange={(e) => setDisplayName(e.target.value)}
                    className="w-full px-4 py-3 rounded-lg border border-surface-300 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                    autoComplete="name"
                  />
                </div>

                <div>
                  <label htmlFor="email" className="block text-sm font-medium text-surface-700 mb-1">
                    {t('auth.email')}
                  </label>
                  <input
                    id="email"
                    type="email"
                    required
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    className="w-full px-4 py-3 rounded-lg border border-surface-300 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                    autoComplete="email"
                  />
                </div>

                <div>
                  <label htmlFor="password" className="block text-sm font-medium text-surface-700 mb-1">
                    {t('auth.password')}
                  </label>
                  <input
                    id="password"
                    type="password"
                    required
                    minLength={8}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    className="w-full px-4 py-3 rounded-lg border border-surface-300 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                    autoComplete="new-password"
                  />
                  <p className="mt-1 text-xs text-surface-400">{t('auth.passwordHint')}</p>
                </div>

                <button
                  type="submit"
                  disabled={loading}
                  className="w-full py-3 px-4 rounded-lg bg-primary-400 text-surface-900 font-semibold hover:bg-primary-500 disabled:opacity-50 transition-colors"
                >
                  {loading ? t('common.loading') : t('auth.register')}
                </button>
              </form>
            </>
          )}

          <p className="mt-6 text-center text-sm text-surface-500">
            {t('auth.hasAccount')}{' '}
            <Link to="/login" className="text-primary-700 font-medium hover:underline">
              {t('auth.login')}
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}
