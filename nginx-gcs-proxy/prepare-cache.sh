#!/bin/sh
set -eu

case "${CACHE_PATH}" in
    ""|"/")
        echo >&2 "CACHE_PATH must be an absolute directory other than /"
        exit 1
        ;;
    *[!A-Za-z0-9_./-]*)
        echo >&2 "CACHE_PATH contains unsupported characters: ${CACHE_PATH}"
        exit 1
        ;;
    /*)
        ;;
    *)
        echo >&2 "CACHE_PATH must be an absolute directory: ${CACHE_PATH}"
        exit 1
        ;;
esac

if ! printf '%s\n' "${CACHE_VALIDITY}" \
    | grep -Eq '^[1-9][0-9]*(ms|s|m|h|d|w|M|y)$'; then
    echo >&2 "CACHE_VALIDITY must be a positive Nginx time value, for example 12h, 7d, or 3M"
    exit 1
fi

if ! printf '%s\n' "${CACHE_MAX_SIZE}" \
    | grep -Eq '^[1-9][0-9]*[kKmMgG]?$'; then
    echo >&2 "CACHE_MAX_SIZE must be a positive Nginx size value, for example 512M, 30G, or 100g"
    exit 1
fi

mkdir -p "${CACHE_PATH}"
chown nginx:nginx "${CACHE_PATH}"
