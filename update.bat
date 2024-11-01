@ECHO OFF

:: Set environment variables
set "scriptFolder=%~dp0"
set "updateScriptUrl=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/update.bat"

:: Check for updates
echo Checking Repository for updates to update.bat...
powershell -command "& { Invoke-WebRequest -Uri '%updateScriptUrl%' -OutFile '%scriptFolder%update.bat.new' }"

:: Compare the current script with the updated version
fc "%scriptFolder%update.bat.new" "%scriptFolder%update.bat" >nul
if errorlevel 1 (
    echo Update found! Updating your update.bat to the latest version...
    move /y "%scriptFolder%update.bat.new" "%scriptFolder%update.bat" >nul
    echo Script updated successfully!
    echo "Returning to the main menu in 5 seconds."
    timeout /t 5 /nobreak >nul
) else (
    echo No updates found.
    del "%scriptFolder%update.bat.new" >nul
    echo "Returning to the main menu in 5 seconds."
    timeout /t 5 /nobreak >nul
)
:: Continue with the main script
goto menu

:menu
echo "  ______   ______   ______   ______   ______   ______   ______ "
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ "
echo "                                                               "
echo "                                                               "
echo "        ___________         __                                 "
echo "        \_   _____/__  ____/  |_____________    ______         "
echo "         |    __)_\  \/  /\   __\_  __ \__  \  /  ___/         "
echo "         |        \>    <  |  |  |  | \// __ \_\___ \          "
echo "        /_______  /__/\_ \ |__|  |__|  (____  /____  >         "
echo "                \/      \/                  \/     \/          "
echo "             _____       .___  .___                            "
echo "            /  _  \    __| _/__| _/____   ____                 "
echo "           /  /_\  \  / __ |/ __ |/  _ \ /    \                "
echo "          /    |    \/ /_/ / /_/ (  <_> )   |  \               "
echo "          \____|__  /\____ \____ |\____/|___|  /               "
echo "                  \/      \/    \/           \/                "
echo "                                                               "
echo "                Extras Addon for YimMenu                       "
echo "                  Addon Version: 1.0.9                         "
echo "    https://github.com/Deadlineem/Extras-Addon-for-YimMenu     "
echo "            http://extrasaddon.us.to/                          "
echo "  ______   ______   ______   ______   ______   ______   ______ "
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ "

