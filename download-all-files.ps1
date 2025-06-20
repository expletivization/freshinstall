# ===================================================================
# ===        Automated "Download-Only" Installer Script         ===
# ===================================================================
#
# This script will DOWNLOAD all the necessary installer files to a
# single folder. It will NOT install any software automatically.
#
# To Run:
# 1. Right-click this .ps1 file
# 2. Select "Run with PowerShell"
#
# ===================================================================

# --- Configuration ---
# All downloaded installer files will be placed in this folder.
$downloadFolder = "C:\FreshInstall"

# --- Script Start ---
Write-Host "Starting the automated download process..." -ForegroundColor Green

# Create the download folder if it doesn't already exist
if (-not (Test-Path -Path $downloadFolder)) {
    Write-Host "Creating download folder at: $downloadFolder"
    New-Item -ItemType Directory -Path $downloadFolder | Out-Null
} else {
    Write-Host "Download folder already exists at: $downloadFolder"
}

# --- Download Files ---
# Each block will try to download a file. If it fails, it will report an error and continue.

Write-Host "`n[1/4] Downloading Google Chrome (Standalone Installer)..." -ForegroundColor Cyan
try {
    $chromeUrl = "http://dl.google.com/chrome/install/375.126/chrome_installer.exe"
    $chromeDest = Join-Path -Path $downloadFolder -ChildPath "Chrome-Installer.exe"
    Invoke-WebRequest -Uri $chromeUrl -OutFile $chromeDest -ErrorAction Stop
    Write-Host "Successfully downloaded Chrome installer." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download Google Chrome." -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host "`n[2/4] Downloading Git for Windows..." -ForegroundColor Cyan
try {
    $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.50.0.windows.1/Git-2.50.0-64-bit.exe"
    $gitDest = Join-Path -Path $downloadFolder -ChildPath "Git-2.50.0-64-bit.exe"
    Invoke-WebRequest -Uri $gitUrl -OutFile $gitDest -ErrorAction Stop
    Write-Host "Successfully downloaded Git for Windows installer." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download Git for Windows." -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host "`n[3/4] Downloading .NET 8 SDK..." -ForegroundColor Cyan
try {
    # This is the direct download link for the x64 SDK installer
    $dotNetUrl = "https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.411/dotnet-sdk-8.0.411-win-x64.exe"
    $dotNetDest = Join-Path -Path $downloadFolder -ChildPath "dotnet-sdk-8.0-win-x64.exe"
    Invoke-WebRequest -Uri $dotNetUrl -OutFile $dotNetDest -ErrorAction Stop
    Write-Host "Successfully downloaded .NET 8 SDK installer." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download the .NET 8 SDK." -ForegroundColor Red
    Write-Host $_.Exception.Message
}

Write-Host "`n[4/4] Downloading SwarmUI Installer..." -ForegroundColor Cyan
try {
    $swarmUiUrl = "https://github.com/mcmonkeyprojects/SwarmUI/releases/download/0.9.5-Beta/install-windows.bat"
    $swarmUiDest = Join-Path -Path $downloadFolder -ChildPath "install-SwarmUI.bat"
    Invoke-WebRequest -Uri $swarmUiUrl -OutFile $swarmUiDest -ErrorAction Stop
    Write-Host "Successfully downloaded the SwarmUI installer." -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to download the SwarmUI installer." -ForegroundColor Red
    Write-Host $_.Exception.Message
}

# --- Script Finish ---
Write-Host "`n===================================================================" -ForegroundColor Green
Write-Host "All downloads are complete."
Write-Host ""
Write-Host "You can find all installer files in the following folder:" -ForegroundColor Yellow
Write-Host "$downloadFolder"
Write-Host "You can now run each executable to install the software manually." -ForegroundColor Yellow
Write-Host "==================================================================="

Read-Host "`nPress Enter to close this window..."
