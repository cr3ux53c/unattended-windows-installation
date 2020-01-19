@call X:\sources\header.cmd
wpeinit
set /p server_ip=Input WDS Server IP address: 
net use N: \\%server_ip%\PXEShare
start taskmgr.exe
diskpart /s X:\sources\diskpart.txt
dism /Get-WIMInfo /WIMFile:N:\install.esd /Index:1
dism /Apply-Image /ImageFile:N:\install.esd /Index:1 /ApplyDir:W:\
bcdboot W:\windows /l ko-kr /s S: