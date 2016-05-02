
Global $a_ResNamesAndLangs[1][2] = [[0, 0]]
Global $INP_Res_Language = 1049
Global $IconResBase = 49
Global $_Enum


Func _EnumResourceNamesAndLangs($fname, $RType)
	; reset content of the Array
	Dim $a_ResNamesAndLangs[1][2] = [[0, 0]]
	; enumerate resource names and languages to a global array
	Local $aRESOURCE_TYPES[24] = ["RT_CURSOR", "RT_BITMAP", "RT_ICON", "RT_MENU", "RT_DIALOG", "RT_STRING", "RT_FONTDIR", "RT_FONT", "RT_ACCELERATOR", _
			"RT_RCDATA", "RT_MESSAGETABLE", "RT_GROUPCURSOR", "", "RT_GROUPICON", "", "RT_VERSION", "RT_DLGINCLUDE", "", "RT_PLUGPLAY", _
			"RT_VXD", "RT_ANICURSOR", "RT_ANIICON", "RT_HTML", "RT_MANIFEST"]
	; did we really get a number?
	If StringIsDigit($RType) Then $RType = Number($RType)
	; check for known resource types and convert to ordinal
	If IsString($RType) Then
		For $k = 0 To UBound($aRESOURCE_TYPES) - 1
			If $RType = $aRESOURCE_TYPES[$k] Then
				$RType = $k + 1
			EndIf
		Next
	EndIf

	Local $hModule = _WinAPI_LoadLibraryEx($fname, $LOAD_LIBRARY_AS_DATAFILE)
	If Not $hModule Then Return SetError(1, 0, 0)

	Local $a_ResNames, $a_ResLangs, $ResLang_Data

	; enumerate resource names
	$a_ResNames = _EnumResourceNames($hModule, $RType)
	If @error Then Exit
	; resize global array
	ReDim $a_ResNamesAndLangs[$a_ResNames[0] + 1][2]
	; assign resource names information to global array
	$a_ResNamesAndLangs[0][0] = $a_ResNames[0]
	For $i = 1 To $a_ResNames[0]
		$a_ResNamesAndLangs[$i][0] = $a_ResNames[$i]
	Next
	; enumerate and assign resource langs information to global array
	For $i = 1 To $a_ResNames[0]
		$a_ResLangs = _EnumResourceLanguages($hModule, $RType, $a_ResNames[$i])
		If @error Then ContinueLoop
		For $x = 1 To UBound($a_ResLangs) - 1
			$ResLang_Data &= $a_ResLangs[$x] & ','
		Next
		If StringRight($ResLang_Data, 1) = ',' Then $ResLang_Data = StringTrimRight($ResLang_Data, 1)
		$a_ResNamesAndLangs[$i][1] = $ResLang_Data
		$ResLang_Data = ''
	Next

	_WinAPI_FreeLibrary($hModule)

	Return 1
EndFunc   ;==>_EnumResourceNamesAndLangs

Func _EnumResourceNames($hModule, $sType)

	Local $Ret, $hEnumProc, $Library = 0, $TypeOfType = 'int'

	If IsString($hModule) Then
		If StringStripWS($hModule, 3) Then
			$hModule = _WinAPI_LoadLibraryEx($hModule, 0x00000003)
			If Not $hModule Then
				Return SetError(1, 0, 0)
			EndIf
			$Library = 1
		Else
			$hModule = 0
		EndIf
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf
	Dim $_Enum[101] = [0]
	$hEnumProc = DllCallbackRegister('_ResNameCallback', 'int', 'ptr;ptr;ptr;long_ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumResourceNamesW', 'ptr', $hModule, $TypeOfType, $sType, 'ptr', DllCallbackGetPtr($hEnumProc), 'long_ptr', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $_Enum[0]) Then
		$_Enum = 0
	EndIf
	If $Library Then
		_WinAPI_FreeLibrary($hModule)
	EndIf
	DllCallbackFree($hEnumProc)
	If Not IsArray($_Enum) Then
		Return SetError(1, 0, 0)
	EndIf
	_Inc($_Enum, -1)
	Return $_Enum
EndFunc   ;==>_EnumResourceNames

Func _EnumResourceLanguages($hModule, $sType, $sName)

	Local $Ret, $hEnumProc, $Library = 0, $TypeOfType = 'int', $TypeOfName = 'int'

	If IsString($hModule) Then
		If StringStripWS($hModule, 3) Then
			$hModule = _WinAPI_LoadLibraryEx($hModule, 0x00000003)
			If Not $hModule Then
				Return SetError(1, 0, 0)
			EndIf
			$Library = 1
		Else
			$hModule = 0
		EndIf
	EndIf
	If IsString($sType) Then
		$TypeOfType = 'wstr'
	EndIf
	If IsString($sName) Then
		$TypeOfName = 'wstr'
	EndIf
	Dim $_Enum[101] = [0]
	$hEnumProc = DllCallbackRegister('_ResLangCallback', 'int', 'ptr;ptr;ptr;ushort;long_ptr')
	$Ret = DllCall('kernel32.dll', 'int', 'EnumResourceLanguagesW', 'ptr', $hModule, $TypeOfType, $sType, $TypeOfName, $sName, 'ptr', DllCallbackGetPtr($hEnumProc), 'long_ptr', 0)
	If (@error) Or (Not $Ret[0]) Or (Not $_Enum[0]) Then
		$_Enum = 0
	EndIf
	If $Library Then
		_WinAPI_FreeLibrary($hModule)
	EndIf
	DllCallbackFree($hEnumProc)
	If Not IsArray($_Enum) Then
		Return SetError(1, 0, 0)
	EndIf
	_Inc($_Enum, -1)
	Return $_Enum
