start taskmgr
diskpart /s N:\diskpart.cfg
dism /Get-WIMInfo /WIMFile:N:\install-unattend-KNUT_Software_2020.esd /Index:1
dism /Apply-Image /ImageFile:N:\install-unattend-KNUT_Software_2020.esd /Index:1 /ApplyDir:W:\
bcdboot W:\windows /l ko-kr /s S: