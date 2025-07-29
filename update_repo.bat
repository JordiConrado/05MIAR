@echo off
REM --- Update your local fork from the professor's original repository ---

echo.
echo Fetching latest changes from professor's (upstream) repository...
git fetch upstream

echo.
echo Checking out your main branch and merging upstream changes...

git checkout main

git merge upstream/main

REM Optional: Resolve conflicts if any. The script will pause if conflicts occur.
REM After resolving, you'd manually run git add . and git commit -m "Resolved conflicts"

echo.
echo Pushing merged changes to your personal GitHub fork (origin)...
git push origin main

echo.
echo Update process complete.
echo You may need to manually resolve merge conflicts if they occurred.
pause