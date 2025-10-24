#!/usr/bin/env bash
set -euo pipefail

WORKSPACE="/home/kavia/workspace/code-generation/robot-framework-test-manager-fullstack-application-for-test-script-management-36-155/ObjectStorage"
cd "$WORKSPACE"

command -v npm >/dev/null 2>&1 || { echo "npm not found" >&2; exit 2; }
# Install deps deterministically, non-interactive, minimal output
npm install --no-audit --no-fund --no-progress --loglevel=error

# Verify key local binaries; prefer node_modules/.bin
BIN_DIR="./node_modules/.bin"
[ -x "$BIN_DIR/vite" ] || { echo "vite not installed at $BIN_DIR/vite" >&2; exit 4; }
[ -x "$BIN_DIR/vitest" ] || { echo "vitest not installed at $BIN_DIR/vitest" >&2; exit 5; }
[ -x "$BIN_DIR/cross-env" ] || { echo "cross-env not installed at $BIN_DIR/cross-env" >&2; exit 6; }
[ -x "$BIN_DIR/http-server" ] || { echo "http-server not installed at $BIN_DIR/http-server" >&2; exit 7; }

# ESLint and Prettier config (TypeScript-aware)
if [ ! -f .eslintrc.json ]; then
cat > .eslintrc.json <<'E'
{
  "env": { "browser": true, "es2022": true },
  "parser": "@typescript-eslint/parser",
  "extends": ["eslint:recommended","plugin:react/recommended","plugin:@typescript-eslint/recommended","prettier"],
  "plugins": ["react","@typescript-eslint"],
  "parserOptions": { "ecmaFeatures": { "jsx": true }, "ecmaVersion": 2022, "sourceType": "module" },
  "settings": { "react": { "version": "detect" } }
}
E
fi
if [ ! -f .prettierrc ]; then
cat > .prettierrc <<'P'
{"singleQuote":true,"trailingComma":"es5"}
P
fi

# Vitest config
if [ ! -f vitest.config.ts ]; then
cat > vitest.config.ts <<'V'
import { defineConfig } from 'vitest/config'
export default defineConfig({ test: { environment: 'jsdom' } })
V
fi

# Add simple test if absent
mkdir -p src/__tests__
if [ ! -f src/__tests__/App.test.tsx ]; then
cat > src/__tests__/App.test.tsx <<'T'
import React from 'react'
import { render } from '@testing-library/react'
import '@testing-library/jest-dom'
import App from '../App'
import { describe, it, expect } from 'vitest'

describe('App', ()=>{ it('renders', ()=>{ const { getByText } = render(<App/>); expect(getByText(/ObjectStorage Frontend/)).toBeInTheDocument(); }) })
T
fi

# All done
exit 0
