Import-Module -verbose .\provisioningFunctions.psm1

##To get this script to run, type the following with PowerShell running as Administrator to set execution policy to unrestricted.  You will have to confirm with "A"  
#Get-ExecutionPolicy
#Set-ExecutionPolicy unrestricted
##Then you run the script by typing its fully qualified path and name into PowerShell

$destinationRootPath = "C:\khn-binary-terraform"
Write-Host "destinationRootPath is: $destinationRootPath"
$terraformPath = $destinationRootPath + "\terraform_0.12.14_windows_amd64"
Write-Host "terraformPath is $terraformPath"
$terraformDownloadURL = "https://releases.hashicorp.com/terraform/0.12.14/terraform_0.12.14_windows_amd64.zip"
Write-Host "terraformDownloadURL is $terraformDownloadURL"
$nameOfTerraformZip = "terraform_0.12.14_windows_amd64.zip"
Write-Host "nameOfTerraformZip is $nameOfTerraformZip"
######################################################################
######################################################################
#### Calls to functions
######################################################################
######################################################################
Write-Host "-------- Does PATH contain $terraformPath --------"
DetermineIfInPATH -pathItem $terraformPath
Write-Host "-------- Check if exists: $destinationRootPath --------"
DoesDirectoryExist -pathOfDirectory $destinationRootPath
Write-Host "-------- Create: $destinationRootPath --------"
CreateTheDirectory -pathOfDirectory $destinationRootPath
Write-Host "-------- DownloadTheZip --------"
DownloadTheZip -urlToGet $terraformDownloadURL -pathOfDirectory $destinationRootPath -nameOfZipFile $nameOfTerraformZip
Write-Host "-------- ExtractTheZip --------"
ExtractTheZip -pathOfDirectory $destinationRootPath -nameOfZipFile $nameOfTerraformZip 
Write-Host "-------- Check if exists: $terraformPath --------"
DoesDirectoryExist -pathOfDirectory $terraformPath
Write-Host "-------- DoesDirectoryExist $terraformPath --------"
DetermineIfInPATH -pathItem $terraformPath
Write-Host "-------- AddToPATH $terraformPath --------"
AddToPATH -pathItem $terraformPath
