# New system installation guide
This guide assumes that Windows is already installed, all required drivers are present, and all Windows Updates have been applied. At this stage the system should be stable but largely uncustomized and unpleasant to use.

Do not start installing applications yet.

## Initial cleanup and debloating
Before doing anything else, remove obvious friction from the default Windows installation. This includes bundled applications, excessive telemetry, advertising features, and UI annoyances.

I usually do this using ChrisTitusTech’s winutil. Run it in PowerShell and apply only conservative options. The goal is to remove things I never use and disable intrusive behavior, not to aggressively optimize or apply experimental tweaks.

After finishing this step, reboot the system.

## Manual system configuration
Now configure Windows so that it is usable visually and ergonomically.

Go through the Settings application manually, category by category:
- Settings → System
- Settings → Personalization
- Settings → Time & Language
- Settings → Privacy & Security

Adjust settings according to the reference files in the `system/` directory of this repository. This includes File Explorer preferences, input behavior, display settings, language and locale, privacy toggles, and general UI configuration.

These settings are intentionally documented rather than automated. Do not proceed until the system feels correct to use.

## Establish the baseline toolchain
Open PowerShell.

First, verify whether `winget` is already available:
```powershell
winget --version
```
If the command is not found, install winget via the Microsoft Store or App Installer and restart the terminal.

Once `winget` is available, install the baseline tools:
```powershell
winget install Git.Git
winget install Mozilla.Firefox
winget install Microsoft.VisualStudioCode
```

Verify that all installed correctly:
```powershell
firefox --version
code --version
```

Now install Scoop. If execution policy prevents installation, allow it for the current user.
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

Add required Scoop buckets:
```powershell
scoop bucket add extras
scoop bucket add nerd-fonts
```

## Install CLI and development tooling (Scoop)
All CLI tools, programming languages, and developer utilities are installed via Scoop.

Install packages in stages. Do not rush this step.

Install the packages listed in `inventory/scoop-packages.txt`. The current set includes, among others:

### Languages and build tools
```powershell
scoop install python
scoop install nodejs
scoop install gcc
scoop install llvm
scoop install gdb
scoop install cmake
scoop install perl
```

> `llvm` provides `clang` and `clang++`, which are verified below.

Verify:
```powershell
git --version
python --version
node --version
gcc --version
clang --version
gdb --version
cmake --version
perl --version
```

Stop and fix any issues before continuing. Google errors if needed using Firefox.

### Terminal and productivity tools
```powershell
scoop install clink
scoop install oh-my-posh
scoop install zoxide
scoop install fzf
scoop install bat
scoop install fd
scoop install ripgrep
```

Install the terminal font:
```powershell
scoop install CascadiaCode-NF
```

Verify:
```powershell
oh-my-posh --version
zoxide --version
fzf --version
bat --version
fd --version
rg --version
```

Resolve errors before continuing.

### Utilities
```powershell
scoop install 7zip
scoop install ffmpeg
scoop install imagemagick
scoop install typst
```

Verify:
```powershell
7z
ffmpeg -version
magick -version
typst --version
```

Resolve errors before continuing.

## Verify and clean PATH
At this point, all tools should resolve correctly.

Check PATH resolution:
```powershell
gcm python
gcm node
gcm gcc
gcm git
```

or in `cmd.exe`

```cmd
where python
where node
where gcc
where git
```

Verify PATH contents:
```powershell
$env:PATH -split ';'
```

Ensure that:
- `$HOME\scoop\shims` is present
- individual Scoop app directories are not required
- `Microsoft\WindowsApps` appears last

If necessary, clean PATH manually so that Scoop shims are the single source of truth.

Do not continue until PATH is clean and predictable.

## Important Windows paths and environment variables (good to know)
During installation and troubleshooting, it is useful to know where Windows and applications actually store files. This section documents the paths that matter most for this setup.

