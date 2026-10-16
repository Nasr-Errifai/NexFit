import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from 'react'
import type { Session, User } from '@supabase/supabase-js'
import { supabase, apiJson } from '../lib/supabase'

export interface MeProfile {
  id: string
  email: string | null
  display_name: string | null
  role: string
  locale: string
  avatar_path: string | null
  has_sports_profile: boolean
}

interface AuthContextValue {
  session: Session | null
  user: User | null
  /** Profil /me, chargé une fois la session établie. */
  profile: MeProfile | null
  /** Vrai tant que le profil /me est en cours de chargement. */
  loading: boolean
  /** Recharger /me (après onboarding, changement de profil…). */
  refreshProfile: () => Promise<void>
  signOut: () => Promise<void>
}

const AuthContext = createContext<AuthContextValue>({
  session: null,
  user: null,
  profile: null,
  loading: true,
  refreshProfile: async () => {},
  signOut: async () => {},
})

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null)
  const [user, setUser] = useState<User | null>(null)
  const [profile, setProfile] = useState<MeProfile | null>(null)
  const [loading, setLoading] = useState(true)

  const refreshProfile = useCallback(async () => {
    const { data } = await supabase.auth.getSession()
    if (!data.session) {
      setProfile(null)
      return
    }
    try {
      const me = await apiJson<MeProfile>('/me')
      setProfile(me)
    } catch {
      // L'API peut être indisponible : on ne bloque pas l'app, on laisse le profil à null.
      setProfile(null)
    }
  }, [])

  useEffect(() => {
    let cancelled = false

    supabase.auth.getSession().then(async ({ data }) => {
      if (cancelled) return
      setSession(data.session)
      setUser(data.session?.user ?? null)
      if (data.session) {
        await refreshProfile()
      }
      if (!cancelled) setLoading(false)
    })

    const { data: sub } = supabase.auth.onAuthStateChange((_event, newSession) => {
      setSession(newSession)
      setUser(newSession?.user ?? null)
      if (!newSession) {
        setProfile(null)
        setLoading(false)
      }
    })
    return () => {
      cancelled = true
      sub.subscription.unsubscribe()
    }
  }, [refreshProfile])

  const signOut = async () => {
    await supabase.auth.signOut()
  }

  return (
    <AuthContext.Provider
      value={{ session, user, profile, loading, refreshProfile, signOut }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  return useContext(AuthContext)
}
