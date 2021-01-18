#!/bin/bash
set -eu

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
