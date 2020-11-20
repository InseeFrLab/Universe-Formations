#!/usr/bin/env bash

set -e

DOC_FOLDER="docs"
SITE_FOLDER="website"
BUNDLE_REPORT_FOLDER="bundle-report"

MAIN_BRANCH="master"
PREVIEW_BRANCH="preview"
UPSTREAM="https://$ACCESS_TOKEN@github.com/$GITHUB_REPOSITORY.git"
UNIVERSE_JSON="universe.json"
MESSAGE="Republishing universe"

function setup() {
    ls target
}

function publish() {

  mv target/universe.json $UNIVERSE_JSON

  git init
  git remote add upstream "$UPSTREAM"
  git fetch --prune upstream
  git reset upstream/gh-pages
  git add $UNIVERSE_JSON
  git config --global user.email "noreply@insee.fr"
  git config --global user.name "inseefrlab-bot"
  if git commit --message "$MESSAGE" ; then
    git push --quiet upstream HEAD:gh-pages
  fi
}

function main() {
  setup && publish
}

main
