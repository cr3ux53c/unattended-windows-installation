@call X:\sources\header.cmd
wpeinit
diskpart /s X:\sources\diskpart.txt
for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W Z) do (
    if exist %%a:\CDUsb.y (
        set strDestDrive=%%a
    )
)
dism /Apply-Image /ImageFile:%strDestDrive%:\sources\install.esd /Index:1 /ApplyDir:W:\
bcdboot W:\windows /l ko-kr /s S: