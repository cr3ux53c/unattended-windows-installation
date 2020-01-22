@echo off
wpeinit
cscript //nologo X:\sources\wds_server_ip.vbs > X:\Windows\wds_server_ip.log
set /p serverIpAddress=<X:\Windows\wds_server_ip.log
net use N: \\%serverIpAddress%\PXEShare /user:WDSUser 6dEYN2HTvJ63xqkS
call N:\autounattend.cmd