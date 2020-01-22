@echo off
wpeinit
set /p server_ip=Input WDS Server IP address: 
net use N: \\%server_ip%\PXEShare
call N:\autounattend.cmd