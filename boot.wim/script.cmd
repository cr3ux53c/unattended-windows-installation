@echo off
echo Initializing USB Device...
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W Z) do (
    if exist %%i:\CDUsb.y (
        set driveLetterUSB=%%i
        goto USBBoot
    )
)
goto PXEBoot

:PXEBoot
echo Initializing network environment...
wpeinit
echo Gathering PXE Server IP address...
cscript //nologo X:\sources\wds_server_ip.vbs > X:\Windows\wds_server_ip.log
set /p serverIpAddress=<X:\Windows\wds_server_ip.log
echo Connecting to PXE Server network directory...
net use N: \\%serverIpAddress%\PXEShare /user:WDSUser 6dEYN2HTvJ63xqkS
echo Load WDS script...
start /b /wait N:\autounattend.cmd
exit

:USBBoot
echo Load Autounattend script...
start /b /wait %driveLetterUSB%:\autounattend.cmd %driveLetterUSB%
exit