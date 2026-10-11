import i18n from 'i18next'
import { initReactI18next } from 'react-i18next'
import en from './locales/en.json'
import fr from './locales/fr.json'

const savedLang = localStorage.getItem('nexfit-lang') || 'fr'

i18n.use(initReactI18next).init({
  resources: {
    fr: { translation: fr },
    en: { translation: en },
  },
  lng: savedLang,
  fallbackLng: 'fr',
  interpolation: {
    escapeValue: false,
  },
})

export function setLanguage(lang: 'fr' | 'en') {
  i18n.changeLanguage(lang)
  localStorage.setItem('nexfit-lang', lang)
  document.documentElement.lang = lang
}

export default i18n
