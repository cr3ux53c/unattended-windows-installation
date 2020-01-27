Const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."
Set objReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & _
strComputer & "\root\default:StdregProv")
strKeypath = "SYSTEM\CurrentControlSet\Control\PXE"
strEntryName = "BootServerReply"
objReg.GetBinaryValue HKEY_LOCAL_MACHINE, strKeyPath, strEntryName, arrValue
Wscript.Echo arrvalue(20) & "." & arrValue(21) & "." & arrValue(22) & "." & arrValue(23)