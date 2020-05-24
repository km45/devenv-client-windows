@echo off

:Main
setlocal
    set WORKDIR=%~dp0

    if "%1" == "" (
        call :LogError "You must specify mode as argument-1."
        exit /b 1
    )

    REM "Execute the role scoop at first"
    call %WORKDIR%\roles\scoop\main.bat %1
    if %ERRORLEVEL% == 1 (
        exit /b
    )

    REM "Execute the role python at second"
    call %WORKDIR%\roles\python\main.bat

    REM "Execute the other roles."
    call %WORKDIR%\roles\consolez\main.bat
    call %WORKDIR%\roles\terminus\main.bat
    call %WORKDIR%\roles\vscode\main.bat

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