`$HOME` refers to the user home directory (`C:\Users\<username>`). In PowerShell, `$HOME` is preferred over hard-coded paths. The `~` shortcut expands to the same location, but `$HOME` is more explicit and is used throughout this document.

Application configuration is primarily split between two locations. `%APPDATA%` (`C:\Users\<username>\AppData\Roaming`) is used for roaming configuration that is safe to sync or copy between machines. `%LOCALAPPDATA%` (`C:\Users\<username>\AppData\Local`) is used for machine-specific state, caches, and large local data. When restoring application configuration, these two locations must be treated differently.

Scoop installs all CLI tools under `$HOME\scoop`. Installed applications live in `$HOME\scoop\apps`, but these directories should never be modified directly. Executables are exposed through `$HOME\scoop\shims`, which is the only Scoop-related path that should appear in `PATH`. If a tool behaves incorrectly, the problem should be solved via Scoop, not by editing files inside `scoop\apps`.

Windows Store applications expose command-line entry points through the `WindowsApps` directory (`%LOCALAPPDATA%\Microsoft\WindowsApps`). This directory must remain on `PATH`, but it should always appear last. It contains stub executables that can shadow real tools if ordered incorrectly.

User startup programs are controlled via the Startup folder. This folder can be opened using `shell:startup` and expands to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`. Applications placed here start automatically for the current user. System-wide startup uses a different location and is not modified as part of this setup.

Several system folders can be opened directly using shell commands (`Win + R`) such as `shell:desktop`, `shell:downloads`, or `shell:appsFolder`. These are useful for navigation and troubleshooting, but are not directly modified during installation.

Understanding these locations makes it much easier to debug configuration issues, restore application state correctly, and avoid accidental misconfiguration.

## Create the home directory structure
Create the standard directory layout in the home directory:
```powershell
New-Item -ItemType Directory -Path "$HOME\Repositories"
New-Item -ItemType Directory -Path "$HOME\Scripts"
New-Item -ItemType Directory -Path "$HOME\Obsidian"
New-Item -ItemType Directory -Path "$HOME\Wallpapers"
```

## Clone the dotfiles repository
Change into the repositories directory and clone this repository:
```powershell
cd $HOME/Repositories
git clone https://github.com/jKazari/windows-dotfiles.git
```
From this point onward, follow instructions from the cloned repository.

## Wallpapers and appearance
Copy wallpapers from the repository into the local wallpapers directory:
```powershell
Copy-Item "windows-dotfiles\wallpapers\*" -Destination "$HOME\Wallpapers" -Recurse -Force
```
Set wallpapers manually in Windows settings according to `system/wallpaper-settings.json`.

## Install GUI applications (winget)
Install GUI applications using winget, following the list in `inventory/winget-packages.txt`.

Install applications broadly, but do not configure them yet. The goal at this stage is availability, not personalization.

## Install Google Drive
Install Google Drive using winget:
```powershell
winget install Google.GoogleDrive
```
Sign in and allow synchronization to complete before proceeding.

## Create desktop links
Create shortcuts or symlinks to important locations:
```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\Desktop\Home" -Target "G:\My Drive\Home"
New-Item -ItemType SymbolicLink -Path "$HOME\Desktop\University" -Target "G:\My Drive\Home\10 University\Mathematics\Mathematics <current semester> sem"
New-Item -ItemType SymbolicLink -Path "$HOME\Desktop\Repositories" -Target "$HOME\Repositories"
```
> If symlink creation fails, ensure Developer Mode is enabled or rerun PowerShell as administrator.

Adjust paths as needed depending on Drive configuration.

## Application configuration
At this point:
- all software is installed
- the terminal environment is stable
- filesystem layout is correct

Next steps are intentionally separated:
- CLI and terminal configuration: see `apps/cli/README.md`
- GUI application configuration: see `apps/gui/README.md`

These steps are time-consuming and application-specific. Follow per-app instructions carefully and avoid overwriting profiles blindly.