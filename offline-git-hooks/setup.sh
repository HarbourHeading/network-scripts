#!/usr/bin/env bash
# Setup Git hooks to link '.githooks'

HOOKS_DIR=".githooks"

mkdir -p .githooks

echo "Configuring Git to use hooks from $HOOKS_DIR..."
git config core.hooksPath "$HOOKS_DIR"

# Make scripts executable (if not windows)
if [[ "$OSTYPE" != "msys" ]]; then
  echo "Making hooks executable..."
  chmod -R 750 .githooks/
fi

echo "Git hooks successfully configured to use $HOOKS_DIR"
