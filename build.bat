@echo off
setlocal

REM --- Compile the Obsidian plugin (esbuild -> main.js) ---
echo Building plugin...
call npm run build
if errorlevel 1 (
    echo.
    echo Build failed. Aborting.
    pause
    exit /b 1
)

REM --- Copy main.js, styles.css, manifest.json to the system clipboard ---
REM The files are placed on the clipboard as file objects, so you can paste them
REM directly into your vault's plugin folder via Explorer (Ctrl+V).
powershell -NoProfile -Command "Set-Clipboard -LiteralPath '%~dp0main.js', '%~dp0styles.css', '%~dp0manifest.json'"
if errorlevel 1 (
    echo.
    echo Failed to copy files to the clipboard.
    pause
    exit /b 1
)

echo.
echo Done. main.js, styles.css and manifest.json are now on the clipboard.
echo Paste them into your vault's .obsidian/plugins/<plugin-id>/ folder.
