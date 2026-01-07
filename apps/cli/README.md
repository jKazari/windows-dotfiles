# CLI and terminal configuration
This directory contains configuration for command-line and terminal-related tools. These tools are treated as part of a single environment rather than as isolated applications.

All software referenced here is assumed to be already installed via `Scoop` or `winget`, as described in `setup/new-install.md`. This directory documents how the environment is restored and what is safe to copy automatically.

The guiding principle is simple: CLI tools are low-risk, text-based, and reproducible. Where possible, configuration is copied directly. Where this is not safe, behavior is documented instead.

> All paths in this document are written as absolute paths and do not assume a current working directory.

## Scope
This directory covers:
- PowerShell configuration
- Prompt configuration (Oh My Posh)
- Terminal behavior (Windows Terminal)
- Shell enhancements (`zoxide`, `fzf`, `bat`, `fd`, `ripgrep`)
- Command-line `Git` configuration
- `mpv` (treated as CLI-first despite having a GUI)
- `clink` (for `cmd.exe` compatibility)

This directory does not cover GUI-heavy applications or applications whose primary configuration happens through a graphical interface. Those are documented in `apps/gui/README.md`.

## Restoration order
CLI configuration should be restored **after**:
- the system is configured
- Scoop packages are installed
- `PATH` is clean and verified

Do not attempt to restore CLI configuration before the terminal environment is stable.

## PowerShell
PowerShell is the primary interactive shell.

The profile file lives at:
```powershell
$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
```

Restore it by copying:

```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\cli\powershell\Microsoft.PowerShell_profile.ps1" `
  -Destination "$HOME\Documents\WindowsPowerShell\" `
  -Force
```

The profile assumes:
- PowerShell 7 is installed
- PSReadLine is available
- Oh My Posh is installed
- All CLI tools resolve correctly via `PATH`

If errors appear on shell startup, stop and resolve them before proceeding.

## Oh My Posh
Oh My Posh is used for prompt rendering.

At the moment, a predefined theme (`dracula`) is used. No custom theme is restored automatically. If custom themes are added in the future, they will live in this directory and must be copied explicitly.

Prompt initialization is handled entirely in the PowerShell profile.

## Windows Terminal

Windows Terminal configuration is stored outside of the repository by default.

The active configuration file can be opened from inside Windows Terminal using:
```
Ctrl + Shift + ,
```

Restore the terminal configuration by replacing the system `settings.json` with the one stored in:
```powershell
$HOME\Repositories\windows-dotfiles\apps\cli\terminal\settings.json
```

> This should be done manually to avoid overwriting machine-specific values such as profile GUIDs.

## zoxide, fzf, bat, fd, ripgrep
These tools are installed via Scoop and require minimal configuration.

Integration is handled through the PowerShell profile:
- `zoxide` replaces manual directory jumping
- `fzf` is used for interactive history search
- `bat` replaces `cat`
- `fd` replaces `find`
- `ripgrep` is used for text search

No standalone configuration files are required. Behavior should be verified interactively after restoring the profile.

## Git
Git is installed via winget as part of the baseline toolchain.

User-level Git configuration lives in:
```powershell
$HOME\.gitconfig
```

Restore it by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\cli\git\.gitconfig" -Destination "$HOME\" -Force
```

This configuration is safe to restore automatically. Credentials and authentication are handled separately via GitHub Desktop and the Windows credential manager.

## clink
clink is used only to improve the legacy `cmd.exe` experience.

Configuration lives under:
```powershell
$env:LOCALAPPDATA\clink
```

Restore by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\cli\clink\*" `
  -Destination "$env:LOCALAPPDATA\clink\" `
  -Recurse -Force
```

## mpv
mpv is treated as a CLI-first application.

Configuration lives under:
```powershell
$env:APPDATA\mpv
```

Restore by copying:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\cli\mpv\*" `
  -Destination "$env:APPDATA\mpv\" `
  -Recurse -Force
```
Scripts and configuration are text-based and safe to restore automatically.

## msys2
MSYS2 is treated as a separate environment and is not integrated deeply into the system.

Only user home files are restored. System-level MSYS2 configuration is left untouched.

Restore files by copying into the MSYS2 home directory:
```powershell
Copy-Item "$HOME\Repositories\windows-dotfiles\apps\cli\msys2\*" `
  -Destination "C:\msys64\home\$env:USERNAME\" `
  -Recurse -Force
```
This step is optional and only required if MSYS2 is actively used.

## Verification
After restoring CLI configuration:
- Open a new PowerShell session
- Ensure the prompt loads without errors
- Verify that `z`, `fzf`, `bat`, and `Git` behave as expected
- Confirm that `PATH` resolution is unchanged

If something breaks, fix it before moving on to GUI applications.