:: Set environment variables for source and destination paths
set "destinationFolder=%APPDATA%\YimMenu\scripts"
set "destinationFolder2=%USERPROFILE%\Downloads"
set "destinationFolder3=%USERPROFILE%\Downloads"
if not exist "%destinationFolder2%" (
    set "destinationFolder2=%USERPROFILE%\OneDrive\Desktop"
)
:: If Downloads folder does not exist default to onedrive desktop
if not exist "%destinationFolder3%" (
    set "destinationFolder3=%USERPROFILE%\OneDrive\Desktop"
)
:: If Onedrive destination does not exist, default to normal Desktop
if not exist "%destinationFolder2%" (
    set "destinationFolder2=%USERPROFILE%\Desktop"
)
if not exist "%destinationFolder3%" (
    set "destinationFolder3=%USERPROFILE%\Desktop"
)
echo ------------------------------------------------------------------
echo   This app is for easily Downloading/Updating Yim/Extras Addon
echo       and tools you may want/need for YimMenu itself.
echo ------------------------------------------------------------------
echo ------------------------------------------------------------------
echo             Main Menu
echo ------------------------------------------------------------------
echo Choose an option:
echo 1. Download YimMenu (To Downloads or Desktop)
echo 2. Download Extras Addon (To YimMenu\scripts)
echo 3. Download FateInjector (To Downloads or Desktop)
echo 4. Delete YimMenu Cache Folder (Quick fix when GTA updates)
echo 5. Optional Downloads (XML's, Animations, ASI Loader, ScriptHookV, Vehicles and Outfits)
echo 6. How to install/use YimMenu
echo 7. Exit the application
echo ------------------------------------------------------------------
echo If your downloads folder is not in the proper location on your
echo harddrive, the downloads will default to your desktop, instead.

choice /c 1234567 /n
if errorlevel 7 goto goodbye
if errorlevel 6 goto instructions
if errorlevel 5 goto optional_downloads
if errorlevel 4 goto delete_cache_folder
if errorlevel 3 goto download_fate_injector
if errorlevel 2 goto download_extras_addon
if errorlevel 1 goto download_yimmenu

:download_yimmenu
cls
echo ------------------------------------------------------------------
echo     Downloading YimMenu from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of YimMenu"
del "%destinationFolder2%\YimMenu.dll" >nul 2>&1

echo "Downloading new version of YimMenu.dll from the repository..."
set "url2=https://github.com/Mr-X-GTA/YimMenu/releases/download/nightly/YimMenu.dll"
powershell -command "& { Invoke-WebRequest -Uri '%url2%' -OutFile '%destinationFolder2%\YimMenu.dll' }"

if not exist "%destinationFolder2%\YimMenu.dll" (
    echo "Error: Failed to download YimMenu. Check the internet connection or the source URL."
) else (
    echo "YimMenu downloaded successfully. File Location: %destinationFolder2%\YimMenu.dll"
    echo "Returning to the main menu in 5 seconds."
)
timeout /t 5 /nobreak >nul
cls
goto menu

:download_extras_addon
cls
echo ------------------------------------------------------------------
echo     Downloading Extras Addon from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of Extras Addon"
del "%destinationFolder%\Extras-Addon.lua" >nul 2>&1

echo "Downloading new version of Extras-Addon.lua from the repository..."
set "url=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/Extras-Addon.lua"
set "url2=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/json.lua"
set "url3=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/Extras-data.lua"
powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%destinationFolder%\Extras-Addon.lua' }"
powershell -command "& { Invoke-WebRequest -Uri '%url2%' -OutFile '%destinationFolder%\json.lua' }"
powershell -command "& { Invoke-WebRequest -Uri '%url3%' -OutFile '%destinationFolder%\Extras-data.lua' }"

if not exist "%destinationFolder%\Extras-Addon.lua" (
    echo "Error: Failed to download Addon. Check the internet connection or the source URL."
) else if not exist "%destinationFolder%\json.lua" (
    echo "Error: Failed to download Json. Check the internet connection or the source URL."
) else (
    echo "Extras Addon downloaded successfully. File Location: %destinationFolder%\Extras-Addon.lua"
    echo "Json downloaded successfully. (Required json config file) File Location: %destinationFolder%\json.lua"
    echo "Extras-data downloaded successfully. (Required, stores objects, vehicles, etc.) File Location: %destinationFolder%\json.lua"
    echo "Returning to the main menu in 10 seconds."
)
timeout /t 10 /nobreak >nul
cls
goto menu

:delete_cache_folder
echo "Deleting YimMenu's cache folder, this is ONLY necessary if you've updated YimMenu.dll and you're still crashing."
echo "If this does not fix the issue, check their github issues page at https://github.com/YimMenu/YimMenu/issues"
rmdir /s /q "%APPDATA%\YimMenu\cache"
echo "Cache folder deleted successfully."
echo "Returning to main menu in 10 seconds."
timeout /t 10 /nobreak >nul
goto menu

:download_fate_injector
cls
echo ------------------------------------------------------------------
echo     Downloading FateInjector from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of FateInjector"
if exist "%destinationFolder3%\FateInjector.exe" (
    echo "Found FateInjector, You do not need to download this again."
) else (
    echo "No existing application was found."
)

echo "Downloading FateInjector from the repository..."
set "url3=https://github.com/fligger/FateInjector/releases/download/1.0/FateInjector.exe"
powershell -command "& { Invoke-WebRequest -Uri '%url3%' -OutFile '%destinationFolder3%\FateInjector.exe' }"

if not exist "%destinationFolder3%\FateInjector.exe" (
    echo "Error: Failed to download FateInjector. Check the internet connection or the source URL."
) else (
    echo "FateInjector downloaded successfully. File Location: %destinationFolder3%\FateInjector.exe"
    echo "Returning to the main menu in 5 seconds."
)
timeout /t 5 /nobreak >nul
cls
goto menu

:optional_downloads
cls
echo ------------------------------------------------------------------
echo     Optional Downloads
echo ------------------------------------------------------------------
echo Choose an option:
echo 1. Get XML Maps/Vehicles (Opens in Browser)
echo 2. Download Animations Dictionary (To YimMenu Root Folder)
echo 3. Download Yim Json Vehicles and Outfits (To YimMenu Root Folder)
echo 4. Download YimASI (To Downloads Folder)
echo 5. Download ScriptHookV (To Downloads Folder)
echo 6. Back to Main Menu
echo ------------------------------------------------------------------
echo More optional downloads may be added in the future!

choice /c 123456 /n
if errorlevel 6 goto menu
if errorlevel 5 goto download_scripthookv
if errorlevel 4 goto download_yimasi
if errorlevel 3 goto download_file_3
if errorlevel 2 goto download_file_2
if errorlevel 1 goto download_file_1

:download_file_1
echo Opening MagicModz89's MEGA drive in a browser window...
start "XML Maps" "https://mega.nz/folder/BnM2jQoT#Lb6MG4m24nGv0GkNGsD3sQ"
echo To use these, download the file as zip and extract the corresponding contents to %APPDATA%\YimMenu\xml_maps and xml_vehicles
echo Returning to Optional Downloads Menu
timeout /t 5 /nobreak >nul
goto optional_downloads

:download_file_2
cls
echo ------------------------------------------------------------------
echo     Downloading Animations Dictionary from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of animDictsCompact.json"
del "%APPDATA%\YimMenu\animDictsCompact.json" >nul 2>&1

echo "Downloading new version of animDictsCompact.json from the repository..."
set "url=https://raw.githubusercontent.com/DurtyFree/gta-v-data-dumps/master/animDictsCompact.json"
powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%APPDATA%\YimMenu\animDictsCompact.json' }"

if not exist "%APPDATA%\YimMenu\animDictsCompact.json" (
    echo "Error: Failed to download Animations. Check the internet connection or the source URL."
) else (
    echo "Extras Addon downloaded successfully. File Location: %APPDATA%\YimMenu\animDictsCompact.json"
    echo "Returning to the main menu in 5 seconds."
)
timeout /t 5 /nobreak >nul
cls
goto optional_downloads

:download_file_3
cls
echo ------------------------------------------------------------------
echo     Downloading Yim Json Vehicles and Outfits from the repository
echo ------------------------------------------------------------------
echo "Downloading new vehicles and outfits from the repository..."

:: YimMenu folder
set "yimMenuFolder=%APPDATA%\YimMenu"

:: Yim Json Vehicles and Outfits files manifest
set "vehAndOutfitsManifest=https://raw.githubusercontent.com/juniorkrz/Yim-Json-Vehicles-and-Outfits/master/manifest.json"

:: PowerShell function to recursively download files and folders available in the manifest.
powershell -Command "try { $response = Invoke-WebRequest -Uri '%vehAndOutfitsManifest%' -UseBasicParsing | ConvertFrom-Json; foreach ($item in $response) { $filename = $item.filename; $path = $item.path; $downloadUrl = $item.download_url; $path = $path -replace '^files\\', ''; $outputFilePath = Join-Path -Path '%yimMenuFolder%' -ChildPath \"$path\$filename\"; $outputDirectory = Split-Path $outputFilePath -Parent; if (!(Test-Path -Path $outputDirectory)) { New-Item -ItemType Directory -Force -Path $outputDirectory > $null }; Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFilePath > $null; Write-Host \"File saved in: $outputFilePath\" }} catch { Write-Host \"Error: $_\" }"

echo "Credits: Yim Json Vehicles and Outfits by Juniorkrz & NetoXP"
echo "Returning to the main menu in 5 seconds."
timeout /t 5 /nobreak >nul
cls
goto optional_downloads

:download_yimasi
cls
echo ------------------------------------------------------------------
echo     Downloading YimASI from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of YimASI"
del "%destinationFolder3%\WTSAPI32.dll" >nul 2>&1

echo "Downloading new version of YimASI from the repository..."
set "url=https://github.com/xesdoog/YimASI/releases/download/release/WTSAPI32.dll"
powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%destinationFolder3%\WTSAPI32.dll' }"

if not exist "%destinationFolder3%\WTSAPI32.dll" (
    echo "Error: Failed to download YimASI. Check the internet connection or the source URL."
) else (
    echo "YimASI downloaded successfully. File Location: %destinationFolder3%\WTSAPI32.dll"
    echo "Returning to the main menu in 5 seconds."
)
timeout /t 5 /nobreak >nul
cls
goto optional_downloads

:download_scripthookv
cls
echo ------------------------------------------------------------------
echo     Downloading ScriptHookV from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of ScriptHookV"
del "%destinationFolder3%\ScriptHookV.zip" >nul 2>&1

echo "Downloading new version of ScriptHookV from the repository..."
set "url=https://github.com/scripthookvdotnet/scripthookvdotnet/releases/download/v3.6.0/ScriptHookVDotNet.zip"
powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%destinationFolder3%\ScriptHookV.zip' }"

if not exist "%destinationFolder3%\ScriptHookV.zip" (
    echo "Error: Failed to download ScriptHookV. Check the internet connection or the source URL."
) else (
    echo "ScriptHookV downloaded successfully. File Location: %destinationFolder3%\ScriptHookV.zip"
    echo "Returning to the main menu in 5 seconds."
)
timeout /t 5 /nobreak >nul
cls
goto optional_downloads

:instructions
cls
echo ------------------------------------------------------------------
echo         How to Install/Use YimMenu
echo ------------------------------------------------------------------
echo "1. Start GTA 5 on your PC"
echo "2. Open your preferred injector, and find/select YimMenu.dll"
echo "3. Select the process (gta5.exe) to inject YimMenu into"
echo "4. Once YimMenu is injected open GTA and you should see the menu"
echo "If this is your first time using YimMenu, press Update Cache"
echo "Press the Insert key to open/close the menu"
echo "Go to Settings > GUI and uncheck Show Overlay to show/hide Yim"
timeout /t 10 /nobreak >nul
echo "Exiting to the main menu in 10 seconds."
timeout /t 10 /nobreak >nul
cls
goto menu

:goodbye
echo "Thank you for using Extras Addon!  Brought to you by DeadlineEm, USBMenus & KAOS Incorporated"
echo "Exiting in 3 seconds."
timeout /t 3 /nobreak >nul
exit
