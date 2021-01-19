#!/bin/bash
set -eu

function LOG_impl() {
    local -r loglevel=$1
    local -r messages=${*:2}
    local -r timestamp=$(date +'%Y/%m/%d %H:%M:%S.%3N')
    echo "[${timestamp}] ${loglevel} ${messages}"
}

function LOGI() {
    local -r messages=$*
    local -r LEVEL='I'
    LOG_impl ${LEVEL} "${messages}"
}

function main() {
    LOGI "Rewrite Cryptomator.cfg to avoid problem"
    sed -i '/^java-options=-Dfile.encoding=utf-8$/d' "${HOME}/scoop/apps/cryptomator/current/app/Cryptomator.cfg"
}

main "$@"
