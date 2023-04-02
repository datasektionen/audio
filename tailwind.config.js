/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{js,jsx,ts,tsx}', './public/index.html'],
  theme: {
    extend: {
      
    },
    fontFamily: {
      'sans': ['ui-sans-serif', 'system-ui'],
      'serif': ['"Times New Roman"'],
      'mono': ['ui-monospace', 'SFMono-Regular'],
    }
  },
  plugins: [
    require('tailwind-scrollbar')
  ],
}
