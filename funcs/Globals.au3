
Global $sIniPath = @ScriptDir & ".\ini.ini"
Global $NavigatorPath =  "C:\Program Files\Mozilla Firefox\firefox.exe"

; === Paramètres ===
Global $UserName = @UserName
Global $LastClip = ""
Global $aCoords[0]
Global $g_iZoom = 8
Global $pincounter = 0
Global $g_bMultiPin = True ; par défaut activé
Global $checkDelay = 2000
Global $routeUrl = ""

Global $counterRead = 0
Global $delayRead = 10


; -------- DetectXp ---------------
Global $ColorXp = 0x2A63D8
Global $XP = 0
Global $XP_Base = 0
Global $XP_Old = 0
Global $Gain = 0
Global $Gain_Old = 0


; -------- WinGet ---------------
Global $Win_Game_Size_Old = [0,0]
Global $Win_Game_Size = [0,0]
Global $Win_Game_Size_New = False
Global $Game_Title = "Pantheon";
Global $Win_Game_Title = "[Title:"&$Game_Title&"]"; 
Global $Win_Game_Class = "[Class:UnityWndClass]"; 
Global $Win_isGame_On = false
Global $Win_isGame_Active = false
Global $Win_Handle = False