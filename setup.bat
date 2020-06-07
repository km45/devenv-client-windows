@echo off

:Main
setlocal
    where scoop > nul 2> nul
    if %ERRORLEVEL% == 1 (
        call :LogError "You must install scoop. https://github.com/lukesampson/scoop"
        exit /b
    )

    call :InstallPackage "git-with-openssh"
    call :InstallPackage "aria2"

    exit /b
endlocal

:InstallPackage
setlocal
    set PACKAGE_NAME=%~1

    scoop list | find " %PACKAGE_NAME% " > nul
    if %ERRORLEVEL% == 0 (
        call :LogDebug "Already installed" %PACKAGE_NAME%
    ) else (
        call :LogInfo "Install" %PACKAGE_NAME%
        call scoop install %PACKAGE_NAME%
    )

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
