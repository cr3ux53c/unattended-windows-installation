@echo off

:: Set Installation Environment
set filePriority=wim esd swm
set isUEFI=1
set diskpartCfg=32
set pauseWhenFinished=1
set index=1

:START_SET_ENVVAR
for %%ext in (%filePriority%) do (
    if exist %1:\sources\install.%%ext (
        set installFileName=install.%%ext
        goto BREAK_FOR
    )
)
:BREAK_FOR
if %isUEFI%=="0" (
    set systemMode=mbr
) else (
    set systemMode=gpt
)
set diskpartCfgFile=diskpart.%diskpartCfg%.%systemMode%.cfg
:END_SET_ENVVAR

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
diskpart /s %1:\sources\%diskpartCfgFile%

echo.
echo ============================================================
echo.
echo Information about Windows image to be installed:
echo.
echo ============================================================


dism /Get-WIMInfo /WIMFile:%1:\sources\%installFileName% /Index:%index%

echo.
echo ============================================================
echo.
echo Apply Windows image...
echo.
echo ============================================================
if %installFileName%=="install.swm" (
    dism /Apply-Image /ImageFile:%1:\sources\%installFileName% /SWMFile:install*.swm /Index:%index% /ApplyDir:W:\
) else (
    dism /Apply-Image /ImageFile:%1:\sources\%installFileName% /Index:%index% /ApplyDir:W:\
)

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
if %isUEFI%=="0" (
    bcdboot W:\windows /l ko-kr /s S: /f BIOS
) else (
    bcdboot W:\windows /l ko-kr /s S: /f UEFI
)

if %pauseWhenFinished%=="0" (
    echo.
    echo ============================================================
    echo.
    echo The system will be rebooted soon.
    echo.
    echo ============================================================
    color 5F
    cscript //nologo %1:\sources\sleep.vbs
) else (
    echo.
    echo ============================================================
    echo.
    echo Windows image extration is complete.
    echo Please boot to Local bootloader, not USB or PXE.
    echo.
    echo ============================================================
    color 5F
    pause
)
exit