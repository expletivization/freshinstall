# ===================================================================
# ===     FASTER Automated "Download-Only" Installer Script     ===
# ===================================================================
#
# This version uses Start-BitsTransfer for significantly faster and
# more reliable downloads.
#
# LAST UPDATED: June 21, 2024 with new .NET SDK link.
#
# ===================================================================

# --- Configuration ---
$downloadFolder = "C:\FreshInstall"

# --- Script Start ---
Write-Host "Starting the FASTER automated download process..." -ForegroundColor Green

if (-not (Test-Path -Path $downloadFolder)) {
    Write-Host "Creating download folder at: $downloadFolder"
    New-Item -ItemType Directory -Path $downloadFolder | Out-Null
} else {
    Write-Host "Download folder already exists at: $downloadFolder"
}

# --- Function to Handle Downloads ---
# This function makes the main script cleaner and handles errors.
function Start-Download {
    param(
        [string]$DisplayName,
        [string]$Url,
        [string]$DestinationPath
    )
    Write-Host "`nDownloading $DisplayName..." -ForegroundColor Cyan
    try {
        Start-BitsTransfer -Source $Url -Destination $DestinationPath -ErrorAction Stop
        Write-Host "Successfully downloaded $DisplayName." -ForegroundColor Green
    } catch {
        Write-Host "ERROR: Failed to download $DisplayName." -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

# --- Download Queue ---

Start-Download -DisplayName "Google Chrome" `
               -Url "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" `
               -DestinationPath (Join-Path $downloadFolder "Chrome-Installer.exe")

Start-Download -DisplayName "Git for Windows" `
               -Url "https://github.com/git-for-windows/git/releases/download/v2.50.0.windows.1/Git-2.50.0-64-bit.exe" `
               -DestinationPath (Join-Path $downloadFolder "Git-2.50.0-64-bit.exe")

# --- .NET SDK link has been updated as requested ---
Start-Download -DisplayName ".NET 8 SDK" `
               -Url "https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.411/dotnet-sdk-8.0.411-win-x64.exe" `
               -DestinationPath (Join-Path $downloadFolder "dotnet-sdk-8.0.411-win-x64.exe")

Start-Download -DisplayName "SwarmUI Installer" `
               -Url "https://github.com/mcmonkeyprojects/SwarmUI/releases/download/0.9.5-Beta/install-windows.bat" `
               -DestinationPath (Join-Path $downloadFolder "install-SwarmUI.bat")


# --- Script Finish ---
Write-Host "`n===================================================================" -ForegroundColor Green
Write-Host "All downloads are complete."
Write-Host "You can find all installer files in: $downloadFolder" -ForegroundColor Yellow
Write-Host "==================================================================="

Read-Host "`nPress Enter to close this window..."
