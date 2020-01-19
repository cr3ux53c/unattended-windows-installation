@call X:\sources\header.cmd
wpeinit
set /p server_ip=Input WDS Server IP address: 
net use N: \\%server_ip%\PXEShare
diskpart /s X:\sources\diskpart.txt
dism /Apply-Image /ImageFile:N:\install.esd /Index:1 /ApplyDir:W:\
bcdboot W:\windows /l ko-kr /s S: