@echo off
title loopback.kr(TM) Windows Autounattend Installation Script
color 1F

start /min taskmgr

echo The Autounattend installation will start soon.
cscript //nologo %1:\sources\sleep.vbs

echo.
echo ============================================================
echo.
echo Setting up disk partitions...
echo.
echo ============================================================
diskpart /s %1:\sources\diskpart.mbr.cfg

echo.
echo ============================================================
echo.
echo Information about Windows image to be installed:
echo.
echo ============================================================
dism /Get-WIMInfo /WIMFile:%1:\sources\install.wim /Index:1

echo.
echo ============================================================
echo.
echo Apply Windows image...
echo.
echo ============================================================
dism /Apply-Image /ImageFile:%1:\sources\install.wim /Index:1 /ApplyDir:W:\

echo.
echo ============================================================
echo.
echo Apply OOBE components...
echo.
echo ============================================================
copy %1:\sources\unattend.xml W:\Windows\Panther\unattend.xml
copy %1:\sources\Professional-x64.cab W:\Windows\Setup\Professional-x64.cab
copy %1:\sources\oemlogo.bmp W:\Windows


echo.
echo ============================================================
echo.
echo Setting up bootloader...
echo.
echo ============================================================
bcdboot W:\windows /l ko-kr /s S: /f BIOS

::echo.
::echo ============================================================
::echo.
::echo The system will be rebooted soon.
::echo.
::echo ============================================================
::color 5F
::cscript //nologo %1:\sources\sleep.vbs
::exit

echo.
echo ============================================================
echo.
echo Windows image extration is complete.
echo Please boot to Local bootloader, not USB or PXE.
echo.
echo ============================================================
color 5F
pause
exit