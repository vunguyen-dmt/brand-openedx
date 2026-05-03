#!/bin/bash
set -e
cd "$(dirname "$0")"

npm run build

sudo cp -rf dist/* ../frontend-app-extensions/node_modules/@edx/brand/dist/

MFES=(learning learner-dashboard profile account discussions authn)

for mfe in "${MFES[@]}"; do
    tutor dev exec "$mfe" npm install --install-links '@edx/brand@file:/brand-openedx' &
done

tutor dev exec extensions npm install --install-links '@edx/brand@file:/openedx/brand-openedx' &

wait
echo "Brand installed in all MFEs."
