# Daily Commit Automation Script
# This script creates 1-20 random commits to fill your GitHub contribution graph

param(
    [string]$Message = "",
    [switch]$Auto,
    [int]$CustomCount = 0
)

$repoPath = Split-Path -Parent $PSScriptRoot
Set-Location $repoPath

# Colors for output
function Write-Success { param($text) Write-Host $text -ForegroundColor Green }
function Write-Info { param($text) Write-Host $text -ForegroundColor Cyan }
function Write-Warning { param($text) Write-Host $text -ForegroundColor Yellow }
function Write-Error { param($text) Write-Host $text -ForegroundColor Red }

# Generate random number of commits (1-20)
if ($CustomCount -gt 0) {
    $commitCount = $CustomCount
} else {
    $commitCount = Get-Random -Minimum 1 -Maximum 21
}

Write-Info "=========================================="
Write-Info "   GitHub Contribution Booster"
Write-Info "=========================================="
Write-Host ""
Write-Success "Target commits for today: $commitCount"
Write-Host ""

# Update daily log
$logFile = Join-Path $repoPath "daily-log.md"
$today = Get-Date -Format "MMMM dd, yyyy"
$dayOfYear = (Get-Date).DayOfYear

# Commit message templates
$commitTemplates = @(
    "Daily learning progress - Day {0}",
    "Updated coding journey - {1}",
    "Daily commit - Keep the streak alive!",
    "Progress update - {1}",
    "Daily coding session - Day {0}",
    "Continuous learning - {1}",
    "Code improvements and updates",
    "Refactoring and optimization",
    "Documentation updates",
    "Bug fixes and enhancements",
    "Feature development progress",
    "Learning new concepts",
    "Practice session completed",
    "Algorithm study - Day {0}",
    "Project progress update",
    "Code review and cleanup",
    "Performance improvements",
    "Adding new functionality",
    "Testing and validation",
    "Code quality improvements",
    "Repository maintenance",
    "Regular practice session",
    "Skill development - {1}",
    "Coding challenge completed",
    "Best practices implementation"
)

$activityTemplates = @(
    "Studied algorithms and data structures",
    "Practiced coding challenges",
    "Built new features",
    "Refactored existing code",
    "Improved code quality",
    "Fixed bugs and issues",
    "Updated documentation",
    "Optimized performance",
    "Learned new concepts",
    "Completed daily practice",
    "Enhanced project structure",
    "Implemented best practices",
    "Reviewed and tested code",
    "Explored new technologies",
    "Problem-solving session"
)

$successCount = 0

# Create multiple commits
for ($i = 1; $i -le $commitCount; $i++) {
    Write-Info "Creating commit $i of $commitCount..."
    
    # Read current log
    $logContent = Get-Content $logFile -Raw
    
    # Generate unique timestamp for this commit
    $timestamp = Get-Date -Format "HH:mm:ss"
    $activity = $activityTemplates | Get-Random
    
    # Check if today's entry exists
    if ($logContent -notmatch $today) {
        # Create new day entry
        $newEntry = @"

### Day $dayOfYear - $today
- [$timestamp] $activity (Commit $i/$commitCount)

"@
        $logContent = $logContent -replace "(## \w+ \d{4})", "`$1$newEntry"
    } else {
        # Add to existing day entry
        $pattern = "(### Day \d+ - $today.*?)(\n### |\z)"
        if ($logContent -match $pattern) {
            $existingEntry = $Matches[1]
            $updatedEntry = "$existingEntry- [$timestamp] $activity (Commit $i/$commitCount)`n"
            $logContent = $logContent -replace [regex]::Escape($existingEntry), $updatedEntry
        }
    }
    
    # Write updated log
    Set-Content -Path $logFile -Value $logContent -NoNewline
    
    # Stage changes
    git add . | Out-Null
    
    # Generate commit message
    if ($Message -eq "" -or $i -gt 1) {
        $template = $commitTemplates | Get-Random
        $commitMsg = $template -f $dayOfYear, $today
        $commitMsg += " (#$i)"
    } else {
        $commitMsg = "$Message (#$i)"
    }
    
    # Create commit
    git commit -m $commitMsg --allow-empty-message --allow-empty 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        $successCount++
        Write-Success "  Commit $i created: $commitMsg"
    } else {
        Write-Error "  Failed to create commit $i"
    }
    
    # Small delay to ensure unique timestamps
    Start-Sleep -Milliseconds 100
}

Write-Host ""
Write-Info "=========================================="
Write-Success "Successfully created $successCount commits!"
Write-Info "=========================================="
Write-Host ""

# Push all commits to GitHub
if ($successCount -gt 0) {
    Write-Info "Pushing $successCount commits to GitHub..."
    Write-Host ""
    
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Success "=========================================="
        Write-Success "   SUCCESS!"
        Write-Success "=========================================="
        Write-Success "  $successCount commits pushed to GitHub!"
        Write-Success "  Your contribution graph is now greener!"
        Write-Host ""
        Write-Info "Check your profile: https://github.com/somsu123"
        Write-Host ""
    } else {
        Write-Error "Failed to push to GitHub"
        Write-Info "Try manually: git push origin main"
    }
} else {
    Write-Warning "No commits were created"
}

Write-Host ""
