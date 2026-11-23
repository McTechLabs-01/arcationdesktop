param([Parameter(Mandatory=$true)][string]$Pfx,[Parameter(Mandatory=$true)][string]$Password)
$ErrorActionPreference='Stop'
$sign=(Get-ChildItem 'C:\Program Files (x86)\Windows Kits\10\bin' -Filter SignTool.exe -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName -Descending | Select-Object -First 1).FullName
if(-not $sign){throw 'SignTool.exe not found. Install the Windows SDK.'}
& $sign sign /fd SHA256 /a /f $Pfx /p $Password (Join-Path (Split-Path -Parent $PSScriptRoot) 'ArcationDesktop.msix')
