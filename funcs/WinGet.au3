Func _FenetreGameExiste()
	; Vérifie si une fenêtre contenant "Pantheon" dans son titre existe
	$Win_Handle = WinWait($Win_Game_Class, "", 1)
	if ($Win_Handle) Then
		Return _FenetreTaille()
	Else
		$Win_Handle = False
		Return False
	EndIf
EndFunc

Func _set_buttonGame($exist,$active)
	if($exist <> $Win_isGame_On) Then
		if($exist) Then
			GUICtrlSetData($btnGameActivity,"Game On")
		Else
			GUICtrlSetData($btnGameActivity,"Game Off")
		EndIf
		$Win_isGame_On = $exist
	EndIf
	if($active <> $Win_isGame_Active) Then
		if($exist And $active) Then
			GUICtrlSetData($btnGameActivity,"Active")
		ElseIf ($exist And Not $active) Then
			GUICtrlSetData($btnGameActivity,"Game On")
		Else
			GUICtrlSetData($btnGameActivity,"Game Off")
		EndIf
		$Win_isGame_Active = $active
	EndIf
EndFunc

Func _FenetreTaille()
	$Win_Game_Size_New = False
	$Win_Game_Size_Old[0] = $Win_Game_Size[0]
	$Win_Game_Size_Old[1] = $Win_Game_Size[1]
	
	Local $aClientSize = WinGetClientSize($Win_Game_Class)
	
    If @error Then
        Return False
    EndIf
	
	if($Win_Game_Size_Old[0] <> $aClientSize[0] Or $Win_Game_Size_Old[1] <> $aClientSize[1])  Then
		$Win_Game_Size_New = True
		$Win_Game_Size[0] = $aClientSize[0]
		$Win_Game_Size[1] = $aClientSize[1]
	EndIf
	
    Return True
EndFunc