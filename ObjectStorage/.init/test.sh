#!/usr/bin/env bash
set -euo pipefail
WORKSPACE="/home/kavia/workspace/code-generation/robot-framework-test-manager-fullstack-application-for-test-script-management-36-155/ObjectStorage"
cd "$WORKSPACE"
command -v npm >/dev/null 2>&1 || { echo "npm not found" >&2; exit 2; }
# Run tests and preserve exit code even when piping to tee
npm run test --silent 2>&1 | tee vitest.run.log
EXIT_CODE=${PIPESTATUS[0]:-1}
if [ "$EXIT_CODE" -ne 0 ]; then
  echo "Tests failed with exit code $EXIT_CODE; see vitest.run.log" >&2
  exit "$EXIT_CODE"
fi
