@echo off
REM --- Automated Git Workflow for 05miar Project ---
REM This script will:
REM 1. Navigate to your project directory.
REM 2. Fetch updates from the professor's (upstream) repository.
REM 3. Merge those updates into your local main branch.
REM 4. Stage any new, modified, or deleted files in your local repository.
REM 5. Commit these staged changes locally.
REM 6. Push all local commits to your personal GitHub fork (origin).

set "PROJECT_DIR=G:\My Drive\Masters\viu\VIU_Notebooks\05miar"

REM IMPORTANT: Set your main branch name (usually 'main' or 'master')
set "MAIN_BRANCH=main"

echo.
echo Navigating to project directory: %PROJECT_DIR%
cd /d "%PROJECT_DIR%"
if %errorlevel% neq 0 (
    echo ERROR: Could not navigate to the project directory. Please check the path.
    pause
    exit /b 1
)

echo.
echo --- Step 1: Fetching latest changes from professor's (upstream) repository ---
git fetch upstream
if %errorlevel% neq 0 (
    echo ERROR: Failed to fetch from upstream. Check your internet connection or upstream remote.
    pause
    exit /b 1
)

echo.
echo --- Step 2: Checking out your %MAIN_BRANCH% branch and merging upstream changes ---
git checkout %MAIN_BRANCH%
if %errorlevel% neq 0 (
    echo ERROR: Failed to checkout %MAIN_BRANCH% branch.
    pause
    exit /b 1
)

git merge upstream/%MAIN_BRANCH%
if %errorlevel% neq 0 (
    echo.
    echo WARNING: Merge conflicts might have occurred or merge failed.
    echo Please resolve any merge conflicts manually, then run:
    echo    git add .
    echo    git commit -m "Resolved conflicts and merged upstream"
    echo    git push origin %MAIN_BRANCH%
    echo.
    pause
    exit /b 1
)

echo.
echo --- Step 3: Staging all new, modified, and deleted files ---
git add .
if %errorlevel% neq 0 (
    echo ERROR: Failed to stage files.
    pause
    exit /b 1
)

echo.
echo --- Step 4: Committing staged changes locally ---
REM Using a generic commit message. For a specific message, commit manually.
git commit -m "Automated update: Merged upstream and committed local changes."
REM Check if there was anything to commit (git commit returns 1 if no changes)
if %errorlevel% neq 0 (
    echo No new changes to commit. Skipping commit step.
) else (
    echo Changes committed successfully.
)

echo.
echo --- Step 5: Pushing all local commits to your personal GitHub fork (origin) ---
git push origin %MAIN_BRANCH%
if %errorlevel% neq 0 (
    echo ERROR: Failed to push to origin. Check your internet connection or GitHub credentials.
    pause
    exit /b 1
)

echo.
echo --- Automated Git Workflow Complete! ---
echo Your local repository is now synced with upstream, and your fork is updated.
pause