#!/bin/bash

cd ${OKTA_HOME}/${REPO}

setup_service grunt
setup_service bundler

# Install required dependencies
yarn install -g @okta/ci-update-package
yarn install -g @okta/ci-pkginfo

if ! bundle install; then
  echo "bundle install failed! Exiting..."
  exit ${FAILED_SETUP}
fi

if ! yarn install --ignore-optional; then
  echo "yarn install failed! Exiting..."
  exit ${FAILED_SETUP}
fi

if ! yarn run build:release; then
  echo "yarn build release failed! Exiting..."
  exit ${FAILED_SETUP}
fi
