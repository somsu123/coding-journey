# Quick Commit Script
# Double-click this file to make a daily commit!

Write-Host "🚀 Daily Commit Automation" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

$scriptPath = Join-Path $PSScriptRoot "daily-commit.ps1"
& $scriptPath

Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
