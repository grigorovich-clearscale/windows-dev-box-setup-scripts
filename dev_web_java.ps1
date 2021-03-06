# Description: Boxstarter Script
# Author: Microsoft
# Common settings for web development with NodeJS

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
executeScript "HyperV.ps1";
executeScript "Docker.ps1";
executeScript "WSL.ps1";
executeScript "Browsers.ps1";
executeScript "ColorschemeSolarized.ps1";

# Browser extensions
## Bitwarden
New-Item HKCU:\Software\Google\Chrome\Extensions\nngceckbapebfimnlniiiahkandclblb
New-ItemProperty -path HKCU:\Software\Google\Chrome\Extensions\nngceckbapebfimnlniiiahkandclblb  -Name update_url -PropertyType String -Value  "https://clients2.google.com/service/update2/crx"

#--- Tools ---
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension msjsdiag.debugger-for-edge

#--- Java Tools ---
cinst -y jdk8
cinst -y jdk11
cinst -y maven
cinst -y gradle

# IntelliJ IDEA Ultimate
cinst -y intellijidea-ultimate

# nodejs + build tools
cinst -y nodejs-lts # Node.js LTS, Recommended for most users
# cinst -y nodejs # Node.js Current, Latest features
cinst -y visualstudio2017buildtools
cinst -y visualstudio2017-workload-vctools
cinst -y python2 # Node.js requires Python 2 to build native modules

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
