$ErrorActionPreference='Stop'
$root=Split-Path -Parent $MyInvocation.MyCommand.Path
$pkg=Join-Path $root '..\package'
$out=Join-Path $root '..\ArcationDesktop.msix'
Write-Host 'This script expects the Windows 10/11 SDK MakeAppx.exe and SignTool.exe.'
$makeappx=(Get-ChildItem 'C:\Program Files (x86)\Windows Kits\10\bin' -Filter MakeAppx.exe -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName -Descending | Select-Object -First 1).FullName
if(-not $makeappx){throw 'MakeAppx.exe not found. Install the Windows 10/11 SDK.'}
& $makeappx pack /o /h SHA256 /d $pkg /p $out
Write-Host "Built $out"
