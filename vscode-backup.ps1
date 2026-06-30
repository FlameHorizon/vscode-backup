param(
    [string]$OutputZip = (Join-Path $PSScriptRoot "VSCode-Config.zip")
)

$ErrorActionPreference = "Stop"

# VS Code user directory
$userDir = Join-Path $env:APPDATA "Code\User"

# Temporary export directory
$tempDir = Join-Path $env:TEMP ("VSCodeExport_" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Export settings.json
if (Test-Path "$userDir\settings.json") {
    Copy-Item "$userDir\settings.json" $tempDir
}

# Export keybindings.json
if (Test-Path "$userDir\keybindings.json") {
    Copy-Item "$userDir\keybindings.json" $tempDir
}

# Export snippets
if (Test-Path "$userDir\snippets") {
    Copy-Item "$userDir\snippets" $tempDir -Recurse
}

# Export installed extensions list
if (Get-Command code -ErrorAction SilentlyContinue) {
    code --list-extensions |
        Sort-Object |
        Out-File (Join-Path $tempDir "extensions.txt") -Encoding utf8
}
else {
    Write-Warning "The 'code' command is not available. Install it from VS Code via Command Palette -> 'Shell Command: Install code command in PATH'."
}

# Create ZIP
if (Test-Path $OutputZip) {
    Remove-Item $OutputZip -Force
}

Compress-Archive -Path "$tempDir\*" -DestinationPath $OutputZip

# Cleanup
Remove-Item $tempDir -Recurse -Force

Write-Host "VS Code configuration exported to:"
Write-Host "  $OutputZip"