import { useState, type FormEvent } from 'react'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { apiJson } from '../../lib/supabase'

const EQUIPMENT = [
  { id: 'barbell', fr: 'Barre', en: 'Barbell' },
  { id: 'dumbbell', fr: 'Haltères', en: 'Dumbbells' },
  { id: 'machine', fr: 'Machines', en: 'Machines' },
  { id: 'cable', fr: 'Poulies', en: 'Cables' },
  { id: 'bodyweight', fr: 'Poids du corps', en: 'Bodyweight' },
  { id: 'kettlebell', fr: 'Kettlebell', en: 'Kettlebell' },
]

const STEPS = 5

export default function OnboardingPage() {
  const { t, i18n } = useTranslation()
  const navigate = useNavigate()
  const lang = i18n.language === 'en' ? 'en' : 'fr'

  const [step, setStep] = useState(0)
  const [level, setLevel] = useState('')
  const [goal, setGoal] = useState('')
  const [daysPerWeek, setDaysPerWeek] = useState(3)
  const [duration, setDuration] = useState(60)
  const [equipment, setEquipment] = useState<string[]>([])
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  const toggleEquipment = (id: string) => {
    setEquipment((prev) => (prev.includes(id) ? prev.filter((e) => e !== id) : [...prev, id]))
  }

  const canNext = () => {
    if (step === 0) return level !== ''
    if (step === 1) return goal !== ''
    if (step === 4) return equipment.length > 0
    return true
  }

  const onSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setError(null)
    setLoading(true)
    try {
      await apiJson('/me/sports-profile', {
        method: 'PUT',
        body: JSON.stringify({
          level,
          goal,
          days_per_week: daysPerWeek,
          session_duration_min: duration,
          equipment,
        }),
      })
      navigate('/')
    } catch (err) {
      setError(err instanceof Error ? err.message : t('common.error'))
    } finally {
      setLoading(false)
    }
  }

  const next = () => setStep((s) => Math.min(s + 1, STEPS - 1))
  const back = () => setStep((s) => Math.max(s - 1, 0))

  const options = (items: { value: string; label: string }[], selected: string, onSelect: (v: string) => void) =>
    items.map((item) => (
      <button
        key={item.value}
        type="button"
        onClick={() => onSelect(item.value)}
        className={`w-full p-4 rounded-xl border-2 text-left transition-colors ${
          selected === item.value
            ? 'border-primary-600 bg-primary-50 text-primary-700'
            : 'border-surface-200 bg-white hover:border-surface-300'
        }`}
      >
        <span className="font-medium">{item.label}</span>
      </button>
    ))

  return (
    <div className="min-h-screen bg-surface-50 flex items-center justify-center px-4 py-8">
      <div className="w-full max-w-lg">
        <div className="mb-6">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-surface-500">
              {step + 1} / {STEPS}
            </span>
            <span className="text-sm text-surface-400">{t('onboarding.title')}</span>
          </div>
          <div className="h-2 bg-surface-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-primary-600 transition-all"
              style={{ width: `${((step + 1) / STEPS) * 100}%` }}
            />
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-md p-6 sm:p-8">
          {error && (
            <div className="mb-4 p-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm">
              {error}
            </div>
          )}

          <form onSubmit={onSubmit}>
            {step === 0 && (
              <div className="space-y-4">
                <h2 className="text-xl font-semibold text-surface-900">{t('onboarding.level')}</h2>
                {options(
                  [
                    { value: 'beginner', label: t('onboarding.levelBeginner') },
                    { value: 'intermediate', label: t('onboarding.levelIntermediate') },
                    { value: 'advanced', label: t('onboarding.levelAdvanced') },
                  ],
                  level,
                  setLevel,
                )}
              </div>
            )}

            {step === 1 && (
              <div className="space-y-4">
                <h2 className="text-xl font-semibold text-surface-900">{t('onboarding.goal')}</h2>
                {options(
                  [
                    { value: 'weight_loss', label: t('onboarding.goalWeightLoss') },
                    { value: 'strength', label: t('onboarding.goalStrength') },
                    { value: 'hypertrophy', label: t('onboarding.goalHypertrophy') },
                    { value: 'conditioning', label: t('onboarding.goalConditioning') },
                  ],
                  goal,
                  setGoal,
                )}
              </div>
            )}

            {step === 2 && (
              <div className="space-y-6">
                <h2 className="text-xl font-semibold text-surface-900">{t('onboarding.daysPerWeek')}</h2>
                <div className="text-center">
                  <span className="text-6xl font-bold text-primary-600">{daysPerWeek}</span>
                  <p className="mt-2 text-surface-500">
                    {daysPerWeek <= 2
                      ? lang === 'fr'
                        ? 'jour'
                        : 'day'
                      : lang === 'fr'
                        ? 'jours'
                        : 'days'}{' '}
                    / {lang === 'fr' ? 'semaine' : 'week'}
                  </p>
                </div>
                <input
                  type="range"
                  min={2}
                  max={6}
                  value={daysPerWeek}
                  onChange={(e) => setDaysPerWeek(Number(e.target.value))}
                  className="w-full h-3 accent-primary-600 cursor-pointer"
                />
                <div className="flex justify-between text-xs text-surface-400">
                  <span>2</span>
                  <span>6</span>
                </div>
              </div>
            )}

            {step === 3 && (
              <div className="space-y-6">
                <h2 className="text-xl font-semibold text-surface-900">{t('onboarding.sessionDuration')}</h2>
                <div className="text-center">
                  <span className="text-6xl font-bold text-primary-600">{duration}</span>
                  <p className="mt-2 text-surface-500">{lang === 'fr' ? 'minutes' : 'minutes'}</p>
                </div>
                <input
                  type="range"
                  min={30}
                  max={120}
                  step={15}
                  value={duration}
                  onChange={(e) => setDuration(Number(e.target.value))}
                  className="w-full h-3 accent-primary-600 cursor-pointer"
                />
                <div className="flex justify-between text-xs text-surface-400">
                  <span>30</span>
                  <span>120</span>
                </div>
              </div>
            )}

            {step === 4 && (
              <div className="space-y-4">
                <h2 className="text-xl font-semibold text-surface-900">{t('onboarding.equipment')}</h2>
                <div className="grid grid-cols-2 gap-3">
                  {EQUIPMENT.map((eq) => (
                    <button
                      key={eq.id}
                      type="button"
                      onClick={() => toggleEquipment(eq.id)}
                      className={`p-4 rounded-xl border-2 text-center font-medium transition-colors ${
                        equipment.includes(eq.id)
                          ? 'border-primary-600 bg-primary-50 text-primary-700'
                          : 'border-surface-200 bg-white hover:border-surface-300'
                      }`}
                    >
                      {lang === 'en' ? eq.en : eq.fr}
                    </button>
                  ))}
                </div>
                {equipment.length === 0 && (
                  <p className="text-sm text-surface-400">{t('onboarding.equipmentHint')}</p>
                )}
              </div>
            )}

            <div className="mt-8 flex gap-3">
              {step > 0 && (
                <button
                  type="button"
                  onClick={back}
                  className="flex-1 py-3 px-4 rounded-lg border border-surface-300 text-surface-700 font-medium hover:bg-surface-50 transition-colors"
                >
                  {t('onboarding.back')}
                </button>
              )}
              {step < STEPS - 1 ? (
                <button
                  type="button"
                  onClick={next}
                  disabled={!canNext()}
                  className="flex-1 py-3 px-4 rounded-lg bg-primary-600 text-white font-medium hover:bg-primary-700 disabled:opacity-50 transition-colors"
                >
                  {t('onboarding.next')}
                </button>
              ) : (
                <button
                  type="submit"
                  disabled={!canNext() || loading}
                  className="flex-1 py-3 px-4 rounded-lg bg-primary-600 text-white font-medium hover:bg-primary-700 disabled:opacity-50 transition-colors"
                >
                  {loading ? t('common.loading') : t('onboarding.finish')}
                </button>
              )}
            </div>
          </form>
        </div>
      </div>
    </div>
  )
}
