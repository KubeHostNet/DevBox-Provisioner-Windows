# DevBox-Provisioner-Windows   
  
This is automation code for provisioning a Windows DevBox that can be used to develop and operate software-defined host networks for Kubernetes clusters as a part of the KubeHostNet open source project.  
  
Clone and run this repository first, so that you can begin working with KubeHostNet quickly.  
  
You will need administrator privileges on your Windows DevBox in order to run the code in this repository.  Specifically, PowerShell will need to be run as an administrator in order to automatically add Terraform to your machine's PATH variable.  
  
If your DevBox is already running Terraform and Python, you may need to make modifications to the approach outlined here.  One option is to lease an AWS Windows Workspace and to provision that workspace with this `DevBox-Provisioner-Windows`.  
   
# Instructions  
  
## Installation Instructions  
  
You can get this working in a few minutes by following these instructions:  
   
1. Open PowerShell as an administrator.  
--* In the Search box next to the Windows Start menu on the bottom left of your screen, type `PowerShell`  
--* Choose “Run as Administrator” from the options that appear  
2. Clone this Devbox-Provisioner-Windows repository to the machine that you want to be your DevBox for KubeHostNet work.  
--* Use whichever method you choose for this (a UI application, the command line, etc.)  
--* Then visually validate that the files have been cloned to the target directory in your DevBox machine.  
3. Install Python 3.7  
--* Use an official automated installer for this.  One option is the Windows installer, as follows:   
--* Type “Python” in the Search Box next to the Windows Start Menu button on the bottom left of your screen  
--* If Python is not yet installed, a link will appear to download and install it through the Windows Store  
--* If Python is already installed, a different link will appear showing the version of Python that is installed and giving options to either run or uninstall it.  
--* KubeHostNet is developed and tested using Python 3.7  
4. Test Python:  
--* In PowerShell, run the following commands:  
--* python --version  
--* Result should be 3.7.x  
--* cd to directory into which you cloned the DebBox-Provisioner-Windows repository.  
--* dir   
--* confirm that testThePythonInstall.py is included in this directory.  
--* python .\testThePythonInstall.py  
--* Result should print the intended message to the console  
5. Install Terraform  
--* In PowerShell, run the following:  
--* .\installTerraform.ps1  
6. Test Terraform:  
--* In PowerShell, run the following:  
--* cd to location of main.tf  
--* terraform init  
--* (Watch as the AWS provider is installed.)  
--* terraform apply  
--* (Watch as the command line prints out the changes it will make.  It should say that it will create one VM.)  
--* Type `yes` to approve   
--* (Watch as the command line prints out the results of creating the VM.)  
--* terraform destroy  
--* (Watch as the command line prints out the changes it will make.  It should say that it will destroy one VM.)  
--* Type `yes` to approve  
--* (Watch as the command line prints out the results of destroying the VM.)  
7.  Install Putty  
--* https://putty.org/  
8.  Install PuttyGen  
--* https://www.puttygen.com/  
9.  Install a Code Editor  
--* For simplicity, we will use Notepad++, but you can use another code editor instead.  
--* https://notepad-plus-plus.org/  
  
## Removal Instructions  
  
1.  Remove Terraform  
--* In PowerShell, type the following:  
--* .\removeTerraform.ps1  
2.  Remove Python  
--* Use the same automated installer that you used to install Python above, but this time choose the “Uninstall” option  
3.  Delete directory into which you downloaded the repository  
4.  Remove Putty  
--* https://putty.org/  
5.  Remove PuttyGen  
--* https://www.puttygen.com/  
6.  Remove Code Editor  
--* https://notepad-plus-plus.org/  
  
The primary development of KubeHostNet and all its components was done by [Green River IT, Incorporated](http://greenriverit.com) in California.  It is released under the generous license terms defined in the [LICENSE](LICENSE.txt) file.  
  
## Support  
  
If you encounter any problems with this release, please create a 
[GitHub Issue](https://github.com/kubehostnet/DevBox-Provisioner-Windows/issues).  
  
For commercial support please send us an email.  
  
## Dependencies  
  
You will need a Windows computer with Administrator privileges.  
  
The code in this repository will automatically install other dependencies.  
  
The code in this repository is intended to be used with code in other repositories at https://github.com/kubehostnet  
  
