New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\System" -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\System" -Name "DisableCMD" -Value 2 -Type DWord