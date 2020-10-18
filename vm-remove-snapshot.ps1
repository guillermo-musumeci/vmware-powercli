# Credentials
$vcserver = "vcenter.kopicloud.local"
$vcusername = "guillermo@kopicloud.local"
$vcpassword = "MyP@ssw0rd67"

# VM information
$vm = "kopidevweb01"
$snapshotname = $vm + "-backup"

# Install VMware Components
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module VMware.PowerCLI -Repository PSGallery -Force
Import-Module VMware.VimAutomation.Core -Force

# Login VMware
Connect-VIServer -Server $vcserver -Protocol https -User $vcusername -Password $vcpassword

# Remove Snapshot
$snap = get-Snapshot -vm $vm -name $snapshotname
write-host "Removing snapshot [$snapshotname] for the VM [$vm]"
remove-snapshot -snapshot $snap -confirm:$false -runasync:$true
