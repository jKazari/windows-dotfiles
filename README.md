# Windows system setup and dotfiles
This repository documents my personal Windows setup and provides a structured way to restore it on a new machine.

It contains:
- installation steps
- lists of installed software
- application configuration files
- documentation for manual system settings

The repository is meant to be used as a reference and checklist, with limited automation where it is safe to do so.

## Repository layout
- `setup/`  
  Step-by-step guide for setting up a fresh Windows installation.  
  Start here on a new system.

- `apps/cli/`  
  Configuration and restore instructions for command-line and terminal tools.

- `apps/gui/`  
  Configuration and restore instructions for GUI applications.

- `system/`  
  Documentation of system-level settings that are configured manually
  (display, input, explorer, privacy, startup behavior, etc.).

- `inventory/`  
  Canonical lists of installed software (winget, scoop, games).

- `wallpapers/`  
  Wallpapers used by the system.

---

## How to use this repository
1. Follow `setup/new-install.md` on a clean Windows install.
2. Install software as instructed.
3. Restore CLI configuration first.
4. Restore GUI application configuration afterward.
5. Use the repository as the source of truth when modifying or rebuilding the system.

This repository is descriptive first and automated only where appropriate.
