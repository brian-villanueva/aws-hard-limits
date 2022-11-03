#!/bin/bash

SERVICE_CODE=''
QUOTA_CODE=''

parse_args() {
    case "$1" in
        --service-code)
            SERVICE_CODE="$2"
            ;;
        --quota-code)
            QUOTA_CODE="$2"
            ;;
        *)
            echo "Unknown or badly placed parameter '$1'." 1>&2
            exit 1
            ;;
    esac
}

while [[ "$#" -ge 2 ]]; do
    parse_args "$1" "$2"
    shift; shift
done

if [ -z "$SERVICE_CODE" ]; then
  echo "No service code given. Retry with --service-code argument."
  exit 1
fi

GITHUB_SOURCE="https://raw.githubusercontent.com/brian-villanueva/aws-hard-limits/master/aws-services/${SERVICE_CODE}.json"

if curl --output /dev/null --silent --head --fail "${GITHUB_SOURCE}"; then

  if [ -z "${QUOTA_CODE}" ]; then
    curl -s "${GITHUB_SOURCE}" | jq
  else
    curl -s "${GITHUB_SOURCE}" | jq --arg qc "${QUOTA_CODE}" '.[] | select(.QuotaCode == $qc)'
  fi

else
  echo "Unsupported service code: ${SERVICE_CODE}"
  exit 1
fi