EndFunc   ;==>_EnumResourceLanguages

Func _ResNameCallback($hModule, $iType, $iName, $lParam)

	#forceref $hModule, $iType, $lParam

	Local $Length = _StrLen($iName)

	_Inc($_Enum)
	If $Length Then
		$_Enum[$_Enum[0]] = DllStructGetData(DllStructCreate('wchar[' & ($Length + 1) & ']', $iName), 1)
	Else
		$_Enum[$_Enum[0]] = Number($iName)
	EndIf
	Return 1
EndFunc   ;==>_ResNameCallback

Func _ResLangCallback($hModule, $iType, $iName, $iLanguage, $lParam)

	#forceref $hModule, $iType, $iName, $lParam

	_Inc($_Enum)
	$_Enum[$_Enum[0]] = $iLanguage
	Return 1
EndFunc   ;==>_ResLangCallback

Func _StrLen($pString, $fUnicode = 1)

	Local $W = ''

	If $fUnicode Then
		$W = 'W'
	EndIf

	Local $Ret = DllCall('kernel32.dll', 'int', 'lstrlen' & $W, 'ptr', $pString)

	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	Return $Ret[0]
EndFunc   ;==>_StrLen

Func _Inc(ByRef $aData, $iIncrement = 100)
	Select
		Case UBound($aData, 2)
			If $iIncrement < 0 Then
				ReDim $aData[$aData[0][0] + 1][UBound($aData, 2)]
			Else
				$aData[0][0] += 1
				If $aData[0][0] > UBound($aData) - 1 Then
					ReDim $aData[$aData[0][0] + $iIncrement][UBound($aData, 2)]
				EndIf
			EndIf
		Case UBound($aData, 1)
			If $iIncrement < 0 Then
				ReDim $aData[$aData[0] + 1]
			Else
				$aData[0] += 1
				If $aData[0] > UBound($aData) - 1 Then
					ReDim $aData[$aData[0] + $iIncrement]
				EndIf
			EndIf
		Case Else
			Return 0
	EndSelect
	Return 1
EndFunc   ;==>_Inc

Func _Res_Create_RTVersion_BuildStringTableEntry($Key, $value)
	Local $padding = 1 - Mod(6 + StringLen($Key) + 1, 2)
	Local $padding2 = 1 - Mod(6 + StringLen($Key) + 1 + $padding + StringLen($value) + 1, 2)
	Local $p_VS_String = DllStructCreate( _
			"short   wLength;" & _                                       ;Specifies the length, in bytes, of this String structure.
			"short   wValueLength;" & _                                  ;Specifies the size, in words, of the Value member.
			"short   wType;" & _                                         ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"wchar   szKey[" & StringLen($Key) + 1 + $padding & "];" & _ ;Specifies an arbitrary Unicode string. The szKey member can be one or more of the following values. These values are guidelines only.
			"wchar   Value[" & StringLen($value) + 1 + $padding2 & "]") ;Specifies a zero-terminated string. See the szKey member description for more information.
	DllStructSetData($p_VS_String, "Wlength", DllStructGetSize($p_VS_String) - $padding2 * 2)
	DllStructSetData($p_VS_String, "wValueLength", StringLen($value) + 1)
	DllStructSetData($p_VS_String, "wType", 1)
	DllStructSetData($p_VS_String, "szKey", $Key)
	DllStructSetData($p_VS_String, "Value", $value)
	Return StringMid(DllStructGetData(DllStructCreate("byte[" & DllStructGetSize($p_VS_String) & "]", DllStructGetPtr($p_VS_String)), 1), 3)
