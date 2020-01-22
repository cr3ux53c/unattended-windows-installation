@echo off
echo Initializing USB Device...
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W Z) do (
    if exist %%i:\CDUsb.y (
        set driveLetterUSB=%%i
    )
)
echo Load Auto unattend script...
start /b /wait %driveLetterUSB%:\autounattend.cmd %driveLetterUSB%
exit