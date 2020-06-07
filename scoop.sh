#!/bin/bash
set -eu

function LOG_impl() {
    local -r loglevel=$1
    local -r messages=${*:2}
    local -r timestamp=$(date +'%Y/%m/%d %H:%M:%S.%3N')
    echo "[${timestamp}] ${loglevel} ${messages}"
}

function LOGD() {
    local -r messages=$*
    local -r LEVEL='D'
    LOG_impl ${LEVEL} "${messages}"
}

function LOGI() {
    local -r messages=$*
    local -r LEVEL='I'
    LOG_impl ${LEVEL} "${messages}"
}

function LOGE() {
    local -r messages=$*
    local -r LEVEL='E'
    LOG_impl ${LEVEL} "${messages}"
}

function update_scoop() {
    LOGI "Update scoop"
    scoop update
}

function update_installed_packages() {
    LOGI "Update installed packages"
    scoop update '*'
}

function add_bucket() {
    local -r bucket_name=$1

    local exists=0
    set +e
    scoop bucket list | grep "${bucket_name}" > /dev/null
    exists=$?
    set -e

    if [ ${exists} -eq 0 ]; then
        LOGD "Already added ${bucket_name}"
        return
    fi

    LOGI "Add bucket ${bucket_name}"
    scoop bucket add "${bucket_name}"
}

function install_package() {
    local -r package_name=$1

    local exists=0
    set +e
    scoop list | grep "${package_name}" > /dev/null
    exists=$?
    set -e

    if [ ${exists} -eq 0 ]; then
        LOGD "Already installed ${package_name}"
        return
    fi

    LOGI "Install ${package_name}"
    scoop install "${package_name}"
}

function main() {
    local mode=$1

    update_scoop
    update_installed_packages

    add_bucket "extras"
    add_bucket "versions"

    git config --global core.autocrlf false

    local packages=(\
        "consolez" \
        "gimp" \
        "jq" \
        "make" \
        "peazip" \
        "python37" \
        "shellcheck" \
        "terminus" \
        "vagrant" \
        "vscode-portable" \
        "winmerge" \
    )

    case ${mode} in
        "1" )
            packages+=(\
                "cryptomator" \
                "flac" \
                "libreoffice-fresh" \
            )
            ;;
        "2" )
            packages+=(\
                "cmake" \
                "winscp" \
            )
            ;;
        "3" )
            packages+=(\
                "firefox-esr" \
            )
            ;;
        * )
            LOGE "Invalid mode specified (mode=${mode})"
            return 1
            ;;
    esac

    for package in "${packages[@]}"; do
        install_package "${package}"
    done
}

main "$@"
