Func _detetect_xp()
	Local $tolerance = 10
	Local $w = $Win_Game_Size[0]
	Local $h = $Win_Game_Size[1]
	Local $couleur = $ColorXp
	
    If Not WinExists($Win_Handle) Then 
		Return False
	EndIf

    Local $pos = WinGetPos($Win_Handle)
    If @error Then 
		Return False
	EndIf
	
    Local $x0 = $pos[0]
    Local $y0 = $pos[1]
    Local $yStart = $y0 + $h-5 

    Local $first = PixelSearch($x0, $yStart, $x0 + $w - 1, $yStart + 5, $couleur, $tolerance)
    If @error Then Return False

    Local $last = PixelSearch($x0 + $w, $yStart, $x0, $yStart +5, $couleur, $tolerance)
    If @error Then Return False

	Local $min = $first[0]
	Local $max = $w - $first[0]
	Local $cur = $last[0]
	Local $new_XP = Round($cur/$max,5)*100
	
	
	if($new_XP <> $XP) Then
			
		if($new_XP>$XP And $XP_Base > 0) Then 
			$Gain = Round($new_XP - $XP_Old,2)
		EndIf
				
		if($XP_Base == 0) Then  $XP_Base = $new_XP

		GUICtrlSetData($XP_Base_label,"Base: "&Round($XP_Base,2)&"%")
		GUICtrlSetData($XP_Gain_label,"Gain: " & $Gain & "%")
		GUICtrlSetData($XP_Gain_Old_label,"Prev: "&Round($Gain_Old,2)&"%")

		$Gain_Old = $Gain
		$XP = $new_XP
		$XP_Old = $XP
		GUICtrlSetData($XP_label,"XP: "&Round($XP,2)&"%")
	EndIf
	Local $datas = [ $XP, $Gain]
    Return $datas
EndFunc
