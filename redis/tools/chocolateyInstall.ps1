$packageName = 'redis' 
$installerType = 'exe'
$url = 'http://ruilopes.com/redis-setup/binaries/redis-2.4.6-setup-32-bit.exe' 
$url64 = 'http://ruilopes.com/redis-setup/binaries/redis-2.4.6-setup-64-bit.exe' 
$silentArgs = '/VERYSILENT' 
$validExitCodes = @(0) 

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"  -validExitCodes $validExitCodes

try { 
  # Runs processes asserting UAC, will assert administrative rights - used by Install-ChocolateyInstallPackage
  Start-ChocolateyProcessAsAdmin 'Start-Service redis' -validExitCodes $validExitCodes
  
  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}