##To get this script to run, type the following with PowerShell running as Administrator to set execution policy to unrestricted.  You will have to confirm with "A"  
#Get-ExecutionPolicy
#Set-ExecutionPolicy unrestricted
##Then you run the script by typing its fully qualified path and name into PowerShell

################################################################################################
#### Functions
################################################################################################

# DetermineIfInPATH function
Function DetermineIfInPATH {
    [cmdletbinding()]
    Param ( [string]$pathItem ) # End of Parameters

    Process {
        Clear-Host
        Write-Host $pathItem
        #The following two lines first get the PATH and put it into a variable and then print out the value of the variable.  
        $pathString = (Get-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment').Path
        Write-Host $pathString
        #Check to see if input string is in the PATH and then return true or false depending on the answer.
        $matchBool = $pathString -match $pathItem
        Write-Host $matchBool
        if($matchBool){
            Write-Host "Item is in the PATH!"
        } # End of If
        Else {
            Write-Host "Nope.  Not in PATH."
        } # End of Else.
		return $matchBool
    } # End of Process
}

# AddToPATH function
Function AddToPATH {
    [cmdletbinding()]
    Param ( [string]$pathItem ) # End of Parameters

    Process {
        Clear-Host
        Write-Host "pathItem is: $pathItem"  
        #$pathItem = C:\projects\binary-terraform\terraform_0.12.14_windows_amd64
        #Get the PATH as a string
        $oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
        Write-Host "oldpath is: $oldpath"
        #Append the new item to the string-copy representation of the PATH
        $newpath = "$oldpath;$pathItem"
        Write-Host "newpath is: $newpath"
        #Set the new version as the replacement PATH permanently, but not within this session
        Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
        [Environment]::SetEnvironmentVariable( 'PATH', $newPath, [EnvironmentVariableTarget]::User )
        #Set the new version as the replacement PATH within this session
        $env:path = $newPath
        #Now print the PATH separated line by line to check its contents.
        Write-Host "The elements of the new PATH are listed in rows as follows: "
        ($env:path).split(";")
    } # End of Process
}

# RemoveFromPATH function
Function RemoveFromPATH {
    [cmdletbinding()]
    Param ( [string]$pathItem ) # End of Parameters

    Process {
        Clear-Host
        #Then separately to remove
        Write-Host "pathItem is: $pathItem"
        #$pathItem = C:\projects\binary-terraform\terraform_0.12.14_windows_amd64
        $pathItem = ";"+$pathItem
        $oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
        Write-Host "oldpath is: $oldpath"
        $newpath = $oldpath.Replace($pathItem,"")
        Write-Host "newpath is: $newpath"
        #Set the new version as the replacement PATH permanently, but not within this session
        Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
        [Environment]::SetEnvironmentVariable( 'PATH', $newPath, [EnvironmentVariableTarget]::User )
        #Set the new version as the replacement PATH within this session
        $env:path = $newPath
        Write-Host "The elements of the new PATH are listed in rows as follows: "
        ($env:path).split(";")
    } # End of Process
}

# DoesDirectoryExist function
Function DoesDirectoryExist {
    [cmdletbinding()]
    Param ( [string]$pathOfDirectory ) # End of Parameters

    Process {
        Clear-Host
        Write-Host $pathOfDirectory
        $returnVal = Test-Path -PathType Container $pathOfDirectory
        if($returnVal) {
            Write-Host "Yeah!  The directory exists! "
        }else {
            #Then say it is missing
            Write-Host "Nay!  The directory does NOT exist! "
            #Then create it
        } # End of Else
        return $returnVal
    } # End of Process
}

# CreateTheDirectory function
Function CreateTheDirectory {
    [cmdletbinding()]
    Param ( [string]$pathOfDirectory ) # End of Parameters

    Process {
        Clear-Host
        Write-Host $pathOfDirectory
        New-Item -ItemType Directory -Force -Path $pathOfDirectory
        #Consider adding logic here to confirm that the directory exists before moving on.
    } # End of Process
}

# DeleteTheDirectory function
Function DeleteTheDirectory {
    [cmdletbinding()]
    Param ( [string]$pathOfDirectory ) # End of Parameters

    Process {
        Clear-Host
        Write-Host $pathOfDirectory
        Remove-Item -Recurse -Force $pathOfDirectory
        #Consider adding logic here to confirm that the directory does not exist anymore before moving on.
    } # End of Process
}

# DownloadTheZip function
Function DownloadTheZip {
    [cmdletbinding()]
    Param ( [string]$urlToGet, [string]$pathOfDirectory, [string]$nameOfZipFile ) # End of Parameters

    Process {
        Clear-Host
        Write-Host "Inside DownloadTheZip"
        Write-Host $urlToGet
        Write-Host $pathOfDirectory
        Write-Host $nameOfZipFile
        $myOutFile = $pathOfDirectory + "\" + $nameOfZipFile
        Write-Host $myOutFile
        wget $urlToGet -outfile $myOutFile
        #Consider adding logic here to confirm that the zip was downloaded successfully before moving on.
        Write-Host "End of DownloadTheZip"
    } # End of Process
}

# ExtractTheZip function
Function ExtractTheZip {
    [cmdletbinding()]
    Param ( [string]$pathOfDirectory, [string]$nameOfZipFile ) # End of Parameters

    Process {
        Clear-Host
        Write-Host "Inside ExtractTheZip"
        Write-Host "pathOfDirectory is: $pathOfDirectory"
        Write-Host "nameOfZipFile is: $nameOfZipFile"
        $myZipFile = $pathOfDirectory + "\" + $nameOfZipFile
        Write-Host "myZipFile is: $myZipFile"
        $dirName = $nameOfZipFile
        $dirName = $dirName -replace ".{4}$" #drop last 4 chars
        Write-Host "dirName is: $dirName"
        $fullDestinationPath = $pathOfDirectory + "\" + $dirName
        Write-Host "fullDestinationPath is: $fullDestinationPath"
        Expand-Archive $myZipFile -DestinationPath $fullDestinationPath
        #Consider adding logic here to confirm that the zip was downloaded successfully before moving on.
        Write-Host "End of ExtractTheZip"
    } # End of Process
}

######################################################################
######################################################################
#### Calls to functions
######################################################################
######################################################################
#### DetermineIfInPATH -pathItem C:\projects\binary-terraform\terraform_0.12.14_windows_amd64
#### Write-Host "-------------------------------------------------------------"
#### DoesDirectoryExist -pathOfDirectory C:\projects
#### Write-Host "-------------------------------------------------------------"
#### DoesDirectoryExist -pathOfDirectory C:\projects\binary-terraform

#### ##Write-Host "-------------------------------------------------------------"
#### ##DeleteTheDirectory -pathOfDirectory C:\projects\binary-terraform
#### ##Write-Host "-------------------------------------------------------------"
#### ##RemoveFromPATH -pathItem C:\projects\binary-terraform\terraform_0.12.14_windows_amd64

#### Write-Host "-------------------------------------------------------------"
#### CreateTheDirectory -pathOfDirectory C:\projects\binary-terraform
#### Write-Host "-------------------------------------------------------------"
#### DownloadTheZip -urlToGet "https://releases.hashicorp.com/terraform/0.12.14/terraform_0.12.14_windows_amd64.zip" -pathOfDirectory "C:\projects\binary-terraform" -nameOfZipFile "terraform_0.12.14_windows_amd64.zip" 
#### Write-Host "-------------------------------------------------------------"
#### ExtractTheZip -pathOfDirectory C:\projects\binary-terraform -nameOfZipFile "terraform_0.12.14_windows_amd64.zip" 
#### Write-Host "-------------------------------------------------------------"
#### DetermineIfInPATH -pathItem C:\projects\binary-terraform\terraform_0.12.14_windows_amd64
#### Write-Host "-------------------------------------------------------------"
#### AddToPATH -pathItem C:\projects\binary-terraform\terraform_0.12.14_windows_amd64
######################################################################
######################################################################

# https://www.python.org/ftp/python/3.7.6/python-3.7.6-embed-amd64.zip