EndFunc   ;==>_Res_Create_RTVersion_BuildStringTableEntry
;
;
Func _Res_Create_RTVersion(ByRef $OutResPath)
	; construct the Stringtable Entries in a Binary string for easy concatenation
	Local $Res_StringTable_Children = "0x"
	If $ModeNOVERS Then
		If $vCompanyName <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("CompanyName", _ReplaceVariables($vCompanyName))
		If $vFileDescription <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("FileDescription", _ReplaceVariables($vFileDescription))
		If $vLegalCopyright <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("LegalCopyright", _ReplaceVariables($vLegalCopyright))
		If $vLegalTrademarks <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("LegalTrademarks", _ReplaceVariables($vLegalTrademarks))
		If $vInternalName <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("InternalName", _ReplaceVariables($vInternalName))
		If $vProductName <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("ProductName", _ReplaceVariables($vProductName))
		If $vOriginalFileName <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("OriginalFilename", _ReplaceVariables($vOriginalFileName))
		If $vFileVersion <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("FileVersion", _ReplaceVariables($vFileVersion))
		If $vProductVersion <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("ProductVersion", _ReplaceVariables($vProductVersion))
		If $vComments <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("Comments", _ReplaceVariables($vComments))
		If $vPrivateBuild <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("PrivateBuild", _ReplaceVariables($vPrivateBuild))
		If $vSpecialBuild <> '' Then $Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("SpecialBuild", _ReplaceVariables($vSpecialBuild))
	Else
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("CompanyName", _ReplaceVariables($vCompanyName))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("FileDescription", _ReplaceVariables($vFileDescription))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("LegalCopyright", _ReplaceVariables($vLegalCopyright))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("LegalTrademarks", _ReplaceVariables($vLegalTrademarks))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("InternalName", _ReplaceVariables($vInternalName))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("ProductName", _ReplaceVariables($vProductName))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("OriginalFilename", _ReplaceVariables($vOriginalFileName))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("FileVersion", _ReplaceVariables($vFileVersion))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("ProductVersion", _ReplaceVariables($vProductVersion))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("Comments", _ReplaceVariables($vComments))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("PrivateBuild", _ReplaceVariables($vPrivateBuild))
		$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry("SpecialBuild", _ReplaceVariables($vSpecialBuild))
	EndIf
