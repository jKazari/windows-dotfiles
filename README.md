# Windows system setup

This repository documents and reproduces my personal Windows setup. It is not a full system image, nor an attempt to fight Windows into being Linux.

Instead, it encodes:
- what software I use
- how my system is structured
- which settings are automated vs manual
- how to restore a productive environment on a new machine safely and predictably

This repository exists so that future-me can:
- rebuild a system confidently
- avoid forgetting decisions
- understand why things are set up a certain way

The goal is reproducibility.

---

# Philosophy

This setup follows a few core principles:
1. Separation of concerns
   - System software is installed via package managers
   - Configuration lives in version control
   - Personal data lives in the cloud
   - Hardware-specific state is documented, not automated
2. Linux-like mental model on Windows
   - `Program Files` = system space
   - `%USERPROFILE%` = home directory
   - Cloud storage = documents, lightweight media, archives
   - Local-only directories = explicit, minimal, intentional
3. Best-effort automation
   - Automate what is safe
   - Document what is fragile
   - Never overwrite state blindly
   - Prefer checklists over clever scripts

---

# Repository structure
```
.
├── apps/                  # Application-specific configs
├── configs/               # List of software, paths of config files
├── system/                # System preferences and documentation
├── wallpapers/            # Local wallpapers
└── README.md
```

### `apps/`
Contains configuration files for individual applications.

Examples:
- VS Code (`settings.json`, `keybindings.json`, snippets)
- PowerShell (`Microsoft.PowerShell_profile.ps1`)
- Windows Terminal (`settings.json`)
- mpv (`mpv.conf`, scripts)
- Obsidian (.obsidian config files)
- qBittorrent, PowerToys, Thunderbird, etc.

Some configs are safe to copy automatically. Others are reference-only and must be restored manually! This distinction is intentional.

### `configs/`
Includes:
- `manual-programs.json` — canonical list of installed software
- `manual-config-files-paths.json` - list of all the paths to config directories (where to copy app-specific config files)
- `manual-standalone-games.json` - list of all my games

### `system/`
Contains declarative documentation of system-level preferences that are not always safely scriptable.

Examples:
- display settings
- power plans
- fonts
- environment variables
- taskbar and file explorer preferences
- startup programs
- wallpaper configuration

Files are named manual-*.json on purpose, to specify that they need to be restored manually.

These are:
- a checklist
- a memory aid
- a future automation reference

Not all of them should ever be automated.

### `wallpapers/`
Local wallpapers used by the system. These are treated as aesthetic configuration, not personal data.

---

# Filesystem Layout Contract
This setup follows a strict directory model.

### Software
Installed software into C:\Program Files and C:\Program Files (x86). Never installed into user directories

### User home directory (%USERPROFILE%)
Used for active local state only:
- `%USERPROFILE%\Repositories` — Git repositories
- `%USERPROFILE%\Wallpapers` — local wallpapers
- `%USERPROFILE%\Scripts` — local scripts
- `%USERPROFILE%\Obsidian` — Obsidian vaults
- `%USERPROFILE%\.config` — user-level configs
- `%USERPROFILE%\.gitconfig` — git config

### Cloud-managed data
Documents, PDFs, images, music, books and lightweight media are stored in the cloud and are out of scope for this repository. This means a clean Windows install does not require restoring personal data locally.

---

# Software Installation Strategy

## Package managers
- Primary: `winget`
  - GUI apps
  - mainstream software
  - system utilities
- Secondary: `scoop`
  - CLI tools
  - single-binary utilities
  - developer tooling

Each program in `manual-programs.json` specifies its intended install method: `winget | scoop | manual | driver`. This allows best-effort automation without forcing fragile installs.

---

# What Is Automated vs Manual

### Safe to automate
- App installation (best-effort)
- VS Code settings & extensions
- Windows Terminal config
- PowerShell profile
- mpv configuration
- PowerToys settings
- Directory creation in `%USERPROFILE%`

### Reference-only (do not auto-restore)
- Browser profiles (Firefox / Brave / Zen)
- Thunderbird profiles
- Anki state
- GPU drivers
- Display layout
- Audio device routing

These are either:
- machine-specific
- version-sensitive
- cloud-synced

They are documented, not blindly restored.

---

# New system setup guide (clean install)
This guide describes how to set up a new Windows system from scratch, using this repository as the canonical reference.

### 1. Install clean Windows
- Perform a clean Windows installation
- Sign into a Microsoft account
- Finish all mandatory setup screens
- Install drivers
- Uninstall all the windows bloatware

At this stage the system should be:
- uncustomized
- minimally functional
- stable

### 2. Establish the baseline toolchain
Install only the absolute minimum needed to proceed:
- winget (if not already present)
- git
- firefox
- VS Code

### 3. Set system preferences (manual)
Using the files in `system/manual-*.json`, configure the system manually. This includes (but is not limited to):
- Display scaling and layout
- Power plan
- Mouse and keyboard behavior
- File Explorer preferences
- Taskbar layout
- Startup programs
- Fonts
- Locale and language settings
- Wallpaper selection
- Environment variables (PATH, etc.)

### 4. Create the filesystem structure
Before restoring any configs, ensure the directory layout contract is respected. Manually create (if not present):
- `%USERPROFILE%\Repositories`
- `%USERPROFILE%\Obsidian`
- `%USERPROFILE%\Scripts`
- `%USERPROFILE%\Wallpapers`
- `%USERPROFILE%\.config`

Install Google Drive, sign in and sync. Create desktop shortcuts:
- `Home` > `G:\My Drive\Home`
- `University` > `G:\My Drive\Home\10 University\Mathematics\[Current semester]`
- `Repositories` > `%USERPROFILE%\Repositories`

