#!/usr/bin/env bash
set -euo pipefail
WORKSPACE="/home/kavia/workspace/code-generation/robot-framework-test-manager-fullstack-application-for-test-script-management-36-155/ObjectStorage"
cd "$WORKSPACE"
FORCE=${FORCE:-0}
if [ ! -f package.json ] || [ "$FORCE" = "1" ]; then
cat > package.json <<'JSON'
{
  "name": "objectstorage-frontend",
  "version": "0.1.0",
  "private": true,
  "engines": { "node": ">=16", "npm": ">=8" },
  "scripts": {
    "dev": "vite",
    "start": "sh -lc \"cross-env NODE_ENV=production PORT=${PORT:-3000} http-server build -p ${PORT:-3000} -c-1\"",
    "build": "vite build --outDir build",
    "test": "cross-env NODE_ENV=test vitest --run --reporter dot",
    "lint": "eslint . --ext .ts,.tsx",
    "format": "prettier --write ."
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "@types/node": "^18.0.0",
    "vite": "^5.0.0",
    "@vitejs/plugin-react": "^4.0.0",
    "vitest": "^1.0.0",
    "jsdom": "^22.0.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0",
    "eslint": "^8.0.0",
    "prettier": "^2.0.0",
    "eslint-config-prettier": "^8.0.0",
    "eslint-plugin-react": "^7.0.0",
    "eslint-plugin-react-hooks": "^4.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "cross-env": "^7.0.0",
    "http-server": "^14.0.0"
  }
}
JSON
fi
# tsconfig
if [ ! -f tsconfig.json ] || [ "$FORCE" = "1" ]; then
cat > tsconfig.json <<'TS'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "jsx": "react-jsx",
    "strict": true,
    "esModuleInterop": true,
    "moduleResolution": "node",
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"]
}
TS
fi
# vite config
if [ ! -f vite.config.ts ] || [ "$FORCE" = "1" ]; then
cat > vite.config.ts <<'VITE'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
export default defineConfig({ plugins: [react()] })
VITE
fi
mkdir -p src
if [ ! -f index.html ] || [ "$FORCE" = "1" ]; then
cat > index.html <<'HTML'
<!doctype html>
<html>
  <head><meta charset="utf-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /></head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
HTML
fi
if [ ! -f src/main.tsx ] || [ "$FORCE" = "1" ]; then
cat > src/main.tsx <<'MAIN'
import React from 'react'
import { createRoot } from 'react-dom/client'
import App from './App'
const rootEl = document.getElementById('root')
if (rootEl) { const root = createRoot(rootEl); root.render(<App />) }
MAIN
fi
if [ ! -f src/App.tsx ] || [ "$FORCE" = "1" ]; then
cat > src/App.tsx <<'APP'
import React from 'react'
export default function App(){
  return <div>ObjectStorage Frontend (minimal)</div>
}
APP
fi
