$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/napari/napari/releases/download/v0.4.2/napari-0.4.2-Windows.zip'
$fileLocation = Join-Path $toolsDir 'napari-0.4.2.msi'

$zipArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  checksum      = '42C0601E5DAB47C124E81A246BC7D7201AF72C2D523CB78EEC2301D8510FF46F'
  checksumType  = 'sha256'
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi'
  file          = $fileLocation
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
  softwareName  = 'napari*'
}

Install-ChocolateyZipPackage @zipArgs
Install-ChocolateyInstallPackage @packageArgs
