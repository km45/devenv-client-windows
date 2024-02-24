#!/bin/bash
set -eu -o pipefail

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

function install_extension() {
        local -r extension_id=$1

        set +e
        code --list-extensions | grep --line-regexp --fixed-strings "${extension_id}" >/dev/null
        local -r ret=$?
        set -e

        case ${ret} in
        0)
                LOGI "Already installed ${extension_id}"
                return
                ;;
        1)
                # break
                ;;
        *)
                LOGE "An unexpected error occurred!"
                exit 1
                ;;
        esac

        LOGI "Install ${extension_id}"
        code --install-extension "${extension_id}"
}

function main() {
        local -r workdir=$(dirname "$0")
        cd "${workdir}"

        LOGI "Install vscode extensions"
        yq .vscode_plugins[] <vscode_extensions.yml | while read -r extension_id; do
                install_extension "${extension_id}"
        done

        if [ ! -e ${VENV_DIR_NAME}/Scripts/activate ]; then
                LOGI "Create new venv"
                python -m venv ${VENV_DIR_NAME}
        fi

        LOGI "Activate venv and install packages"
        . ${VENV_DIR_NAME}/Scripts/activate && python -m pip install -r requirements.txt

        LOGI "Change vscode user settings"
        python -m change_user_settings vscode_extensions.yml

}

main "$@"
