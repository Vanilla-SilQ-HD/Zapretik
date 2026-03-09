@echo off
chcp 65001 >nul

set "ROOT=%~dp0..\\"
set "LISTS=%ROOT%lists\\"
set "RULIST_HOSTS_URL=https://raw.githubusercontent.com/bol-van/rulist/refs/heads/main/reestr_hostname.txt"
set "RULIST_IPSET_URL=https://raw.githubusercontent.com/bol-van/rulist/refs/heads/main/reestr_smart4.txt"

if /I "%~1"=="hosts" goto update_hosts
if /I "%~1"=="ipset" goto update_ipset

echo Usage:
echo   update-rulist-lists.bat hosts ^| ipset
pause
exit /b 1


:ensure_lists_dir
if not exist "%LISTS%" (
    mkdir "%LISTS%"
)
exit /b 0


:update_hosts
call :ensure_lists_dir
set "TARGET=%LISTS%list-general.txt"
set "TEMP=%TARGET%.tmp"

echo [rulist] Updating list-general.txt from bol-van/rulist...
echo Source: %RULIST_HOSTS_URL%

if exist "%SystemRoot%\System32\curl.exe" (
    curl -L -o "%TEMP%" "%RULIST_HOSTS_URL%"
) else (
    powershell -NoProfile -Command ^
        "$url = '%RULIST_HOSTS_URL%';" ^
        "$out = '%TEMP%';" ^
        "$dir = Split-Path -Parent $out;" ^
        "if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null };" ^
        "$res = Invoke-WebRequest -Uri $url -TimeoutSec 20 -UseBasicParsing;" ^
        "if ($res.StatusCode -eq 200) { $res.Content | Out-File -FilePath $out -Encoding UTF8 } else { exit 1 }"
)

if not exist "%TEMP%" (
    echo [ERROR] Failed to download list-general.txt from rulist.
    pause
    exit /b 1
)

for %%S in ("%TEMP%") do if %%~zS LEQ 0 (
    echo [ERROR] Downloaded list-general.txt is empty. Keeping previous version.
    del /f /q "%TEMP%" >nul 2>&1
    pause
    exit /b 1
)

move /Y "%TEMP%" "%TARGET%" >nul

>>"%TARGET%" (
    echo encryptedsni.com
    echo adblockplus.org
)

echo [OK] list-general.txt updated from rulist.
pause
exit /b 0


:update_ipset
call :ensure_lists_dir
set "TARGET=%LISTS%ipset-all.txt"
set "TEMP=%TARGET%.tmp"

echo [rulist] Updating ipset-all.txt from bol-van/rulist...
echo This will REPLACE current ipset-all.txt with Roskomnadzor registry ranges.
echo Source: %RULIST_IPSET_URL%

if exist "%SystemRoot%\System32\curl.exe" (
    curl -L -o "%TEMP%" "%RULIST_IPSET_URL%"
) else (
    powershell -NoProfile -Command ^
        "$url = '%RULIST_IPSET_URL%';" ^
        "$out = '%TEMP%';" ^
        "$dir = Split-Path -Parent $out;" ^
        "if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null };" ^
        "$res = Invoke-WebRequest -Uri $url -TimeoutSec 20 -UseBasicParsing;" ^
        "if ($res.StatusCode -eq 200) { $res.Content | Out-File -FilePath $out -Encoding UTF8 } else { exit 1 }"
)

if not exist "%TEMP%" (
    echo [ERROR] Failed to download ipset-all.txt from rulist.
    pause
    exit /b 1
)

for %%S in ("%TEMP%") do if %%~zS LEQ 0 (
    echo [ERROR] Downloaded ipset-all.txt is empty. Keeping previous version.
    del /f /q "%TEMP%" >nul 2>&1
    pause
    exit /b 1
)

move /Y "%TEMP%" "%TARGET%" >nul

echo [OK] ipset-all.txt updated from rulist.
pause
exit /b 0