;~ 	For $U = 1 To $INP_RES_FieldCount
;~ 		If $INP_FieldName[$U] <> "" And $INP_FieldValue[$U] <> "" Then
;~ 			$INP_FieldValue[$U] = Convert_Variables($INP_FieldValue[$U])
;~ 			$Res_StringTable_Children &= _Res_Create_RTVersion_BuildStringTableEntry($INP_FieldName[$U], $INP_FieldValue[$U])
;~ 		EndIf
;~ 	Next
	;
	; construct the Stringtable
	Local $p_VS_StringTable = DllStructCreate( _
			"short   wLength;" & _       ;Specifies the length, in bytes, of this StringTable structure, including all structures indicated by the Children member.
			"short   wValueLength;" & _  ;This member is always equal to zero.
			"short   wType;" & _         ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"byte    szKey[16];" & _     ;Specifies an 8-digit hexadecimal number stored as a Unicode string. The four most significant digits represent the language identifier. The four least significant digits represent the code page for which the data is formatted. Each Microsoft Standard Language identifier contains two parts: the low-order 10 bits specify the major language, and the high-order 6 bits specify the sublanguage. For a table of valid identifiers see .
			"byte    Padding[2];" & _    ;Contains as many zero words as necessary to align the Children member on a 32-bit boundary.
			"byte    Children[" & (StringLen($Res_StringTable_Children) - 2) / 2 & "]") ;Specifies an array of one or more String structures.
	DllStructSetData($p_VS_StringTable, "Wlength", DllStructGetSize($p_VS_StringTable))
	DllStructSetData($p_VS_StringTable, "wValueLength", 0)
	DllStructSetData($p_VS_StringTable, "wType", 1)
	DllStructSetData($p_VS_StringTable, "szKey", StringToBinary(Hex($INP_Res_Language, 4) & '04b0', 2))
	DllStructSetData($p_VS_StringTable, "Children", Binary($Res_StringTable_Children))
	;
	; construct the StringFileInfo
	Local $p_VS_StringFileInfo = DllStructCreate( _
			"short  wLength;" & _      ;Specifies the length, in bytes, of the entire StringFileInfo block, including all structures indicated by the Children member.
			"short  wValueLength;" & _ ;This member is always equal to zero.
			"short  wType;" & _        ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"WCHAR  szKey[15];" & _    ;Contains the Unicode string "StringFileInfo".
			"byte   Children[" & DllStructGetSize($p_VS_StringTable) & "]") ;Contains an array of one or mcore StringTable structures. Each StringTable structure's szKey member indicates the appropriate language and code page for displaying the text in that StringTable structure.
	DllStructSetData($p_VS_StringFileInfo, "Wlength", DllStructGetSize($p_VS_StringFileInfo))
	DllStructSetData($p_VS_StringFileInfo, "wValueLength", 0)
	DllStructSetData($p_VS_StringFileInfo, "wType", 1)
	DllStructSetData($p_VS_StringFileInfo, "szKey", "StringFileInfo")
	Local $p_VS_StringTable_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_StringTable) & "]", DllStructGetPtr($p_VS_StringTable))
	DllStructSetData($p_VS_StringFileInfo, "Children", DllStructGetData($p_VS_StringTable_Total, 1))
	;
	; construct the Var
	Local $p_VS_Var = DllStructCreate( _
			"short  wLength;" & _       ;Specifies the length, in bytes, of the Var structure.
			"short  wValueLength;" & _  ;Specifies the length, in bytes, of the Value member.
			"short  wType;" & _         ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"WCHAR  szKey[12];" & _     ;Contains the Unicode string "Translation".
			"char  Padding[1];" & _     ;Contains as many zero words as necessary to align the Value member on a 32-bit boundary.
			"short  lang;" & _          ;Specifies an array of one or more values that are language and code page identifier pairs. For additional information, see the following Remarks section.
			"short  lang2") ;Specifies an array of one or more values that are language and code page identifier pairs. For additional information, see the following Remarks section.
	DllStructSetData($p_VS_Var, "Wlength", DllStructGetSize($p_VS_Var))
	DllStructSetData($p_VS_Var, "wValueLength", 4)
	DllStructSetData($p_VS_Var, "wType", 0)
	DllStructSetData($p_VS_Var, "szKey", "Translation")
	DllStructSetData($p_VS_Var, "lang", $INP_Res_Language)
	DllStructSetData($p_VS_Var, "lang2", 0x04B0)
	;
	; construct the VarFileInfo
	Local $p_VS_VarFileInfo = DllStructCreate( _
			"short  wLength;" & _       ;Specifies the length, in bytes, of the entire VarFileInfo block, including all structures indicated by the Children member.
			"short  wValueLength;" & _  ;This member is always equal to zero.
			"short  wType;" & _         ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"WCHAR szKey[12];" & _      ;Contains the Unicode string "VarFileInfo".
			"char  Padding[2];" & _     ;Contains as many zero words as necessary to align the Value member on a 32-bit boundary.
			"Byte   Children[" & DllStructGetSize($p_VS_Var) & "]") ;Specifies a Var structure that typically contains a list of languages that the application or DLL supports.
	DllStructSetData($p_VS_VarFileInfo, "Wlength", DllStructGetSize($p_VS_VarFileInfo))
	DllStructSetData($p_VS_VarFileInfo, "wValueLength", 0)
	DllStructSetData($p_VS_VarFileInfo, "wType", 1)
	DllStructSetData($p_VS_VarFileInfo, "szKey", "VarFileInfo")
	Local $p_VS_Var_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_Var) & "]", DllStructGetPtr($p_VS_Var))
	DllStructSetData($p_VS_VarFileInfo, "Children", DllStructGetData($p_VS_Var_Total, 1))
	;
	; construct the FIXEDFILEINFO
	Local $p_VS_FIXEDFILEINFO = DllStructCreate( _
			"DWORD dwSignature;" & _
			"DWORD dwStrucVersion;" & _
			"DWORD dwFileVersionMS;" & _
			"DWORD dwFileVersionLS;" & _
			"DWORD dwProductVersionMS;" & _
			"DWORD dwProductVersionLS;" & _
			"DWORD dwFileFlagsMask;" & _
			"DWORD dwFileFlags;" & _
			"DWORD dwFileOS;" & _
			"DWORD dwFileType;" & _
			"DWORD dwFileSubtype;" & _
			"DWORD dwFileDateMS;" & _
			"DWORD dwFileDateLS")
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwSignature", 0xFEEF04BD)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwStrucVersion", 0x00010000)
	Local $INP_Fileversion = _Valid_FileVersion($vFileVersion)
	Local $tFileversion = StringSplit($INP_Fileversion, ".")
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileVersionMS", Number("0x" & Hex($tFileversion[1], 4) & Hex($tFileversion[2], 4)))
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileVersionLS", Number("0x" & Hex($tFileversion[3], 4) & Hex($tFileversion[4], 4)))
	Local $INP_ProductVersion = _Valid_FileVersion($vProductVersion)
	$tFileversion = StringSplit($INP_ProductVersion, ".")
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwProductVersionMS", Number("0x" & Hex($tFileversion[1], 4) & Hex($tFileversion[2], 4)))
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwProductVersionLS", Number("0x" & Hex($tFileversion[3], 4) & Hex($tFileversion[4], 4)))
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileFlagsMask", 0)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileFlags", 0)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileOS", 0x00004)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileType", 0)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileSubtype", 0)
	DllStructSetData($p_VS_FIXEDFILEINFO, "dwFileDateLS", 0)
	;
	; construct the Final VERSIONINFO
	Local $p_VS_VERSIONINFO = DllStructCreate( _
			"short  wLength;" & _       ;Specifies the length, in bytes, of the VS_VERSIONINFO structure. This length does not include any padding that aligns any subsequent version resource data on a 32-bit boundary.
			"short  wValueLength;" & _  ;Specifies the length, in bytes, of the Value member. This value is zero if there is no Value member associated with the current version structure.
			"short  wType;" & _         ;Specifies the type of data in the version resource. This member is 1 if the version resource contains text data and 0 if the version resource contains binary data.
			"wchar  szKey[16];" & _     ;Contains the Unicode string "VS_VERSION_INFO".
			"wchar  Padding1[1];" & _   ;Contains as many zero words as necessary to align the Value member on a 32-bit boundary.
			"byte   value[" & DllStructGetSize($p_VS_FIXEDFILEINFO) & "];" & _     ;Contains a VS_FIXEDFILEINFO structure that specifies arbitrary data associated with this VS_VERSIONINFO structure. The wValueLength member specifies the length of this member; if wValueLength is zero, this member does not exist.
			"byte   Children[" & DllStructGetSize($p_VS_StringFileInfo) & "];" & _ ;Specifies an array of zero or one StringFileInfo structures, and
			"byte   Children2[" & DllStructGetSize($p_VS_VarFileInfo) & "]") ;          zero or one VarFileInfo structures that are children of the current VS_VERSIONINFO structure.
	DllStructSetData($p_VS_VERSIONINFO, "Wlength", DllStructGetSize($p_VS_VERSIONINFO))
	DllStructSetData($p_VS_VERSIONINFO, "wValueLength", DllStructGetSize($p_VS_FIXEDFILEINFO))
	DllStructSetData($p_VS_VERSIONINFO, "wType", 0)
	DllStructSetData($p_VS_VERSIONINFO, "szKey", "VS_VERSION_INFO")
	; Add the VS_FIXEDFILEINFO structure
	Local $p_VS_FIXEDFILEINFO_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_FIXEDFILEINFO) & "]", DllStructGetPtr($p_VS_FIXEDFILEINFO))
	DllStructSetData($p_VS_VERSIONINFO, "value", DllStructGetData($p_VS_FIXEDFILEINFO_Total, 1))
	; Add the VS_StringFileInfo structure
	Local $p_VS_StringFileInfo_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_StringFileInfo) & "]", DllStructGetPtr($p_VS_StringFileInfo))
	DllStructSetData($p_VS_VERSIONINFO, "Children", DllStructGetData($p_VS_StringFileInfo_Total, 1))
	; Add the VarFileInfo structure
	Local $p_VS_VarFileInfo_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_VarFileInfo) & "]", DllStructGetPtr($p_VS_VarFileInfo))
	DllStructSetData($p_VS_VERSIONINFO, "Children2", DllStructGetData($p_VS_VarFileInfo_Total, 1))
	; Write the Whole structure to a RES file
	Local $p_VS_VERSIONINFO_Total = DllStructCreate("byte Children[" & DllStructGetSize($p_VS_VERSIONINFO) & "]", DllStructGetPtr($p_VS_VERSIONINFO))
	#forceref $OutResPath
	If $OutResPath = "" Then $OutResPath = @TempDir & "\temp.res"
	Local $Fh = FileOpen($OutResPath, 2 + 16)
	FileWrite($Fh, DllStructGetData($p_VS_VERSIONINFO_Total, 1))
	FileClose($Fh)
