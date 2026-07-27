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

mkdir -p "${CACHE_PATH}"
chown nginx:nginx "${CACHE_PATH}"
