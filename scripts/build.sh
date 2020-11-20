#!/bin/bash
set -o errexit -o nounset -o pipefail

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_BASE_DIR=${SCRIPTS_DIR}/..

echo "Building the universe!"

mkdir -p ${REPO_BASE_DIR}/target/

# Install dependencies
pip3 install -r ${SCRIPTS_DIR}/requirements/requirements.txt

python3 "$SCRIPTS_DIR"/validate_packages.py
python3 "$SCRIPTS_DIR"/gen_universe.py --repository="${REPO_BASE_DIR}"/repo/packages/ --out-dir="${REPO_BASE_DIR}"/target/

