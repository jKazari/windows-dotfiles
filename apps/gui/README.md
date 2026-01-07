# GUI application configuration
This directory documents configuration and restoration of graphical applications installed via winget or other installers.

Unlike CLI tools, GUI applications vary widely in how they store state, what can be safely copied, and what is better restored via sync or manual setup. As a result, restoration is intentionally conservative and mostly manual.

All applications referenced here are assumed to already be installed, as described in `setup/new-install.md`.

All paths in this document are written as absolute paths and do not assume a current working directory.

## General principles
GUI applications are restored using one of three approaches:

1. Sign in and let the application sync its state
2. Copy a small number of known configuration files
3. Copy and replace the entire application profile directory

Which approach is used depends on how reliable the application’s own sync mechanisms are and how sensitive its local state is to machine-specific differences.

When in doubt, prefer documentation over automation.

## Sign-in and sync only
The following applications are restored primarily by signing in and allowing their built-in sync mechanisms to restore state.

For these applications:
- do not copy configuration files manually
- sign in after installation
- verify settings inside the application

### Applications in this category
- Notion
- Zotero
- Google Drive
- iCloud
- iTunes
- Visual Studio Code
- Bitwarden
- Anki
- Discord
- Spotify
- GitHub Desktop
- SignalRGB
- Game launchers (Steam, GOG Galaxy, Battle.net, Ubisoft Connect, EA App, HoYoPlay, Paradox Launcher)

### Procedure
1. Launch the application.
2. Sign in to the appropriate account.
3. Allow synchronization to complete.
4. Verify that data and settings are present.
5. Adjust any remaining preferences manually.

No files from this repository are copied for applications in this category.

## Configuration-copy friendly applications
These applications store most of their state in a small, well-defined set of configuration files. Their configuration can be restored by copying files from this repository into the appropriate location.

Overwriting existing configuration on a fresh install is safe.

### Actual
Follow the guide on https://actualbudget.org/docs/backup-restore/restore

Restore by copying the file in `$HOME\Repositories\windows-dotfiles\apps\gui\actual\*` into location specified in the article.

### Calibre
Configuration lives under:
```powershell
$env:APPDATA\calibre
```

Restore by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\gui\calibre\*" `
  -Destination "$env:APPDATA\calibre\" `
  -Recurse -Force
```

### PowerToys
Configuration lives under:
```powershell
$env:LOCALAPPDATA\Microsoft\PowerToys
```

Restore by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\gui\powertoys\*" `
  -Destination "$env:LOCALAPPDATA\Microsoft\PowerToys\" `
  -Recurse -Force
```
Restart PowerToys after restoring configuration.

### qBittorrent
Configuration lives under:
```powershell
$env:APPDATA\qBittorrent
```

Restore by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\gui\qbittorrent\*" `
  -Destination "$env:APPDATA\qBittorrent\" `
  -Recurse -Force
```

## Applications with partial or unreliable sync
Some applications provide cloud synchronization, but in practice do not reliably restore all state. This commonly includes UI layout, appearance settings, extensions or plugins, and certain application-specific preferences.

For these applications, the most reliable restoration method is to copy the entire local profile directory from the old machine and place it into the appropriate location on the new system.

This process is intentionally manual and invasive.

### Firefox
Firefox provides sync, but it does not reliably restore:
- toolbar layout
- certain UI customizations
- some extension state

The recommended approach is to copy the full Firefox profile.

**On the original machine:**
1. Open Firefox.
2. Navigate to about:support.
3. Locate Profile Folder and click Open Folder.
4. Close Firefox completely.
5. Go up two levels to the Profiles directory.
6. Copy the entire profile folder to a transfer medium.

The profile directory is typically located under:
```powershell
$env:APPDATA\Mozilla\Firefox\Profiles
```

**On the new machine:**
1. Launch Firefox once, then close it.
2. Navigate to:
	```powershell
	$env:APPDATA\Mozilla\Firefox\Profiles
	```
3. Replace the newly created profile directory with the copied one.
4. Launch Firefox and verify:
	- extensions
	- UI layout
	- settings

### Thunderbird
Thunderbird sync is unreliable for full profile restoration. The recommended approach is to copy the entire Thunderbird profile directory.

**On the original machine:**
1. Open Thunderbird.
2. Go to **Help → Troubleshooting Information**.
3. Locate **Profile Folder** and click **Open Folder**.
4. Close Thunderbird completely.
5. Go up three levels until the `Thunderbird` directory is visible.
6. Copy the entire `Thunderbird` directory to a transfer medium.

The directory is typically located under:
```powershell
$env:APPDATA\Thunderbird
```

**On the new machine:**
1. Launch Thunderbird once, then close it.
2. Navigate to:
	```powershell
	$env:APPDATA
	```
3. Replace the existing Thunderbird directory with the copied one.
4. Launch Thunderbird and verify:
	- accounts
	- folders
	- extensions
	- UI state

### Obsidian
Obsidian provides sync, but certain appearance settings, plugin states, and UI layout inconsistencies are common.

The recommended approach is to copy the `.obsidian` directory for each vault.

**On the original machine:**
1. Close Obsidian completely.
2. Navigate to the root directory of the vault.
3. Copy the `.obsidian` directory to a transfer medium.

**On the new machine:**
1. Restore the vault directory itself (via cloud sync or manual copy).
2. Close Obsidian.
3. Paste the copied .obsidian directory into the vault root, overwriting the existing one.
4. Launch Obsidian and verify:
	- plugins
	- appearance
	- editor behavior

## Verification
After restoring GUI applications:
- Launch each application at least once.
- Verify that data and settings are present.
- Check for unexpected defaults.
- Resolve issues immediately before daily use.

GUI configuration is intentionally the final step in system restoration.