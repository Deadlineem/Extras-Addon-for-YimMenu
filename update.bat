@ECHO OFF

echo "  ______   ______   ______   ______   ______   ______   ______ ";
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ ";
echo "                                                               ";
echo "                                                               ";
echo "        ___________         __                                 ";
echo "        \_   _____/__  ____/  |_____________    ______         ";
echo "         |    __)_\  \/  /\   __\_  __ \__  \  /  ___/         ";
echo "         |        \>    <  |  |  |  | \// __ \_\___ \          ";
echo "        /_______  /__/\_ \ |__|  |__|  (____  /____  >         ";
echo "                \/      \/                  \/     \/          ";
echo "             _____       .___  .___                            ";
echo "            /  _  \    __| _/__| _/____   ____                 ";
echo "           /  /_\  \  / __ |/ __ |/  _ \ /    \                ";
echo "          /    |    \/ /_/ / /_/ (  <_> )   |  \               ";
echo "          \____|__  /\____ \____ |\____/|___|  /               ";
echo "                  \/      \/    \/           \/                ";
echo "                                                               ";
echo "                Extras Addon for YimMenu                       ";
echo "                  Addon Version: 0.9.4                         ";
echo "  ______   ______   ______   ______   ______   ______   ______ ";
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ ";
:: Set environment variables for source and destination paths
set "destinationFolder=%APPDATA%\YimMenu\scripts"

echo "Checking to see if there is an existing version of the Addon"
if exist "%destinationFolder%\Extras-Addon.lua" (
    del "%destinationFolder%\Extras-Addon.lua"
    echo "Found Existing Version, Deleting..."
) else (
    echo "No existing version was found."
)

echo "Downloading new version of Extras-Addon.lua..."
set "url=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/Extras-Addon.lua"
powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%destinationFolder%\Extras-Addon.lua' }"

if not exist "%destinationFolder%\Extras-Addon.lua" (
    echo "Error: Failed to download Addon. Check the internet connection or the source URL."
) else (
    echo "Addon downloaded successfully. Path: %destinationFolder%\Extras-Addon.lua"
)

pause