### 5. Install remaining software
Using `manual-programs.json` as the source of truth. Install software via:
- `winget` (preferred)
- `scoop` (CLI tools)
- manual installers (when required)

Install broadly, but do not configure yet.

### 6. Restore application-specific configuration

1. **Anki**
	Copy the contents of `apps\anki` directory to your `Anki2` directory.
	```powershell
	Copy-Item "apps\anki\*" -Destination "C:\Users\<username>\AppData\Roaming\Anki2\" -Force -Recurse
	```
2. **Firefox**
	Copy the contents of `apps\firefox\Roaming` directory to your `Firefox` directory
	```powershell
	Copy-Item "apps\firefox\Roaming\*" -Destination "C:\Users\zacha\AppData\Roaming\Mozilla\Firefox\Profiles\" -Force -Recurse
	```
	Copy the contents of `apps\firefox\Local` directory to your `Firefox` directory
	```powershell
	Copy-Item "apps\firefox\Local\*" -Destination "C:\Users\zacha\AppData\Local\Mozilla\Firefox\Profiles\" -Force -Recurse
	```
3. **Calibre**
	Copy `apps\calibre\gui.json` to your `calibre` directory.
	```powershell
	Copy-Item "apps\calibre\gui.json" -Destination "C:\Users\<username>\AppData\Roaming\calibre\" -Force
	```
4. **Clink**
	Copy the contents of `apps\clink` directory to your `clink` directory.
	```powershell
	Copy-Item "apps\clink\*" -Destination "C:\Users\<username>\AppData\Local\clink\" -Force -Recurse
	```
5. **File explorer**
	...
6. **Git**
   Copy `apps\git\.gitconfig` to your home directory.
   ```powershell
	Copy-Item "apps\git\.gitconfig" -Destination "C:\Users\<username>\" -Force
   ```
7. **mpv**
	Copy the contents of `apps\mpv` directory to your `mpv` directory.
	```powershell
	Copy-Item "apps\mpv\*" -Destination "C:\Users\<username>\AppData\Roaming\mpv\" -Force -Recurse
	```
8. **MSYS2**
	Copy the contents of `apps\msys2` directory to your `msys64` home directory.
	```powershell
	Copy-Item "apps\msys2\*" -Destination "C:\msys64\home\<username>\" -Force -Recurse
	```
9. **Obsidian**
    Copy the contents of `apps\obsidian` directory to the `.obsidian` directory of your obsidian vault. For example:
	```powershell
	Copy-Item "apps\obsidian\*" -Destination "C:\Users\<username>\Obsidian\.obsidian\" -Force -Recurse
	```
10. **Oh my posh**
	It's not really necessary (for now) to copy the theme as I am using a predefined automatically installed `dracula` theme. However in the future when I will create my own themes, it will be necessary.
	```powershell
	Copy-Item "apps\oh-my-posh\<theme>.omp.json" -Destination "C:\Users\<username>\AppData\Local\Programs\oh-my-posh\themes\" -Force
	```
11. **Powershell**
	Copy `apps\powershell\Microsoft.PowerShell_profile.ps1` to your `WindowsPowerShell` directory.
	```powershell
	Copy-Item "apps\powershell\Microsoft.PowerShell_profile.ps1" -Destination "C:\Users\<username>\Documents\WindowsPowerShell\" -Force
	```
12. **Powertoys**
	Copy `apps\powertoys\settings.json` to your `PowerToys` directory.
	```powershell
	Copy-Item "apps\powertoys\settings.json" -Destination "C:\Users\<username>\AppData\Local\Microsoft\PowerToys\" -Force
	```
13. **qbittorrent**
	Copy the contents of `apps\qbittorrent` directory to your `qBittorrent` directory.
	```powershell
	Copy-Item "apps\qbittorrent\*" -Destination "C:\Users\zacha\AppData\Roaming\qBittorrent\" -Force -Recurse
	```
14. **Terminal**
	Open Windows Terminal, hit `Ctrl + Shift + ,`. This will reveal the location of your terminal settings in the system. Replace that `settings.json` file with the `apps\terminal\settings.json` file. For example:
	```powershell
	Copy-Item "apps\terminal\settings.json" -Destination "C:\Users\<username>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\" -Force
	```
15. **Thunderbird**
	Copy `apps\thunderbird\prefs.js` to your thunderbird profile's directory. For example:
	```powershell
	Copy-Item "apps\thunderbird\prefs.js" -Destination "C:\Users\<username>\AppData\Roaming\Thunderbird\Profiles\to5zpttk.default-release\" -Force
	```
16. **Visual Studio Code**
	Copy `apps\vs-code\settings.json` as well as `apps\vs-code\keybindings.json` and `apps\vs-code\snippets` to your VS Code directory.
	```powershell
	Copy-Item "apps\vs-code\settings.json" -Destination "C:\Users\<username>\AppData\Roaming\Code\User\" -Force
	Copy-Item "apps\vs-code\keybindings.json" -Destination "C:\Users\<username>\AppData\Roaming\Code\User\" -Force
	Copy-Item "apps\vs-code\snippets\" -Destination "C:\Users\<username>\AppData\Roaming\Code\User\" -Force -Recurse
	```

Safe to restore automatically
- VS Code:
  - settings.json
  - keybindings.json
  - snippets
  - install extensions
- Windows Terminal settings.json
- PowerShell profile
- mpv configuration
- PowerToys settings
- qBittorrent config

Restore via sync / manual confirmation
- Firefox
  - sign in
  - let sync restore extensions and preferences
- Obsidian
  - restore vault
  - verify plugins and themes
- Anki
  - sync account
  - restore backups only if needed
- Thunderbird
  - reconfigure accounts
  - selectively compare prefs.js

Do not overwrite browser or mail profiles blindly.