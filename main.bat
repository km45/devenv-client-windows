@echo off

:Main
setlocal
    set WORKDIR=%~dp0

    REM "Execute setup.bat, update.bat and scoop.sh at first"
    call %WORKDIR%\setup.bat
    call %WORKDIR%\update.bat
    %HOMEDRIVE%%HOMEPATH%\scoop\apps\git-with-openssh\current\usr\bin\bash.exe --login scoop.sh

    REM "Execute the role python at second"
    call %WORKDIR%\roles\python\main.bat

    REM "Execute the other roles."
    call %WORKDIR%\roles\git-bash\main.bat
    %HOMEDRIVE%%HOMEPATH%\scoop\apps\git-with-openssh\current\usr\bin\bash.exe --login %WORKDIR%\roles\vscode\main.sh
    %HOMEDRIVE%%HOMEPATH%\scoop\apps\git-with-openssh\current\usr\bin\bash.exe --login %WORKDIR%\roles\windows-terminal\main.sh

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