EndFunc   ;==>_Res_Create_RTVersion

Func _Valid_FileVersion($i_FileVersion)
	Local $T_Numbers = StringSplit($i_FileVersion, ".")
	If $T_Numbers[0] > 4 Then Return '1.0.0.0'
	If $T_Numbers[0] < 4 Then ReDim $T_Numbers[5]
	For $x = 1 To 4
		If $T_Numbers[$x] = '' Then $T_Numbers[$x] = 0
		If Not ($T_Numbers[$x] == Number($T_Numbers[$x])) Then
			$T_Numbers[$x] = Number($T_Numbers[$x])
		EndIf
	Next
;~ 	If $IsFileVersion Then
;~ 		; Auto Increment when requested
;~ 		If $INP_Fileversion_AutoIncrement <> "n" Then
;~ 			$INP_Fileversion_New = $T_Numbers[1] & "." & $T_Numbers[2] & "." & $T_Numbers[3] & "." & $T_Numbers[4] + 1
;~ 		EndIf
;~ 	EndIf
	Return $T_Numbers[1] & "." & $T_Numbers[2] & "." & $T_Numbers[3] & "." & $T_Numbers[4]
EndFunc   ;==>Valid_FileVersion

Func _Res_Update($rh, $InpResFile, $RType, $RName, $RLanguage = 1033)
	Local $result, $hFile, $tSize, $tBuffer, $pBuffer, $bread = 0
	Local $RType_Type, $RName_Type
	Local $aRESOURCE_TYPES[24] = ["RT_CURSOR", "RT_BITMAP", "RT_ICON", "RT_MENU", "RT_DIALOG", "RT_STRING", "RT_FONTDIR", "RT_FONT", "RT_ACCELERATOR", _
			"RT_RCDATA", "RT_MESSAGETABLE", "RT_GROUPCURSOR", "", "RT_GROUPICON", "", "RT_VERSION", "RT_DLGINCLUDE", "", "RT_PLUGPLAY", _
			"RT_VXD", "RT_ANICURSOR", "RT_ANIICON", "RT_HTML", "RT_MANIFEST"]
	; did we really get a number?
	If StringIsDigit($RType) Then $RType = Number($RType)
	If StringIsDigit($RName) Then $RName = Number($RName)
	; check for known resource types and convert to ordinal
	If IsString($RType) Then
		For $k = 0 To UBound($aRESOURCE_TYPES) - 1
			If $RType = $aRESOURCE_TYPES[$k] Then
				$RType = $k + 1
				$RType_Type = "long"
			EndIf
		Next
	EndIf
	; set parameter types
	If IsString($RType) Then
		$RType_Type = "wstr"
		$RType = StringUpper($RType)
	Else
		$RType_Type = "long"
	EndIf
	If IsString($RName) Then
		$RName_Type = "wstr"
		$RName = StringUpper($RName)
	Else
		$RName_Type = "long"
	EndIf
	;
	; Remove requested Section from the program resources.
	If $InpResFile = "" Then
		; No resource file defined thus delete the existing resource
		$result = DllCall("kernel32.dll", "int", "UpdateResourceW", "ptr", $rh, $RType_Type, $RType, $RName_Type, $RName, "ushort", $RLanguage, "ptr", 0, "dword", 0)
		Return SetError(0, 1, 0)
	EndIf
	; Make sure the input res file exists
	If Not FileExists($InpResFile) Then Return SetError(1, 0, 0)
	; Open the Resource File
	If ($RType <> 6) Then ; not for RT_STRING
		$hFile = _WinAPI_CreateFile($InpResFile, 2, 2)
		If Not $hFile Then Return SetError(1, 0, 0)
	EndIf
	;
	; Process the different Update types
	Switch $RType
		Case 3 ; *** RT_ICON
			;ICO section
			$tSize = FileGetSize($InpResFile)
			Local $tI_Input_Header = DllStructCreate("word res;word type;word ImageCount;byte rest[" & $tSize - 6 & "]") ; Create the buffer
			_WinAPI_ReadFile($hFile, DllStructGetPtr($tI_Input_Header), FileGetSize($InpResFile), $bread, 0)
			If $hFile Then _WinAPI_CloseHandle($hFile)
			; Read input file header
			Local $IconType = DllStructGetData($tI_Input_Header, "Type")
			Local $IconCount = DllStructGetData($tI_Input_Header, "ImageCount")
			; Created IconGroup Structure
			Local $tB_IconGroupHeader = DllStructCreate("align 2;word res;word type;word ImageCount;byte rest[" & $IconCount * 14 & "]") ; Create the buffer.
			Local $pB_IconGroupHeader = DllStructGetPtr($tB_IconGroupHeader)
			DllStructSetData($tB_IconGroupHeader, "Res", 0)
			DllStructSetData($tB_IconGroupHeader, "Type", $IconType)
			DllStructSetData($tB_IconGroupHeader, "ImageCount", $IconCount)
			; process all internal Icons
			For $x = 1 To $IconCount
				; Set pointer correct in the input struct
				Local $pB_Input_IconHeader = DllStructGetPtr($tI_Input_Header, "rest") + ($x - 1) * 16
				Local $tB_Input_IconHeader = DllStructCreate("byte Width;byte Height;byte Colors;byte res;word Planes;word BitsPerPixel;dword ImageSize;dword ImageOffset", $pB_Input_IconHeader) ; Create the buffer.
				; get info form the input
				Local $IconWidth = DllStructGetData($tB_Input_IconHeader, "Width")
