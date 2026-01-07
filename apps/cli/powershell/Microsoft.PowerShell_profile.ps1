# PSReadLine (must be first)
Import-Module PSReadLine

# Oh My Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\dracula.omp.json" | Invoke-Expression

# Terminal icons
Import-Module Terminal-Icons

# Zoxide
zoxide init powershell | Out-String | Invoke-Expression

# Fzf history (Ctrl+R)
Set-PSReadLineKeyHandler -Key Ctrl+r -ScriptBlock {
    $history = Get-Content (Get-PSReadLineOption).HistorySavePath
    $command = $history | fzf
    if ($command) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
    }
}

# Aliases
Remove-Item Alias:cat -Force
Set-Alias cat bat
Set-Alias find fd
Set-Alias ll Get-ChildItem
Set-Alias la Get-ChildItem

function ll {
    Get-ChildItem -Force
}

function la {
    Get-ChildItem -Force
}
