#!/bin/bash
set -eu -o pipefail

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

readonly SETTINGS_JSON_BASE_FILE_PATH='settings_base.json'
readonly SETTINGS_JSON_GENERATED_PATH='settings.json'

function generate_settings() {
        LOGD "Generate settings.json to put"
        # NOTE: Add dynamic values if necessary (like jq '.foo|="bar"')
        jq --indent 4 . <${SETTINGS_JSON_BASE_FILE_PATH} >${SETTINGS_JSON_GENERATED_PATH}
}

function main() {
        local -r workdir=$(dirname "$0")
        cd "${workdir}"

        LOGI "Install vscode extensions"
        yq .vscode_plugins[] <vscode_extensions.yml | while read -r extension_id; do
                install_extension "${extension_id}"
        done

        LOGI "Change vscode user settings"
        generate_settings
        LOGD "Put settings.json"
        cp -pv ${SETTINGS_JSON_GENERATED_PATH} ~/scoop/apps/vscode/current/data/user-data/User/settings.json

}

main "$@"
