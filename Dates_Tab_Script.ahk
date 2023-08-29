
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
