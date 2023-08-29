
; AutoHotkey Script for Applications Tab

; Create Applications Logs folder if it doesn't exist
IfNotExist, Logs\Applications
    FileCreateDir, Logs\Applications

; Initialize GUI for Applications Tab
Gui, App:New, , Applications Tab
Gui, App:Add, ListView, r20 w500 vAppList, Application|Path|Time
Gui, App:Add, Button, gAddApp, Add

; Define subroutine for Add button
AddApp:
FileAppend, "Attempting to add application to AppList.`n", Logs/Applications/Applications_Log.txt
Gui, App:Submit, NoHide
InputBox, NewApp, Add Application, Enter the application name:
InputBox, NewPath, Add Application, Enter the application path:
if (NewApp != "" &&  NewPath != "")  
{
    Gui, App:ListView, AppList
    LV_Add("", NewApp, NewPath, "9:00 AM")
    FileAppend, "Application '%NewApp%' added successfully.`n", Logs/Applications/Applications_Log.txt
}
else
{
    FileAppend, "Failed to add application. Name or path is missing.`n", Logs/Applications/Applications_Log.txt
}
Gui, App:Show
Return
