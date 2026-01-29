# Daily Commit Automation Script
# This script helps maintain your GitHub contribution graph

param(
    [string]$Message = "",
    [switch]$Auto
)

$repoPath = Split-Path -Parent $PSScriptRoot
Set-Location $repoPath

# Colors for output
function Write-Success { param($text) Write-Host $text -ForegroundColor Green }
function Write-Info { param($text) Write-Host $text -ForegroundColor Cyan }
function Write-Error { param($text) Write-Host $text -ForegroundColor Red }

# Update daily log
$logFile = Join-Path $repoPath "daily-log.md"
$today = Get-Date -Format "MMMM dd, yyyy"
$dayOfYear = (Get-Date).DayOfYear

# Read existing log
$logContent = Get-Content $logFile -Raw

# Check if today's entry already exists
if ($logContent -match $today) {
    Write-Info "Daily entry already exists in daily-log.md"
} else {
    # Add new entry
    $newEntry = @"

### Day $dayOfYear - $today
- Daily progress logged
- Continued coding journey
- Committed to consistency

"@
    
    # Insert after the header (after "## January 2026" or similar)
    $logContent = $logContent -replace "(## \w+ \d{4})", "`$1$newEntry"
    Set-Content -Path $logFile -Value $logContent
    Write-Success "Updated daily-log.md with today's entry"
}

# Create a commit
if ($Message -eq "") {
    $commitMessages = @(
        "Daily learning progress - Day $dayOfYear",
        "Updated coding journey - $today",
        "Daily commit - Keep the streak alive!",
        "Progress update - $today",
        "Daily coding session - Day $dayOfYear",
        "Continuous learning - $today"
    )
    $Message = $commitMessages | Get-Random
}

Write-Info "Staging changes..."
git add .

$status = git status --porcelain
if ($status) {
    Write-Info "Creating commit..."
    git commit -m $Message
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Commit created: $Message"
        
        Write-Info "Pushing to GitHub..."
        git push origin main
        
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Successfully pushed to GitHub!"
            Write-Success "Your contribution graph has been updated!"
        } else {
            Write-Error "Failed to push to GitHub"
            Write-Info "Try: git push origin main"
        }
    } else {
        Write-Error "Failed to create commit"
    }
} else {
    Write-Info "No changes to commit"
    Write-Info "Make some changes first, or the script will update the daily log"
}

Write-Host ""
Write-Info "Your GitHub: https://github.com/somsu123"
Write-Host ""
