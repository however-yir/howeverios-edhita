#!/usr/bin/env bash
set -euo pipefail

if ! git remote get-url upstream >/dev/null 2>&1; then
  git remote add upstream https://github.com/tnantoka/edhita.git
fi

git fetch upstream master
git merge --no-ff upstream/master -m "chore: sync upstream master"
