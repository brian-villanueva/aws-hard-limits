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

if [ -z "$SERVICE_CODE" ];
  echo "No service code given. Retry with --service-code argument."
  exit 1
fi

GITHUB_SOURCE="https://raw.githubusercontent.com/brian-villanueva/aws-hard-limits/master/aws-services/${SERVICE_CODE}.json"

if [ -z "${QUOTA_CODE}" ];
  curl -s "${GITHUB_SOURCE}"
else
  echo "TODO: select matching quota code"
  #curl -s "${GITHUB_SOURCE}" | jq  ...
fi