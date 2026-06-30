$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VSCodeConfig = Join-Path $env:APPDATA "Code\User"

Write-Host "Deploying VS Code configuration..."

New-Item -ItemType Directory -Force -Path $VSCodeConfig | Out-Null

Copy-Item "$ScriptDir\settings.json" $VSCodeConfig -Force
Copy-Item "$ScriptDir\keybindings.json" $VSCodeConfig -Force

$SourceSnippets = Join-Path $ScriptDir "snippets"
$TargetSnippets = Join-Path $VSCodeConfig "snippets"

if (Test-Path $SourceSnippets) {
    Remove-Item $TargetSnippets -Recurse -Force -ErrorAction SilentlyContinue
    Copy-Item $SourceSnippets $TargetSnippets -Recurse
}

Write-Host "Done."