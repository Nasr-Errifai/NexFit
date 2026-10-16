import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string
const supabaseKey = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY as string

export const supabase = createClient(supabaseUrl, supabaseKey)

export const API_URL = (import.meta.env.VITE_API_URL as string) || 'http://localhost:8000'

export async function apiFetch(path: string, options: RequestInit = {}): Promise<Response> {
  const { data } = await supabase.auth.getSession()
  const token = data.session?.access_token
  return fetch(`${API_URL}${path}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(options.headers || {}),
    },
  })
}

export async function apiJson<T>(path: string, options: RequestInit = {}): Promise<T> {
  const resp = await apiFetch(path, options)
  if (!resp.ok) {
    const body = await resp.json().catch(() => null)
    const detail = body?.detail
    const message = typeof detail === 'string' ? detail : JSON.stringify(detail ?? resp.statusText)
    throw new Error(message)
  }
  if (resp.status === 204) return undefined as T
  return resp.json()
}
