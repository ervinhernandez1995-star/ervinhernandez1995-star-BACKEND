/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#2563eb',
          600: '#1d4ed8',
          700: '#1e40af',
          800: '#1e3a8a',
          900: '#1e3a8a',
        },
        success: '#16a34a',
        warning: '#f59e0b',
        error: '#dc2626',
        'page-bg': '#f8f9fa',
        'surface-bg': '#ffffff',
        'border': '#e5e7eb',
        'text-primary': '#111827',
        'text-secondary': '#6b7280',
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      boxShadow: {
        'subtle': '0 4px 12px rgba(0, 0, 0, 0.05)',
        'elevated': '0 8px 24px rgba(37, 99, 235, 0.1)',
      },
      borderRadius: {
        'card': '12px',
        'button': '8px',
      },
    },
  },
  plugins: [],
}