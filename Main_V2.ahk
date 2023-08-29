
; AutoHotkey Productivity Script v2.1

#Persistent

; Initialization
FileDelete, Logs.txt  ; Clear the existing log file for a fresh start
FileAppend, ""Script Initialization Started`n"", Logs.txt

Global Settings := {
}
Global Applications := Object()
Global ExcludedDates := Object()
Global Logs := []

; Initialize the script GUI
Gui, Add, Tab, , Applications|Dates|Settings|Logs
FileAppend, ""GUI Tabs Initialized`n"", Logs.txt

; Applications Tab Logic

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


; Dates Tab Logic

; AutoHotkey Script for Dates Tab

; Define subroutine for Add button
AddDate:
FileAppend, "Attempting to add date to DateList.`n", Logs/Dates_Log.txt
Gui, Date:Submit, NoHide
InputBox, NewDate, Add Date, Enter the date (YYYY-MM-DD):
If (NewDate != "")
{
    Gui, Date:ListView, DateList
    LV_Add("", NewDate)
    FileAppend, "Date '%NewDate%' added successfully.`n", Logs/Dates_Log.txt
}
Else
{
    FileAppend, "Failed to add date. Date is missing.`n", Logs/Dates_Log.txt
}
Gui, Date:Show
Return

; Initialize GUI for Dates Tab
Gui, Date:New, , Dates Tab
Gui, Date:Add, ListView, r20 w300 vDateList, Date
Gui, Date:Add, Button, gAddDate, Add
Gui, Date:Show


; Settings Tab
Gui, Tab, Settings
Gui, Add, Checkbox, vAutoStart, Auto-Start
FileAppend, ""Settings Tab Initialized`n"", Logs.txt

; Logs Tab
Gui, Tab, Logs
Gui, Add, Edit, w400 h200 vLogArea ReadOnly
FileAppend, ""Logs Tab Initialized`n"", Logs.txt

; Show GUI
Gui, Show, w500 h300, AutoHotkey Productivity Script
FileAppend, ""GUI Shown`n"", Logs.txt

; Auto-Start Logic
SetTimer, AutoRun, 60000  ; Run every 60 seconds
FileAppend, ""Auto-Start Initialized`n"", Logs.txt

; Main AutoRun Logic
AutoRun:
    FormatTime, CurrentTime,, HH
    If (CurrentTime >= 9 and CurrentTime <= 18)
    {
        For AppName, AppPath in Applications
        {
            If !WinExist(AppName)
            {
                Run, %AppPath%
                FileAppend, A_TickCount "" - Auto-Started "" AppName ""`n"", Logs.txt
            }
        }
    }
Return
