@echo off
chcp 65001 >nul

set "ROOT=%~dp0..\"
set "BIN=%ROOT%bin\"

if not exist "%BIN%" (
    mkdir "%BIN%"
)

echo [bin] Обновление файлов из zapret-win-bundle/zapret-winws...
echo.

call :download_file "https://github.com/bol-van/zapret-win-bundle/raw/refs/heads/master/zapret-winws/winws.exe" "%BIN%winws.exe" "winws.exe"
call :download_file "https://github.com/bol-van/zapret-win-bundle/raw/refs/heads/master/zapret-winws/WinDivert.dll" "%BIN%WinDivert.dll" "WinDivert.dll"
call :download_file "https://github.com/bol-van/zapret-win-bundle/raw/refs/heads/master/zapret-winws/WinDivert64.sys" "%BIN%WinDivert64.sys" "WinDivert64.sys"
call :download_file "https://github.com/bol-van/zapret-win-bundle/raw/refs/heads/master/zapret-winws/cygwin1.dll" "%BIN%cygwin1.dll" "cygwin1.dll"

echo.
echo [bin] Готово.
pause
exit /b 0


:download_file
set "DF_URL=%~1"
set "DF_DEST=%~2"
set "DF_NAME=%~3"
set "DF_TEMP=%DF_DEST%.tmp"

echo [bin] Загружаем %DF_NAME%...

if exist "%SystemRoot%\System32\curl.exe" (
    curl -L -o "%DF_TEMP%" "%DF_URL%"
) else (
    powershell -NoProfile -Command ^
        "$url = '%DF_URL%';" ^
        "$out = '%DF_TEMP%';" ^
        "$dir = Split-Path -Parent $out;" ^
        "if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null };" ^
        "$data = Invoke-WebRequest -Uri $url -TimeoutSec 30 -UseBasicParsing;" ^
        "[System.IO.File]::WriteAllBytes($out, $data.Content)"
)

if not exist "%DF_TEMP%" (
    echo [bin] ОШИБКА: не удалось скачать %DF_NAME% из %DF_URL%.
    exit /b 1
)

for %%S in ("%DF_TEMP%") do if %%~zS LEQ 0 (
    echo [bin] ОШИБКА: загруженный %DF_NAME% пустой. Предыдущая версия не тронута.
    del /f /q "%DF_TEMP%" >nul 2>&1
    exit /b 1
)

move /Y "%DF_TEMP%" "%DF_DEST%" >nul
echo [bin] %DF_NAME% успешно загружен.

exit /b 0

