@echo off
set "url=https://raw.githubusercontent.com/Deadlineem/Extras-Addon-for-YimMenu/main/Extras-Addon.lua"
set "output=%APPDATA%\YimMenu\scripts\Extras-Addon.lua"

powershell -command "& { Invoke-WebRequest -Uri '%url%' -OutFile '%output%' }"