;~ 				If $IconWidth = 0 then $IconWidth = 256
				Local $IconHeight = DllStructGetData($tB_Input_IconHeader, "Height")
;~ 				If $IconHeight = 0 then $IconHeight = 256
				Local $IconColors = DllStructGetData($tB_Input_IconHeader, "Colors")
				Local $IconPlanes = DllStructGetData($tB_Input_IconHeader, "Planes")
				Local $IconBitsPerPixel = DllStructGetData($tB_Input_IconHeader, "BitsPerPixel")
				Local $IconImageSize = DllStructGetData($tB_Input_IconHeader, "ImageSize")
				Local $IconImageOffset = DllStructGetData($tB_Input_IconHeader, "ImageOffset")
				; Update the ICO Group header struct
				$pB_IconGroupHeader = DllStructGetPtr($tB_IconGroupHeader, "rest") + ($x - 1) * 14
				Local $tB_GroupIcon = DllStructCreate("align 2;byte Width;byte Height;byte Colors;byte res;word Planes;word BitsPerPixel;dword ImageSize;word ResourceID", $pB_IconGroupHeader) ; Create the buffer.
				DllStructSetData($tB_GroupIcon, "Width", $IconWidth)
				DllStructSetData($tB_GroupIcon, "Height", $IconHeight)
				DllStructSetData($tB_GroupIcon, "Colors", $IconColors)
				DllStructSetData($tB_GroupIcon, "res", 0)
				DllStructSetData($tB_GroupIcon, "Planes", $IconPlanes)
				DllStructSetData($tB_GroupIcon, "BitsPerPixel", $IconBitsPerPixel)
				DllStructSetData($tB_GroupIcon, "ImageSize", $IconImageSize)
				$IconResBase += 1
				DllStructSetData($tB_GroupIcon, "ResourceID", $IconResBase)
				; Get data pointer
				Local $pB_IconData = DllStructGetPtr($tI_Input_Header) + $IconImageOffset
				; add Icon
				$result = DllCall("kernel32.dll", "int", "UpdateResourceW", "ptr", $rh, "long", 3, "long", $IconResBase, "ushort", $RLanguage, "ptr", $pB_IconData, "dword", $IconImageSize)
