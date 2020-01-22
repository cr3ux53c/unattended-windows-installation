::Initialize Environment
@echo off
title loopback.kr(TM) Windows Autounattend Script 2020
color 1F

start /min taskmgr
echo.
echo ============================================================
echo.
echo Setting up disk partitions...
echo.
echo ============================================================
diskpart /s N:\diskpart.gpt.cfg

echo.
echo ============================================================
echo.
echo Information about Windows image to be installed:
echo.
echo ============================================================
dism /Get-WIMInfo /WIMFile:N:\install.wim /Index:1

echo.
echo ============================================================
echo.
echo Apply Windows image...
echo.
echo ============================================================
dism /Apply-Image /ImageFile:N:\install.wim /Index:1 /ApplyDir:W:\

echo.
echo ============================================================
echo.
echo Setting up bootloader...
echo.
echo ============================================================
bcdboot W:\windows /l ko-kr /s S: