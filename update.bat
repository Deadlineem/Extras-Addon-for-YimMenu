@ECHO OFF

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
echo "                  Addon Version: 0.9.5                         "
echo "  ______   ______   ______   ______   ______   ______   ______ "
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ "

:: Set environment variables for source and destination paths
set "destinationFolder=%APPDATA%\YimMenu\scripts"
set "destinationFolder2=%USERPROFILE%\Downloadsz"
set "destinationFolder3=%USERPROFILE%\Downloadsz"
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
echo 	  and tools you may want/need to use YimMenu itself.
echo ------------------------------------------------------------------
echo ------------------------------------------------------------------
echo 			Main Menu
echo ------------------------------------------------------------------
echo Choose an option:
echo 1. Download Extras Addon (To Appdata\YimMenu\scripts)
echo 2. Download YimMenu (To Downloads Folder)
echo 3. Download FateInjector (To Downloads Folder)
echo 4. How to install/use YimMenu
echo 5. Exit the application

choice /c 12345 /n
if errorlevel 5 goto goodbye
if errorlevel 4 goto instructions
if errorlevel 3 goto download_fate_injector
if errorlevel 2 goto download_yimmenu
if errorlevel 1 goto check_yimmenu

:check_yimmenu
    set /p yn=Have you downloaded/used YimMenu before? (Y/N): 
    if /i "%yn%"=="Y" (
        goto download_extras_addon
    ) else (
		cls
        echo "Please download and use YimMenu first before installing the Extras Addon."
        echo "After using YimMenu, you can come back and install the Extras Addon."
        echo "to use YimMenu, download an injector like FateInjector, Xenos or ProcessHacker2."
		echo ------------------------------------------------------------------
		echo "When running YimMenu for the first time, click Update Cache and load into story mode or online."
		echo "If you don't know how to use YimMenu, press 4 on the main menu for instructions"
		echo ------------------------------------------------------------------
		echo "Returning to the main menu in 15 seconds."
		timeout /t 15 /nobreak >nul
		cls
		goto menu
    )
:download_extras_addon
	cls
	echo ------------------------------------------------------------------
	echo 	Downloading Extras Addon from the repository
	echo ------------------------------------------------------------------
	echo "Checking to see if there is an existing version of Extras Addon"
	if exist "%destinationFolder%\Extras-Addon.lua" (
		echo "Found Existing Version, Deleting..."
		del "%destinationFolder%\Extras-Addon.lua"
	) else (
		echo "No existing version was found."
	)

	echo "Downloading new version of Extras-Addon.lua from the repository..."
	set "url=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/Extras-Addon.lua"
	powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%destinationFolder%\Extras-Addon.lua' }"

	if not exist "%destinationFolder%\Extras-Addon.lua" (
		echo "Error: Failed to download Addon. Check the internet connection or the source URL."
	) else (
		echo "Extras Addon downloaded successfully. File Location: %destinationFolder%\Extras-Addon.lua"
		echo "Returning to the main menu in 10 seconds."
	)
	timeout /t 10 /nobreak >nul
	cls
	goto menu
	
:download_yimmenu
cls
echo ------------------------------------------------------------------
echo 	Downloading YimMenu from the repository
echo ------------------------------------------------------------------
echo "Checking to see if there is an existing version of YimMenu"
if exist "%destinationFolder2%\YimMenu.dll" (
    del "%destinationFolder2%\YimMenu.dll"
    echo "Found Existing YimMenu.dll, Deleting..."
) else (
    echo "No existing version was found."
)

echo "Downloading new version of YimMenu.dll from the repository..."
set "url2=https://github.com/YimMenu/YimMenu/releases/download/nightly/YimMenu.dll"
powershell -command "& { Invoke-WebRequest -Uri '%url2%' -OutFile '%destinationFolder2%\YimMenu.dll' }"

if not exist "%destinationFolder2%\YimMenu.dll" (
    echo "Error: Failed to download YimMenu. Check the internet connection or the source URL."
) else (
    echo "YimMenu downloaded successfully. File Location: %destinationFolder2%\YimMenu.dll"
    echo "Returning to the main menu in 10 seconds."
)
timeout /t 10 /nobreak >nul
cls
goto menu

:exit
echo Exiting...
exit /b

:download_fate_injector
cls
echo ------------------------------------------------------------------
echo 	Downloading FateInjector from the repository
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
    echo "Returning to the main menu in 10 seconds."
)
timeout /t 10 /nobreak >nul
cls
goto menu

:instructions
cls
echo ------------------------------------------------------------------
echo 		How to Install/Use YimMenu
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
