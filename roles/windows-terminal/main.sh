#!/bin/bash
set -eu

readonly VENV_DIR_NAME=venv

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
        local -r workdir=$(dirname "$0")
        cd "${workdir}"

        if [ ! -e ${VENV_DIR_NAME}/Scripts/activate ]; then
                LOGI "Create new venv"
                python -m venv ${VENV_DIR_NAME}
        fi

        LOGI "Activate venv and install packages"
        . ${VENV_DIR_NAME}/Scripts/activate && python -m pip install -r requirements.txt

        LOGI "Generate config from jinja2 template"
        python -m generate

        LOGI "Deactivate venv"
        deactivate

        local -r copy_from="${workdir}/settings.json"
        local -r copy_to="${HOMEDRIVE}${HOMEPATH}/scoop/apps/windows-terminal/current/settings"

        LOGI "Copy config"
        mkdir -p "${copy_to}"
        cp -p "${copy_from}" "${copy_to}"
}

main "$@"
