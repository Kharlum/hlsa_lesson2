#!/bin/bash

TEMP_DIR=/grafana

if ! command -v curl &> /dev/null
then
  echo "Please install curl before running this script" && exit 1
fi

if ! command -v jq &> /dev/null
then
  echo "Please install jq before running this script" && exit 1
fi

if [ ! -d "${TEMP_DIR}" ]; then
  echo "${TEMP_DIR} doesn't exist" && exit 1
fi

pushd "${TEMP_DIR}" > /dev/null

if ! compgen -G "*.json" > /dev/null; then
  echo "No *.json files in ${TEMP_DIR}" && exit 1
fi

for dashboard in *.json; do
  echo "Uploading $(jq .title "${dashboard}") to Grafana"
  curl -X POST -H "Content-Type: application/json" \
       -u admin:admin \
       -d "${dashboard}" \
       -4 --retry 5 --retry-connrefused --retry-delay 5 --fail \
       http://grafana.local:3000/api/dashboards/db || echo "Uploading error"
done