;~ 				MsgBox(0, '', $result[0])
			Next
			; Add Icongroup entry
			$pB_IconGroupHeader = DllStructGetPtr($tB_IconGroupHeader)
			$result = DllCall("kernel32.dll", "int", "UpdateResourceW", "ptr", $rh, "long", 14, $RName_Type, $RName, "ushort", $RLanguage, "ptr", $pB_IconGroupHeader, "dword", DllStructGetSize($tB_IconGroupHeader))
;~ 			MsgBox(0, '', $result[0])
		Case 16 ; RT_VERSION
			$tSize = FileGetSize($InpResFile)
			$tBuffer = DllStructCreate("byte Text[" & $tSize & "]") ; Create the buffer.
			$pBuffer = DllStructGetPtr($tBuffer)
			_WinAPI_ReadFile($hFile, $pBuffer, $tSize, $bread, 0)
			If $hFile Then _WinAPI_CloseHandle($hFile)
			If $bread > 0 Then
				$result = DllCall("kernel32.dll", "int", "UpdateResourceW", "ptr", $rh, $RType_Type, $RType, $RName_Type, $RName, "ushort", $RLanguage, "ptr", $pBuffer, "dword", $tSize)
;~ 				MsgBox(0, '', $result[0])
			EndIf
	EndSwitch
	;
EndFunc   ;==>_Res_Update

; *****************************************
;              EXTRACT ICON
; *****************************************

Func _ExtractIcon($sFile, $sIcon, $rName, $rLang)

	Local $sExtension
	Local $bBinaryToWrite
	Local $sFileType
	Local $sSuggestedName

	Local $aIconData = _CrackIcon($rName, $rLang, $sFile)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf

	Local $iIconCount = UBound($aIconData)

	Local $tIconHeader = DllStructCreate("ushort;" & _
			"ushort Type;" & _
			"ushort ImageCount")

	DllStructSetData($tIconHeader, "Type", 1)
	DllStructSetData($tIconHeader, "ImageCount", $iIconCount)

	Local $tBinaryIconHeader = DllStructCreate("byte[6]", DllStructGetPtr($tIconHeader))
	Local $bBinaryIconHeader = DllStructGetData($tBinaryIconHeader, 1)

	Local $aIconSizes[$iIconCount]
	Local $bBinaryBody
	Local $bBinaryChunk

	For $i = 0 To $iIconCount - 1
		$bBinaryChunk = _ResourceGetAsRaw(3, $aIconData[$i][6], $rLang, $sFile, 1) ;$RT_ICON
		$aIconSizes[$i] = BinaryLen($bBinaryChunk)
		$bBinaryBody = _BinaryConcat($bBinaryBody, $bBinaryChunk)
	Next

	Local $tDirectory = DllStructCreate("byte[" & 16 * $iIconCount & "]")

	Local $tDirectoryChunk
	Local $tBinaryDirectoryChunk
	Local $bBinaryDirectoryChunk
	Local $bBinaryDirectory
	Local $iOffset = 6 + 16 * $iIconCount

	For $i = 0 To $iIconCount - 1

		$tDirectoryChunk = DllStructCreate("ubyte Width;" & _
				"ubyte Height;" & _
				"ubyte Colors;" & _
				"ubyte;" & _
				"ushort Planes;" & _
				"ushort BitPerPixel;" & _
				"dword BitmapSize;" & _
				"dword Offset")

		DllStructSetData($tDirectoryChunk, "Width", $aIconData[$i][0])
		DllStructSetData($tDirectoryChunk, "Height", $aIconData[$i][1])
		DllStructSetData($tDirectoryChunk, "Colors", $aIconData[$i][2])
		DllStructSetData($tDirectoryChunk, "Planes", $aIconData[$i][3])
		DllStructSetData($tDirectoryChunk, "BitPerPixel", $aIconData[$i][4])
		DllStructSetData($tDirectoryChunk, "BitmapSize", $aIconData[$i][5])
		DllStructSetData($tDirectoryChunk, "Offset", $iOffset)
		$iOffset += $aIconSizes[$i]

		$tBinaryDirectoryChunk = DllStructCreate("byte[16]", DllStructGetPtr($tDirectoryChunk))
		$bBinaryDirectoryChunk = DllStructGetData($tBinaryDirectoryChunk, 1)

		$bBinaryDirectory = _BinaryConcat($bBinaryDirectory, $bBinaryDirectoryChunk)

	Next

	$bBinaryToWrite = _BinaryConcat($bBinaryIconHeader, $bBinaryDirectory)
	$bBinaryToWrite = _BinaryConcat($bBinaryToWrite, $bBinaryBody)

	Local $hSaveFile = FileOpen($sIcon, 26)
	If @error Or $hSaveFile = -1 Then
		Return SetError(2, 0, 0)
	EndIf
	FileWrite($hSaveFile, $bBinaryToWrite)
	FileClose($hSaveFile)

	Return SetError(0, 0, 1)

