; === Custom Shortcuts ===

; Win + B -> Opens default browser
#b::Run("brave.exe")

; Win + F -> Opens file explorer
#f::Run("explorer.exe")

; Win + Enter -> Opens Windows Terminal (Sends Win + 1)
#Enter::Send("#1")

; Win + R -> Opens PowerToys Run (Alt + Space)
#r::Send("!{Space}")

; Win + Q -> Closes focused app (Alt + F4)
#q::Send("!{F4}")

; Move Window to Center (Ctrl + Alt + C)
^!c::
{
    WinGetPos(&X, &Y, &Width, &Height, "A")
    WinMove("A", , (A_ScreenWidth - Width) / 2, (A_ScreenHeight - Height) / 2)
}
