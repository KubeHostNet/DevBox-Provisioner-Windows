Import-Module -verbose .\provisioningFunctions.psm1

#### ##To get this script to run, type the following with PowerShell running as Administrator to set execution policy to unrestricted.  You will have to confirm with "A"  
#### #Get-ExecutionPolicy
#### #Set-ExecutionPolicy unrestricted
#### ##Then you run the script by typing its fully qualified path and name into PowerShell

#$DesktopPath = [Environment]::GetFolderPath("Desktop")
#$DesktopPath = C:\projects
######################################################################
$destinationRootPath = "C:\khn-binary-terraform"
Write-Host "destinationRootPath is: $destinationRootPath"
$terraformPath = $destinationRootPath + "\terraform_0.12.14_windows_amd64"
Write-Host "terraformPath is $terraformPath"
######################################################################
######################################################################
#### Calls to functions
######################################################################
######################################################################
DetermineIfInPATH -pathItem $terraformPath
Write-Host "-------------------------------------------------------------"
DoesDirectoryExist -pathOfDirectory $destinationRootPath
Write-Host "-------------------------------------------------------------"
DoesDirectoryExist -pathOfDirectory $terraformPath

# NEED TO ADD DELETE OF destinationRootPath
Write-Host "-------------------------------------------------------------"
DeleteTheDirectory -pathOfDirectory $destinationRootPath
Write-Host "-------------------------------------------------------------"
RemoveFromPATH -pathItem $terraformPath
Write-Host "terraformPath is $terraformPath"
