#NoEnv
#Warn
#SingleInstance, force
SendMode Input
SetWorkingDir %A_ScriptDir%

Gui, +Resize
Gui, Add, Checkbox, y10 vAntiSleepVal, Keep display active
Gui, Add, Checkbox, vAntiIdleVal, Move mouse
Gui, Add, Checkbox, vAntiAFKVal, Press modifier keys
Gui, Add, Button, y+10 w50, Start
Gui, Add, Button, x+10 w50, Stop
Gui, Add, Text, x+10 yp+5 Hidden vStatus, Anti Idle ON
Gui, Show, w300 h110, Anti Idle
Return

ButtonStart:
    Gui, Submit, NoHide
    
    if (AntiIdleVal)
        SetTimer, AntiIdle, 2000
    if (AntiSleepVal)
        SetTimer, AntiSleep, 120000
    if (AntiAFKVal)
        SetTimer, AntiAFK, 5000
    
    if (AntiIdleVal or AntiSleepVal or AntiAFKVal)
        GuiControl, Show, Status
Return

ButtonStop:
    GuiControl, Hide, Status
    SetTimer, AntiIdle, off
    SetTimer, AntiSleep, off
    SetTimer, AntiAFK, off
Return

AntiSleep:
    DllCall("SetThreadExecutionState", UInt, 0x80000003)
Return

AntiIdle:
    MouseMove, 0, 1, 0, R
    Sleep 1000
    MouseMove, 0, -1, 0, R
Return

AntiAFK:
    Send, {Shift}
    Send, {Ctrl}
Return

GuiClose:
ExitApp

Esc::ExitApp