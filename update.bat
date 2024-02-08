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
echo "                  Addon Version: 0.8.9                         ";
echo "  ______   ______   ______   ______   ______   ______   ______ ";
echo " /_____/  /_____/  /_____/  /_____/  /_____/  /_____/  /_____/ ";
:: Set environment variables for source and destination paths
set "sourceFile=Extras-Addon.lua"
set "destinationFolder=%APPDATA%\YimMenu\scripts"

echo "Checking to see if there is an existing version of the Addon"
if exist "%destinationFolder%\%sourceFile%" (
    del "%destinationFolder%\%sourceFile%"
    echo "Found Existing Version, Deleting..."
) else (
    echo "No existing version was found."
)

echo "Copying new version of Extras-Addon.lua to the YimMenu scripts folder."
copy "%sourceFile%" "%destinationFolder%"

if errorlevel 1 (
    echo "Error: Failed to copy Addon. Check the source path or destination permissions."
) else (
    echo "Addon copied successfully.  Copy Path: %destinationFolder%\%sourceFile%"
)

pause
