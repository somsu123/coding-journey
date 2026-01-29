# 🤖 Automation Scripts

This folder contains automation scripts to help maintain your GitHub contribution graph.

## 📜 Scripts

### `daily-commit.ps1`
Main automation script that:
- Updates your daily log
- Creates a commit with a random encouraging message
- Pushes to GitHub automatically

**Usage:**
```powershell
.\automation\daily-commit.ps1
```

**Custom message:**
```powershell
.\automation\daily-commit.ps1 -Message "Your custom commit message"
```

### `quick-commit.ps1`
Simple wrapper script - just double-click to run!

## ⚙️ Setup Task Scheduler (Optional)

To automate daily commits, you can set up Windows Task Scheduler:

1. Open **Task Scheduler**
2. Click **Create Basic Task**
3. Name: "Daily GitHub Commit"
4. Trigger: Daily at your preferred time
5. Action: Start a program
   - Program: `powershell.exe`
   - Arguments: `-ExecutionPolicy Bypass -File "C:\full\path\to\daily-commit.ps1"`
6. Finish!

## ⚠️ Important Notes

- **Be Authentic**: While automation helps maintain streaks, real learning is more important!
- **Execution Policy**: You may need to run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- **GitHub Authentication**: Ensure you're authenticated with Git

## 💡 Tips

- Use the automation as a reminder to code daily
- Make real contributions to real projects
- Update the daily log with actual progress
- Build meaningful projects alongside automation

---

**Remember**: Green squares are nice, but actual skills are better! 🚀
