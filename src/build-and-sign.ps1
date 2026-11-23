$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$pkg=Join-Path $root 'package'
$out=Join-Path $root 'ArcationDesktop.msix'
$binRoot='C:\Program Files (x86)\Windows Kits\10\bin'
$makeappx=(Get-ChildItem $binRoot -Filter MakeAppx.exe -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName -Descending | Select-Object -First 1).FullName
$sign=(Get-ChildItem $binRoot -Filter SignTool.exe -Recurse -ErrorAction SilentlyContinue | Sort-Object FullName -Descending | Select-Object -First 1).FullName
if(-not $makeappx -or -not $sign){throw 'Install the Windows 10/11 SDK first.'}
$certPath=Join-Path $root 'ArcationDesktop-dev.pfx'
$password=ConvertTo-SecureString 'arcation-dev' -AsPlainText -Force
$cert=New-SelfSignedCertificate -Type Custom -KeyUsage DigitalSignature -Subject 'CN=Mc' -CertStoreLocation 'Cert:\CurrentUser\My' -TextExtension @('2.5.29.37={text}1.3.6.1.5.5.7.3.3','2.5.29.19={text}') -FriendlyName 'Arcation Desktop Development'
Export-PfxCertificate -Cert $cert -FilePath $certPath -Password $password | Out-Null
Import-PfxCertificate -CertStoreLocation 'Cert:\CurrentUser\TrustedPeople' -FilePath $certPath -Password $password | Out-Null
& $makeappx pack /o /h SHA256 /d $pkg /p $out
& $sign sign /fd SHA256 /a /f $certPath /p 'arcation-dev' $out
Write-Host "Built and signed: $out"
Write-Host "For local install, trust $certPath in Trusted People, then double-click the MSIX."
