@echo off

:Main
setlocal
    set WORKDIR=%~dp0

    if "%1" == "" (
        call :LogError "You must specify mode as argument-1."
        exit /b 1
    )

    REM "Execute setup.bat, update.bat and scoop.sh at first"
    call %WORKDIR%\setup.bat
    call %WORKDIR%\update.bat
    %HOMEDRIVE%%HOMEPATH%\scoop\apps\git-with-openssh\current\usr\bin\bash.exe --login scoop.sh %1

    REM "Execute the role python at second"
    call %WORKDIR%\roles\python\main.bat

    REM "Execute the other roles."
    call %WORKDIR%\roles\terminus\main.bat
    call %WORKDIR%\roles\vscode\main.bat
    call %WORKDIR%\roles\windows-terminal\main.bat

    REM "Execute optional roles."
    if "%1" == "1" (
        %HOMEDRIVE%%HOMEPATH%\scoop\apps\git-with-openssh\current\usr\bin\bash.exe --login roles\cryptomator\main.sh
    )

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
