#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <GuiConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Timers.au3>
#include <Clipboard.au3>
#include <Array.au3>
#include <WinAPI.au3>
#include <File.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include "funcs\Globals.au3"
#include "funcs\DetectXp.au3"
#include "funcs\WinGet.au3"
#include "funcs\Gui.au3"

; === Map taille arbitraire ===
Global $mapW = 12000
Global $mapH = 12000
; === Détecter Firefox ===
If FileExists($sIniPath) Then
	$path = IniRead($sIniPath, "Path", "NavigatorPath", "")
	if($path and $path<>"") Then 
		$NavigatorPath = $path
	EndIf
Else
    FileOpen($sIniPath, 1)
	IniWriteSection  ( $sIniPath, "path", "NavigatorPath", $NavigatorPath)
    FileClose($sIniPath)
EndIf

; === Détecter Firefox ===
If FileExists($NavigatorPath) Then
    Global $g_sBrowser = $NavigatorPath
Else
    MsgBox(16, "Erreur", "Navigateur non trouvé. Changez le chemin dans ini.ini !")
    Exit
EndIf

; === Démarrage vérification presse-papier ===
AdlibRegister("_CheckClipboard", $checkDelay)

Func _While_Check()
	; ------ Game Open  -----------------
	Local $GamePos = _FenetreGameExiste()
	if($GamePos) Then		
		If  ($Win_Handle) Then
			; ------ Vérifie si la fenêtre est active (focus)
			If WinActive($Win_Handle) Then
				_set_buttonGame(True,True)
				Local $datas_XP = _detetect_xp()
			Else
				$counterRead = $delayRead
				_set_buttonGame(True,False)
			EndIf
		Else
			_set_buttonGame(False,False)
		EndIf
	EndIf
EndFunc

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
			;if($g_bMultiPin = 0) Then
			;	GUICtrlSetState($btnShalazam, $GUI_HIDE)
			;	if($pincounter > 0) Then GUICtrlSetState($btnShalazam, $GUI_SHOW)
			;Else
			;	if($pincounter > 1) Then
			;			GUICtrlSetState($btnShalazam, $GUI_SHOW)
			;	Else
			;		GUICtrlSetState($btnShalazam, $GUI_HIDE)
			;	EndIf
			;EndIf
				
		Case $itemResetClear
			_ClearPins()
			$routeUrl = ""
			GUICtrlSetData($menuCounter, "")
		Case $itemQuiAide
			MsgBox(64, "A propos", "Loc Tracker" & @CRLF & _
				"Version : 1.0" & @CRLF & _
				"Auteur : Patapizza 😎" & @CRLF & _
				"Utilise les données du presse-papier pour suivre ta position dans le jeu grace au super site de shalazam.info.")
	EndSwitch
	_While_Check()
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
	
	If UBound($aCoords) > 1 Then GUICtrlSetState($btnShalazam, $GUI_SHOW)

	Local $xRound = Round(Number($a[0]))
	Local $zRound = Round(Number($a[2]))
	Local $rotation = Number($a[3])
	Local $pinX = Number($a[0])
	Local $pinZ = Number($a[2])

	$pincounter += 1
	local $s = "s"
	if ($pincounter<1) Then $s = ""
	GUICtrlSetData($menuCounter,  $pincounter & " pin" & $s)
	
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