EndFunc   ;==>_ExtractIcon

Func _CrackIcon($iIconName, $iResLang, $sModule)

	Local $bBinary = _ResourceGetAsRaw(14, $iIconName, $iResLang, $sModule, 1) ;$RT_GROUP_ICON

	If @error Then
		Return SetError(@error + 3, 0, "")
	EndIf

	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tBinary, 1, $bBinary)

	Local $tResource = DllStructCreate("ushort;" & _
			"ushort Type;" & _
			"ushort ImageCount;" & _
			"byte Body[" & DllStructGetSize($tBinary) - 6 & "]", _
			DllStructGetPtr($tBinary))

	Local $iIconCount = DllStructGetData($tResource, "ImageCount")

	If Not $iIconCount Or $iIconCount > 50 Then ; this likely indicates usage of exe compressor
		Return SetError(0, 1, "")
	EndIf

	Local $iWidth, $iHeight
	Local $aIconsData[$iIconCount][7]
	Local $tGroupIconData

	For $i = 0 To $iIconCount - 1
		$tGroupIconData = DllStructCreate("ubyte Width;" & _
				"ubyte Height;" & _
				"ubyte Colors;" & _
				"ubyte;" & _
				"ushort Planes;" & _
				"ushort BitPerPixel;" & _
				"dword BitmapSize;" & _
				"ushort OrdinalName;", _
				DllStructGetPtr($tResource, "Body") + $i * 14)

		$iWidth = DllStructGetData($tGroupIconData, "Width")
		If Not $iWidth Then
			$iWidth = 256
		EndIf

		$iHeight = DllStructGetData($tGroupIconData, "Height")
		If Not $iHeight Then
			$iHeight = 256
		EndIf

		$aIconsData[$i][0] = $iWidth
		$aIconsData[$i][1] = $iHeight
		$aIconsData[$i][2] = DllStructGetData($tGroupIconData, "Colors")
		$aIconsData[$i][3] = DllStructGetData($tGroupIconData, "Planes")
		$aIconsData[$i][4] = DllStructGetData($tGroupIconData, "BitPerPixel")
		$aIconsData[$i][5] = DllStructGetData($tGroupIconData, "BitmapSize")
		$aIconsData[$i][6] = DllStructGetData($tGroupIconData, "OrdinalName")
	Next

	Return SetError(0, 0, $aIconsData)

EndFunc   ;==>_CrackIcon

Func _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, $iMode = 0, $iSize = 0)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Switch IsNumber($iResType) + 2 * IsNumber($iResName)
		Case 0
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"wstr", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang)
		Case 1
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"int", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang)
		Case 2
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"wstr", $iResType, _
					"int", $iResName, _
					"int", $iResLang)
		Case 3
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"int", $iResType, _
					"int", $iResName, _
					"int", $iResLang)
	EndSwitch

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	Local $hResource = $a_hCall[0]

	Local $a_iCall = DllCall("kernel32.dll", "int", "SizeofResource", "hwnd", $hModule, "hwnd", $hResource)

	If @error Or Not $a_iCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(4, 0, "")
	EndIf

	Local $iSizeOfResource = $a_iCall[0]

	$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadResource", "hwnd", $hModule, "hwnd", $hResource)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(5, 0, "")
	EndIf

	Local $a_pCall = DllCall("kernel32.dll", "ptr", "LockResource", "hwnd", $a_hCall[0])

	If @error Or Not $a_pCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(6, 0, "")
	EndIf

	Local $tOut
	Switch $iMode
		Case 0
			$tOut = DllStructCreate("char[" & $iSizeOfResource + 1 & "]", $a_pCall[0])
		Case 1
			$tOut = DllStructCreate("byte[" & $iSizeOfResource & "]", $a_pCall[0])
	EndSwitch

	Local $sReturnData = DllStructGetData($tOut, 1)

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(7, 0, "")
		EndIf
	EndIf

	Switch $iSize
		Case 0
			Return SetError(0, 0, $sReturnData)
		Case Else
			Switch $iMode
				Case 0
					Return SetError(0, 0, StringLeft($sReturnData, $iSize))
				Case 1
					Return SetError(0, 0, BinaryMid($sReturnData, 1, $iSize))
			EndSwitch
	EndSwitch

EndFunc   ;==>_ResourceGetAsRaw

Func _BinaryConcat($bBinary1, $bBinary2)

	If Not IsBinary($bBinary1) Then
		Return $bBinary2
	EndIf

	Local $tInitial = DllStructCreate("byte[" & BinaryLen($bBinary1) & "];byte[" & BinaryLen($bBinary2) & "]")
	DllStructSetData($tInitial, 1, $bBinary1)
	DllStructSetData($tInitial, 2, $bBinary2)

	Local $tOutput = DllStructCreate("byte[" & DllStructGetSize($tInitial) & "]", DllStructGetPtr($tInitial))

	Return SetError(0, 0, DllStructGetData($tOutput, 1))

EndFunc   ;==>_BinaryConcat