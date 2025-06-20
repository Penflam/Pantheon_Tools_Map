local $UI_y = 25
GUICreate("PantheonRoadMap", 160, 120, -1, -1, $WS_CAPTION + $WS_SYSMENU)

Global $tab = GUICtrlCreateTab(2, 0, 158, 95)
GUICtrlCreateTabItem("Map")

; === Menu principal ===
Global $menuReset = GUICtrlCreateMenu("Reset")
Global $menuQui = GUICtrlCreateMenu("?")
Global $menuCounter = GUICtrlCreateMenu("")

; Sous-menu Reset
Global $itemResetClear = GUICtrlCreateMenuItem("Reset Pins", $menuReset)
; Sous-menu Aide
Global $itemQuiAide = GUICtrlCreateMenuItem("À propos...", $menuQui)

; UI Zoom
Global $lblZoom = GUICtrlCreateLabel("Zoom: " & $g_iZoom, 10, $UI_y, 70, 20)
Global $btnZoomMoins = GUICtrlCreateButton("-", 90, $UI_y-5, 30, 25)
Global $btnZoomPlus  = GUICtrlCreateButton("+", 120, $UI_y-5, 30, 25)

; UI delay
$UI_y += 25 ; 100
Global $trackSpeed = GUICtrlCreateLabel("Delay: " & $checkDelay, 10, $UI_y, 70, 20)
Global $btnTrackSpeedMoins = GUICtrlCreateButton("-", 90, $UI_y-5, 30, 25)
Global $btnTrackSpeedPlus  = GUICtrlCreateButton("+", 120, $UI_y-5, 30, 25)

; UI Track
$UI_y += 20 ; 100
Global $chkMultiPin = GUICtrlCreateCheckbox("Track", 10, $UI_y+2, 45, 20)
GUICtrlSetState($chkMultiPin, $GUI_CHECKED)

; UI Shalazam Btn
Global $btnShalazam = GUICtrlCreateButton("Go Shalazam !", 60, $UI_y, 90, 25)
GUICtrlSetState($btnShalazam, $GUI_HIDE)

GUICtrlCreateTabItem("XP")
$Ui_y = 30
Global $XP_Base_label = GUICtrlCreateLabel("Base: 0%", 5, $UI_y, 80, 20)
$Ui_y += 15
Global $XP_label = GUICtrlCreateLabel("XP: 0%", 5, $UI_y, 80, 20)
$Ui_y += 15
Global $XP_Gain_label = GUICtrlCreateLabel("Gain: 0%", 5, $UI_y, 80, 20)
$Ui_y += 15
Global $XP_Gain_Old_label = GUICtrlCreateLabel("Prev: 0%", 5, $UI_y, 80, 20)
$Ui_y = 30
Global $btnGameActivity  = GUICtrlCreateButton("Game AOff", 92, $Ui_y, 60)
GUICtrlSetBkColor($btnGameActivity, 0x00FF00) ; Vert
GUICtrlSetState($btnGameActivity, $GUI_DISABLE)

GUISetState(@SW_SHOW)
WinSetOnTop("[ACTIVE]", "", 1)