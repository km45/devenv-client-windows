@echo off

:Main
setlocal
    if "%1" == "" (
        exit /b 1
    )

    where scoop > nul 2> nul
    if %ERRORLEVEL% == 1 (
        call :LogError "You must install scoop. https://github.com/lukesampson/scoop"
        exit /b
    )

    call :UpdateScoop
    call :UpdateInstalledPackages

    call :AddBucket "extras"
    call :AddBucket "versions"

    call :InstallPackage "git-with-openssh"
    git config --global core.autocrlf false

    call :InstallPackage "aria2"

    REM "install packages depending on mode"
    if %1 == 1 (
        for %%p in ("cryptomator" ^
                    "flac" ^
                    "libreoffice-fresh" ) do (
            call :InstallPackage %%p
        )
    ) else if %1 == 2 (
        for %%p in ("cmake" ^
                    "winscp" ) do (
            call :InstallPackage %%p
        )
    ) else (
        call :LogError "invalid mode specified"
        exit /b 1
    )

    REM "install common packages"
    for %%p in ("consolez" ^
                "firefox-esr" ^
                "gimp" ^
                "jq" ^
                "make" ^
                "peazip" ^
                "python37" ^
                "shellcheck" ^
                "terminus" ^
                "vagrant" ^
                "vscode-portable" ^
                "winmerge" ) do (
        call :InstallPackage %%p
    )

    exit /b
endlocal

:UpdateScoop
setlocal
    call :LogInfo "Update scoop"
    call scoop update
    exit /b
endlocal

:UpdateInstalledPackages
setlocal
    call :LogInfo "Update installed packages"
    call scoop update *
    exit /b
endlocal

:AddBucket
setlocal
    set BUCKET_NAME=%1

    scoop bucket list | find %BUCKET_NAME% > nul
    if %ERRORLEVEL% == 0 (
        call :LogDebug "Already added" %BUCKET_NAME%
        exit /b
    )

    call :LogInfo "Add bucket" %BUCKET_NAME%
    scoop bucket add %BUCKET_NAME%
    exit /b
endlocal

:InstallPackage
setlocal
    set PACKAGE_NAME=%~1

    scoop list | find " %PACKAGE_NAME% " > nul
    if %ERRORLEVEL% == 0 (
        call :LogDebug "Already installed" %PACKAGE_NAME%
        exit /b
    )

    call :LogInfo "Install" %PACKAGE_NAME%
    call scoop install %PACKAGE_NAME%

    exit /b
endlocal

:LogDebug
setlocal
    call :LogImpl D %*
    exit /b
endlocal

:LogInfo
setlocal
    call :LogImpl I %*
    exit /b
endlocal

:LogError
setlocal
    call :LogImpl E %*
    exit /b
endlocal

:LogImpl
setlocal
    set /p NOP=%date% < nul
    set /p NOP=%time% < nul
    for %%s in (%*) do (
        set /p NOP=%%~s < nul
    )
    echo;
    exit /b
endlocal
