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

# Browser extensions
## Bitwarden
$extensionPath="HKCU:\Software\Google\Chrome\Extensions\nngceckbapebfimnlniiiahkandclblb"
IF(!(Test-Path $extensionPath)) {
    New-Item -Force $extensionPath
    New-ItemProperty -path $extensionPath -Name update_url -PropertyType String -Value  "https://clients2.google.com/service/update2/crx"
}

# Set default Edge search engine to Bing (as opposed to market-default one)
$searchEnginePath="HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\OpenSearch"
IF(!(Test-Path $searchEnginePath)) {
    New-Item -Force $searchEnginePath
    New-ItemProperty -path $searchEnginePath -Name SetDefaultSearchEngine -Type String -Value "EDGEBING"
}

cinst -y slack
cinst -y microsoft-office-deployment

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
