#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <GuiConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Timers.au3>
#include <Clipboard.au3>
#include <Array.au3>
#include <WinAPI.au3>

Global $sIniPath = @ScriptDir & ".\ini.ini"
Global $NavigatorPath = IniRead($sIniPath, "Path", "NavigatorPath", "C:\Program Files\Mozilla Firefox\firefox.exe")
; === Paramètres ===
Global $UserName = @UserName
Global $LastClip = ""
Global $aCoords[0]
Global $g_iZoom = 8
Global $pincounter = 0
Global $g_bMultiPin = True ; par défaut activé
Global $checkDelay = 2000
Global $routeUrl = ""

; === Map taille arbitraire ===
Global $mapW = 12000
Global $mapH = 12000

; === Détecter Firefox ===
If FileExists($NavigatorPath) Then
    Global $g_sBrowser = $NavigatorPath
Else
    MsgBox(16, "Erreur", "Navigateur non trouvé. Changez le chemin dans ini.ini !")
    Exit
EndIf

; === GUI simplifiée ===
local $UIy = 10
GUICreate("RoadMap", 160, 120, -1, -1, $WS_CAPTION + $WS_SYSMENU)

; === Menu principal ===
Global $menuReset = GUICtrlCreateMenu("Reset")
Global $menuQui = GUICtrlCreateMenu("?")

; Sous-menu Reset
Global $itemResetClear = GUICtrlCreateMenuItem("Reset Pins", $menuReset)
; Sous-menu Aide
Global $itemQuiAide = GUICtrlCreateMenuItem("À propos...", $menuQui)

; UI Zoom
Global $lblZoom = GUICtrlCreateLabel("Zoom: " & $g_iZoom, 10, $UIy, 70, 20)
Global $btnZoomMoins = GUICtrlCreateButton("-", 90, $UIy-5, 30, 25)
Global $btnZoomPlus  = GUICtrlCreateButton("+", 120, $UIy-5, 30, 25)

; UI delay
$UIy = $UIy + 27 ; 100
Global $trackSpeed = GUICtrlCreateLabel("Delay: " & $checkDelay, 10, $UIy, 70, 20)
Global $btnTrackSpeedMoins = GUICtrlCreateButton("-", 90, $UIy-5, 30, 25)
Global $btnTrackSpeedPlus  = GUICtrlCreateButton("+", 120, $UIy-5, 30, 25)

; UI Track
$UIy = $UIy + 27 ; 100
Global $chkMultiPin = GUICtrlCreateCheckbox("Track", 10, $UIy+2, 45, 20)
GUICtrlSetState($chkMultiPin, $GUI_CHECKED)

; UI Shalazam Btn
Global $btnShalazam = GUICtrlCreateButton("Go Shalazam !", 60, $UIy, 90, 25)
GUICtrlSetState($btnShalazam, $GUI_HIDE)

GUISetState(@SW_SHOW)
WinSetOnTop("[ACTIVE]", "", 1)

; === Démarrage vérification presse-papier ===
AdlibRegister("_CheckClipboard", $checkDelay)
While 1
		Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnShalazam
			If $routeUrl <> "" Then
				ShellExecute("firefox.exe", "" & '"' & $routeUrl & '"')
			EndIf
		Case $btnTrackSpeedMoins
			If $checkDelay > 500 Then
				$checkDelay -= 500
				GUICtrlSetData($trackSpeed, "Delay: " & $checkDelay)
			EndIf
		Case $btnTrackSpeedPlus
			If $checkDelay < 10000 Then
				$checkDelay += 500
				GUICtrlSetData($trackSpeed, "Delay: " & $checkDelay)
			EndIf
		Case $btnZoomMoins
			If $g_iZoom > 2 Then
				$g_iZoom -= 1
				GUICtrlSetData($lblZoom, "Zoom: " & $g_iZoom)
			EndIf
		Case $btnZoomPlus
			If $g_iZoom < 10 Then
				$g_iZoom += 1
				GUICtrlSetData($lblZoom, "Zoom: " & $g_iZoom)
			EndIf
		Case $chkMultiPin
			$g_bMultiPin = (BitAND(GUICtrlRead($chkMultiPin), $GUI_CHECKED) <> 0)
		Case $itemResetClear
			_ClearPins()
			$routeUrl = ""
		Case $itemQuiAide
			MsgBox(64, "A propos", "Loc Tracker" & @CRLF & _
				"Version : 1.0" & @CRLF & _
				"Auteur : Patapizza 😎" & @CRLF & _
				"Utilise les données du presse-papier pour suivre ta position dans le jeu grace au super site de shalazam.info.")
	EndSwitch
WEnd

; === Fonctions ===
Func _ClearPins()
    ReDim $aCoords[0]
    $pincounter = 0
	GUICtrlSetState($btnShalazam, $GUI_HIDE)
EndFunc

Func _CheckClipboard()
    Local $clip = _ClipBoard_GetData()
    If @error Or $clip = $LastClip Then Return

    $LastClip = $clip

    Local $a = StringRegExp($clip, "^/jumploc\s+([-+]?\d+\.\d+)\s+([-+]?\d+\.\d+)\s+([-+]?\d+\.\d+)\s+([-+]?\d+)$", 1)
    If @error Then Return
	
	; Ajout en mémoire
	_ArrayAdd($aCoords, $clip)
	
	If UBound($aCoords) > 0 Then GUICtrlSetState($btnShalazam, $GUI_SHOW)

	Local $xRound = Round(Number($a[0]))
	Local $zRound = Round(Number($a[2]))
	Local $rotation = Number($a[3])
	Local $pinX = Number($a[0])
	Local $pinZ = Number($a[2])

	$pincounter += 1

	Local $url = "https://shalazam.info/maps/1?zoom=" & $g_iZoom & "&x=" & $xRound-10 & "&y=" & $zRound+10

	If $g_bMultiPin Then
		; Ajouter tous les pins
		For $i = 0 To UBound($aCoords) - 1
			Local $coord = $aCoords[$i]
			Local $aTmp = StringRegExp($coord, "^/jumploc\s+([-+]?\d+\.\d+)\s+[-+]?\d+\.\d+\s+([-+]?\d+\.\d+)", 1)
			If Not @error Then
				$url &= "&pin[]=" & Round(Number($aTmp[0])) & "." & Round(Number($aTmp[1])) & ".pin" & $i
				$routeUrl = $url
			EndIf
		Next
	Else
		; Un seul pin
		$url &= "&pin[]=" & $xRound & "." & $zRound  & ".vous+etes+ici"
	    ShellExecute("firefox.exe", $url)
	EndIf

	; Réactiver la fenêtre du jeu
	Local $hWnd = WinGetHandle("[CLASS:UnityWndClass]", "")
	If IsHWnd($hWnd) Then
		WinActivate($hWnd)
		WinSetState($hWnd, "", @SW_RESTORE)
	EndIf

EndFunc


; Sauvegarder
FileDelete($sHistPath)
FileWrite($sHistPath, Json_Encode($jHist, 1))