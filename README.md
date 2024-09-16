## Restoring configurations

### App-specific
1. **Anki**
	Copy the contents of `apps\anki` directory to your `Anki2` directory.
	```powershell
	Copy-Item "apps\anki\*" -Destination "C:\Users\<username>\AppData\Roaming\Anki2\" -Force -Recurse
	```
2. **Brave**
	...
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

### System

### Games