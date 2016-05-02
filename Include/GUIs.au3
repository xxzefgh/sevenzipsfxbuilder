; *****************************************************
; 					GUI ARC INFO
; *****************************************************
Func _GUI_ArcInfo()
	$cPos = WinGetPos($GUI_MAIN)
	GUISetState(@SW_DISABLE, $GUI_MAIN)
	$GUI_ARC = GUICreate('Archive settings', 450, 450, $cPos[0] + 80, $cPos[1] + 10, $WS_SYSMENU, $WS_EX_ACCEPTFILES, $GUI_MAIN)
	$ARC_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 250, 385, 85, 25)
	$ARC_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 350, 385, 85, 25)
	$ARC_BTN_ADDFILE = GUICtrlCreateButton('', 5, 5, 34, 24)
	$ARC_BTN_ADDFLDR = GUICtrlCreateButton('', 45, 5, 34, 24)
	$ARC_BTN_REMOVE = GUICtrlCreateButton('', 85, 5, 34, 24)
	$ARC_BTN_MOVEUP = GUICtrlCreateButton('', 125, 5, 34, 24)
	$ARC_BTN_MOVEDOWN = GUICtrlCreateButton('', 165, 5, 34, 24)
	$ARC_LBL_NOTE = GUICtrlCreateLabel($_LNG_GUI_ARCSETS[2], 205, 3, 240, 25, 0x2000)
	$ARC_LST = GUICtrlCreateListView(' ', 5, 35, 435, 140, BitOR($LVS_SHOWSELALWAYS, $LVS_NOLABELWRAP, $LVS_NOCOLUMNHEADER))
	$ARC_CHK = GUICtrlCreateCheckbox($_LNG_GUI_ARCSETS[1], 6, 175, 430)
	$ARC_INP = GUICtrlCreateInput(GUICtrlRead($S_INP_ARCHIVE), 5, 208, 435, -1, 0x0800)
	$ARC_EDT = GUICtrlCreateEdit('', 5, 230, 435, 140, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))
	_GUICtrlListView_SetColumnWidth($ARC_LST, 0, $LVSCW_AUTOSIZE)
	GUICtrlSetState($ARC_LST, $GUI_DROPACCEPTED)
	GUICtrlSetTip($ARC_BTN_ADDFILE, $_LNG_GUI_ARCSETS[3])
	GUICtrlSetTip($ARC_BTN_ADDFLDR, $_LNG_GUI_ARCSETS[4])
	GUICtrlSetTip($ARC_BTN_REMOVE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($ARC_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($ARC_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	_GUICtrlButton_SetImageList($ARC_BTN_ADDFILE, $iBtnList_small[5], 4)
	_GUICtrlButton_SetImageList($ARC_BTN_ADDFLDR, $iBtnList_small[6], 4)
	_GUICtrlButton_SetImageList($ARC_BTN_REMOVE, $iBtnList_small[9], 4)
	_GUICtrlButton_SetImageList($ARC_BTN_MOVEUP, $iBtnList_small[11], 4)
	_GUICtrlButton_SetImageList($ARC_BTN_MOVEDOWN, $iBtnList_small[12], 4)
	GUICtrlSetBkColor($ARC_LBL_NOTE, -2)
	GUICtrlSetBkColor($ARC_CHK, 0xFFFFFF)
	GUICtrlSetBkColor($ARC_INP, 0xFFFFFF)
	GUICtrlSetBkColor($ARC_EDT, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 0, 444, 375)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlCreateGraphic(0, 200, 444, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlSetOnEvent($ARC_BTN_SAVE, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_CANCEL, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_ADDFILE, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_ADDFLDR, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_REMOVE, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_MOVEUP, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_BTN_MOVEDOWN, '_GUI_ArcInfo_Events')
	GUICtrlSetOnEvent($ARC_CHK, '_GUI_ArcInfo_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_ArcInfo_Events')
	GUISetOnEvent($GUI_EVENT_DROPPED, '_GUI_ArcInfo_Drag')
	GUICtrlSetState($ARC_CHK, $GUI_DISABLE)
	For $c = 1 To $FilesToArc[0]
		GUICtrlCreateListViewItem($FilesToArc[$c], $ARC_LST)
		GUICtrlSetOnEvent(-1, '_ArcFiles_List')
	Next
	_GUICtrlListView_SetColumnWidth($ARC_LST, 0, $LVSCW_AUTOSIZE_USEHEADER)
	If $UseFONT Then _GUI_ArcInfo_Font()
	GUISetState(@SW_SHOW, $GUI_ARC)
	GUICtrlSetData($ARC_EDT, _Get_ArchiveInfo(GUICtrlRead($S_INP_ARCHIVE)))
EndFunc   ;==>_GUI_ArcInfo
Func _GUI_ArcInfo_Events()
	Switch @GUI_CtrlId
		Case $ARC_BTN_CANCEL, $GUI_EVENT_CLOSE
			_Close_Window($GUI_ARC, $GUI_MAIN)
		Case $ARC_BTN_SAVE
			$FilesToArc[0] = _GUICtrlListView_GetItemCount($ARC_LST)
			For $c = 0 To $FilesToArc[0] - 1
				$FilesToArc[$c + 1] = _GUICtrlListView_GetItemText($ARC_LST, $c, 0)
			Next
			_Close_Window($GUI_ARC, $GUI_MAIN)
		Case @GUI_CtrlId = $ARC_BTN_ADDFILE
			Local $FO_SFXFILES = FileOpenDialog('Select files:', '', 'All files (*.*)', 7, '', $GUI_ARC)
			If @error Then Return SetError(1, 1)
			If StringInStr($FO_SFXFILES, '|') Then
				If _String_GetStrCount($FO_SFXFILES, '|') = 1 Then Return SetError(1, 2)
				Local $aSFXFILES = StringSplit($FO_SFXFILES, '|')
				For $c = 2 To $aSFXFILES[0]
					GUICtrlCreateListViewItem($aSFXFILES[1] & '\' & $aSFXFILES[$c], $ARC_LST)
					GUICtrlSetOnEvent(-1, '_ArcFiles_List')
				Next
			Else
				GUICtrlCreateListViewItem($FO_SFXFILES, $ARC_LST)
				GUICtrlSetOnEvent(-1, '_ArcFiles_List')
			EndIf
			_GUICtrlListView_SetColumnWidth($ARC_LST, 0, $LVSCW_AUTOSIZE_USEHEADER)
		Case @GUI_CtrlId = $ARC_BTN_ADDFLDR
			Local $FSF_SFXFILES = FileSelectFolder('Select folder:', @DesktopDir, 7, '', $GUI_ARC)
			If Not @error Then
				If StringRight($FSF_SFXFILES, 1) <> '\' Then $FSF_SFXFILES &= '\'
				GUICtrlCreateListViewItem($FSF_SFXFILES & '|', $ARC_LST)
				GUICtrlSetOnEvent(-1, '_ArcFiles_List')
				_GUICtrlListView_SetColumnWidth($ARC_LST, 0, $LVSCW_AUTOSIZE_USEHEADER)
			EndIf
		Case @GUI_CtrlId = $ARC_BTN_REMOVE
			If _GUICtrlListView_GetSelectedCount($ARC_LST) > 0 Then
				$iMsgBoxAnswer = _MsgBoxEx(36, $GUI_ARC)
				If $iMsgBoxAnswer = 6 Then _GUICtrlListView_DeleteItemsSelected($ARC_LST)
			Else
				_MsgBoxEx(34, $GUI_ARC)
			EndIf
		Case @GUI_CtrlId = $ARC_BTN_MOVEUP
			_MoveListViewItem($ARC_LST, 1)
		Case @GUI_CtrlId = $ARC_BTN_MOVEDOWN
			_MoveListViewItem($ARC_LST, 2)
		Case @GUI_CtrlId = $ARC_CHK
			If _GUICtrlListView_GetSelectedCount($ARC_LST) <> 1 Then Return
			Local $selText = _GUICtrlListView_GetItemText($ARC_LST, _GUICtrlListView_GetSelectionMark($ARC_LST))
			If StringRight($selText, 1) = '\' Then
				_GUICtrlListView_SetItemText($ARC_LST, _GUICtrlListView_GetSelectionMark($ARC_LST), $selText & '*')
				GUICtrlSetState($ARC_CHK, $GUI_CHECKED)
			ElseIf StringRight($selText, 2) = '\*' Then
				_GUICtrlListView_SetItemText($ARC_LST, _GUICtrlListView_GetSelectionMark($ARC_LST), StringTrimRight($selText, 1))
				GUICtrlSetState($ARC_CHK, $GUI_UNCHECKED)
			EndIf
	EndSwitch
EndFunc   ;==>_GUI_ArcInfo_Events
Func _GUI_ArcInfo_Drag()
	Local $DragFILE
	$DragFILE = StringReplace(@GUI_DragFile, @CRLF, '')
	If $DragFILE = '' Then Return
	If FileExists($DragFILE & '\') Then $DragFILE &= '\'
	GUICtrlCreateListViewItem($DragFILE & '|', $ARC_LST)
	GUICtrlSetOnEvent(-1, '_ArcFiles_List')
	_GUICtrlListView_SetColumnWidth($ARC_LST, 0, $LVSCW_AUTOSIZE_USEHEADER)
EndFunc   ;==>_GUI_ArcInfo_Drag
Func _GUI_ArcInfo_Font()
	GUICtrlSetFont($ARC_BTN_SAVE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_BTN_CANCEL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_LBL_NOTE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_LST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_CHK, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_INP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ARC_EDT, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_ArcInfo_Font
; *****************************************************
; 				GUI PRESET MANAGER
; *****************************************************
Func _GUI_PresetMgr()
	$cPos = WinGetPos($GUI_MAIN)
	GUISetState(@SW_DISABLE, $GUI_MAIN)
	$GUI_PRESET = GUICreate($_LNG_GUI_PRESET[1], 450, 330, $cPos[0] + 80, $cPos[1] + 80, $WS_SYSMENU, -1, $GUI_MAIN)
	$PRE_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 250, 265, 85, 25)
	$PRE_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 350, 265, 85, 25)
	; Controls
	$PRE_CMB = GUICtrlCreateCombo('', 10, 10, 230, 20, 0x0003)
	$PRE_BTN_NEW = GUICtrlCreateButton('', 252, 9, 32, 24)
	$PRE_BTN_LOAD = GUICtrlCreateButton('', 289, 9, 32, 24)
	$PRE_BTN_PSAVE = GUICtrlCreateButton('', 326, 9, 32, 24)
	$PRE_BTN_EDITN = GUICtrlCreateButton('', 363, 9, 32, 24)
	$PRE_BTN_DEL = GUICtrlCreateButton('', 400, 9, 32, 24)
	$PRE_TRV = GUICtrlCreateTreeView(5, 50, 160, 190, BitOR(0x0004, 0x0001, 0x0002, 0x0020), $WS_EX_CLIENTEDGE) ;$TVS_LINESATROOT, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_SHOWSELALWAYS
	$PRE_TRVi_TT = GUICtrlCreateTreeViewItem('Title/Text', $PRE_TRV)
	$PRE_TRVi_MSG = GUICtrlCreateTreeViewItem('Messages', $PRE_TRV)
	$PRE_TRVi_TITLE = GUICtrlCreateTreeViewItem('Title', $PRE_TRVi_TT)
	$PRE_TRVi_TXPT = GUICtrlCreateTreeViewItem('ExtractPathTitle', $PRE_TRVi_TT)
	$PRE_TRVi_XT = GUICtrlCreateTreeViewItem('ExtractTitle', $PRE_TRVi_TT)
	$PRE_TRVi_XCT = GUICtrlCreateTreeViewItem('ExtractCancelText', $PRE_TRVi_TT)
	$PRE_TRVi_BP = GUICtrlCreateTreeViewItem('BeginPrompt', $PRE_TRVi_MSG)
	$PRE_TRVi_XPT = GUICtrlCreateTreeViewItem('ExtractPathText', $PRE_TRVi_MSG)
	$PRE_TRVi_XDT = GUICtrlCreateTreeViewItem('ExtractDialogText', $PRE_TRVi_MSG)
	$PRE_TRVi_CP = GUICtrlCreateTreeViewItem('CancelPrompt', $PRE_TRVi_MSG)
	$PRE_TRVi_FM = GUICtrlCreateTreeViewItem('FinishMessage', $PRE_TRVi_MSG)
	$PRE_LBL_TIT = GUICtrlCreateLabel('Title:', 180, 50, 250)
	$PRE_LBL_XPT = GUICtrlCreateLabel('ExtractPathTitle:', 180, 100, 250)
	$PRE_LBL_XT = GUICtrlCreateLabel('ExtractTitle:', 180, 150, 250)
	$PRE_LBL_XCT = GUICtrlCreateLabel('ExtractCancelText:', 180, 200, 250)
	$PRE_LBL_PNAME = GUICtrlCreateLabel(' ', 5, 268, 240)
	$PRE_INP_TIT = GUICtrlCreateInput('', 180, 70, 250, 20)
	$PRE_INP_XPT = GUICtrlCreateInput('', 180, 120, 250, 20)
	$PRE_INP_XT = GUICtrlCreateInput('', 180, 170, 250, 20)
	$PRE_INP_XCT = GUICtrlCreateInput('', 180, 220, 250, 20)
	$PRE_EDT_BP = GUICtrlCreateEdit('', 180, 50, 250, 190)
	$PRE_EDT_XPT = GUICtrlCreateEdit('', 180, 50, 250, 190)
	$PRE_EDT_XDT = GUICtrlCreateEdit('', 180, 50, 250, 190)
	$PRE_EDT_CP = GUICtrlCreateEdit('', 180, 50, 250, 190)
	$PRE_EDT_FM = GUICtrlCreateEdit('', 180, 50, 250, 190)
	; Control operations
	GUICtrlSetTip($PRE_BTN_NEW, $_LNG_GUI_PRESET[4])
	GUICtrlSetTip($PRE_BTN_LOAD, $_LNG_GUI_PRESET[5])
	GUICtrlSetTip($PRE_BTN_PSAVE, $_LNG_GUI_PRESET[6])
	GUICtrlSetTip($PRE_BTN_EDITN, $_LNG_GUI_PRESET[7])
	GUICtrlSetTip($PRE_BTN_DEL, $_LNG_GUI_PRESET[8])
	_GUICtrlButton_SetImageList($PRE_BTN_NEW, $iBtnList_small[7], 4)
	_GUICtrlButton_SetImageList($PRE_BTN_LOAD, $iBtnList_small[14], 4)
	_GUICtrlButton_SetImageList($PRE_BTN_PSAVE, $iBtnList_small[16], 4)
	_GUICtrlButton_SetImageList($PRE_BTN_EDITN, $iBtnList_small[8], 4)
	_GUICtrlButton_SetImageList($PRE_BTN_DEL, $iBtnList_small[10], 4)
	GUICtrlSetState($PRE_BTN_PSAVE, $GUI_DISABLE)
	GUICtrlSetState($PRE_EDT_BP, $GUI_HIDE)
	GUICtrlSetState($PRE_EDT_XPT, $GUI_HIDE)
	GUICtrlSetState($PRE_EDT_XDT, $GUI_HIDE)
	GUICtrlSetState($PRE_EDT_CP, $GUI_HIDE)
	GUICtrlSetState($PRE_EDT_FM, $GUI_HIDE)
	_GUICtrlTreeView_Expand($PRE_TRV)
	GUICtrlSetBkColor($PRE_LBL_TIT, -2)
	GUICtrlSetBkColor($PRE_LBL_XPT, -2)
	GUICtrlSetBkColor($PRE_LBL_XT, -2)
	GUICtrlSetBkColor($PRE_LBL_XCT, -2)
	; Graphic controls
	GUICtrlCreateGraphic(0, 0, 444, 255)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlCreateGraphic(0, 40, 444, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	; Set events
	GUICtrlSetOnEvent($PRE_BTN_SAVE, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_CANCEL, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_NEW, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_LOAD, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_PSAVE, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_EDITN, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_BTN_DEL, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_CMB, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRV, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_TT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_MSG, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_TITLE, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_TXPT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_XT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_XCT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_BP, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_XPT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_XDT, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_CP, '_GUI_PresetMgr_Events')
	GUICtrlSetOnEvent($PRE_TRVi_FM, '_GUI_PresetMgr_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_PresetMgr_Events')
	_Load_Int_Preset()
	_GUICtrlComboBox_SetCurSel($PRE_CMB, 0)
	If $UseFONT Then _GUI_PresetMgr_Font()
	GUISetState(@SW_SHOW, $GUI_PRESET)
EndFunc   ;==>_GUI_PresetMgr
Func _GUI_PresetMgr_Events()
	Select
		Case @GUI_CtrlId = $PRE_BTN_NEW
			$cPos = WinGetPos($GUI_PRESET)
			GUISetState(@SW_DISABLE, $GUI_PRESET)
			Local $nPreset = InputBox($_LNG_GUI_PRESET[2], $_LNG_GUI_PRESET[9], '', '', 250, 125, $cPos[0] + 100, $cPos[1] + 100, 0, $GUI_PRESET)
			If @error = 1 Then
				GUISetState(@SW_ENABLE, $GUI_PRESET)
				Return
			EndIf
			_GUICtrlComboBox_AddString($PRE_CMB, $nPreset)
			$pInd = _GUICtrlComboBox_GetCount($PRE_CMB)
			_GUICtrlComboBox_SetCurSel($PRE_CMB, $pInd - 1)
			$pDataInt[0][0] += 1
			$pDataInt[$pInd][0] = $nPreset
			GUICtrlSetState($PRE_BTN_PSAVE, $GUI_ENABLE)
			_Reset_Preset()
			GUISetState(@SW_ENABLE, $GUI_PRESET)
		Case @GUI_CtrlId = $PRE_BTN_LOAD
			If _GUICtrlComboBox_GetCurSel($PRE_CMB) = -1 Then Return
			$pInd = _GUICtrlComboBox_GetCurSel($PRE_CMB) + 1
			Local $pText
			_GUICtrlComboBox_GetLBText($PRE_CMB, $pInd - 1, $pText)
			GUICtrlSetData($PRE_LBL_PNAME, $pText)
			GUICtrlSetState($PRE_BTN_PSAVE, $GUI_ENABLE)
			GUICtrlSetData($PRE_INP_TIT, $pDataInt[$pInd][1])
			GUICtrlSetData($PRE_INP_XPT, $pDataInt[$pInd][2])
			GUICtrlSetData($PRE_INP_XT, $pDataInt[$pInd][3])
			GUICtrlSetData($PRE_INP_XCT, $pDataInt[$pInd][4])
			GUICtrlSetData($PRE_EDT_BP, $pDataInt[$pInd][5])
			GUICtrlSetData($PRE_EDT_XPT, $pDataInt[$pInd][6])
			GUICtrlSetData($PRE_EDT_XDT, $pDataInt[$pInd][7])
			GUICtrlSetData($PRE_EDT_CP, $pDataInt[$pInd][8])
			GUICtrlSetData($PRE_EDT_FM, $pDataInt[$pInd][9])
		Case @GUI_CtrlId = $PRE_BTN_PSAVE
			If Not StringIsDigit($pInd) Or $pInd < 1 Then Return
			$pDataInt[$pInd][1] = GUICtrlRead($PRE_INP_TIT)
			$pDataInt[$pInd][2] = GUICtrlRead($PRE_INP_XPT)
			$pDataInt[$pInd][3] = GUICtrlRead($PRE_INP_XT)
			$pDataInt[$pInd][4] = GUICtrlRead($PRE_INP_XCT)
			$pDataInt[$pInd][5] = GUICtrlRead($PRE_EDT_BP)
			$pDataInt[$pInd][6] = GUICtrlRead($PRE_EDT_XPT)
			$pDataInt[$pInd][7] = GUICtrlRead($PRE_EDT_XDT)
			$pDataInt[$pInd][8] = GUICtrlRead($PRE_EDT_CP)
			$pDataInt[$pInd][9] = GUICtrlRead($PRE_EDT_FM)
		Case @GUI_CtrlId = $PRE_BTN_EDITN
			$cPos = WinGetPos($GUI_PRESET)
			GUISetState(@SW_DISABLE, $GUI_PRESET)
			Local $cmbSel = _GUICtrlComboBox_GetCurSel($PRE_CMB)
			Local $cmbText = ''
			_GUICtrlComboBox_GetLBText($PRE_CMB, $cmbSel, $cmbText)
			Local $nPreset = InputBox($_LNG_GUI_PRESET[3], $_LNG_GUI_PRESET[9], $cmbText, '', 250, 120, $cPos[0] + 100, $cPos[1] + 100, 0, $GUI_PRESET)
			If @error = 1 Then
				GUISetState(@SW_ENABLE, $GUI_PRESET)
				Return
			EndIf
			Local $pText
			_GUICtrlComboBox_GetLBText($PRE_CMB, $cmbSel, $pText)
			If $pText = GUICtrlRead($PRE_LBL_PNAME) Then GUICtrlSetData($PRE_LBL_PNAME, $nPreset)
			_GUICtrlComboBox_DeleteString($PRE_CMB, $cmbSel)
			_GUICtrlComboBox_InsertString($PRE_CMB, $nPreset, $cmbSel)
			_GUICtrlComboBox_SetCurSel($PRE_CMB, $cmbSel)
			$pDataInt[$cmbSel + 1][0] = $nPreset
			GUISetState(@SW_ENABLE, $GUI_PRESET)
		Case @GUI_CtrlId = $PRE_BTN_DEL
			Local $cmbSel = _GUICtrlComboBox_GetCurSel($PRE_CMB)
			If $cmbSel = -1 Then
				MsgBox(0, 'Error!', 'Please select item first.', '', $GUI_PRESET)
				Return
			EndIf
			_GUICtrlComboBox_DeleteString($PRE_CMB, $cmbSel)
			_ArrayDelete($pDataInt, $cmbSel + 1)
			GUICtrlSetData($PRE_LBL_PNAME, '')
			If $cmbSel = ($pInd - 1) Then
				_Reset_Preset()
				GUICtrlSetState($PRE_BTN_PSAVE, $GUI_DISABLE)
			EndIf
			If $cmbSel < ($pInd - 1) Then $pInd -= 1
			If $cmbSel = _GUICtrlComboBox_GetCount($PRE_CMB) Then $cmbSel -= 1
			_GUICtrlComboBox_SetCurSel($PRE_CMB, $cmbSel)
			$pDataInt[0][0] -= 1
;~ 			_ArrayDisplay($pDataInt)
		Case @GUI_CtrlId = $PRE_TRVi_TT Or @GUI_CtrlId = $PRE_TRVi_TITLE Or @GUI_CtrlId = $PRE_TRVi_TXPT Or @GUI_CtrlId = $PRE_TRVi_XT Or @GUI_CtrlId = $PRE_TRVi_XCT
			; hide
			GUICtrlSetState($PRE_EDT_BP, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_XPT, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_XDT, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_CP, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_FM, $GUI_HIDE)
			; show
			GUICtrlSetState($PRE_INP_TIT, $GUI_SHOW)
			GUICtrlSetState($PRE_INP_XPT, $GUI_SHOW)
			GUICtrlSetState($PRE_INP_XT, $GUI_SHOW)
			GUICtrlSetState($PRE_INP_XCT, $GUI_SHOW)
			GUICtrlSetState($PRE_LBL_TIT, $GUI_SHOW)
			GUICtrlSetState($PRE_LBL_XPT, $GUI_SHOW)
			GUICtrlSetState($PRE_LBL_XT, $GUI_SHOW)
			GUICtrlSetState($PRE_LBL_XCT, $GUI_SHOW)
			Switch @GUI_CtrlId
				Case $PRE_TRVi_TITLE
					GUICtrlSetState($PRE_INP_TIT, $GUI_FOCUS)
				Case $PRE_TRVi_TXPT
					GUICtrlSetState($PRE_INP_XPT, $GUI_FOCUS)
				Case $PRE_TRVi_XT
					GUICtrlSetState($PRE_INP_XT, $GUI_FOCUS)
				Case $PRE_TRVi_XCT
					GUICtrlSetState($PRE_INP_XCT, $GUI_FOCUS)
			EndSwitch
		Case @GUI_CtrlId = $PRE_TRVi_BP Or @GUI_CtrlId = $PRE_TRVi_XPT Or @GUI_CtrlId = $PRE_TRVi_XDT Or @GUI_CtrlId = $PRE_TRVi_CP Or @GUI_CtrlId = $PRE_TRVi_FM
			GUICtrlSetState($PRE_INP_TIT, $GUI_HIDE)
			GUICtrlSetState($PRE_INP_XPT, $GUI_HIDE)
			GUICtrlSetState($PRE_INP_XT, $GUI_HIDE)
			GUICtrlSetState($PRE_INP_XCT, $GUI_HIDE)
			GUICtrlSetState($PRE_LBL_TIT, $GUI_HIDE)
			GUICtrlSetState($PRE_LBL_XPT, $GUI_HIDE)
			GUICtrlSetState($PRE_LBL_XT, $GUI_HIDE)
			GUICtrlSetState($PRE_LBL_XCT, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_BP, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_XPT, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_XDT, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_CP, $GUI_HIDE)
			GUICtrlSetState($PRE_EDT_FM, $GUI_HIDE)
			Switch @GUI_CtrlId
				Case $PRE_TRVi_BP
					GUICtrlSetState($PRE_EDT_BP, $GUI_SHOW)
					GUICtrlSetState($PRE_EDT_BP, $GUI_FOCUS)
				Case $PRE_TRVi_XPT
					GUICtrlSetState($PRE_EDT_XPT, $GUI_SHOW)
					GUICtrlSetState($PRE_EDT_XPT, $GUI_FOCUS)
				Case $PRE_TRVi_XDT
					GUICtrlSetState($PRE_EDT_XDT, $GUI_SHOW)
					GUICtrlSetState($PRE_EDT_XDT, $GUI_FOCUS)
				Case $PRE_TRVi_CP
					GUICtrlSetState($PRE_EDT_CP, $GUI_SHOW)
					GUICtrlSetState($PRE_EDT_CP, $GUI_FOCUS)
				Case $PRE_TRVi_FM
					GUICtrlSetState($PRE_EDT_FM, $GUI_SHOW)
					GUICtrlSetState($PRE_EDT_FM, $GUI_FOCUS)
			EndSwitch
		Case @GUI_CtrlId = $PRE_BTN_SAVE
;~ 			_ArrayDisplay($pDataInt)
			_Write_Preset()
			_Close_Window($GUI_PRESET, $GUI_MAIN)
		Case @GUI_CtrlId = $GUI_EVENT_CLOSE Or @GUI_CtrlId = $PRE_BTN_CANCEL
			_Close_Window($GUI_PRESET, $GUI_MAIN)
	EndSelect
EndFunc   ;==>_GUI_PresetMgr_Events
Func _GUI_PresetMgr_Font()
	GUICtrlSetFont($PRE_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($PRE_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($PRE_BTN_NEW, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_BTN_LOAD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_BTN_PSAVE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_BTN_DEL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_CMB, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_TRV, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_INP_TIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_INP_XPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_INP_XT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_INP_XCT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_LBL_TIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_LBL_XPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_LBL_XT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_LBL_XCT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_LBL_PNAME, $Font[1], '', 2, $Font[0])
	GUICtrlSetFont($PRE_EDT_BP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_EDT_XPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_EDT_XDT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_EDT_CP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PRE_EDT_FM, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_PresetMgr_Font
; *****************************************************
; 					GUI GUI/MISC FLAGS
; *****************************************************
Func _GUI_GMFlags()
	$GUI_GUIFLAGS = GUICreate($_LNG_GUI_GF[1], 580, 460, $cPos[0] + 15, $cPos[1] + 10, $WS_SYSMENU, -1, $GUI_MAIN)
	$GFL_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 380, 395, 85, 25)
	$GFL_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 480, 395, 85, 25)
	; Controls
	$GFL_CMB_GFP = GUICtrlCreateCombo('', 10, 11, 395, 20, 0x0003)
	$GFL_BTN_NEW = GUICtrlCreateButton('', 415, 10, 32, 24)
	$GFL_BTN_LOAD = GUICtrlCreateButton('', 455, 10, 32, 24)
	$GFL_BTN_RESET = GUICtrlCreateButton('', 495, 10, 32, 24)
	$GFL_BTN_DEL = GUICtrlCreateButton('', 535, 10, 32, 24)
	GUICtrlCreateLabel('GUI Flags:', 10, 39)
	GUICtrlSetBkColor(-1, -2)
	$GFL_CHK[1] = GUICtrlCreateCheckbox('1 - ' & $_LNG_GUI_GF[2], 5, 60, 560, 15)
	$GFL_CHK[2] = GUICtrlCreateCheckbox('2 - ' & $_LNG_GUI_GF[3], 5, 75, 560, 15)
	$GFL_CHK[3] = GUICtrlCreateCheckbox('4 - ' & $_LNG_GUI_GF[4], 5, 90, 560, 15)
	$GFL_CHK[4] = GUICtrlCreateCheckbox('8 - ' & $_LNG_GUI_GF[5], 5, 105, 560, 15)
	$GFL_CHK[5] = GUICtrlCreateCheckbox('16 - ' & $_LNG_GUI_GF[6], 5, 120, 560, 15)
	$GFL_CHK[6] = GUICtrlCreateCheckbox('32 - ' & $_LNG_GUI_GF[7], 5, 135, 560, 15)
	$GFL_CHK[7] = GUICtrlCreateCheckbox('64 - ' & $_LNG_GUI_GF[8], 5, 150, 560, 15)
	$GFL_CHK[8] = GUICtrlCreateCheckbox('128 - ' & $_LNG_GUI_GF[9], 5, 165, 560, 15)
	$GFL_CHK[9] = GUICtrlCreateCheckbox('256 - ' & $_LNG_GUI_GF[10], 5, 180, 560, 15)
	$GFL_CHK[10] = GUICtrlCreateCheckbox('512 - ' & $_LNG_GUI_GF[11], 5, 195, 560, 15)
	$GFL_CHK[11] = GUICtrlCreateCheckbox('1024 - ' & $_LNG_GUI_GF[12], 5, 210, 560, 15)
	$GFL_CHK[12] = GUICtrlCreateCheckbox('2048 - ' & $_LNG_GUI_GF[13], 5, 225, 560, 15)
	$GFL_CHK[13] = GUICtrlCreateCheckbox('4096 - ' & $_LNG_GUI_GF[14], 5, 240, 560, 15)
	$GFL_CHK[14] = GUICtrlCreateCheckbox('8192 - ' & $_LNG_GUI_GF[15], 5, 255, 560, 15)
	$GFL_CHK[15] = GUICtrlCreateCheckbox('16384 - ' & $_LNG_GUI_GF[16], 5, 270, 560, 15)
	GUICtrlCreateLabel('Misc Flags:', 10, 294)
	GUICtrlSetBkColor(-1, -2)
	$GFL_CHK[16] = GUICtrlCreateCheckbox('1 - ' & $_LNG_GUI_GF[17], 5, 315, 560, 15)
	$GFL_CHK[17] = GUICtrlCreateCheckbox('2 - ' & $_LNG_GUI_GF[18], 5, 330, 560, 15)
	$GFL_CHK[18] = GUICtrlCreateCheckbox('4 - ' & $_LNG_GUI_GF[19], 5, 345, 560, 15)
	$GFL_CHK[19] = GUICtrlCreateCheckbox('8 - ' & $_LNG_GUI_GF[20], 5, 360, 560, 15)
	; Control operations
	For $c = 1 To 19
		GUICtrlSetBkColor($GFL_CHK[$c], 0xFFFFFF)
	Next
	GUICtrlSetData($GFL_CMB_GFP, _Load_GMFlags())
	_Set_GMFlags('G' & GUICtrlRead($M_INP_GUIFLAGS) & 'M' & GUICtrlRead($M_INP_MISCFLAGS))
	_GUICtrlComboBox_SetCurSel($GFL_CMB_GFP, 0)
	_GUICtrlButton_SetImageList($GFL_BTN_NEW, $iBtnList_small[7], 4)
	_GUICtrlButton_SetImageList($GFL_BTN_LOAD, $iBtnList_small[14], 4)
	_GUICtrlButton_SetImageList($GFL_BTN_RESET, $iBtnList_small[22], 4)
	_GUICtrlButton_SetImageList($GFL_BTN_DEL, $iBtnList_small[10], 4)
	GUICtrlSetTip($GFL_BTN_NEW, $_LNG_GUI_GF[21])
	GUICtrlSetTip($GFL_BTN_LOAD, $_LNG_GUI_GF[22])
	GUICtrlSetTip($GFL_BTN_RESET, $_LNG_GUI_GF[23])
	GUICtrlSetTip($GFL_BTN_DEL, $_LNG_GUI_GF[24])
	; Graphic controls
	GUICtrlCreateGraphic(0, 0, 574, 385)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlCreateGraphic(70, 45, 504, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlCreateGraphic(70, 300, 504, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	; Set events
	GUICtrlSetOnEvent($GFL_BTN_NEW, '_GUI_GMFlags_Events')
	GUICtrlSetOnEvent($GFL_BTN_LOAD, '_GUI_GMFlags_Events')
	GUICtrlSetOnEvent($GFL_BTN_RESET, '_Reset_GMFlags')
	GUICtrlSetOnEvent($GFL_BTN_DEL, '_GUI_GMFlags_Events')
	GUICtrlSetOnEvent($GFL_BTN_SAVE, '_GUI_GMFlags_Events')
	GUICtrlSetOnEvent($GFL_BTN_CANCEL, '_GUI_GMFlags_Events')
	GUICtrlSetOnEvent($GFL_CHK[4], '_GUI_GMFlags_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_GMFlags_Events')
	If $UseFONT Then _GUI_GMFlags_Font()
	GUISetState(@SW_SHOW, $GUI_GUIFLAGS)
EndFunc   ;==>_GUI_GMFlags
Func _GUI_GMFlags_Events()
	Switch @GUI_CtrlId
		Case $GFL_BTN_NEW
			If _Enum_GMFlags() <> '' Then
				GUICtrlSetData($GFL_CMB_GFP, _Enum_GMFlags(), _Enum_GMFlags())
			EndIf
		Case $GFL_BTN_LOAD
			_Set_GMFlags(GUICtrlRead($GFL_CMB_GFP))
			If @error Then _MsgBoxEx(38, $GUI_GUIFLAGS)
		Case $GFL_BTN_DEL
			Local $cIndex = _GUICtrlComboBox_GetCurSel($GFL_CMB_GFP)
			If $cIndex <> -1 Then
				_GUICtrlComboBox_DeleteString($GFL_CMB_GFP, $cIndex)
				If $cIndex = 0 Then
					_GUICtrlComboBox_SetCurSel($GFL_CMB_GFP, 0)
				Else
					_GUICtrlComboBox_SetCurSel($GFL_CMB_GFP, $cIndex - 1)
				EndIf
			EndIf
		Case $GFL_BTN_SAVE
			GUICtrlSetData($M_INP_GUIFLAGS, _Enum_GMFlags(1))
			GUICtrlSetData($M_INP_MISCFLAGS, _Enum_GMFlags(2))
			_Write_GMFlags(-1)
			Local $hData = StringSplit(_GUICtrlComboBox_GetList($GFL_CMB_GFP), '|')
			For $c = 1 To $hData[0]
				If $hData[$c] <> '' Then _Write_GMFlags($c, $hData[$c])
			Next
			_Close_Window($GUI_GUIFLAGS, $GUI_MAIN)
		Case $GFL_BTN_CANCEL, $GUI_EVENT_CLOSE
			_Close_Window($GUI_GUIFLAGS, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_GMFlags_Events
Func _GUI_GMFlags_Font()
	For $c = 1 To 19
		GUICtrlSetFont($GFL_CHK[$c], $Font[1], '', '', $Font[0])
	Next
	GUICtrlSetFont($GFL_BTN_LOAD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($GFL_BTN_DEL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($GFL_BTN_NEW, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($GFL_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($GFL_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($GFL_GRP_PROF, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($GFL_CMB_GFP, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_GMFlags_Font
; *****************************************************
; 				GUI PROGRAM OPTIONS
; *****************************************************
Func _GUI_Options()
	$GUI_OPTS = GUICreate($_LNG_GUI_APPOPTS[1], 500, 370, $cPos[0] + 50, $cPos[1] + 55, $WS_SYSMENU, -1, $GUI_MAIN)
	$OPT_BTN_OK = GUICtrlCreateButton($_LNG_GLOBAL[10], 300, 305, 85, 25)
	$OPT_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 400, 305, 85, 25)
	; Controls
	$OPT_GRP_PROG = GUICtrlCreateGroup($_LNG_GUI_APPOPTS[7], 10, 10, 475, 155)
	$OPT_CHK_REGMODE = GUICtrlCreateCheckbox($_LNG_GUI_APPOPTS[6], 20, 30, 460)
	$OPT_CHK_AUTOMOD = GUICtrlCreateCheckbox($_LNG_GUI_APPOPTS[13], 20, 50, 460)
	$OPT_LBL_LNG = GUICtrlCreateLabel($_LNG_GUI_APPOPTS[9], 20, 75)
	$OPT_CMB_LNG = GUICtrlCreateCombo('', 30, 95, 160, 20, 0x0003)
	$OPT_BTN_LNG = GUICtrlCreateButton('', 197, 94, 34, 23)
	$OPT_BTN_INT = GUICtrlCreateButton($_LNG_GUI_APPOPTS[2], 20, 130, 455, 23)
	$OPT_GRP_SFX = GUICtrlCreateGroup($_LNG_GUI_APPOPTS[8], 10, 180, 475, 90)
	$OPT_CHK_VERS = GUICtrlCreateCheckbox($_LNG_GUI_APPOPTS[3], 20, 200, 460)
	$OPT_CHK_CSFX = GUICtrlCreateCheckbox($_LNG_GUI_APPOPTS[4], 20, 220, 460)
	$OPT_CHK_OW_SFX = GUICtrlCreateCheckbox($_LNG_GUI_APPOPTS[5], 20, 240, 460)
	$OPT_BTN_EXPORT = GUICtrlCreateButton($_LNG_GUI_APPOPTS[10], 10, 305, 100, 25)
	$Dummy_Export = GUICtrlCreateDummy()
	$cMenu_Export = GUICtrlCreateContextMenu($Dummy_Export)
	$OPT_Mi_EXPREG = _GUICtrlCreateMenuItemEx($_LNG_GUI_APPOPTS[11], $cMenu_Export)
	$OPT_Mi_EXPINI = _GUICtrlCreateMenuItemEx($_LNG_GUI_APPOPTS[12], $cMenu_Export)
	_GUICtrlButton_SetImageList($OPT_BTN_LNG, $iBtnList_small[0], 4)
	GUICtrlSetBkColor($OPT_LBL_LNG, -2)
	GUICtrlSetBkColor($OPT_CHK_REGMODE, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_CHK_AUTOMOD, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_CHK_VERS, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_CHK_CSFX, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_CHK_OW_SFX, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_GRP_PROG, 0xFFFFFF)
	GUICtrlSetBkColor($OPT_GRP_SFX, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 0, 494, 295)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($OPT_BTN_OK, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_BTN_CANCEL, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_BTN_LNG, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_BTN_INT, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_BTN_EXPORT, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_Mi_EXPREG, '_GUI_Options_Events')
	GUICtrlSetOnEvent($OPT_Mi_EXPINI, '_GUI_Options_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_Options_Events')
	$_LngText[0] = $CurLang[1]
	GUICtrlSetData($OPT_CMB_LNG, $_LngList, $_LngText[0])
	If $RegMode = 1 Then GUICtrlSetState($OPT_CHK_REGMODE, $GUI_CHECKED)
	If $ModeAUTOMOD = 1 Then GUICtrlSetState($OPT_CHK_AUTOMOD, $GUI_CHECKED)
	If $ModeNOVERS = 1 Then GUICtrlSetState($OPT_CHK_VERS, $GUI_CHECKED)
	If $ModeAUTOSFX = 1 Then GUICtrlSetState($OPT_CHK_CSFX, $GUI_CHECKED)
	If $ModeOWSFX = 1 Then GUICtrlSetState($OPT_CHK_OW_SFX, $GUI_CHECKED)
	If $UseFONT Then _GUI_Options_Font()
	GUISetState(@SW_SHOW, $GUI_OPTS)
EndFunc   ;==>_GUI_Options
Func _GUI_Options_Events()
	Select
		Case @GUI_CtrlId = $OPT_BTN_LNG
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_OPTS)
			_GUI_LangInfo()
		Case @GUI_CtrlId = $OPT_BTN_INT
			RegWrite('HKEY_CLASSES_ROOT\*\shell\Open with 7z SFX Builder')
			RegWrite('HKEY_CLASSES_ROOT\*\shell\Open with 7z SFX Builder', 'Icon', 'REG_SZ', @ScriptFullPath)
			RegWrite('HKEY_CLASSES_ROOT\*\shell\Open with 7z SFX Builder\command', '', 'REG_SZ', @ScriptFullPath & ' "%1"')
			_MsgBoxEx(31, $GUI_OPTS)
		Case @GUI_CtrlId = $OPT_BTN_OK
			If GUICtrlRead($OPT_CHK_REGMODE) = $GUI_CHECKED Then
				$RegMode = 1
			Else
				$RegMode = 0
			EndIf
			If GUICtrlRead($OPT_CHK_AUTOMOD) = $GUI_CHECKED Then
				$ModeAUTOMOD = 1
			Else
				$ModeAUTOMOD = 0
			EndIf
			If GUICtrlRead($OPT_CHK_VERS) = $GUI_CHECKED Then
				$ModeNOVERS = 1
			Else
				$ModeNOVERS = 0
			EndIf
			If GUICtrlRead($OPT_CHK_CSFX) = $GUI_CHECKED Then
				$ModeAUTOSFX = 1
			Else
				$ModeAUTOSFX = 0
			EndIf
			If GUICtrlRead($OPT_CHK_OW_SFX) = $GUI_CHECKED Then
				$ModeOWSFX = 1
			Else
				$ModeOWSFX = 0
			EndIf
			$_LngText[1] = GUICtrlRead($OPT_CMB_LNG)
			_GUICtrlODMenuItemDelete($OPT_Mi_EXPREG)
			_GUICtrlODMenuItemDelete($OPT_Mi_EXPINI)
			_Close_Window($GUI_OPTS, $GUI_MAIN)
			If $_LngText[0] <> $_LngText[1] Then _Select_Language()
			$_LngText[1] = ''
		Case @GUI_CtrlId = $OPT_BTN_EXPORT
			_ShowMenu($GUI_OPTS, $OPT_BTN_EXPORT, $cMenu_Export)
		Case @GUI_CtrlId = $OPT_Mi_EXPREG
			Local $_FSDLG = FileSaveDialog('Select File Name', '', 'Windows Registry Files (*.reg)', 18, 'Settings.reg', $GUI_OPTS)
			If @error Then Return
			_ExportSettings($_FSDLG, 1)
		Case @GUI_CtrlId = $OPT_Mi_EXPINI
			Local $_FSDLG = FileSaveDialog('Select File Name', '', 'INI files (*.ini)', 18, 'Settings.ini', $GUI_OPTS)
			If @error Then Return
			_ExportSettings($_FSDLG, 2)
		Case @GUI_CtrlId = $OPT_BTN_CANCEL Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_GUICtrlODMenuItemDelete($OPT_Mi_EXPREG)
			_GUICtrlODMenuItemDelete($OPT_Mi_EXPINI)
			_Close_Window($GUI_OPTS, $GUI_MAIN)
			$_LngText[1] = ''
	EndSelect
EndFunc   ;==>_GUI_Options_Events
Func _GUI_Options_Font()
	GUICtrlSetFont($OPT_BTN_OK, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($OPT_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($OPT_BTN_INT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_BTN_EXPORT, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($OPT_CMB_LNG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_REGMODE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_AUTOMOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_PMPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_VERS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_CSFX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_CHK_OW_SFX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_GRP_PROG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_GRP_SFX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($OPT_LBL_LNG, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_Options_Font
; *****************************************************
; 				GUI RUN PROGRAM
; *****************************************************
Func _GUI_RunProgram()
	$GUI_RUN = GUICreate($_LNG_GUI_RUN[1], 500, 245, $cPos[0] + 50, $cPos[1] + 120, $WS_SYSMENU, -1, $GUI_MAIN)
	$RUN_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 300, 180, 85, 25)
	$RUN_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 400, 180, 85, 25)
	$RUN_BTN_ADD = GUICtrlCreateButton('', 450, 74, 34, 22)
	$RUN_COMBO_PARAM = GUICtrlCreateCombo('', 100, 15, 100, 20, $CBS_DROPDOWNLIST)
	$RUN_COMBO_PARAM_X = GUICtrlCreateCombo('', 220, 15, 35, 20)
	$RUN_CHK_ADD_QUOTES = GUICtrlCreateCheckbox($_LNG_GLOBAL[7], 10, 181, 180)
	$RUN_INP_FILE = GUICtrlCreateInput('', 100, 45, 385, 20)
	$RUN_INP_PREFIX = GUICtrlCreateInput('', 100, 75, 345, 20, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
	$RUN_EDT_CMDS = GUICtrlCreateEdit('', 100, 105, 385, 55, BitOR($ES_AUTOVSCROLL, $WS_VSCROLL))
	$RUN_LBL[0] = GUICtrlCreateLabel($_LNG_GUI_RUN[3], 10, 18, 85)
	$RUN_LBL[1] = GUICtrlCreateLabel($_LNG_GUI_RUN[4], 10, 48, 85)
	$RUN_LBL[2] = GUICtrlCreateLabel($_LNG_GUI_RUN[5], 10, 78, 85)
	$RUN_LBL[3] = GUICtrlCreateLabel($_LNG_GUI_RUN[6], 10, 108, 85)
	GUICtrlSetBkColor($RUN_LBL[0], -2)
	GUICtrlSetBkColor($RUN_LBL[1], -2)
	GUICtrlSetBkColor($RUN_LBL[2], -2)
	GUICtrlSetBkColor($RUN_LBL[3], -2)
	GUICtrlCreateGraphic(0, 0, 494, 170)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetData($RUN_COMBO_PARAM, 'RunProgram|AutoInstall|AutoInstallX|ExecuteFile', 'RunProgram')
	GUICtrlSetData($RUN_COMBO_PARAM_X, '0|1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z', '0')
	GUICtrlSetTip($RUN_BTN_ADD, $_LNG_TAB_MAIN[17])
	_GUICtrlButton_SetImageList($RUN_BTN_ADD, $iBtnList_small[1], 4)
	GUICtrlSetOnEvent($RUN_BTN_SAVE, '_GUI_RunProgram_Events')
	GUICtrlSetOnEvent($RUN_COMBO_PARAM, '_GUI_RunProgram_Events')
	GUICtrlSetOnEvent($RUN_BTN_ADD, '_GUI_RunProgram_Events')
	GUICtrlSetOnEvent($RUN_BTN_CANCEL, '_GUI_RunProgram_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_RunProgram_Events')
	GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
	If $UseFONT Then _GUI_RunProgram_Font()
	GUISetState(@SW_SHOW, $GUI_RUN)
EndFunc   ;==>_GUI_RunProgram
Func _GUI_RunProgram_Events()
	Local $Run_Data
	Switch @GUI_CtrlId
		Case $RUN_BTN_SAVE
			If Not _CheckString($RUN_INP_FILE) Then Return
			If Not _CheckString($RUN_EDT_CMDS) Then Return
			If @error Then Return
			If StringLen(GUICtrlRead($RUN_COMBO_PARAM_X)) > 1 And GUICtrlRead($RUN_COMBO_PARAM) = 'AutoInstallX' Then
				_MsgBoxEx(38, $GUI_RUN)
				GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_FOCUS)
				Return SetError(1)
			EndIf
			If GUICtrlRead($RUN_INP_FILE) <> '' Then
				Local $r_SetData[5] = [GUICtrlRead($RUN_COMBO_PARAM), _
						GUICtrlRead($RUN_INP_PREFIX), _
						GUICtrlRead($RUN_INP_FILE), _
						StringReplace(GUICtrlRead($RUN_EDT_CMDS), @CRLF, ''), _
						'False']
				If GUICtrlRead($RUN_CHK_ADD_QUOTES) = 1 Then $r_SetData[4] = 'True'
				If $r_SetData[0] = 'AutoInstallX' Then
					$r_SetData[0] = 'AutoInstall' & GUICtrlRead($RUN_COMBO_PARAM_X)
				ElseIf $r_SetData[0] = 'ExecuteFile' Then
					$r_SetData[1] = 'N/A'
					$r_SetData[4] = 'N/A'
				EndIf
				If $Run_ListToEdit[0] = False Then
					GUICtrlCreateListViewItem($r_SetData[0] & '|' & $r_SetData[1] & '|' & $r_SetData[2] & '|' & $r_SetData[3] & '|' & $r_SetData[4], $R_LIST)
				Else
					_GUICtrlListView_SetItem($R_LIST, $r_SetData[0], $Run_ListToEdit[1], 0)
					_GUICtrlListView_SetItem($R_LIST, $r_SetData[1], $Run_ListToEdit[1], 1)
					_GUICtrlListView_SetItem($R_LIST, $r_SetData[2], $Run_ListToEdit[1], 2)
					_GUICtrlListView_SetItem($R_LIST, $r_SetData[3], $Run_ListToEdit[1], 3)
					_GUICtrlListView_SetItem($R_LIST, $r_SetData[4], $Run_ListToEdit[1], 4)
					_Close_Window($GUI_RUN, $GUI_MAIN)
				EndIf
			Else
				_MsgBoxEx(38, $GUI_RUN)
				GUICtrlSetState($RUN_INP_FILE, $GUI_FOCUS)
			EndIf
		Case @GUI_CtrlId = $RUN_BTN_ADD
			$cPos = WinGetPos($GUI_RUN)
			GUISetState(@SW_DISABLE, $GUI_RUN)
			_GUI_Prefix()
			Local $PFXStrSplit = StringSplit(GUICtrlRead($RUN_INP_PREFIX), ':')
			For $c = 1 To $PFXStrSplit[0]
				Switch $PFXStrSplit[$c]
					Case 'del0'
						GUICtrlSetState($PFX_CHK_DEL, 1)
						GUICtrlSetData($PFX_COMBO_DEL, '0')
					Case 'del1'
						GUICtrlSetState($PFX_CHK_DEL, 1)
						GUICtrlSetData($PFX_COMBO_DEL, '1')
					Case 'shc0'
						GUICtrlSetState($PFX_CHK_SHC, 1)
						GUICtrlSetData($PFX_COMBO_SHC, '0')
					Case 'shc1'
						GUICtrlSetState($PFX_CHK_SHC, 1)
						GUICtrlSetData($PFX_COMBO_SHC, '1')
					Case 'hidcon'
						GUICtrlSetState($PFX_CHK_HIDCON, 1)
					Case 'nowait'
						GUICtrlSetState($PFX_CHK_NOWAIT, 1)
					Case 'forcenowait'
						GUICtrlSetState($PFX_CHK_FNOWAIT, 1)
					Case 'waitall'
						GUICtrlSetState($PFX_CHK_WAITALL, 1)
					Case 'x64'
						GUICtrlSetState($PFX_CHK_X64, 1)
					Case 'x86'
						GUICtrlSetState($PFX_CHK_X86, 1)
				EndSwitch
				If GUICtrlRead($PFX_CHK_NOWAIT) = 1 Then
					GUICtrlSetState($PFX_CHK_FNOWAIT, 4)
					GUICtrlSetState($PFX_CHK_WAITALL, 4)
				ElseIf GUICtrlRead($PFX_CHK_FNOWAIT) = 1 Then
					GUICtrlSetState($PFX_CHK_NOWAIT, 4)
					GUICtrlSetState($PFX_CHK_WAITALL, 4)
				ElseIf GUICtrlRead($PFX_CHK_WAITALL) = 1 Then
					GUICtrlSetState($PFX_CHK_NOWAIT, 4)
					GUICtrlSetState($PFX_CHK_FNOWAIT, 4)
				EndIf
				If StringLeft($PFXStrSplit[$c], 2) = 'fm' Then
					GUICtrlSetState($PFX_CHK_FM, 1)
					Local $PFX_FMVal = StringMid($PFXStrSplit[$c], 3, StringLen($PFXStrSplit[$c]))
					GUICtrlSetData($PFX_COMBO_FM, $PFX_FMVal)
					If GUICtrlRead($PFX_COMBO_FM) <> $PFX_FMVal Then GUICtrlSetData($PFX_COMBO_FM, $PFX_FMVal)
				EndIf
			Next
		Case $RUN_COMBO_PARAM
			If _GUICtrlComboBox_GetCurSel($RUN_COMBO_PARAM) = 0 Then
				GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
				GUICtrlSetState($RUN_BTN_ADD, $GUI_ENABLE)
				GUICtrlSetState($RUN_CHK_ADD_QUOTES, $GUI_ENABLE)
			ElseIf _GUICtrlComboBox_GetCurSel($RUN_COMBO_PARAM) = 1 Then
				GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
				GUICtrlSetState($RUN_BTN_ADD, $GUI_ENABLE)
				GUICtrlSetState($RUN_CHK_ADD_QUOTES, $GUI_ENABLE)
			ElseIf _GUICtrlComboBox_GetCurSel($RUN_COMBO_PARAM) = 2 Then
				GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_ENABLE)
				GUICtrlSetState($RUN_BTN_ADD, $GUI_ENABLE)
				GUICtrlSetState($RUN_CHK_ADD_QUOTES, $GUI_ENABLE)
			ElseIf _GUICtrlComboBox_GetCurSel($RUN_COMBO_PARAM) = 3 Then
				GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
				GUICtrlSetState($RUN_BTN_ADD, $GUI_DISABLE)
				GUICtrlSetState($RUN_CHK_ADD_QUOTES, $GUI_DISABLE)
			EndIf
		Case $RUN_BTN_CANCEL Or $GUI_EVENT_CLOSE
			_Close_Window($GUI_RUN, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_RunProgram_Events
Func _GUI_RunProgram_Font()
	GUICtrlSetFont($RUN_BTN_ADD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($RUN_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($RUN_CHK_ADD_QUOTES, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_COMBO_PARAM, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_COMBO_PARAM_X, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_INP_FILE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_INP_PREFIX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RUN_EDT_CMDS, $Font[1], '', '', $Font[0])
	For $c = 0 To 3
		GUICtrlSetFont($RUN_LBL[$c], $Font[1], '', '', $Font[0])
	Next
EndFunc   ;==>_GUI_RunProgram_Font
; *****************************************************
; 					GUI DELETE
; *****************************************************
Func _GUI_Delete()
	$GUI_DELETE = GUICreate($_LNG_GUI_DEL[1], 370, 180, $cPos[0] + 115, $cPos[1] + 160, $WS_SYSMENU, -1, $GUI_MAIN)
	$DEL_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 170, 115, 85, 25)
	$DEL_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 270, 115, 85, 25)
	$DEL_COMBO_PARAM = GUICtrlCreateCombo('', 105, 15, 100, 20, $CBS_DROPDOWNLIST)
	$DEL_COMBO_PARAM_X = GUICtrlCreateCombo('', 225, 15, 40, 20)
	$DEL_CHK_ADD_QUOTES = GUICtrlCreateCheckbox($_LNG_GLOBAL[7], 10, 116, 150)
	$DEL_INP_FILE = GUICtrlCreateInput('', 10, 68, 345, 20)
	GUICtrlSetData($DEL_COMBO_PARAM, 'Delete|DeleteX', 'Delete')
	GUICtrlSetData($DEL_COMBO_PARAM_X, '0|1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z', '0')
	$DEL_LBL[0] = GUICtrlCreateLabel($_LNG_GUI_DEL[2], 10, 18)
	GUICtrlSetBkColor(-1, -2)
	$DEL_LBL[1] = GUICtrlCreateLabel($_LNG_GUI_DEL[3], 10, 45)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlCreateGraphic(0, 0, 364, 105)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($DEL_BTN_CANCEL, '_GUI_Delete_Events')
	GUICtrlSetOnEvent($DEL_BTN_SAVE, '_GUI_Delete_Events')
	GUICtrlSetOnEvent($DEL_COMBO_PARAM, '_GUI_Delete_Events')
	GUICtrlSetState($DEL_COMBO_PARAM_X, $GUI_DISABLE)
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_Delete_Events')
	If $UseFONT Then _GUI_Delete_Font()
	GUISetState(@SW_SHOW, $GUI_DELETE)
EndFunc   ;==>_GUI_Delete
Func _GUI_Delete_Events()
	Switch @GUI_CtrlId
		Case $DEL_BTN_SAVE
			If Not _CheckString($DEL_INP_FILE) Then Return
			If StringLen(GUICtrlRead($DEL_COMBO_PARAM_X)) > 1 And GUICtrlRead($DEL_COMBO_PARAM) = 'DeleteX' Then
				_MsgBoxEx(38, $GUI_DELETE)
				GUICtrlSetState($DEL_COMBO_PARAM_X, $GUI_FOCUS)
				Return SetError(1)
			EndIf
			If GUICtrlRead($DEL_INP_FILE) <> '' Then
				Local $d_SetData[3] = [GUICtrlRead($DEL_COMBO_PARAM), _
						GUICtrlRead($DEL_INP_FILE), _
						'False']
				If GUICtrlRead($DEL_CHK_ADD_QUOTES) = 1 Then $d_SetData[2] = 'True'
				If $d_SetData[0] = 'DeleteX' Then $d_SetData[0] = 'Delete' & GUICtrlRead($DEL_COMBO_PARAM_X)
				If $Del_ListToEdit[0] = False Then
					GUICtrlCreateListViewItem($d_SetData[0] & '|' & $d_SetData[1] & '|' & $d_SetData[2], $D_LIST)
				Else
					_GUICtrlListView_SetItem($D_LIST, $d_SetData[0], $Del_ListToEdit[1], 0)
					_GUICtrlListView_SetItem($D_LIST, $d_SetData[1], $Del_ListToEdit[1], 1)
					_GUICtrlListView_SetItem($D_LIST, $d_SetData[2], $Del_ListToEdit[1], 2)
					_Close_Window($GUI_DELETE, $GUI_MAIN)
				EndIf
			Else
				_MsgBoxEx(38, $GUI_DELETE)
				GUICtrlSetState($DEL_INP_FILE, $GUI_FOCUS)
			EndIf
		Case @GUI_CtrlId = $DEL_COMBO_PARAM
			If GUICtrlRead($DEL_COMBO_PARAM) = 'Delete' Then
				GUICtrlSetState($DEL_COMBO_PARAM_X, $GUI_DISABLE)
			ElseIf GUICtrlRead($DEL_COMBO_PARAM) = 'DeleteX' Then
				GUICtrlSetState($DEL_COMBO_PARAM_X, $GUI_ENABLE)
			EndIf
		Case $DEL_BTN_CANCEL Or $GUI_EVENT_CLOSE
			_Close_Window($GUI_DELETE, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_Delete_Events
Func _GUI_Delete_Font()
	GUICtrlSetFont($DEL_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($DEL_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($DEL_CHK_ADD_QUOTES, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($DEL_COMBO_PARAM, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($DEL_COMBO_PARAM_X, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($DEL_LBL[0], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($DEL_LBL[1], $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_Delete_Font
; *****************************************************
; 					GUI SGORTCUTS
; *****************************************************
Func _GUI_Shortcuts()
	$GUI_SHC = GUICreate($_LNG_GUI_SHC[1], 415, 465, $cPos[0] + 95, $cPos[1] + 5, $WS_SYSMENU, -1, $GUI_MAIN)
	$SHC_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 215, 400, 85, 25)
	$SHC_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 315, 400, 85, 25)
	GUIStartGroup()
	$SHC_RADIO_DESKTOP = GUICtrlCreateRadio($_LNG_GUI_SHC[2], 20, 25, 170)
	$SHC_RADIO_STARTMENU = GUICtrlCreateRadio($_LNG_GUI_SHC[3], 20, 50, 170)
	$SHC_RADIO_PROGRAMS = GUICtrlCreateRadio($_LNG_GUI_SHC[4], 20, 75, 170)
	$SHC_RADIO_STARTUP = GUICtrlCreateRadio($_LNG_GUI_SHC[5], 20, 100, 170)
	GUIStartGroup()
	$SHC_RADIO_USER = GUICtrlCreateRadio($_LNG_GUI_SHC[6], 220, 25, 170)
	$SHC_RADIO_ALL_USERS = GUICtrlCreateRadio($_LNG_GUI_SHC[7], 220, 50, 170)
	$SHC_COMBO_PARAM = GUICtrlCreateCombo('Shortcut', 220, 100, 100, 20, $CBS_DROPDOWNLIST)
	$SHC_COMBO_PARAM_X = GUICtrlCreateCombo('0', 340, 100, 35, 20)
	$SHC_INP_FILE = GUICtrlCreateInput('', 150, 145, 250, 20)
	$SHC_INP_CMDS = GUICtrlCreateInput('', 150, 175, 250, 20)
	$SHC_INP_DEST_FLDR = GUICtrlCreateInput('', 150, 205, 250, 20)
	$SHC_INP_DESCRIPTION = GUICtrlCreateInput('', 150, 235, 250, 20)
	$SHC_INP_NAME = GUICtrlCreateInput('', 150, 265, 250, 20)
	$SHC_INP_WRK_DIR = GUICtrlCreateInput('', 150, 295, 250, 20)
	$SHC_INP_ICON = GUICtrlCreateInput('', 150, 325, 250, 20)
	$SHC_INP_ICON_INDEX = GUICtrlCreateInput('', 150, 355, 250, 20)
	$SHC_TYPE = 'D'
	$SHC_USER = 'u'
	GUICtrlSetData($SHC_COMBO_PARAM, 'ShortcutX', 'Shortcut')
	GUICtrlSetData($SHC_COMBO_PARAM_X, '1|2|3|4|5|6|7|8|9|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z', '0')
	$SHC_GRP[0] = GUICtrlCreateGroup($_LNG_GUI_SHC[8], 10, 10, 190, 120)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHC_GRP[1] = GUICtrlCreateGroup($_LNG_GUI_SHC[9], 210, 10, 190, 68)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHC_GRP[2] = GUICtrlCreateGroup($_LNG_GUI_SHC[10], 210, 80, 190, 50)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHC_LBL[0] = GUICtrlCreateLabel($_LNG_GUI_SHC[11], 10, 148, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[1] = GUICtrlCreateLabel($_LNG_GUI_SHC[12], 10, 178, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[2] = GUICtrlCreateLabel($_LNG_GUI_SHC[13], 10, 208, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[3] = GUICtrlCreateLabel($_LNG_GUI_SHC[14], 10, 238, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[4] = GUICtrlCreateLabel($_LNG_GUI_SHC[15], 10, 268, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[5] = GUICtrlCreateLabel($_LNG_GUI_SHC[16], 10, 298, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[6] = GUICtrlCreateLabel($_LNG_GUI_SHC[17], 10, 328, 135)
	GUICtrlSetBkColor(-1, -2)
	$SHC_LBL[7] = GUICtrlCreateLabel($_LNG_GUI_SHC[18], 10, 358, 135)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetBkColor($SHC_RADIO_DESKTOP, 0xFFFFFF)
	GUICtrlSetBkColor($SHC_RADIO_STARTMENU, 0xFFFFFF)
	GUICtrlSetBkColor($SHC_RADIO_PROGRAMS, 0xFFFFFF)
	GUICtrlSetBkColor($SHC_RADIO_STARTUP, 0xFFFFFF)
	GUICtrlSetBkColor($SHC_RADIO_USER, 0xFFFFFF)
	GUICtrlSetBkColor($SHC_RADIO_ALL_USERS, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 0, 409, 390)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($SHC_BTN_CANCEL, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_BTN_SAVE, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_DESKTOP, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_STARTMENU, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_PROGRAMS, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_STARTUP, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_ALL_USERS, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_RADIO_USER, '_GUI_Shortcuts_Events')
	GUICtrlSetOnEvent($SHC_COMBO_PARAM, '_GUI_Shortcuts_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_Shortcuts_Events')
	GUICtrlSetState($SHC_RADIO_DESKTOP, $GUI_CHECKED)
	GUICtrlSetState($SHC_RADIO_USER, $GUI_CHECKED)
	GUICtrlSetState($SHC_COMBO_PARAM_X, $GUI_DISABLE)
	If $UseFONT Then _GUI_Shortcuts_Font()
	GUISetState(@SW_SHOW, $GUI_SHC)
EndFunc   ;==>_GUI_Shortcuts
Func _GUI_Shortcuts_Events()
	Switch @GUI_CtrlId
		Case $SHC_BTN_SAVE
			If Not _CheckString($SHC_INP_FILE) Then Return
			If Not _CheckString($SHC_INP_CMDS) Then Return
			If Not _CheckString($SHC_INP_DEST_FLDR) Then Return
			If Not _CheckString($SHC_INP_DESCRIPTION) Then Return
			If Not _CheckString($SHC_INP_NAME) Then Return
			If Not _CheckString($SHC_INP_WRK_DIR) Then Return
			If Not _CheckString($SHC_INP_ICON) Then Return
			If Not _CheckString($SHC_INP_ICON_INDEX) Then Return
			Local $shcData[12] = [GUICtrlRead($SHC_COMBO_PARAM), _
					GUICtrlRead($SHC_COMBO_PARAM_X), _
					GUICtrlRead($SHC_INP_FILE), _
					GUICtrlRead($SHC_INP_CMDS), _
					GUICtrlRead($SHC_INP_DEST_FLDR), _
					GUICtrlRead($SHC_INP_DESCRIPTION), _
					GUICtrlRead($SHC_INP_NAME), _
					GUICtrlRead($SHC_INP_WRK_DIR), _
					GUICtrlRead($SHC_INP_ICON), _
					GUICtrlRead($SHC_INP_ICON_INDEX), _
					'Shortcut']
			If $shcData[0] = 'ShortcutX' And StringLen($shcData[1]) > 1 Then
				_MsgBoxEx(38, $GUI_SHC)
				GUICtrlSetState($SHC_COMBO_PARAM_X, $GUI_FOCUS)
				Return
			EndIf
			If GUICtrlRead($SHC_INP_FILE) = '' Then
				_MsgBoxEx(38, $GUI_SHC)
				GUICtrlSetState($SHC_INP_FILE, $GUI_FOCUS)
				Return
			EndIf
			If $shcData[0] = 'ShortcutX' Then $shcData[10] &= $shcData[1]
			$shcData[11] = $shcData[10] & '|' & $SHC_TYPE & $SHC_USER & '|' & $shcData[2] & '|' & $shcData[3] & '|' & $shcData[4] & '|' & $shcData[5] & '|' & $shcData[6] & '|' & $shcData[7] & '|' & $shcData[8] & '|' & $shcData[9]
			If $Shc_ListToEdit[0] = False Then
				GUICtrlCreateListViewItem($shcData[11], $SH_LIST)
			Else
				_GUICtrlListView_SetItem($SH_LIST, $shcData[10], $Shc_ListToEdit[1], 0)
				_GUICtrlListView_SetItem($SH_LIST, $SHC_TYPE & $SHC_USER, $Shc_ListToEdit[1], 1)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[2], $Shc_ListToEdit[1], 2)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[3], $Shc_ListToEdit[1], 3)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[4], $Shc_ListToEdit[1], 4)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[5], $Shc_ListToEdit[1], 5)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[6], $Shc_ListToEdit[1], 6)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[7], $Shc_ListToEdit[1], 7)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[8], $Shc_ListToEdit[1], 8)
				_GUICtrlListView_SetItem($SH_LIST, $shcData[9], $Shc_ListToEdit[1], 9)
				_Close_Window($GUI_SHC, $GUI_MAIN)
			EndIf
			;Shortcut="Du,{%%T\\source},{commands},{folder},{decription},{name},{workingdir},{iconfile},{iconindex}"
		Case $SHC_RADIO_DESKTOP
			$SHC_TYPE = 'D'
		Case $SHC_RADIO_STARTMENU
			$SHC_TYPE = 'S'
		Case $SHC_RADIO_PROGRAMS
			$SHC_TYPE = 'P'
		Case $SHC_RADIO_STARTUP
			$SHC_TYPE = 'T'
		Case $SHC_RADIO_ALL_USERS
			$SHC_USER = ''
		Case $SHC_RADIO_USER
			$SHC_USER = 'u'
		Case $SHC_COMBO_PARAM
			If GUICtrlRead($SHC_COMBO_PARAM) = 'Shortcut' Then
				GUICtrlSetState($SHC_COMBO_PARAM_X, $GUI_DISABLE)
			ElseIf GUICtrlRead($SHC_COMBO_PARAM) = 'ShortcutX' Then
				GUICtrlSetState($SHC_COMBO_PARAM_X, $GUI_ENABLE)
			EndIf
		Case $SHC_BTN_CANCEL Or $GUI_EVENT_CLOSE
			_Close_Window($GUI_SHC, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_Shortcuts_Events
Func _GUI_Shortcuts_Font()
	GUICtrlSetFont($SHC_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($SHC_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_DESKTOP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_STARTMENU, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_PROGRAMS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_STARTUP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_USER, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_RADIO_ALL_USERS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_COMBO_PARAM, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_COMBO_PARAM_X, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_GRP[0], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_GRP[1], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SHC_GRP[2], $Font[1], '', '', $Font[0])
	For $c = 0 To 7
		GUICtrlSetFont($SHC_LBL[$c], $Font[1], '', '', $Font[0])
	Next
EndFunc   ;==>_GUI_Shortcuts_Font
; *****************************************************
; 				GUI SET ENVIRONMENT
; *****************************************************
Func _GUI_SetEnv()
	$GUI_ENV = GUICreate($_LNG_GUI_ENV[1], 365, 155, $cPos[0] + 120, $cPos[1] + 150, $WS_SYSMENU, -1, $GUI_MAIN)
	$ENV_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 165, 90, 85, 25)
	$ENV_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 265, 90, 85, 25)
	$ENV_INP_NAME = GUICtrlCreateCombo('', 100, 15, 250, 22)
	$ENV_INP_VALUE = GUICtrlCreateInput('', 100, 45, 250, 22)
	$ENV_LBL[0] = GUICtrlCreateLabel($_LNG_GUI_ENV[2], 10, 18, 85)
	$ENV_LBL[1] = GUICtrlCreateLabel($_LNG_GUI_ENV[3], 10, 48, 85)
	GUICtrlSetData($ENV_INP_NAME, 'Name|Vers|PathInst|NameInf|7zSfxString25|7zSfxString26|7zSfxString27|7zSfxString28|7zSfxString29|7zSfxString35|7zSfxString36|7zSfxString37|7zSfxString38|sfx_homepage')
	GUICtrlSetBkColor($ENV_LBL[0], -2)
	GUICtrlSetBkColor($ENV_LBL[1], -2)
	GUICtrlCreateGraphic(0, 0, 359, 80)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($ENV_BTN_SAVE, '_GUI_SetEnv_Events')
	GUICtrlSetOnEvent($ENV_BTN_CANCEL, '_GUI_SetEnv_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_SetEnv_Events')
	If $UseFONT Then _GUI_SetEnv_Font()
	GUISetState(@SW_SHOW, $GUI_ENV)
EndFunc   ;==>_GUI_SetEnv
Func _GUI_SetEnv_Events()
	Switch @GUI_CtrlId
		Case $ENV_BTN_SAVE
			If Not _CheckString($ENV_INP_NAME) Then Return
			If Not _CheckString($ENV_INP_VALUE) Then Return
			If GUICtrlRead($ENV_INP_NAME) <> '' Then
				If $Var_ListToEdit[0] = False Then
					GUICtrlCreateListViewItem(GUICtrlRead($ENV_INP_NAME) & '|' & GUICtrlRead($ENV_INP_VALUE), $E_LIST)
				Else
					_GUICtrlListView_SetItem($E_LIST, GUICtrlRead($ENV_INP_NAME), $Var_ListToEdit[1], 0)
					_GUICtrlListView_SetItem($E_LIST, GUICtrlRead($ENV_INP_VALUE), $Var_ListToEdit[1], 1)
					_Close_Window($GUI_ENV, $GUI_MAIN)
				EndIf
			Else
				_MsgBoxEx(38, $GUI_ENV)
				GUICtrlSetState($ENV_INP_NAME, $GUI_FOCUS)
			EndIf
		Case $ENV_BTN_CANCEL Or $GUI_EVENT_CLOSE
			_Close_Window($GUI_ENV, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_SetEnv_Events
Func _GUI_SetEnv_Font()
	GUICtrlSetFont($ENV_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($ENV_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($ENV_INP_NAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ENV_INP_VALUE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ENV_LBL[0], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($ENV_LBL[1], $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_SetEnv_Font
; *****************************************************
; 					GUI PREFIX
; *****************************************************
Func _GUI_Prefix()
	$GUI_PREFIX = GUICreate($_LNG_GUI_RUN[2], 190, 275, $cPos[0] + 155, $cPos[1] - 17, $WS_SYSMENU, -1, $GUI_RUN)
	$PFX_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 10, 210, 75, 25)
	$PFX_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 100, 210, 75, 25)
	$PFX_COMBO_DEL = GUICtrlCreateCombo('', 100, 10, 40, 20, $CBS_DROPDOWNLIST)
	$PFX_COMBO_FM = GUICtrlCreateCombo('', 100, 35, 40, 20)
	$PFX_COMBO_SHC = GUICtrlCreateCombo('', 100, 60, 40, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData($PFX_COMBO_DEL, '0|1', '0')
	GUICtrlSetData($PFX_COMBO_FM, '5|10|15|20|25|30', '20')
	GUICtrlSetData($PFX_COMBO_SHC, '0|1', '0')
	$PFX_CHK_DEL = GUICtrlCreateCheckbox(' delX', 10, 10, 85)
	$PFX_CHK_FM = GUICtrlCreateCheckbox(' fmX', 10, 35, 85)
	$PFX_CHK_SHC = GUICtrlCreateCheckbox(' shcX', 10, 60, 85)
	$PFX_CHK_HIDCON = GUICtrlCreateCheckbox(' hidcon', 10, 85, 85)
	$PFX_CHK_NOWAIT = GUICtrlCreateCheckbox(' nowait', 10, 115, 85)
	$PFX_CHK_WAITALL = GUICtrlCreateCheckbox(' waitall', 100, 115, 85)
	$PFX_CHK_FNOWAIT = GUICtrlCreateCheckbox(' forcenowait', 10, 140, 85)
	$PFX_CHK_X64 = GUICtrlCreateCheckbox(' x64', 10, 170, 85)
	$PFX_CHK_X86 = GUICtrlCreateCheckbox(' x86', 100, 170, 85)
	GUICtrlSetBkColor($PFX_CHK_DEL, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_FM, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_SHC, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_HIDCON, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_NOWAIT, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_FNOWAIT, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_WAITALL, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_X64, 0xFFFFFF)
	GUICtrlSetBkColor($PFX_CHK_X86, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 0, 184, 200)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlCreateGraphic(0, 109, 184, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlCreateGraphic(0, 164, 184, 3)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlSetOnEvent($PFX_BTN_SAVE, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_BTN_CANCEL, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_CHK_NOWAIT, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_CHK_FNOWAIT, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_CHK_WAITALL, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_CHK_X64, '_GUI_Prefix_Events')
	GUICtrlSetOnEvent($PFX_CHK_X86, '_GUI_Prefix_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_Prefix_Events')
	If $UseFONT Then _GUI_Prefix_Font()
	GUISetState(@SW_SHOW, $GUI_PREFIX)
EndFunc   ;==>_GUI_Prefix
Func _GUI_Prefix_Events()
	Select
		Case @GUI_CtrlId = $PFX_BTN_SAVE
			If GUICtrlRead($PFX_CHK_FM) = 1 Then
				If StringLen(GUICtrlRead($PFX_COMBO_FM)) > 3 Then
					_MsgBoxEx(38, $GUI_PREFIX)
					GUICtrlSetState($PFX_COMBO_FM, $GUI_FOCUS)
					Return SetError(1)
				ElseIf Not StringIsDigit(GUICtrlRead($PFX_COMBO_FM)) Then
					_MsgBoxEx(38, $GUI_PREFIX)
					GUICtrlSetState($PFX_COMBO_FM, $GUI_FOCUS)
					Return SetError(1)
				EndIf
			EndIf
			Local $PFXData
			If GUICtrlRead($PFX_CHK_DEL) = 1 Then $PFXData &= 'del' & GUICtrlRead($PFX_COMBO_DEL) & ':'
			If GUICtrlRead($PFX_CHK_FM) = 1 Then $PFXData &= 'fm' & GUICtrlRead($PFX_COMBO_FM) & ':'
			If GUICtrlRead($PFX_CHK_NOWAIT) = 1 Then $PFXData &= 'nowait:'
			If GUICtrlRead($PFX_CHK_FNOWAIT) = 1 Then $PFXData &= 'forcenowait:'
			If GUICtrlRead($PFX_CHK_HIDCON) = 1 Then $PFXData &= 'hidcon:'
			If GUICtrlRead($PFX_CHK_SHC) = 1 Then $PFXData &= 'shc' & GUICtrlRead($PFX_COMBO_SHC) & ':'
			If GUICtrlRead($PFX_CHK_WAITALL) = 1 Then $PFXData &= 'waitall:'
			If GUICtrlRead($PFX_CHK_X64) = 1 Then $PFXData &= 'x64:'
			If GUICtrlRead($PFX_CHK_X86) = 1 Then $PFXData &= 'x86:'
			GUICtrlSetData($RUN_INP_PREFIX, '')
			GUICtrlSetData($RUN_INP_PREFIX, $PFXData)
			_Close_Window($GUI_PREFIX, $GUI_RUN)
		Case @GUI_CtrlId = $PFX_CHK_NOWAIT
			GUICtrlSetState($PFX_CHK_FNOWAIT, 4)
			GUICtrlSetState($PFX_CHK_WAITALL, 4)
		Case @GUI_CtrlId = $PFX_CHK_FNOWAIT
			GUICtrlSetState($PFX_CHK_NOWAIT, 4)
			GUICtrlSetState($PFX_CHK_WAITALL, 4)
		Case @GUI_CtrlId = $PFX_CHK_WAITALL
			GUICtrlSetState($PFX_CHK_NOWAIT, 4)
			GUICtrlSetState($PFX_CHK_FNOWAIT, 4)
		Case @GUI_CtrlId = $PFX_CHK_X64
			GUICtrlSetState($PFX_CHK_X86, 4)
		Case @GUI_CtrlId = $PFX_CHK_X86
			GUICtrlSetState($PFX_CHK_X64, 4)
		Case @GUI_CtrlId = $PFX_BTN_CANCEL Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_Close_Window($GUI_PREFIX, $GUI_RUN)
	EndSelect
EndFunc   ;==>_GUI_Prefix_Events
Func _GUI_Prefix_Font()
	GUICtrlSetFont($PFX_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($PFX_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($PFX_COMBO_DEL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_COMBO_FM, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_COMBO_SHC, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_FM, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_SHC, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_HIDCON, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_NOWAIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_FNOWAIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_WAITALL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_X64, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($PFX_CHK_X86, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_Prefix_Font
; *****************************************************
; 					GUI SFX OPTIONS
; *****************************************************
Func _GUI_SFX_Options()
	$GUI_SFXOPTS = GUICreate($_LNG_GUI_SFXOPTS[1], 450, 255, $cPos[0] + 75, $cPos[1] + 95, $WS_SYSMENU, -1, $GUI_MAIN)
	$SFXOPTS_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 250, 190, 85, 25)
	$SFXOPTS_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 350, 190, 85, 25)
	$SFXOPTS_CHK_USE_UPX = GUICtrlCreateCheckbox($_LNG_GUI_SFXOPTS[2], 10, 5, 420)
	$SFXOPTS_CHK_USE_DEF = GUICtrlCreateCheckbox($_LNG_GUI_SFXOPTS[3], 10, 65, 420)
	If Not StringInStr($CMB_UPX_DATA, $USE_UPX[1] & '|') Or $USE_UPX[1] = '' Then $USE_UPX[1] = '--best --all-methods'
	If Not StringInStr($CMB_SFXMOD_DATA, $USE_DEFMOD[1] & '|') Or $USE_DEFMOD[1] = '' Then $USE_DEFMOD[1] = '7zsd_All'
	$SFXOPTS_CMB_UPX = GUICtrlCreateCombo('', 10, 30, 150, 20, 0x0003)
	$SFXOPTS_CMB_DEF_SFX = GUICtrlCreateCombo('', 10, 90, 150, 20, 0x0003)
	GUICtrlSetData($SFXOPTS_CMB_UPX, $CMB_UPX_DATA, $USE_UPX[1])
	GUICtrlSetData($SFXOPTS_CMB_DEF_SFX, $CMB_SFXMOD_DATA, $USE_DEFMOD[1])
	$SFXOPTS_BTN_SFXINFO = GUICtrlCreateButton('', 168, 89, 34, 23)
	$SFXOPTS_LBL_7ZIP = GUICtrlCreateLabel($_LNG_GUI_SFXOPTS[11], 10, 125)
	$SFXOPTS_INP_7ZIP = GUICtrlCreateInput('', 10, 145, 345, 20)
	$SFXOPTS_SEL_7ZIP = GUICtrlCreateButton('', 362, 144, 34, 22)
	$SFXOPTS_SET_7ZIP = GUICtrlCreateButton('', 402, 144, 34, 22)
	GUICtrlSetData($SFXOPTS_INP_7ZIP, $7ZIP_PATH)
	GUICtrlSetTip($SFXOPTS_SEL_7ZIP, $_LNG_GUI_SFXOPTS[12])
	GUICtrlSetTip($SFXOPTS_SET_7ZIP, $_LNG_GUI_SFXOPTS[13])
	_GUICtrlButton_SetImageList($SFXOPTS_BTN_SFXINFO, $iBtnList_small[0], 4)
	_GUICtrlButton_SetImageList($SFXOPTS_SEL_7ZIP, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($SFXOPTS_SET_7ZIP, $iBtnList_small[1], 4)
	GUICtrlSetBkColor($SFXOPTS_CHK_USE_UPX, 0xFFFFFF)
	GUICtrlSetBkColor($SFXOPTS_CHK_USE_DEF, 0xFFFFFF)
	GUICtrlSetBkColor($SFXOPTS_LBL_7ZIP, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 0, 444, 180)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($SFXOPTS_BTN_CANCEL, '_GUI_SFX_Options_Events')
	GUICtrlSetOnEvent($SFXOPTS_BTN_SAVE, '_GUI_SFX_Options_Events')
	GUICtrlSetOnEvent($SFXOPTS_BTN_SFXINFO, '_GUI_SFX_Options_Events')
	GUICtrlSetOnEvent($SFXOPTS_SEL_7ZIP, '_GUI_SFX_Options_Events')
	GUICtrlSetOnEvent($SFXOPTS_SET_7ZIP, '_GUI_SFX_Options_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_SFX_Options_Events')
	If $USE_UPX[0] = 1 Then GUICtrlSetState($SFXOPTS_CHK_USE_UPX, 1)
	If $USE_DEFMOD[0] = 1 Then GUICtrlSetState($SFXOPTS_CHK_USE_DEF, 1)
	If $UseFONT Then _GUI_SFX_Options_Font()
	GUISetState(@SW_SHOW, $GUI_SFXOPTS)
EndFunc   ;==>_GUI_SFX_Options
Func _GUI_SFX_Options_Events()
	Select
		Case @GUI_CtrlId = $SFXOPTS_BTN_SFXINFO
			_SFX_Info($Mods_Dir & '\' & GUICtrlRead($SFXOPTS_CMB_DEF_SFX) & '.sfx', $GUI_SFXOPTS)
		Case @GUI_CtrlId = $SFXOPTS_SEL_7ZIP
			Local $FO_7ZIP = FileOpenDialog('Select "7z.exe" file:', _FileGetPathData(GUICtrlRead($SFXOPTS_INP_7ZIP)), 'Executable files (*.exe)', 1, '7z.exe', $GUI_SFXOPTS)
			If Not @error Then GUICtrlSetData($SFXOPTS_INP_7ZIP, $FO_7ZIP)
		Case @GUI_CtrlId = $SFXOPTS_SET_7ZIP
			$cPos = WinGetPos($GUI_SFXOPTS)
			GUISetState(@SW_DISABLE, $GUI_SFXOPTS)
			_GUI_7Zip()
		Case @GUI_CtrlId = $SFXOPTS_BTN_SAVE
			If GUICtrlRead($SFXOPTS_CHK_USE_UPX) = 1 Then
				$USE_UPX[0] = 1
			Else
				$USE_UPX[0] = 0
			EndIf
			If GUICtrlRead($SFXOPTS_CHK_USE_DEF) = 1 Then
				$USE_DEFMOD[0] = 1
				GUICtrlSetState($S_INP_SFXMOD, $GUI_DISABLE)
				GUICtrlSetState($S_SEL_SFXMOD, $GUI_DISABLE)
			Else
				$USE_DEFMOD[0] = 0
				GUICtrlSetState($S_INP_SFXMOD, $GUI_ENABLE)
				GUICtrlSetState($S_SEL_SFXMOD, $GUI_ENABLE)
			EndIf
			$USE_UPX[1] = GUICtrlRead($SFXOPTS_CMB_UPX)
			$USE_DEFMOD[1] = GUICtrlRead($SFXOPTS_CMB_DEF_SFX)
			$7ZIP_PATH = GUICtrlRead($SFXOPTS_INP_7ZIP)
			_Close_Window($GUI_SFXOPTS, $GUI_MAIN)
		Case @GUI_CtrlId = $SFXOPTS_BTN_CANCEL Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_Close_Window($GUI_SFXOPTS, $GUI_MAIN)
	EndSelect
EndFunc   ;==>_GUI_SFX_Options_Events
Func _GUI_SFX_Options_Font()
	GUICtrlSetFont($SFXOPTS_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_CHK_USE_UPX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_CHK_USE_DEF, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_CMB_UPX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_CMB_DEF_SFX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_CMB_7ZIP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_LBL_7ZIP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SFXOPTS_INP_7ZIP, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_SFX_Options_Font
; *****************************************************
; 						GUI 7ZIP
; *****************************************************
Func _GUI_7Zip()
	$GUI_7ZIP = GUICreate($_LNG_GUI_SFXOPTS[18], 340, 230, $cPos[0] + 55, $cPos[1] + 10, $WS_SYSMENU, -1, $GUI_SFXOPTS)
	$7ZIP_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 140, 165, 85, 25)
	$7ZIP_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 240, 165, 85, 25)
	$7ZIP_CMB_LVL = GUICtrlCreateCombo('', 170, 15, 150, 20, 0x0003)
	$7ZIP_CMB_METHOD = GUICtrlCreateCombo('', 170, 50, 150, 20, 0x0003)
	$7ZIP_CMB_DICT = GUICtrlCreateCombo('', 170, 85, 150, 20, 0x0003)
	$7ZIP_CMB_SOLID = GUICtrlCreateCombo('', 170, 120, 150, 20, 0x0003)
	$7ZIP_LBL_LVL = GUICtrlCreateLabel($_LNG_GUI_SFXOPTS[19], 10, 17, 150)
	$7ZIP_LBL_METHOD = GUICtrlCreateLabel($_LNG_GUI_SFXOPTS[20], 10, 52, 150)
	$7ZIP_LBL_DICT = GUICtrlCreateLabel($_LNG_GUI_SFXOPTS[21], 10, 87, 150)
	$7ZIP_LBL_SOLID = GUICtrlCreateLabel($_LNG_GUI_SFXOPTS[22], 10, 122, 150)
	If Not StringInStr($CMB_LVL_DATA, $7z_LVL[0] & '|') Or $7z_LVL[0] = '' Then $7z_LVL[0] = 'Ultra'
	If Not StringInStr($CMB_METHOD_DATA, $7z_METHOD[0] & '|') Or $7z_METHOD[0] = '' Then $7z_METHOD[0] = 'LZMA2'
	If Not StringInStr($CMB_DICT_DATA, $7z_DICT[0] & '|') Or $7z_DICT[0] = '' Then $7z_DICT[0] = '64 MB'
	If Not StringInStr($CMB_SOLID_DATA, $7z_SOLID[0] & '|') Or $7z_SOLID[0] = '' Then $7z_SOLID[0] = 'Solid'
	GUICtrlSetData($7ZIP_CMB_LVL, $CMB_LVL_DATA, $7z_LVL[0])
	GUICtrlSetData($7ZIP_CMB_METHOD, $CMB_METHOD_DATA, $7z_METHOD[0])
	GUICtrlSetData($7ZIP_CMB_DICT, $CMB_DICT_DATA, $7z_DICT[0])
	GUICtrlSetData($7ZIP_CMB_SOLID, $CMB_SOLID_DATA, $7z_SOLID[0])
	GUICtrlSetBkColor($7ZIP_LBL_LVL, -2)
	GUICtrlSetBkColor($7ZIP_LBL_METHOD, -2)
	GUICtrlSetBkColor($7ZIP_LBL_DICT, -2)
	GUICtrlSetBkColor($7ZIP_LBL_SOLID, -2)
	GUICtrlCreateGraphic(0, 0, 334, 155)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	GUICtrlSetOnEvent($7ZIP_BTN_SAVE, '_GUI_7Zip_Events')
	GUICtrlSetOnEvent($7ZIP_BTN_CANCEL, '_GUI_7Zip_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_7Zip_Events')
	If $UseFONT Then _GUI_7Zip_Font()
	GUISetState(@SW_SHOW, $GUI_7ZIP)
EndFunc   ;==>_GUI_7Zip
Func _GUI_7Zip_Events()
	Select
		Case @GUI_CtrlId = $7ZIP_BTN_SAVE
			$7z_LVL[0] = GUICtrlRead($7ZIP_CMB_LVL)
			$7z_METHOD[0] = GUICtrlRead($7ZIP_CMB_METHOD)
			$7z_DICT[0] = GUICtrlRead($7ZIP_CMB_DICT)
			$7z_SOLID[0] = GUICtrlRead($7ZIP_CMB_SOLID)
			_Close_Window($GUI_7ZIP, $GUI_SFXOPTS)
		Case @GUI_CtrlId = $7ZIP_BTN_CANCEL Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_Close_Window($GUI_7ZIP, $GUI_SFXOPTS)
	EndSelect
EndFunc   ;==>_GUI_7Zip_Events
Func _GUI_7Zip_Font()
	GUICtrlSetFont($7ZIP_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_CMB_LVL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_CMB_METHOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_CMB_DICT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_CMB_SOLID, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_LBL_LVL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_LBL_METHOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_LBL_DICT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($7ZIP_LBL_SOLID, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_7Zip_Font
; *****************************************************
; 					GUI EDIT VERSION
; *****************************************************
Func _GUI_EditVersion()
	$GUI_RESEDIT = GUICreate($_LNG_GUI_VERS[1], 450, 370, $cPos[0] + 75, $cPos[1] + 50, $WS_SYSMENU, -1, $GUI_MAIN)
	$RES_BTN_LOAD = GUICtrlCreateButton($_LNG_GUI_VERS[2], 180, 305, 75, 25)
	$Dummy_LoadRes = GUICtrlCreateDummy()
	$cMenu_LoadRes = GUICtrlCreateContextMenu($Dummy_LoadRes)
	$RES_Mi_LOAD_SFX = _GUICtrlCreateMenuItemEx($_LNG_GUI_VERS[3], $cMenu_LoadRes)
	$RES_Mi_LOAD_FILE = _GUICtrlCreateMenuItemEx($_LNG_GUI_VERS[4], $cMenu_LoadRes)
	$RES_Mi_LOAD_INI = _GUICtrlCreateMenuItemEx($_LNG_GUI_VERS[5], $cMenu_LoadRes)
	_GUICtrlCreateMenuItemEx('', $cMenu_LoadRes)
	$RES_Mi_WRITE_INI = _GUICtrlCreateMenuItemEx($_LNG_GUI_VERS[6], $cMenu_LoadRes, $ScriptFPath, 101)
	$RES_BTN_SAVE = GUICtrlCreateButton($_LNG_GLOBAL[5], 270, 305, 75, 25)
	$RES_BTN_CANCEL = GUICtrlCreateButton($_LNG_GLOBAL[6], 360, 305, 75, 25)
	$RES_CHK_INCLUDE = GUICtrlCreateCheckbox($_LNG_GUI_VERS[7], 10, 250, 430)
	$RES_CHK_USE = GUICtrlCreateCheckbox($_LNG_GUI_VERS[8], 10, 270, 430)
	$RES_BTN_COPYRIGHT = GUICtrlCreateButton('©', 190, 144, 20, 22)
	$RES_INP_FILEVERS = GUICtrlCreateInput('', 10, 25, 200, 20)
	$RES_INP_COMPNAME = GUICtrlCreateInput('', 235, 25, 200, 20)
	$RES_INP_COMMENTS = GUICtrlCreateInput('', 10, 65, 200, 20)
	$RES_INP_FILEDESC = GUICtrlCreateInput('', 235, 65, 200, 20)
	$RES_INP_PRODUCTVERS = GUICtrlCreateInput('', 10, 105, 200, 20)
	$RES_INP_PRODUCTNAME = GUICtrlCreateInput('', 235, 105, 200, 20)
	$RES_INP_COPYRIGHT = GUICtrlCreateInput('', 10, 145, 180, 20)
	$RES_INP_TRADEMARK = GUICtrlCreateInput('', 235, 145, 200, 20)
	$RES_INP_INTNAME = GUICtrlCreateInput('', 10, 185, 200, 20)
	$RES_INP_ORIGNAME = GUICtrlCreateInput('', 235, 185, 200, 20)
	$RES_INP_SPECIALBUILD = GUICtrlCreateInput('', 10, 225, 200, 20)
	$RES_INP_PRIVBUILD = GUICtrlCreateInput('', 235, 225, 200, 20)
	;-------------
	$RES_LBL[1] = GUICtrlCreateLabel('File Version:', 10, 10, 200, 20, 0x01)
	$RES_LBL[2] = GUICtrlCreateLabel('Company Name:', 235, 10, 200, 20, 0x01)
	$RES_LBL[3] = GUICtrlCreateLabel('Comments:', 10, 50, 200, 20, 0x01)
	$RES_LBL[4] = GUICtrlCreateLabel('File Description:', 235, 50, 200, 20, 0x01)
	$RES_LBL[5] = GUICtrlCreateLabel('Product Version:', 10, 90, 200, 20, 0x01)
	$RES_LBL[6] = GUICtrlCreateLabel('Product Name:', 235, 90, 200, 20, 0x01)
	$RES_LBL[7] = GUICtrlCreateLabel('Legal Copyright:', 10, 130, 200, 20, 0x01)
	$RES_LBL[8] = GUICtrlCreateLabel('Legal Trademarks:', 235, 130, 200, 20, 0x01)
	$RES_LBL[9] = GUICtrlCreateLabel('Internal Name:', 10, 170, 200, 20, 0x01)
	$RES_LBL[10] = GUICtrlCreateLabel('Original FileName:', 235, 170, 200, 20, 0x01)
	$RES_LBL[11] = GUICtrlCreateLabel('Special Build:', 10, 210, 200, 20, 0x01)
	$RES_LBL[12] = GUICtrlCreateLabel('Private Build:', 235, 210, 200, 20, 0x01)
	GUICtrlSetFont($RES_BTN_COPYRIGHT, 10)
	GUICtrlSetBkColor($RES_CHK_INCLUDE, 0xFFFFFF)
	GUICtrlSetBkColor($RES_CHK_USE, 0xFFFFFF)
	For $c = 1 To 12
		GUICtrlSetBkColor($RES_LBL[$c], -2)
	Next
	GUICtrlCreateGraphic(0, 0, 444, 295)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetColor(-1, 0xDFDFDF)
	;-------------
	GUICtrlSetOnEvent($RES_BTN_LOAD, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_Mi_LOAD_SFX, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_Mi_LOAD_FILE, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_Mi_LOAD_INI, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_Mi_WRITE_INI, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_BTN_SAVE, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_BTN_CANCEL, '_GUI_EditVersion_Events')
	GUICtrlSetOnEvent($RES_BTN_COPYRIGHT, '_GUI_EditVersion_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_EditVersion_Events')
	If $UseFONT Then _GUI_EditVersion_Font()
	GUISetState(@SW_SHOW, $GUI_RESEDIT)
EndFunc   ;==>_GUI_EditVersion
Func _GUI_EditVersion_Events()
	Switch @GUI_CtrlId
		Case $RES_BTN_SAVE
			$vFileVersion = GUICtrlRead($RES_INP_FILEVERS)
			$vCompanyName = GUICtrlRead($RES_INP_COMPNAME)
			$vComments = GUICtrlRead($RES_INP_COMMENTS)
			$vFileDescription = GUICtrlRead($RES_INP_FILEDESC)
			$vProductVersion = GUICtrlRead($RES_INP_PRODUCTVERS)
			$vProductName = GUICtrlRead($RES_INP_PRODUCTNAME)
			$vLegalCopyright = GUICtrlRead($RES_INP_COPYRIGHT)
			$vLegalTrademarks = GUICtrlRead($RES_INP_TRADEMARK)
			$vInternalName = GUICtrlRead($RES_INP_INTNAME)
			$vOriginalFileName = GUICtrlRead($RES_INP_ORIGNAME)
			$vSpecialBuild = GUICtrlRead($RES_INP_SPECIALBUILD)
			$vPrivateBuild = GUICtrlRead($RES_INP_PRIVBUILD)
			If GUICtrlRead($RES_CHK_USE) = 1 Then
				$ModeRESCHANGE = 1
			Else
				$ModeRESCHANGE = 0
			EndIf
			If GUICtrlRead($RES_CHK_INCLUDE) = 1 Then
				$ModeINCLUDERES = True
			Else
				$ModeINCLUDERES = False
			EndIf
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_SFX)
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_FILE)
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_INI)
			_GUICtrlODMenuItemDelete($RES_Mi_WRITE_INI)
			_Close_Window($GUI_RESEDIT, $GUI_MAIN)
		Case $RES_BTN_COPYRIGHT
			GUICtrlSetData($RES_INP_COPYRIGHT, '©', 1)
		Case $RES_BTN_LOAD
			_ShowMenu($GUI_RESEDIT, $RES_BTN_LOAD, $cMenu_LoadRes)
		Case $RES_Mi_LOAD_SFX, $RES_Mi_LOAD_FILE
			If @GUI_CtrlId = $RES_Mi_LOAD_SFX Then
				Local $SFX_TO_LOAD = GUICtrlRead($S_INP_SFXMOD)
				If $USE_DEFMOD[0] = 1 Then $SFX_TO_LOAD = $Mods_Dir & '\' & $USE_DEFMOD[1] & '.sfx'
				If Not FileExists($SFX_TO_LOAD) Then _MsgBoxEx(12, $GUI_RESEDIT)
			ElseIf @GUI_CtrlId = $RES_Mi_LOAD_FILE Then
				Local $SFX_TO_LOAD = FileOpenDialog('Select file:', '', 'All supported formats(*.exe; *.dll; *.sys)|Executable files(*.exe)|Dynamic Link Library files(*.dll)|SYS files(*.sys)', 3, '', $GUI_RESEDIT)
				GUISetState(@SW_SHOWNA, $GUI_MAIN)
			EndIf
			If FileExists($SFX_TO_LOAD) Then
				GUICtrlSetData($RES_INP_FILEVERS, FileGetVersion($SFX_TO_LOAD, 'FileVersion'))
				GUICtrlSetData($RES_INP_COMPNAME, FileGetVersion($SFX_TO_LOAD, 'CompanyName'))
				GUICtrlSetData($RES_INP_COMMENTS, FileGetVersion($SFX_TO_LOAD, 'Comments'))
				GUICtrlSetData($RES_INP_FILEDESC, FileGetVersion($SFX_TO_LOAD, 'FileDescription'))
				GUICtrlSetData($RES_INP_PRODUCTVERS, FileGetVersion($SFX_TO_LOAD, 'ProductVersion'))
				GUICtrlSetData($RES_INP_PRODUCTNAME, FileGetVersion($SFX_TO_LOAD, 'ProductName'))
				GUICtrlSetData($RES_INP_COPYRIGHT, FileGetVersion($SFX_TO_LOAD, 'LegalCopyright'))
				GUICtrlSetData($RES_INP_TRADEMARK, FileGetVersion($SFX_TO_LOAD, 'LegalTrademarks'))
				GUICtrlSetData($RES_INP_INTNAME, FileGetVersion($SFX_TO_LOAD, 'InternalName'))
				GUICtrlSetData($RES_INP_ORIGNAME, FileGetVersion($SFX_TO_LOAD, 'OriginalFilename'))
				GUICtrlSetData($RES_INP_SPECIALBUILD, FileGetVersion($SFX_TO_LOAD, 'SpecialBuild'))
				GUICtrlSetData($RES_INP_PRIVBUILD, FileGetVersion($SFX_TO_LOAD, 'PrivateBuild'))
				GUICtrlSetState($RES_CHK_USE, $GUI_CHECKED)
				GUICtrlSetState($RES_CHK_INCLUDE, $GUI_CHECKED)
			EndIf
		Case $RES_Mi_LOAD_INI
			If $RegMode = 1 Then
				GUICtrlSetData($RES_INP_FILEVERS, RegRead($reg_Path & '\ResInfo', 'FileVersion'))
				GUICtrlSetData($RES_INP_COMPNAME, RegRead($reg_Path & '\ResInfo', 'CompanyName'))
				GUICtrlSetData($RES_INP_COMMENTS, RegRead($reg_Path & '\ResInfo', 'Comments'))
				GUICtrlSetData($RES_INP_FILEDESC, RegRead($reg_Path & '\ResInfo', 'FileDescription'))
				GUICtrlSetData($RES_INP_PRODUCTVERS, RegRead($reg_Path & '\ResInfo', 'ProductVersion'))
				GUICtrlSetData($RES_INP_PRODUCTNAME, RegRead($reg_Path & '\ResInfo', 'ProductName'))
				GUICtrlSetData($RES_INP_COPYRIGHT, RegRead($reg_Path & '\ResInfo', 'LegalCopyright'))
				GUICtrlSetData($RES_INP_TRADEMARK, RegRead($reg_Path & '\ResInfo', 'LegalTrademarks'))
				GUICtrlSetData($RES_INP_INTNAME, RegRead($reg_Path & '\ResInfo', 'InternalName'))
				GUICtrlSetData($RES_INP_ORIGNAME, RegRead($reg_Path & '\ResInfo', 'OriginalFilename'))
				GUICtrlSetData($RES_INP_SPECIALBUILD, RegRead($reg_Path & '\ResInfo', 'SpecialBuild'))
				GUICtrlSetData($RES_INP_PRIVBUILD, RegRead($reg_Path & '\ResInfo', 'PrivateBuild'))
			Else
				GUICtrlSetData($RES_INP_FILEVERS, IniRead($SetsINI, 'VersionInfo', 'FileVersion', ''))
				GUICtrlSetData($RES_INP_COMPNAME, IniRead($SetsINI, 'VersionInfo', 'CompanyName', ''))
				GUICtrlSetData($RES_INP_COMMENTS, IniRead($SetsINI, 'VersionInfo', 'Comments', ''))
				GUICtrlSetData($RES_INP_FILEDESC, IniRead($SetsINI, 'VersionInfo', 'FileDescription', ''))
				GUICtrlSetData($RES_INP_PRODUCTVERS, IniRead($SetsINI, 'VersionInfo', 'ProductVersion', ''))
				GUICtrlSetData($RES_INP_PRODUCTNAME, IniRead($SetsINI, 'VersionInfo', 'ProductName', ''))
				GUICtrlSetData($RES_INP_COPYRIGHT, IniRead($SetsINI, 'VersionInfo', 'LegalCopyright', ''))
				GUICtrlSetData($RES_INP_TRADEMARK, IniRead($SetsINI, 'VersionInfo', 'LegalTrademarks', ''))
				GUICtrlSetData($RES_INP_INTNAME, IniRead($SetsINI, 'VersionInfo', 'InternalName', ''))
				GUICtrlSetData($RES_INP_ORIGNAME, IniRead($SetsINI, 'VersionInfo', 'OriginalFilename', ''))
				GUICtrlSetData($RES_INP_SPECIALBUILD, IniRead($SetsINI, 'VersionInfo', 'SpecialBuild', ''))
				GUICtrlSetData($RES_INP_PRIVBUILD, IniRead($SetsINI, 'VersionInfo', 'PrivateBuild', ''))
			EndIf
			GUICtrlSetState($RES_CHK_USE, $GUI_CHECKED)
			GUICtrlSetState($RES_CHK_INCLUDE, $GUI_CHECKED)
		Case $RES_Mi_WRITE_INI
			If $RegMode = 1 Then
				RegWrite($reg_Path & '\ResInfo', 'FileVersion', 'REG_SZ', GUICtrlRead($RES_INP_FILEVERS))
				RegWrite($reg_Path & '\ResInfo', 'CompanyName', 'REG_SZ', GUICtrlRead($RES_INP_COMPNAME))
				RegWrite($reg_Path & '\ResInfo', 'Comments', 'REG_SZ', GUICtrlRead($RES_INP_COMMENTS))
				RegWrite($reg_Path & '\ResInfo', 'FileDescription', 'REG_SZ', GUICtrlRead($RES_INP_FILEDESC))
				RegWrite($reg_Path & '\ResInfo', 'ProductVersion', 'REG_SZ', GUICtrlRead($RES_INP_PRODUCTVERS))
				RegWrite($reg_Path & '\ResInfo', 'ProductName', 'REG_SZ', GUICtrlRead($RES_INP_PRODUCTNAME))
				RegWrite($reg_Path & '\ResInfo', 'LegalCopyright', 'REG_SZ', GUICtrlRead($RES_INP_COPYRIGHT))
				RegWrite($reg_Path & '\ResInfo', 'LegalTrademarks', 'REG_SZ', GUICtrlRead($RES_INP_TRADEMARK))
				RegWrite($reg_Path & '\ResInfo', 'InternalName', 'REG_SZ', GUICtrlRead($RES_INP_INTNAME))
				RegWrite($reg_Path & '\ResInfo', 'OriginalFilename', 'REG_SZ', GUICtrlRead($RES_INP_ORIGNAME))
				RegWrite($reg_Path & '\ResInfo', 'SpecialBuild', 'REG_SZ', GUICtrlRead($RES_INP_SPECIALBUILD))
				RegWrite($reg_Path & '\ResInfo', 'PrivateBuild', 'REG_SZ', GUICtrlRead($RES_INP_PRIVBUILD))
			Else
				IniWrite($SetsINI, 'VersionInfo', 'FileVersion', GUICtrlRead($RES_INP_FILEVERS))
				IniWrite($SetsINI, 'VersionInfo', 'CompanyName', GUICtrlRead($RES_INP_COMPNAME))
				IniWrite($SetsINI, 'VersionInfo', 'Comments', GUICtrlRead($RES_INP_COMMENTS))
				IniWrite($SetsINI, 'VersionInfo', 'FileDescription', GUICtrlRead($RES_INP_FILEDESC))
				IniWrite($SetsINI, 'VersionInfo', 'ProductVersion', GUICtrlRead($RES_INP_PRODUCTVERS))
				IniWrite($SetsINI, 'VersionInfo', 'ProductName', GUICtrlRead($RES_INP_PRODUCTNAME))
				IniWrite($SetsINI, 'VersionInfo', 'LegalCopyright', GUICtrlRead($RES_INP_COPYRIGHT))
				IniWrite($SetsINI, 'VersionInfo', 'LegalTrademarks', GUICtrlRead($RES_INP_TRADEMARK))
				IniWrite($SetsINI, 'VersionInfo', 'InternalName', GUICtrlRead($RES_INP_INTNAME))
				IniWrite($SetsINI, 'VersionInfo', 'OriginalFilename', GUICtrlRead($RES_INP_ORIGNAME))
				IniWrite($SetsINI, 'VersionInfo', 'SpecialBuild', GUICtrlRead($RES_INP_SPECIALBUILD))
				IniWrite($SetsINI, 'VersionInfo', 'PrivateBuild', GUICtrlRead($RES_INP_PRIVBUILD))
			EndIf
		Case $RES_BTN_CANCEL, $GUI_EVENT_CLOSE
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_SFX)
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_FILE)
			_GUICtrlODMenuItemDelete($RES_Mi_LOAD_INI)
			_GUICtrlODMenuItemDelete($RES_Mi_WRITE_INI)
			_Close_Window($GUI_RESEDIT, $GUI_MAIN)
	EndSwitch
EndFunc   ;==>_GUI_EditVersion_Events
Func _GUI_EditVersion_Font()
	GUICtrlSetFont($RES_BTN_LOAD, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($RES_BTN_SAVE, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($RES_BTN_CANCEL, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($RES_CHK_INCLUDE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_CHK_USE, $Font[1], '', '', $Font[0])
	For $c = 1 To 12
		GUICtrlSetFont($RES_LBL[$c], $Font[1], '', '', $Font[0])
	Next
	GUICtrlSetFont($RES_INP_FILEVERS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_COMPNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_COMMENTS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_FILEDESC, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_PRODUCTVERS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_PRODUCTNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_COPYRIGHT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_TRADEMARK, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_INTNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_ORIGNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_SPECIALBUILD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($RES_INP_PRIVBUILD, $Font[1], '', '', $Font[0])
EndFunc   ;==>_GUI_EditVersion_Font