#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon\icon.ico
#AutoIt3Wrapper_Outfile=7z SFX Builder.exe
#AutoIt3Wrapper_Outfile_x64=7z SFX Builder-x64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=A tool to create SFX files based on 7-Zip archives.
#AutoIt3Wrapper_Res_Description=7z SFX Builder 2.1.0.0
#AutoIt3Wrapper_Res_Fileversion=2.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2012-2016 Mirza Brunjadze
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#AutoIt3Wrapper_Res_Field=CompanyName|brunjadze.xyz
#AutoIt3Wrapper_Res_Field=Email|brunjadzem@gmail.com
#AutoIt3Wrapper_Res_Field=ProductName|7z SFX Builder
#AutoIt3Wrapper_Res_Field=ProductVersion|Version 2.1
#AutoIt3Wrapper_Res_Field=OriginalFilename|7z SFX Builder.exe
#AutoIt3Wrapper_Res_Field=AutoIt Comments|Compiled with AutoIt v%AutoItVer% http://www.autoitscript.com/
#AutoIt3Wrapper_Res_Field=Compile Date|%date% %time%
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Open.ico,RT_ICON,100
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Save.ico,RT_ICON,101
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\SaveAs.ico,RT_ICON,102
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Close.ico,RT_ICON,103
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Test.ico,RT_ICON,104
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Preset.ico,RT_ICON,105
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\BuildSFX.ico,RT_ICON,106
#AutoIt3Wrapper_Res_File_Add=.\Icon\ToolBar\Options.ico,RT_ICON,107
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Reload.ico,RT_ICON,150
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Clear.ico,RT_ICON,151
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Exit.ico,RT_ICON,152
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Lang.ico,RT_ICON,153
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Help.ico,RT_ICON,154
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\HomePage.ico,RT_ICON,155
#AutoIt3Wrapper_Res_File_Add=.\Icon\Menu\Web.ico,RT_ICON,156
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Info.ico,RT_ICON,200
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Set.ico,RT_ICON,201
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Insert.ico,RT_ICON,202
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Browse.ico,RT_ICON,203
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\OpenFolder.ico,RT_ICON,204
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\AddFile.ico,RT_ICON,205
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\AddFolder.ico,RT_ICON,206
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Add.ico,RT_ICON,207
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Edit.ico,RT_ICON,208
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Delete.ico,RT_ICON,209
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\DeleteAll.ico,RT_ICON,210
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\MoveUp.ico,RT_ICON,211
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\MoveDown.ico,RT_ICON,212
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Run.ico,RT_ICON,213
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Reset.ico,RT_ICON,214
#AutoIt3Wrapper_Res_File_Add=.\Icon\Button\Success.ico,RT_ICON,215
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Before=del /q "%out%"
#AutoIt3Wrapper_Run_Before=del /q "%outx64%"
#AutoIt3Wrapper_Run_After=del /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
If Not @Compiled Then Global $LaunchTimer = TimerInit()

#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
#include <File.au3>
#include <GuiListView.au3>
#include <GUIComboBox.au3>
#include <String.au3>
#include <GuiTab.au3>
#include <GuiToolbar.au3>
#include <Constants.au3>
#include <GuiToolTip.au3>
#include <GuiTreeView.au3>
#include <GuiButton.au3>
#include <GuiEdit.au3>
;~ #include <WinAPI.au3>
;~ #include <APIConstants.au3>
#include <GuiMenu.au3>
;~ #include <Misc.au3>
;~ #include <GuiComboBoxEx.au3>
#include <GuiImageList.au3>
#include ".\Include\ModernMenuRaw.au3"
;~ #include <Array.au3>
;~ #include <ComboConstants.au3>
;~ #include <StaticConstants.au3>

#Region Start --- Declare Variables
Global $OSArch = @AutoItX64
Global $TempFOLDER = _Path_GetTempName(@TempDir & '\7zSFXBuilder_')
Global Const $TempSFXFLDR = $TempFOLDER & '\sfx_files'
Global Const $TempTESTFLDR = $TempFOLDER & '\test_files'
Global Const $TempINI = $TempFOLDER & '\test.ini'
Global $TempRESFILE = $TempFOLDER & '\version.res'
Global $TestCONFIG = ''
Global Const $TestSFXMOD = $TempTESTFLDR & '\test.sfx'
_Create_TempDir()
Global Const $3rdP_Dir = @ScriptDir & '\3rdParty'
Global Const $Mods_Dir = $3rdP_Dir & '\Modules'
Global Const $tMod_Path = $3rdP_Dir & '\TEST.SFX'
Global Const $UPX_Dir = $3rdP_Dir & '\UPX\upx.exe'
Global Const $Split_Dir = $3rdP_Dir & '\SFXSPLIT.EXE'
Global Const $SetsINI = @ScriptDir & '\Settings.ini'
Global Const $reg_Path = 'HKEY_CURRENT_USER\Software\7z SFX Builder'
Global Const $reg_7zPath = 'HKEY_CURRENT_USER\Software\7z SFX Builder\7-Zip'
Global Const $reg_mruPath = 'HKEY_CURRENT_USER\Software\7z SFX Builder\MRU'
Global Const $reg_profPath = 'HKEY_CURRENT_USER\Software\7z SFX Builder\Profiles'
If IniRead($SetsINI, 'Mode', 'RegMode', '') = '0' Then
	$RegMode = 0
Else
	$RegMode = 1
EndIf
Global $WinPos[2]
If $RegMode = 1 Then
	$WinPos[0] = RegRead($reg_Path, 'XPos')
	$WinPos[1] = RegRead($reg_Path, 'YPos')
Else
	$WinPos[0] = IniRead($SetsINI, 'Main', 'XPos', '')
	$WinPos[1] = IniRead($SetsINI, 'Main', 'YPos', '')
EndIf
;~ correct values to avoid hidden windows
If Not StringIsDigit($WinPos[0]) Or $WinPos[0] > @DesktopWidth - 50 Then $WinPos[0] = -1
If Not StringIsDigit($WinPos[1]) Or $WinPos[1] > @DesktopHeight - 50 Then $WinPos[1] = -1
;-------------------------
Global $ModeEXE[2] = [False, ''], $ModeINCLUDERES = False, $ModeRESCHANGE = 0, $ModeAUTOMOD = 0, $ModeNOVERS = 0, $ModeAUTOSFX = 0, $ModeOWSFX = 0, $ModeEXTCFG = 0
If $RegMode = 1 Then
	If RegRead($reg_Path, 'AutoSelectModule') = 1 Then $ModeAUTOMOD = 1
	If RegRead($reg_Path, 'IgnoreEmptyVersData') = 1 Then $ModeNOVERS = 1
	If RegRead($reg_Path, 'AutoDetermineSFXPath') = 1 Then $ModeAUTOSFX = 1
	If RegRead($reg_Path, 'OverwriteSFX') = 1 Then $ModeOWSFX = 1
Else
	If IniRead($SetsINI, 'Main', 'AutoSelectModule', '') = 1 Then $ModeAUTOMOD = 1
	If IniRead($SetsINI, 'Main', 'IgnoreEmptyVersData', '') = 1 Then $ModeNOVERS = 1
	If IniRead($SetsINI, 'Main', 'OverwriteSFX', '') = 1 Then $ModeOWSFX = 1
	If IniRead($SetsINI, 'Main', 'AutoDetermineSFXPath', '') = 1 Then $ModeAUTOSFX = 1
EndIf
Global $rh
Global $GuiMode, $OverWriteMode, $NumGF, $NumMF, $msg
Global $CurFile, $SaveFILE
Global $sFileRead, $Str_Split
Global $cPos, $iMsgBoxAnswer, $ParamShc
Global $LineCOUNT, $last_saved
Global $MSG_GLOBAL, $cMod_Path
Global $pData[1000][10], $pDataInt[1000][10], $pInd
Global $CurLang[2], $LngCount = 0, $nL, $_LngText[2] = ['', ''], $_LngList
Global $FilesToArc[1000], $MRUData[6]
If $RegMode = 1 Then
	$CurLang[0] = RegRead($reg_Path, 'Lang')
Else
	$CurLang[0] = IniRead($SetsINI, 'Main', 'Lang', '')
EndIf

Global $Font[4] = [ _
		'Segoe UI', _	; this is Global font type
		8.5, _			; This is Global font size
		9] ; This is a font size for Buttons 'Save' | 'Cancel' | 'OK'
Global $UseFONT = True ; this boolean value determines whether the font is used or not
Global $BuiltCONFIG[2] = ['', ''] ;0 - handles only config; 1 - handles config with extralines
;~ MAIN GUI
Global $GUI_MAIN
Global $TAB_MAIN
Global $INP_CUR_FILE
Global $BTN_CFG_RELOAD
Global $BTN_CFG_OPEN
Global $hToolbar
Global $aStrings[8]
Global $hToolTip
Global $Dummy_Test
Global $c_Menu_Test
Global $Dummy_Preset
Global $c_Menu_Preset
Global $h_Menu_Preset
Global $TBi_BP
Global $TBi_EPT
Global $TBi_EDT
Global $TBi_CP
Global $TBi_FM
Global $TBi_HT
Global $TBi_WARN
Global $TBi_ERROR
Global $TBi_PASSWD
Global Enum $id_Open = 1000, $id_Save, $id_SaveAs, $id_Close, $id_Test, $id_Preset, $id_MakeSFX, $id_Opts
Global $iItem
Global $Menu_FILE
Global $Mi_OPEN
Global $Mi_RELOAD
Global $Mi_SAVE
Global $Mi_SAVEAS
Global $Mi_CLOSE
Global $Mi_PRESET_MAN
Global $Mi_PRESET_MAN2
Global $Mi_PRESET[1000] = [0]
Global $sMenu_TEST
Global $Mi_BP
Global $Mi_XPT
Global $Mi_XD
Global $Mi_CP
Global $Mi_FM
Global $Mi_HT
Global $sMenu_RECENT_FILES
Global $Mi_CLEAR
Global $Mi_RecFile[6]
Global $Mi_EXIT
Global $Menu_HELP
Global $Mi_PSITE
Global $Mi_HELPEN
Global $Mi_HELPRU
Global $sMenu_THIRD
Global $Mi_SFXMod
Global $Mi_SFXSplit
Global $Mi_UPX
Global $Mi_ABOUT
Global $Menu_SETS
Global $Mi_OPTS
Global $sMenu_LANG
Global $Mi_LANG[250]
Global $LangName[250]
Global $M_GFP_DATA
;~ TABITEM MAIN
Global $Ti_MAIN
Global $M_BTN_INSTPATH
Global $M_BTN_GUIFLAGS
Global $M_INP_GUIFLAGS
Global $M_INP_INSTPATH
Global $M_INP_MISCFLAGS
Global $M_INP_BPT
Global $M_INP_XDWidth
Global $M_INP_XPWidth
Global $M_INP_VOLNAME
Global $M_CHK_TEMPMODE
Global $M_CHK_SKIPLOCKED
Global $M_CHK_SELFDELETE
Global $M_CHK_BPT
Global $M_CHK_XDWidth
Global $M_CHK_XPWidth
Global $M_CHK_VOLNAME
Global $M_RAD_OMode[4]
Global $M_RAD_GMode[4]
Global $M_UD_BPT
Global $M_UD_XDWidth
Global $M_UD_XPWidth
Global $M_UD_VOLNAME
Global $Dummy_InstPath
Global $c_Menu_InstPath
Global $Mi_IP[14]
Global $M_GRP_OW_MODE
Global $M_GRP_GUI_MODE
Global $M_LBL_GF
Global $M_LBL_EXT_PATH
;~ TABITEM TITLE/TEXT
Global $Ti_TITLETEXT
Global $T_INP_ERRORTITLE
Global $T_INP_WARNTITLE
Global $T_INP_WINTITLE
Global $T_INP_XCANCELTEXT
Global $T_INP_XPATHWINTITLE
Global $T_INP_XTITLE
Global $T_INP_PASSWDTEXT
Global $T_INP_PASSWDTITLE
Global $T_GRP_TITLE
Global $T_GRP_TEXT
Global $T_LBL_TITLE
Global $T_LBL_EXT_PATH_TITLE
Global $T_LBL_EXT_TITLE
Global $T_LBL_ERR_TITLE
Global $T_LBL_WARN_TITLE
Global $T_LBL_PSWD_TITLE
Global $T_LBL_PSWD_TEXT
Global $T_LBL_CANCEL_TEXT
;~ TABITEM DIALOGS
Global $Ti_MESSAGES
Global $MS_BTN_BEGINPROMPT
Global $MS_BTN_XPATHTEXT
Global $MS_BTN_XDIALOGTEXT
Global $MS_BTN_FINISHMSG
Global $MS_BTN_CANCELPROMPT
Global $MS_BTN_HELPTEXT
Global $MS_BTN_TEST
Global $MS_EDT_MESSAGES[7]
Global $MS_VALUES[7] = ['', '', '', '', '', '', ''] ;1 - BeginPrompt; 2 - ExtractPathText; 3 - ExtractDialogText; 4 - CancelPrompt; 5 - FinishMessage; 6 - HelpText
;~ TABITEM RUNPROGRAM
Global $Ti_RUNPROGRAM
Global $Run_ListToEdit[2]
Global $Run_StringSplit
Global $R_LIST
Global $R_BTN_ADD
Global $R_BTN_EDIT
Global $R_BTN_DELETE
Global $R_BTN_DELETEALL
Global $R_BTN_MOVEUP
Global $R_BTN_MOVEDOWN
;~ TABITEM DELETE
Global $Ti_DELETE
Global $Del_ListToEdit[2]
Global $Del_StringSplit
Global $D_LIST
Global $D_BTN_ADD
Global $D_BTN_EDIT
Global $D_BTN_DELETE
Global $D_BTN_DELETEALL
Global $D_BTN_MOVEUP
Global $D_BTN_MOVEDOWN
;~ TABITEM SHORTCUTS
Global $Ti_SHORTCUTS
Global $Shc_ListToEdit[2]
Global $Shc_StringSplit
Global $SH_LIST
Global $SH_BTN_ADD
Global $SH_BTN_EDIT
Global $SH_BTN_DELETE
Global $SH_BTN_DELETEALL
Global $SH_BTN_MOVEUP
Global $SH_BTN_MOVEDOWN
;~ TABITEM SETENVIRONMENT
Global $Ti_SETENVIRONMENT
Global $Var_ListToEdit[2]
Global $Var_StringSplit
Global $E_LIST
Global $E_BTN_ADD
Global $E_BTN_EDIT
Global $E_BTN_DELETE
Global $E_BTN_DELETEALL
Global $E_BTN_MOVEUP
Global $E_BTN_MOVEDOWN
;~ TABITEM OUTPUT
Global $Ti_OUTPUT
Global $O_EDIT
;~ TABITEM SFX
Global $Ti_SFX, $S_ICO_SFX
Global $S_BTN_MAKESFX
Global $S_BTN_ARCINFO
Global $S_BTN_SFXINFO
Global $S_BTN_RUNSFX
;~ Global $S_BTN_ICNINFO
Global $S_SEL_CONFIG, $Dlg_CONFIG
Global $S_SEL_ARCHIVE, $Dlg_ARCHIVE
Global $S_SEL_SFXMOD, $Dlg_SFXMOD
Global $S_SEL_SFXPATH, $Dlg_SFXPATH
Global $S_SEL_SFXICON, $Dlg_SFXICON
Global $S_BTN_CONFIG
Global $S_BTN_ARCHIVE
Global $S_BTN_SFXMOD
Global $S_BTN_SFXPATH
Global $S_BTN_SFXICON
Global $S_BTN_SFX_OPTS
Global $S_BTN_RESEDIT
Global $S_CHK_EXTCFG
Global $S_CHK_ARCHIVE
Global $S_CHK_SFXMOD
Global $S_CHK_SFXPATH
Global $S_CHK_SFXICON
Global $S_INP_CONFIG
Global $S_INP_ARCHIVE
Global $S_INP_SFXMOD
Global $S_INP_SFXPATH
Global $S_INP_SFXICON
Global $S_GRP_SFX_FILES
Global $S_LBL_CONFIG
Global $S_LBL_ARCHIVE
Global $S_LBL_SFXMOD
Global $S_LBL_SFXPATH
Global $S_LBL_SFXICON
;~ GUI RUNPROGRAM
Global $GUI_RUN
Global $RUN_BTN_ADD
Global $RUN_BTN_SAVE
Global $RUN_BTN_CANCEL
Global $RUN_CHK_ADD_QUOTES
Global $RUN_COMBO_PARAM
Global $RUN_COMBO_PARAM_X
Global $RUN_INP_FILE
Global $RUN_INP_PREFIX
Global $RUN_EDT_CMDS
Global $RUN_LBL[4]
;~ GUI PREFIX
Global $GUI_PREFIX
Global $PFX_BTN_SAVE
Global $PFX_BTN_CANCEL
Global $PFX_CHK_DEL
Global $PFX_CHK_FM
Global $PFX_CHK_SHC
Global $PFX_CHK_HIDCON
Global $PFX_CHK_NOWAIT
Global $PFX_CHK_FNOWAIT
Global $PFX_CHK_WAITALL
Global $PFX_CHK_X64
Global $PFX_CHK_X86
Global $PFX_COMBO_DEL
Global $PFX_COMBO_FM
Global $PFX_COMBO_SHC
;~ GUI DELETE
Global $GUI_DELETE
Global $DEL_BTN_SAVE
Global $DEL_BTN_CANCEL
Global $DEL_CHK_ADD_QUOTES
Global $DEL_COMBO_PARAM
Global $DEL_COMBO_PARAM_X
Global $DEL_INP_FILE
Global $DEL_LBL[2]
;~ GUI SHORTCUTS
Global $GUI_SHC
Global $SHC_BTN_SAVE
Global $SHC_BTN_CANCEL
Global $SHC_RADIO_DESKTOP
Global $SHC_RADIO_STARTMENU
Global $SHC_RADIO_PROGRAMS
Global $SHC_RADIO_STARTUP
Global $SHC_RADIO_USER
Global $SHC_RADIO_ALL_USERS
Global $SHC_COMBO_PARAM
Global $SHC_COMBO_PARAM_X
Global $SHC_INP_FILE
Global $SHC_INP_CMDS
Global $SHC_INP_NAME
Global $SHC_INP_DESCRIPTION
Global $SHC_INP_DEST_FLDR
Global $SHC_INP_WRK_DIR
Global $SHC_INP_ICON
Global $SHC_INP_ICON_INDEX
Global $SHC_TYPE, $SHC_USER
Global $SHC_GRP[3]
Global $SHC_LBL[8]
;~ GUI SETENVIRONMENT
Global $GUI_ENV
Global $ENV_BTN_SAVE
Global $ENV_BTN_CANCEL
Global $ENV_INP_NAME
Global $ENV_INP_VALUE
Global $ENV_LBL[2]
;~ GUI PRESET MANAGER
Global $GUI_PRESET
Global $PRE_BTN_SAVE
Global $PRE_BTN_CANCEL
Global $PRE_BTN_NEW
Global $PRE_BTN_LOAD
Global $PRE_BTN_EDITN
Global $PRE_BTN_PSAVE
Global $PRE_BTN_DEL
Global $PRE_CMB
Global $PRE_TRV
Global $PRE_TRVi_TT
Global $PRE_TRVi_MSG
Global $PRE_TRVi_TITLE
Global $PRE_TRVi_TXPT
Global $PRE_TRVi_XT
Global $PRE_TRVi_XCT
Global $PRE_TRVi_BP
Global $PRE_TRVi_XPT
Global $PRE_TRVi_XDT
Global $PRE_TRVi_CP
Global $PRE_TRVi_FM
Global $PRE_INP_TIT
Global $PRE_INP_XPT
Global $PRE_INP_XT
Global $PRE_INP_XCT
Global $PRE_LBL_TIT
Global $PRE_LBL_XPT
Global $PRE_LBL_XT
Global $PRE_LBL_XCT
Global $PRE_LBL_PNAME
Global $PRE_EDT_BP
Global $PRE_EDT_XPT
Global $PRE_EDT_XDT
Global $PRE_EDT_CP
Global $PRE_EDT_FM
;~ GUI GUIFLAGS
Global $GUI_GUIFLAGS
Global $GFL_BTN_NEW
Global $GFL_BTN_LOAD
Global $GFL_BTN_RESET
Global $GFL_BTN_DEL
Global $GFL_BTN_SAVE
Global $GFL_BTN_CANCEL
Global $GFL_CMB_GFP
Global $GFL_CHK[20]
Global $GFL_GRP_PROF
;~ GUI PROGRAM OPTIONS
Global $GUI_OPTS
Global $OPT_BTN_OK
Global $OPT_BTN_CANCEL
Global $OPT_BTN_INT
Global $OPT_BTN_LNG
Global $OPT_BTN_EXPORT
Global $Dummy_Export
Global $cMenu_Export
Global $OPT_Mi_EXPREG
Global $OPT_Mi_EXPINI
Global $OPT_CMB_LNG
Global $OPT_CHK_REGMODE
Global $OPT_CHK_AUTOMOD
Global $OPT_CHK_PMPT
Global $OPT_CHK_VERS
Global $OPT_CHK_CSFX
Global $OPT_CHK_OW_SFX
Global $OPT_GRP_PROG
Global $OPT_GRP_SFX
Global $OPT_LBL_LNG
;~ GUI EDIT GFP
Global $GUI_EDIT_GFP
Global $GFP_BTN_SAVE
Global $GFP_BTN_CANCEL
;~ GUI RESEDIT
Global $GUI_RESEDIT
Global $RES_BTN_LOAD
Global $RES_BTN_SAVE
Global $RES_BTN_CANCEL
Global $RES_BTN_COPYRIGHT
Global $Dummy_LoadRes
Global $cMenu_LoadRes
Global $RES_Mi_LOAD_FILE
Global $RES_Mi_LOAD_SFX
Global $RES_Mi_LOAD_INI
Global $RES_Mi_WRITE_INI
Global $RES_CHK_INCLUDE
Global $RES_CHK_USE
Global $RES_INP_FILE
Global $RES_INP_FILEVERS
Global $RES_INP_COMPNAME
Global $RES_INP_COMMENTS
Global $RES_INP_FILEDESC
Global $RES_INP_PRODUCTVERS
Global $RES_INP_PRODUCTNAME
Global $RES_INP_COPYRIGHT
Global $RES_INP_TRADEMARK
Global $RES_INP_INTNAME
Global $RES_INP_ORIGNAME
Global $RES_INP_SPECIALBUILD
Global $RES_INP_PRIVBUILD
Global $RES_LBL[13]
Global $vFileVersion = ''
Global $vCompanyName = ''
Global $vComments = ''
Global $vFileDescription = ''
Global $vProductVersion = ''
Global $vProductName
Global $vLegalCopyright = ''
Global $vLegalTrademarks = ''
Global $vInternalName = ''
Global $vOriginalFileName = ''
Global $vSpecialBuild = ''
Global $vPrivateBuild = ''
;~ GUI SFXOPTIONS
Global $GUI_SFXOPTS
Global $SFXOPTS_BTN_SAVE
Global $SFXOPTS_BTN_CANCEL
Global $SFXOPTS_BTN_SFXINFO
Global $SFXOPTS_CHK_USE_UPX
Global $SFXOPTS_CHK_USE_DEF
Global $SFXOPTS_CMB_UPX
Global $SFXOPTS_CMB_DEF_SFX
Global $SFXOPTS_CMB_7ZIP
Global $SFXOPTS_SEL_7ZIP
Global $SFXOPTS_SET_7ZIP
Global $SFXOPTS_INP_7ZIP
Global $SFXOPTS_LBL_7ZIP
Global $USE_UPX[2] = [0, '']
Global $USE_DEFMOD[2] = [0, '']
Global $7ZIP_PATH
Global $CMB_UPX_DATA = '--best --all-methods|--brute|--ultra-brute|-1|-2|-3|-4|-5|-6|-7|-8|-9|'
Global $CMB_SFXMOD_DATA = '7zsd_All|7zsd_All_x64|7zsd_LZMA|7zsd_LZMA_x64|7zsd_LZMA_Dialogs|7zsd_LZMA_Dialogs_x64|7zsd_LZMA2|7zsd_LZMA2_x64|7zsd_Deflate|7zsd_Deflate_x64|7zsd_PPMd|7zsd_PPMd_x64|'
If $RegMode = 1 Then
	$USE_UPX[1] = RegRead($reg_Path, 'UPXCommands')
	$USE_DEFMOD[1] = RegRead($reg_Path, 'DefaultSFXMod')
	$7ZIP_PATH = RegRead($reg_7zPath, 'Path')
	If RegRead($reg_Path, 'UseUPX') = 1 Then $USE_UPX[0] = 1
	If RegRead($reg_Path, 'UseDefaultSFXMod') = 1 Then $USE_DEFMOD[0] = 1
Else
	$USE_UPX[1] = IniRead($SetsINI, 'Main', 'UPXCommands', '')
	$USE_DEFMOD[1] = IniRead($SetsINI, 'Main', 'DefaultSFXMod', '')
	$7ZIP_PATH = IniRead($SetsINI, '7-Zip', 'Path', '')
	If IniRead($SetsINI, 'Main', 'UseUPX', '') = 1 Then $USE_UPX[0] = 1
	If IniRead($SetsINI, 'Main', 'UseDefaultSFXMod', '') = 1 Then $USE_DEFMOD[0] = 1
EndIf
If Not StringInStr($CMB_UPX_DATA, $USE_UPX[1] & '|') Then $USE_UPX[1] = '--best --all-methods'
If Not StringInStr($CMB_SFXMOD_DATA, $USE_DEFMOD[1] & '|') Then $USE_DEFMOD[1] = '7zsd_All'
If $7ZIP_PATH = '' Then
	If FileExists($3rdP_Dir & '\7z.exe') Then
		$7ZIP_PATH = $3rdP_Dir & '\7z.exe'
	ElseIf FileExists(@ProgramFilesDir & '\7-Zip\7z.exe') Then
		$7ZIP_PATH = @ProgramFilesDir & '\7-Zip\7z.exe'
	EndIf
EndIf
; GUI 7-Zip
Global $GUI_7ZIP
Global $7ZIP_BTN_SAVE
Global $7ZIP_BTN_CANCEL
Global $7ZIP_CMB_LVL
Global $7ZIP_CMB_METHOD
Global $7ZIP_CMB_DICT
Global $7ZIP_CMB_SOLID
Global $7ZIP_LBL_LVL
Global $7ZIP_LBL_METHOD
Global $7ZIP_LBL_DICT
Global $7ZIP_LBL_SOLID
Global $7z_LVL[2]
Global $7z_METHOD[2]
Global $7z_DICT[2]
Global $7z_SOLID[2]
Global $CMB_LVL_DATA = 'Store|Fastest|Fast|Normal|Maximum|Ultra|'
Global $CMB_METHOD_DATA = 'LZMA2|LZMA|' ;'LZMA2|LZMA|PPMd|BZip2|'
Global $CMB_DICT_DATA = '64 KB|1 MB|2 MB|3 MB|4 MB|6 MB|8 MB|12 MB|16 MB|24 MB|32 MB|48 MB|64 MB|'
Global $CMB_SOLID_DATA = 'Non-solid|1 MB|2 MB|4 MB|8 MB|16 MB|32 MB|64 MB|128 MB|256 MB|512 MB|1 GB|2 GB|4 GB|8 GB|16 GB|32 GB|64 GB|Solid|'
If $RegMode = 1 Then
	$7z_LVL[0] = RegRead($reg_7zPath, 'Level')
	$7z_METHOD[0] = RegRead($reg_7zPath, 'Method')
	$7z_DICT[0] = RegRead($reg_7zPath, 'Dictionary')
	$7z_SOLID[0] = RegRead($reg_7zPath, 'BlockSize')
Else
	$7z_LVL[0] = IniRead($SetsINI, '7-Zip', 'Level', '')
	$7z_METHOD[0] = IniRead($SetsINI, '7-Zip', 'Method', '')
	$7z_DICT[0] = IniRead($SetsINI, '7-Zip', 'Dictionary', '')
	$7z_SOLID[0] = IniRead($SetsINI, '7-Zip', 'BlockSize', '')
EndIf
_ConvertArcValues()
;~ GUI MAKE SFX
Global $GUI_MAKE_SFX
Global $GUI_MSFX_PROGRESS
Global $GUI_MSFX_LST
Global $GUI_MSFX_OPEN
Global $GUI_MSFX_RUN
Global $GUI_MSFX_CLOSE
Global $BuiltSFX
Global $iListView
;~ GUI LANG INFO
Global $GUI_LANG
Global $GUI_LNG_BTN_OK
Global $GUI_LNG_LBL_CONTACT
;~ GUI ABOUT
Global $GUI_ABOUT
Global $GUI_ABOUT_BUTTON_OK
Global $GUI_ABOUT_LABEL_P_SITE
Global $GUI_ABOUT_LABEL_ICONS
Global $GUI_ABOUT_LABEL_MAIL
;~ GUI ARCHIVE
Global $GUI_ARC
Global $ARC_BTN_SAVE
Global $ARC_BTN_CANCEL
Global $ARC_BTN_ADDFILE
Global $ARC_BTN_ADDFLDR
Global $ARC_BTN_REMOVE
Global $ARC_BTN_MOVEUP
Global $ARC_BTN_MOVEDOWN
Global $ARC_LBL_NOTE
Global $ARC_LST
Global $ARC_CHK
Global $ARC_INP
Global $ARC_EDT
#Region End --- Declare Variables


Global $ScriptFPath = @ScriptFullPath, $IconPath = @ScriptFullPath
If Not @Compiled Then $ScriptFPath = @ScriptDir & '\7z SFX Builder.exe'
If Not @Compiled Then $IconPath = @ScriptDir & '\Icon'

; load icons
Global $LstImage = _GUIImageList_Create(32, 32, 5)
If @Compiled Then
	_GUIImageList_AddIcon($LstImage, $IconPath, -100, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -101, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -102, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -103, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -104, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -105, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -106, True)
	_GUIImageList_AddIcon($LstImage, $IconPath, -107, True)
Else
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Open.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Save.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\SaveAs.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Close.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Test.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Preset.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\BuildSFX.ico', 0, True)
	_GUIImageList_AddIcon($LstImage, $IconPath & '\Toolbar\Options.ico', 0, True)
EndIf

Global $iBtnList_small[24]
Global $iBtnList_large[6]
$iBtnList_small[0] = _GUIImageList_Create(16, 16, 5) ; Info 16x16
$iBtnList_small[1] = _GUIImageList_Create(16, 16, 5) ; Set 16x16
$iBtnList_small[2] = _GUIImageList_Create(16, 16, 5) ; Insert 16x16
$iBtnList_small[3] = _GUIImageList_Create(16, 16, 5) ; Browse 16x16
$iBtnList_small[4] = _GUIImageList_Create(16, 16, 5) ; Open Folder 16x16
$iBtnList_small[5] = _GUIImageList_Create(16, 16, 5) ; AddFile 16x16
$iBtnList_small[6] = _GUIImageList_Create(16, 16, 5) ; AddFolder 16x16
$iBtnList_small[7] = _GUIImageList_Create(16, 16, 5) ; Add 16x16
$iBtnList_small[8] = _GUIImageList_Create(16, 16, 5) ; Edit 16x16
$iBtnList_small[9] = _GUIImageList_Create(16, 16, 5) ; Delete 16x16
$iBtnList_small[10] = _GUIImageList_Create(16, 16, 5) ; DeleteAll 16x16
$iBtnList_small[11] = _GUIImageList_Create(16, 16, 5) ; MoveUp 16x16
$iBtnList_small[12] = _GUIImageList_Create(16, 16, 5) ; MoveDown 16x16
$iBtnList_small[13] = _GUIImageList_Create(16, 16, 5) ; Run 16x16
$iBtnList_small[22] = _GUIImageList_Create(16, 16, 5) ; Reset 16x16
$iBtnList_small[14] = _GUIImageList_Create(16, 16, 5) ; Open 16x16
$iBtnList_small[15] = _GUIImageList_Create(16, 16, 5) ; Save 16x16
$iBtnList_small[16] = _GUIImageList_Create(16, 16, 5) ; SaveAs 16x16
$iBtnList_small[17] = _GUIImageList_Create(16, 16, 5) ; Close 16x16
$iBtnList_small[18] = _GUIImageList_Create(16, 16, 5) ; Test 16x16
$iBtnList_small[19] = _GUIImageList_Create(16, 16, 5) ; Preset 16x16
$iBtnList_small[20] = _GUIImageList_Create(16, 16, 5) ; BuildSFX 16x16
$iBtnList_small[21] = _GUIImageList_Create(16, 16, 5) ; Options 16x16
$iBtnList_small[23] = _GUIImageList_Create(16, 16, 5) ; Reload 16x16
$iBtnList_large[0] = _GUIImageList_Create(32, 32, 5) ; Add 32x32
$iBtnList_large[1] = _GUIImageList_Create(32, 32, 5) ; Edit 32x32
$iBtnList_large[2] = _GUIImageList_Create(32, 32, 5) ; Delete 32x32
$iBtnList_large[3] = _GUIImageList_Create(32, 32, 5) ; DeleteAll 32x32
$iBtnList_large[4] = _GUIImageList_Create(32, 32, 5) ; MoveUp 32x32
$iBtnList_large[5] = _GUIImageList_Create(32, 32, 5) ; MoveDown 32x32
If @Compiled Then
	_GUIImageList_AddIcon($iBtnList_small[0], $IconPath, -200, False)
	_GUIImageList_AddIcon($iBtnList_small[1], $IconPath, -201, False)
	_GUIImageList_AddIcon($iBtnList_small[2], $IconPath, -202, False)
	_GUIImageList_AddIcon($iBtnList_small[3], $IconPath, -203, False)
	_GUIImageList_AddIcon($iBtnList_small[4], $IconPath, -204, False)
	_GUIImageList_AddIcon($iBtnList_small[5], $IconPath, -205, False)
	_GUIImageList_AddIcon($iBtnList_small[6], $IconPath, -206, False)
	_GUIImageList_AddIcon($iBtnList_small[7], $IconPath, -207, False)
	_GUIImageList_AddIcon($iBtnList_small[8], $IconPath, -208, False)
	_GUIImageList_AddIcon($iBtnList_small[9], $IconPath, -209, False)
	_GUIImageList_AddIcon($iBtnList_small[10], $IconPath, -210, False)
	_GUIImageList_AddIcon($iBtnList_small[11], $IconPath, -211, False)
	_GUIImageList_AddIcon($iBtnList_small[12], $IconPath, -212, False)
	_GUIImageList_AddIcon($iBtnList_small[13], $IconPath, -213, False)
	_GUIImageList_AddIcon($iBtnList_small[22], $IconPath, -214, False)
	_GUIImageList_AddIcon($iBtnList_small[14], $IconPath, -100, False)
	_GUIImageList_AddIcon($iBtnList_small[15], $IconPath, -101, False)
	_GUIImageList_AddIcon($iBtnList_small[16], $IconPath, -102, False)
	_GUIImageList_AddIcon($iBtnList_small[17], $IconPath, -103, False)
	_GUIImageList_AddIcon($iBtnList_small[18], $IconPath, -104, False)
	_GUIImageList_AddIcon($iBtnList_small[19], $IconPath, -105, False)
	_GUIImageList_AddIcon($iBtnList_small[20], $IconPath, -106, False)
	_GUIImageList_AddIcon($iBtnList_small[21], $IconPath, -107, False)
	_GUIImageList_AddIcon($iBtnList_small[23], $IconPath, -150, False)
	_GUIImageList_AddIcon($iBtnList_large[0], $IconPath, -207, True)
	_GUIImageList_AddIcon($iBtnList_large[1], $IconPath, -208, True)
	_GUIImageList_AddIcon($iBtnList_large[2], $IconPath, -209, True)
	_GUIImageList_AddIcon($iBtnList_large[3], $IconPath, -210, True)
	_GUIImageList_AddIcon($iBtnList_large[4], $IconPath, -211, True)
	_GUIImageList_AddIcon($iBtnList_large[5], $IconPath, -212, True)
Else
	_GUIImageList_AddIcon($iBtnList_small[0], $IconPath & '\Button\Info.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[1], $IconPath & '\Button\Set.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[2], $IconPath & '\Button\Insert.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[3], $IconPath & '\Button\Browse.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[4], $IconPath & '\Button\OpenFolder.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[5], $IconPath & '\Button\AddFile.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[6], $IconPath & '\Button\AddFolder.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[7], $IconPath & '\Button\Add.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[8], $IconPath & '\Button\Edit.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[9], $IconPath & '\Button\Delete.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[10], $IconPath & '\Button\DeleteAll.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[11], $IconPath & '\Button\MoveUp.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[12], $IconPath & '\Button\MoveDown.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[13], $IconPath & '\Button\Run.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[22], $IconPath & '\Button\Reset.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[14], $IconPath & '\Toolbar\Open.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[15], $IconPath & '\Toolbar\Save.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[16], $IconPath & '\Toolbar\SaveAs.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[17], $IconPath & '\Toolbar\Close.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[18], $IconPath & '\Toolbar\Test.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[19], $IconPath & '\Toolbar\Preset.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[20], $IconPath & '\Toolbar\BuildSFX.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[21], $IconPath & '\Toolbar\Options.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_small[23], $IconPath & '\Menu\Reload.ico', 0, False)
	_GUIImageList_AddIcon($iBtnList_large[0], $IconPath & '\Button\Add.ico', 0, True)
	_GUIImageList_AddIcon($iBtnList_large[1], $IconPath & '\Button\Edit.ico', 0, True)
	_GUIImageList_AddIcon($iBtnList_large[2], $IconPath & '\Button\Delete.ico', 0, True)
	_GUIImageList_AddIcon($iBtnList_large[3], $IconPath & '\Button\DeleteAll.ico', 0, True)
	_GUIImageList_AddIcon($iBtnList_large[4], $IconPath & '\Button\MoveUp.ico', 0, True)
	_GUIImageList_AddIcon($iBtnList_large[5], $IconPath & '\Button\MoveDown.ico', 0, True)
EndIf
Global $iBtnMsgList = _GUIImageList_Create(105, 30, 5, 1, 3)
Global $hBtnMsgBitmap[4]
$hBtnMsgBitmap[1] = _WinAPI_CreateSolidBitmap($GUI_MAIN, 0xcccccc, 105, 30)
$hBtnMsgBitmap[2] = _WinAPI_CreateSolidBitmap($GUI_MAIN, 0x999999, 105, 30)
$hBtnMsgBitmap[3] = _WinAPI_CreateSolidBitmap($GUI_MAIN, 0x666666, 105, 30)
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[1])
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[2])
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[3])
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[3])
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[1])
_GUIImageList_Add($iBtnMsgList, $hBtnMsgBitmap[1])

Opt('MustDeclareVars', 1)
Opt('GUIOnEventMode', 1)
;~ Opt('SendKeyDelay', 50)
;~ Opt('GUIResizeMode', 802)

Global Const $NameAPP = '7z SFX Builder'
Global Const $VersAPP = '2.1'
Global Const $VersAPP2 = '2.1.0.0'
Global Const $SiteAPP = 'https://github.com/brunjick/sevenzipsfxbuilder/'
Global Const $MailAPP = 'brunjadzem@gmail.com'

#include '.\include\Load_Language.au3'
#include '.\include\GUIs.au3'
#include '.\Include\ResEdit.au3'

If Not @Compiled Then Local $MainTimer = TimerDiff($LaunchTimer)

_Main()

; ***********************************************************
; *						GUI MAIN							*
; ***********************************************************
Func _Main()
	$GUI_MAIN = GUICreate($NameAPP, 600, 450, $WinPos[0], $WinPos[1], -1, $WS_EX_ACCEPTFILES)
	$TAB_MAIN = GUICtrlCreateTab(5, 50, 590, 350)
	GUISetBkColor(0xFFFFFF, $GUI_MAIN)
	If $UseFONT Then GUICtrlSetFont($TAB_MAIN, 8.5, '', '', $Font[0])
	$INP_CUR_FILE = GUICtrlCreateInput('', 5, 404, 511, 22, BitOR($ES_READONLY, $ES_AUTOHSCROLL))
	$BTN_CFG_RELOAD = GUICtrlCreateButton('', 523, 403, 34, 24)
	$BTN_CFG_OPEN = GUICtrlCreateButton('', 562, 403, 34, 24)
	_GUICtrlButton_SetImageList($BTN_CFG_RELOAD, $iBtnList_small[23], 4)
	_GUICtrlButton_SetImageList($BTN_CFG_OPEN, $iBtnList_small[14], 4)
	GUICtrlSetTip($BTN_CFG_RELOAD, $_LNG_TAB_MAIN[19])
	GUICtrlSetTip($BTN_CFG_OPEN, $_LNG_TAB_MAIN[20])
	GUICtrlSetOnEvent($BTN_CFG_OPEN, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($BTN_CFG_RELOAD, '_MainGUI_Control_Events')
	; ######### ToolBar #########
	$hToolbar = _GUICtrlToolbar_Create($GUI_MAIN, $TBSTYLE_FLAT, $TBSTYLE_EX_DRAWDDARROWS)
	$hToolTip = _GUIToolTip_Create($hToolbar)
	_GUICtrlToolbar_SetToolTips($hToolbar, $hToolTip)
	; set icons
	_GUICtrlToolbar_SetImageList($hToolbar, $LstImage)
	; add buttons
	_GUICtrlToolbar_AddButton($hToolbar, $id_Open, 0)
	_GUICtrlToolbar_AddButton($hToolbar, $id_Save, 1)
	_GUICtrlToolbar_AddButton($hToolbar, $id_SaveAs, 2)
	_GUICtrlToolbar_AddButton($hToolbar, $id_Close, 3)
	_GUICtrlToolbar_AddButton($hToolbar, $id_Test, 4, $BTNS_WHOLEDROPDOWN)
	_GUICtrlToolbar_AddButton($hToolbar, $id_Preset, 5, $BTNS_WHOLEDROPDOWN)
	_GUICtrlToolbar_AddButton($hToolbar, $id_MakeSFX, 6)
	_GUICtrlToolbar_AddButtonSep($hToolbar)
	_GUICtrlToolbar_AddButton($hToolbar, $id_Opts, 7)
	; Toolbar Context Menu
	$bUseAdvMenu = True
	$bUseRGBColors = True
	$Dummy_Test = GUICtrlCreateDummy()
	$c_Menu_Test = GUICtrlCreateContextMenu($Dummy_Test)
	$TBi_BP = _GUICtrlCreateMenuItemEx('BeginPrompt' & @TAB & 'Ctrl+Shift+A', $c_Menu_Test)
	$TBi_EPT = _GUICtrlCreateMenuItemEx('ExtractPathText' & @TAB & 'Ctrl+Shift+X', $c_Menu_Test)
	$TBi_EDT = _GUICtrlCreateMenuItemEx('ExtractDialogText' & @TAB & 'Ctrl+Shift+D', $c_Menu_Test)
	$TBi_CP = _GUICtrlCreateMenuItemEx('CancelPrompt' & @TAB & 'Ctrl+Shift+C', $c_Menu_Test)
	$TBi_FM = _GUICtrlCreateMenuItemEx('FinishMessage' & @TAB & 'Ctrl+Shift+F', $c_Menu_Test)
	$TBi_HT = _GUICtrlCreateMenuItemEx('HelpText' & @TAB & 'Ctrl+Shift+H', $c_Menu_Test)
	$TBi_WARN = _GUICtrlCreateMenuItemEx('WarningMessage' & @TAB & 'Ctrl+Shift+W', $c_Menu_Test)
	$TBi_ERROR = _GUICtrlCreateMenuItemEx('ErrorMessage' & @TAB & 'Ctrl+Shift+E', $c_Menu_Test)
;~ 	$TBi_PASSWD = _GUICtrlCreateMenuItemEx('PasswordPrompt' & @TAB & 'Ctrl+Shift+S', $c_Menu_Test) ; temporarily disabled
	GUICtrlSetOnEvent($TBi_BP, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_EPT, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_EDT, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_CP, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_FM, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_HT, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_WARN, '_Toolbar_Menu_Events')
	GUICtrlSetOnEvent($TBi_ERROR, '_Toolbar_Menu_Events')
;~ 	GUICtrlSetOnEvent($TBi_PASSWD, '_Toolbar_Menu_Events')
	$Dummy_Preset = GUICtrlCreateDummy()
	$c_Menu_Preset = GUICtrlCreateContextMenu($Dummy_Preset)
	$h_Menu_Preset = GUICtrlGetHandle($c_Menu_Preset)
	$Mi_PRESET_MAN = _GUICtrlCreateMenuItemEx($_LNG_MENU[17], $c_Menu_Preset, $ScriptFPath, 107)
	_GUICtrlCreateMenuItemEx('', $c_Menu_Preset)
	; ######### Menu #########
	$Menu_FILE = GUICtrlCreateMenu($_LNG_MENU[1])
	$Mi_OPEN = _GUICtrlCreateMenuItemEx($_LNG_MENU[4], $Menu_FILE, $ScriptFPath, 100)
	$Mi_RELOAD = _GUICtrlCreateMenuItemEx($_LNG_MENU[5], $Menu_FILE, $ScriptFPath, 150)
	$Mi_SAVE = _GUICtrlCreateMenuItemEx($_LNG_MENU[6], $Menu_FILE, $ScriptFPath, 101)
	$Mi_SAVEAS = _GUICtrlCreateMenuItemEx($_LNG_MENU[7], $Menu_FILE, $ScriptFPath, 102)
	$Mi_CLOSE = _GUICtrlCreateMenuItemEx($_LNG_MENU[8], $Menu_FILE, $ScriptFPath, 103)
	_GUICtrlCreateMenuItemEx('', $Menu_FILE)
	$sMenu_RECENT_FILES = _GUICtrlCreateMenuEx($_LNG_MENU[9], $Menu_FILE)
	$Mi_CLEAR = _GUICtrlCreateMenuItemEx($_LNG_MENU[10], $sMenu_RECENT_FILES, $ScriptFPath, 151)
	_GUICtrlCreateMenuItemEx('', $sMenu_RECENT_FILES)
	_GUICtrlCreateMenuItemEx('', $Menu_FILE)
	$Mi_EXIT = _GUICtrlCreateMenuItemEx($_LNG_MENU[11], $Menu_FILE, $ScriptFPath, 152)
	$Menu_SETS = GUICtrlCreateMenu($_LNG_MENU[2])
	$sMenu_LANG = _GUICtrlCreateMenuEx($_LNG_MENU[13], $Menu_SETS, $ScriptFPath, 153)
	_GUICtrlCreateMenuItemEx('', $Menu_SETS)
	$Mi_PRESET_MAN2 = _GUICtrlCreateMenuItemEx($_LNG_MENU[17], $Menu_SETS, $ScriptFPath, 105)
	$Mi_OPTS = _GUICtrlCreateMenuItemEx($_LNG_MENU[12], $Menu_SETS, $ScriptFPath, 107)
	$Menu_HELP = GUICtrlCreateMenu($_LNG_MENU[3])
	$Mi_HELPEN = _GUICtrlCreateMenuItemEx($_LNG_MENU[14] & ' EN', $Menu_HELP, $ScriptFPath, 154)
	$Mi_HELPRU = _GUICtrlCreateMenuItemEx($_LNG_MENU[14] & ' RU', $Menu_HELP, $ScriptFPath, 154)
	$Mi_PSITE = _GUICtrlCreateMenuItemEx($_LNG_MENU[15], $Menu_HELP, $ScriptFPath, 155)
	$sMenu_THIRD = _GUICtrlCreateMenuEx('3rd Party', $Menu_HELP, $ScriptFPath, 156)
	$Mi_SFXMod = _GUICtrlCreateMenuItemEx('7z SFX Modified Module', $sMenu_THIRD, $ScriptFPath, 155)
	$Mi_SFXSplit = _GUICtrlCreateMenuItemEx('SFX Splitter', $sMenu_THIRD, $ScriptFPath, 155)
	$Mi_UPX = _GUICtrlCreateMenuItemEx('UPX', $sMenu_THIRD, $ScriptFPath, 155)
	_GUICtrlCreateMenuItemEx('', $Menu_HELP)
	$Mi_ABOUT = _GUICtrlCreateMenuItemEx($_LNG_MENU[16], $Menu_HELP, $ScriptFPath, 200)
	Dim $AccelTable[15][2] = [['^o', $Mi_OPEN],['^r', $Mi_RELOAD],['^s', $Mi_SAVE],['^+s', $Mi_SAVEAS],['^w', $Mi_CLOSE],['^q', $Mi_EXIT], _
			['^+a', $TBi_BP],['^+x', $TBi_EPT],['^+d', $TBi_EDT],['^+c', $TBi_CP],['^+f', $TBi_FM],['^+h', $TBi_HT],['^+w', $TBi_WARN],['^+e', $TBi_ERROR],['^+s', $TBi_PASSWD]]
	GUISetAccelerators($AccelTable)
	GUICtrlSetOnEvent($TAB_MAIN, '_Tab_Event')
	GUICtrlSetOnEvent($Mi_OPEN, '_FileOpenDialog')
	GUICtrlSetOnEvent($Mi_RELOAD, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_SAVE, '_CFG_Save')
	GUICtrlSetOnEvent($Mi_SAVEAS, '_CFG_SaveAs')
	GUICtrlSetOnEvent($Mi_CLOSE, '_FileCloseDialog')
	GUICtrlSetOnEvent($Mi_BP, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_XPT, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_XD, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_CP, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_FM, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_HT, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_CLEAR, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_OPTS, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_HELPEN, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_HELPRU, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_PSITE, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_SFXMod, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_SFXSplit, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_UPX, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_ABOUT, '_MenuItem_Control_Events')
	GUICtrlSetOnEvent($Mi_EXIT, '_Exit')
	GUICtrlSetOnEvent($Mi_PRESET_MAN, '_GUI_PresetMgr')
	GUICtrlSetOnEvent($Mi_PRESET_MAN2, '_GUI_PresetMgr')
	GUICtrlSetBkColor($INP_CUR_FILE, 0xFFFFFF)
	GUICtrlSetFont($INP_CUR_FILE, 8.5, '', '', $Font[0])
	_MRU_Load_Startup()
	Local $LngList = _FileListToArrayEx(@ScriptDir & '\Lang\', '*.ini')
	If Not @error Then _Lang_Create_MenuItem($LngList)
	_Load_Preset()
	_Preset_Create_MenuItem()
	; =-----=
	;  Main
	; =-----=
	#Region Start --- TabItems
	$Ti_MAIN = GUICtrlCreateTabItem($_LNG_TABNAME[1])
	$M_BTN_INSTPATH = GUICtrlCreateButton('', 547, 174, 34, 22)
	$Dummy_InstPath = GUICtrlCreateDummy()
	$c_Menu_InstPath = GUICtrlCreateContextMenu($Dummy_InstPath)
	$M_BTN_GUIFLAGS = GUICtrlCreateButton('', 547, 219, 34, 22)
	$M_INP_INSTPATH = GUICtrlCreateInput('', 170, 175, 365, 20)
	$M_INP_GUIFLAGS = GUICtrlCreateInput('', 170, 220, 295, 20, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
	$M_INP_MISCFLAGS = GUICtrlCreateInput('', 475, 220, 60, 20, BitOR($ES_AUTOHSCROLL, $ES_READONLY))
	$M_INP_BPT = GUICtrlCreateInput('0', 300, 294, 60, 20, $ES_NUMBER)
	$M_INP_XDWidth = GUICtrlCreateInput('0', 300, 316, 60, 20, $ES_NUMBER)
	$M_INP_XPWidth = GUICtrlCreateInput('0', 300, 338, 60, 20, $ES_NUMBER)
	$M_INP_VOLNAME = GUICtrlCreateInput('0', 300, 360, 60, 20, $ES_NUMBER)
	$M_UD_BPT = GUICtrlCreateUpdown($M_INP_BPT)
	$M_UD_XDWidth = GUICtrlCreateUpdown($M_INP_XDWidth)
	$M_UD_XPWidth = GUICtrlCreateUpdown($M_INP_XPWidth)
	$M_UD_VOLNAME = GUICtrlCreateUpdown($M_INP_VOLNAME)
	$M_CHK_TEMPMODE = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[0], 170, 200, 400, 15)
	$M_CHK_SKIPLOCKED = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[1], 15, 250, 570, 20)
	$M_CHK_SELFDELETE = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[2], 15, 272, 570, 20)
	$M_CHK_BPT = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[3], 15, 294, 280, 20)
	$M_CHK_XDWidth = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[4], 15, 316, 280, 20)
	$M_CHK_XPWidth = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[5], 15, 338, 280, 20)
	$M_CHK_VOLNAME = GUICtrlCreateCheckbox($_LNG_TAB_MAIN[21], 15, 360, 280, 20)
	GUIStartGroup()
	$M_RAD_OMode[1] = GUICtrlCreateRadio($_LNG_TAB_MAIN[6], 25, 95, 260)
	$M_RAD_OMode[2] = GUICtrlCreateRadio($_LNG_TAB_MAIN[7], 25, 115, 260)
	$M_RAD_OMode[3] = GUICtrlCreateRadio($_LNG_TAB_MAIN[8], 25, 135, 260)
	GUIStartGroup()
	$M_RAD_GMode[1] = GUICtrlCreateRadio($_LNG_TAB_MAIN[9], 315, 95, 260)
	$M_RAD_GMode[2] = GUICtrlCreateRadio($_LNG_TAB_MAIN[10], 315, 115, 260)
	$M_RAD_GMode[3] = GUICtrlCreateRadio($_LNG_TAB_MAIN[11], 315, 135, 260)
	$M_GRP_OW_MODE = GUICtrlCreateGroup($_LNG_TAB_MAIN[12], 15, 75, 275, 90)
	$M_GRP_GUI_MODE = GUICtrlCreateGroup($_LNG_TAB_MAIN[13], 305, 75, 275, 90)
	$M_LBL_EXT_PATH = GUICtrlCreateLabel($_LNG_TAB_MAIN[14], 15, 177, 240)
	$M_LBL_GF = GUICtrlCreateLabel('GUI/Misc Flags:', 15, 222)
	GUICtrlSetTip($M_BTN_GUIFLAGS, $_LNG_TAB_MAIN[17])
	GUICtrlSetTip($M_BTN_INSTPATH, $_LNG_TAB_MAIN[18])
	GUICtrlSetTip($M_CHK_VOLNAME, '')
	GUICtrlSetBkColor($M_INP_GUIFLAGS, 0xFFFFFF)
	GUICtrlSetBkColor($M_INP_MISCFLAGS, 0xFFFFFF)
	_GUICtrlButton_SetImageList($M_BTN_GUIFLAGS, $iBtnList_small[1], 4)
	_GUICtrlButton_SetImageList($M_BTN_INSTPATH, $iBtnList_small[2], 4)
	GUICtrlSetLimit($M_UD_BPT, 999, -999)
	GUICtrlSetLimit($M_UD_XDWidth, 16959, 0)
	GUICtrlSetLimit($M_UD_XPWidth, 16959, 0)
	GUICtrlSetLimit($M_UD_VOLNAME, 1, 0)
	GUICtrlSetState($M_RAD_OMode[1], 1)
	GUICtrlSetState($M_RAD_GMode[1], 1)
	GUICtrlSetState($M_INP_BPT, $GUI_DISABLE)
	GUICtrlSetState($M_INP_XDWidth, $GUI_DISABLE)
	GUICtrlSetState($M_INP_XPWidth, $GUI_DISABLE)
	GUICtrlSetState($M_INP_VOLNAME, $GUI_DISABLE)
	; ------------------------------------------------------------------------------
	$Mi_IP[1] = _GUICtrlCreateMenuItemEx('%%M (' & $_LNG_TAB_MAIN[15] & ')', $c_Menu_InstPath)
	$Mi_IP[2] = _GUICtrlCreateMenuItemEx('%%S (' & $_LNG_TAB_MAIN[16] & ')', $c_Menu_InstPath)
	_GUICtrlCreateMenuItemEx('', $c_Menu_InstPath)
	$Mi_IP[3] = _GUICtrlCreateMenuItemEx('%SystemDrive%', $c_Menu_InstPath)
	$Mi_IP[4] = _GUICtrlCreateMenuItemEx('%SystemRoot%', $c_Menu_InstPath)
	$Mi_IP[11] = _GUICtrlCreateMenuItemEx('%ProgramFiles%', $c_Menu_InstPath)
	$Mi_IP[8] = _GUICtrlCreateMenuItemEx('%WinDir%', $c_Menu_InstPath)
	$Mi_IP[7] = _GUICtrlCreateMenuItemEx('%Temp%', $c_Menu_InstPath)
	$Mi_IP[5] = _GUICtrlCreateMenuItemEx('%CommonDesktop%', $c_Menu_InstPath)
	$Mi_IP[9] = _GUICtrlCreateMenuItemEx('%CommonDocuments%', $c_Menu_InstPath)
	$Mi_IP[10] = _GUICtrlCreateMenuItemEx('%AllUsersProfile%', $c_Menu_InstPath)
	$Mi_IP[6] = _GUICtrlCreateMenuItemEx('%UserDesktop%', $c_Menu_InstPath)
	$Mi_IP[12] = _GUICtrlCreateMenuItemEx('%UserDocuments%', $c_Menu_InstPath)
	$Mi_IP[13] = _GUICtrlCreateMenuItemEx('%UserProfile%', $c_Menu_InstPath)
	; ------------------------------------------------------------------------------
	GUICtrlSetOnEvent($M_BTN_INSTPATH, '_Insert_Variables')
	GUICtrlSetOnEvent($M_BTN_GUIFLAGS, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($M_CHK_TEMPMODE, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($M_CHK_BPT, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($M_CHK_XDWidth, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($M_CHK_XPWidth, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($M_CHK_VOLNAME, '_MainGUI_Control_Events')
	; ------------------------------------------------------------------------------
	GUICtrlSetOnEvent($Mi_IP[1], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[2], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[3], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[4], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[5], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[6], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[7], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[8], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[9], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[10], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[11], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[12], '_Insert_Variables')
	GUICtrlSetOnEvent($Mi_IP[13], '_Insert_Variables')
	; =-----------=
	;  Title/Text
	; =-----------=
	$Ti_TITLETEXT = GUICtrlCreateTabItem($_LNG_TABNAME[2])
	$T_INP_WINTITLE = GUICtrlCreateInput('', 25, 120, 250, 20)
	$T_INP_XPATHWINTITLE = GUICtrlCreateInput('', 25, 165, 250, 20)
	$T_INP_XTITLE = GUICtrlCreateInput('', 25, 210, 250, 20)
	$T_INP_ERRORTITLE = GUICtrlCreateInput('', 25, 255, 250, 20)
	$T_INP_WARNTITLE = GUICtrlCreateInput('', 25, 300, 250, 20)
	$T_INP_PASSWDTITLE = GUICtrlCreateInput('', 25, 345, 250, 20)
	$T_INP_PASSWDTEXT = GUICtrlCreateInput('', 320, 120, 250, 20)
	$T_INP_XCANCELTEXT = GUICtrlCreateInput('', 320, 165, 250, 20)
	$T_GRP_TITLE = GUICtrlCreateGroup($_LNG_TAB_TT[1], 10, 75, 280, 315)
	$T_GRP_TEXT = GUICtrlCreateGroup($_LNG_TAB_TT[2], 305, 75, 280, 315)
	$T_LBL_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[3], 25, 100, 250)
	$T_LBL_EXT_PATH_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[4], 25, 145, 250)
	$T_LBL_EXT_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[5], 25, 190, 250)
	$T_LBL_ERR_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[6], 25, 235, 250)
	$T_LBL_WARN_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[7], 25, 280, 250)
	$T_LBL_PSWD_TITLE = GUICtrlCreateLabel($_LNG_TAB_TT[8], 25, 325, 250)
	$T_LBL_PSWD_TEXT = GUICtrlCreateLabel($_LNG_TAB_TT[9], 320, 100, 250)
	$T_LBL_CANCEL_TEXT = GUICtrlCreateLabel($_LNG_TAB_TT[10], 320, 145, 250)
	; =-------------------------------------------------------------------------------------------=
	;  BeginPrompt | ExtractPathText | ExtractDialogText | CancelPrompt | FinishMessage | HelpText
	; =-------------------------------------------------------------------------------------------=
	$Ti_MESSAGES = GUICtrlCreateTabItem($_LNG_TABNAME[3])
	$MS_BTN_TEST = GUICtrlCreateButton($_LNG_GLOBAL[14], 10, 365, 105, 30)
	$MS_BTN_BEGINPROMPT = GUICtrlCreateButton('BeginPrompt', 10, 80, 105, 30, 0x0300)
	$MS_BTN_XPATHTEXT = GUICtrlCreateButton('ExtractPathText', 10, 115, 105, 30, 0x0300)
	$MS_BTN_XDIALOGTEXT = GUICtrlCreateButton('ExtractDialogText', 10, 150, 105, 30, 0x0300)
	$MS_BTN_CANCELPROMPT = GUICtrlCreateButton('CancelPrompt', 10, 185, 105, 30, 0x0300)
	$MS_BTN_FINISHMSG = GUICtrlCreateButton('FinishMessage', 10, 220, 105, 30, 0x0300)
	$MS_BTN_HELPTEXT = GUICtrlCreateButton('HelpText', 10, 255, 105, 30, 0x0300)
	$MS_EDT_MESSAGES[1] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	$MS_EDT_MESSAGES[2] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	$MS_EDT_MESSAGES[3] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	$MS_EDT_MESSAGES[4] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	$MS_EDT_MESSAGES[5] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	$MS_EDT_MESSAGES[6] = GUICtrlCreateEdit('', 120, 80, 470, 315)
	GUICtrlSetFont($MS_BTN_BEGINPROMPT, 8, 1000, '', $Font[0])
	GUICtrlSetFont($MS_BTN_XPATHTEXT, 8, 1000, '', $Font[0])
	GUICtrlSetFont($MS_BTN_XDIALOGTEXT, 8, 1000, '', $Font[0])
	GUICtrlSetFont($MS_BTN_CANCELPROMPT, 8, 1000, '', $Font[0])
	GUICtrlSetFont($MS_BTN_FINISHMSG, 8, 1000, '', $Font[0])
	GUICtrlSetFont($MS_BTN_HELPTEXT, 8, 1000, '', $Font[0])
	GUICtrlSetCursor($MS_BTN_BEGINPROMPT, 0)
	GUICtrlSetCursor($MS_BTN_XPATHTEXT, 0)
	GUICtrlSetCursor($MS_BTN_XDIALOGTEXT, 0)
	GUICtrlSetCursor($MS_BTN_CANCELPROMPT, 0)
	GUICtrlSetCursor($MS_BTN_FINISHMSG, 0)
	GUICtrlSetCursor($MS_BTN_HELPTEXT, 0)
	_GUICtrlButton_SetImageList($MS_BTN_TEST, $iBtnList_small[18], 0)
	_GUICtrlButton_SetImageList($MS_BTN_BEGINPROMPT, $iBtnMsgList, 4)
	_GUICtrlButton_SetImageList($MS_BTN_XPATHTEXT, $iBtnMsgList, 4)
	_GUICtrlButton_SetImageList($MS_BTN_XDIALOGTEXT, $iBtnMsgList, 4)
	_GUICtrlButton_SetImageList($MS_BTN_CANCELPROMPT, $iBtnMsgList, 4)
	_GUICtrlButton_SetImageList($MS_BTN_FINISHMSG, $iBtnMsgList, 4)
	_GUICtrlButton_SetImageList($MS_BTN_HELPTEXT, $iBtnMsgList, 4)
	GUICtrlSetFont($MS_EDT_MESSAGES[1], 8.5, '', '', $Font[0])
	GUICtrlSetFont($MS_EDT_MESSAGES[2], 8.5, '', '', $Font[0])
	GUICtrlSetFont($MS_EDT_MESSAGES[3], 8.5, '', '', $Font[0])
	GUICtrlSetFont($MS_EDT_MESSAGES[4], 8.5, '', '', $Font[0])
	GUICtrlSetFont($MS_EDT_MESSAGES[5], 8.5, '', '', $Font[0])
	GUICtrlSetFont($MS_EDT_MESSAGES[6], 8.5, '', '', $Font[0])
	GUICtrlSetState($MS_BTN_BEGINPROMPT, $GUI_DISABLE)
	GUICtrlSetState($MS_EDT_MESSAGES[2], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[3], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[4], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[5], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[6], $GUI_HIDE)
	GUICtrlSetOnEvent($MS_BTN_TEST, '_Button_Test_Events')
	GUICtrlSetOnEvent($MS_BTN_BEGINPROMPT, '_Tab_Dialogs_Events')
	GUICtrlSetOnEvent($MS_BTN_XPATHTEXT, '_Tab_Dialogs_Events')
	GUICtrlSetOnEvent($MS_BTN_XDIALOGTEXT, '_Tab_Dialogs_Events')
	GUICtrlSetOnEvent($MS_BTN_CANCELPROMPT, '_Tab_Dialogs_Events')
	GUICtrlSetOnEvent($MS_BTN_FINISHMSG, '_Tab_Dialogs_Events')
	GUICtrlSetOnEvent($MS_BTN_HELPTEXT, '_Tab_Dialogs_Events')
	; =-------------------------=
	;  RunProgram/AutoInstall(X)
	; =-------------------------=
	$Ti_RUNPROGRAM = GUICtrlCreateTabItem($_LNG_TABNAME[4])
	$R_BTN_ADD = GUICtrlCreateButton('', 10, 80, 40, 40)
	$R_BTN_EDIT = GUICtrlCreateButton('', 10, 125, 40, 40)
	$R_BTN_DELETE = GUICtrlCreateButton('', 10, 170, 40, 40)
	$R_BTN_DELETEALL = GUICtrlCreateButton('', 10, 215, 40, 40)
	$R_BTN_MOVEUP = GUICtrlCreateButton('', 10, 260, 40, 40)
	$R_BTN_MOVEDOWN = GUICtrlCreateButton('', 10, 305, 40, 40)
	$R_LIST = GUICtrlCreateListView($_LNG_TAB_RUN[1], 55, 80, 535, 315, BitOR($LVS_SHOWSELALWAYS, $LVS_NOLABELWRAP))
	GUICtrlSendMsg($R_LIST, $LVM_SETCOLUMNWIDTH, 0, 80)
	GUICtrlSendMsg($R_LIST, $LVM_SETCOLUMNWIDTH, 1, 70)
	GUICtrlSendMsg($R_LIST, $LVM_SETCOLUMNWIDTH, 2, 245)
	GUICtrlSendMsg($R_LIST, $LVM_SETCOLUMNWIDTH, 3, 70)
	GUICtrlSendMsg($R_LIST, $LVM_SETCOLUMNWIDTH, 4, 65)
	GUICtrlSetTip($R_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($R_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($R_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($R_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($R_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($R_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	_GUICtrlButton_SetImageList($R_BTN_ADD, $iBtnList_large[0], 4)
	_GUICtrlButton_SetImageList($R_BTN_EDIT, $iBtnList_large[1], 4)
	_GUICtrlButton_SetImageList($R_BTN_DELETE, $iBtnList_large[2], 4)
	_GUICtrlButton_SetImageList($R_BTN_DELETEALL, $iBtnList_large[3], 4)
	_GUICtrlButton_SetImageList($R_BTN_MOVEUP, $iBtnList_large[4], 4)
	_GUICtrlButton_SetImageList($R_BTN_MOVEDOWN, $iBtnList_large[5], 4)
	GUICtrlSetOnEvent($R_BTN_ADD, '_TabItem_Run_Events')
	GUICtrlSetOnEvent($R_BTN_EDIT, '_TabItem_Run_Events')
	GUICtrlSetOnEvent($R_BTN_DELETE, '_TabItem_Run_Events')
	GUICtrlSetOnEvent($R_BTN_DELETEALL, '_TabItem_Run_Events')
	GUICtrlSetOnEvent($R_BTN_MOVEUP, '_TabItem_Run_Events')
	GUICtrlSetOnEvent($R_BTN_MOVEDOWN, '_TabItem_Run_Events')
	; =----------------=
	;  Delete/Delete(X)
	; =----------------=
	$Ti_DELETE = GUICtrlCreateTabItem($_LNG_TABNAME[5])
	$D_BTN_ADD = GUICtrlCreateButton('', 10, 80, 40, 40)
	$D_BTN_EDIT = GUICtrlCreateButton('', 10, 125, 40, 40)
	$D_BTN_DELETE = GUICtrlCreateButton('', 10, 170, 40, 40)
	$D_BTN_DELETEALL = GUICtrlCreateButton('', 10, 215, 40, 40)
	$D_BTN_MOVEUP = GUICtrlCreateButton('', 10, 260, 40, 40)
	$D_BTN_MOVEDOWN = GUICtrlCreateButton('', 10, 305, 40, 40)
	$D_LIST = GUICtrlCreateListView($_LNG_TAB_DEL[1], 55, 80, 535, 315, BitOR($LVS_SHOWSELALWAYS, $LVS_NOLABELWRAP))
	GUICtrlSendMsg($D_LIST, $LVM_SETCOLUMNWIDTH, 0, 70)
	GUICtrlSendMsg($D_LIST, $LVM_SETCOLUMNWIDTH, 1, 395)
	GUICtrlSendMsg($D_LIST, $LVM_SETCOLUMNWIDTH, 2, 65)
	GUICtrlSetTip($D_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($D_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($D_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($D_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($D_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($D_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	_GUICtrlButton_SetImageList($D_BTN_ADD, $iBtnList_large[0], 4)
	_GUICtrlButton_SetImageList($D_BTN_EDIT, $iBtnList_large[1], 4)
	_GUICtrlButton_SetImageList($D_BTN_DELETE, $iBtnList_large[2], 4)
	_GUICtrlButton_SetImageList($D_BTN_DELETEALL, $iBtnList_large[3], 4)
	_GUICtrlButton_SetImageList($D_BTN_MOVEUP, $iBtnList_large[4], 4)
	_GUICtrlButton_SetImageList($D_BTN_MOVEDOWN, $iBtnList_large[5], 4)
	GUICtrlSetOnEvent($D_BTN_ADD, '_TabItem_Delete_Events')
	GUICtrlSetOnEvent($D_BTN_EDIT, '_TabItem_Delete_Events')
	GUICtrlSetOnEvent($D_BTN_DELETE, '_TabItem_Delete_Events')
	GUICtrlSetOnEvent($D_BTN_DELETEALL, '_TabItem_Delete_Events')
	GUICtrlSetOnEvent($D_BTN_MOVEUP, '_TabItem_Delete_Events')
	GUICtrlSetOnEvent($D_BTN_MOVEDOWN, '_TabItem_Delete_Events')
	; =--------------------=
	;  Shortcut/Shortcut(X)
	; =--------------------=
	$Ti_SHORTCUTS = GUICtrlCreateTabItem($_LNG_TABNAME[6])
	$SH_BTN_ADD = GUICtrlCreateButton('', 10, 80, 40, 40)
	$SH_BTN_EDIT = GUICtrlCreateButton('', 10, 125, 40, 40)
	$SH_BTN_DELETE = GUICtrlCreateButton('', 10, 170, 40, 40)
	$SH_BTN_DELETEALL = GUICtrlCreateButton('', 10, 215, 40, 40)
	$SH_BTN_MOVEUP = GUICtrlCreateButton('', 10, 260, 40, 40)
	$SH_BTN_MOVEDOWN = GUICtrlCreateButton('', 10, 305, 40, 40)
	$SH_LIST = GUICtrlCreateListView($_LNG_TAB_SHC[1], 55, 80, 535, 315, BitOR($LVS_SHOWSELALWAYS, $LVS_NOLABELWRAP))
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 0, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 1, 40)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 2, 120)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 3, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 4, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 5, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 6, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 7, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 8, 70)
	GUICtrlSendMsg($SH_LIST, $LVM_SETCOLUMNWIDTH, 9, 40)
	GUICtrlSetTip($SH_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($SH_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($SH_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($SH_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($SH_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($SH_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	_GUICtrlButton_SetImageList($SH_BTN_ADD, $iBtnList_large[0], 4)
	_GUICtrlButton_SetImageList($SH_BTN_EDIT, $iBtnList_large[1], 4)
	_GUICtrlButton_SetImageList($SH_BTN_DELETE, $iBtnList_large[2], 4)
	_GUICtrlButton_SetImageList($SH_BTN_DELETEALL, $iBtnList_large[3], 4)
	_GUICtrlButton_SetImageList($SH_BTN_MOVEUP, $iBtnList_large[4], 4)
	_GUICtrlButton_SetImageList($SH_BTN_MOVEDOWN, $iBtnList_large[5], 4)
	GUICtrlSetOnEvent($SH_BTN_ADD, '_TabItem_Shortcuts_Events')
	GUICtrlSetOnEvent($SH_BTN_EDIT, '_TabItem_Shortcuts_Events')
	GUICtrlSetOnEvent($SH_BTN_DELETE, '_TabItem_Shortcuts_Events')
	GUICtrlSetOnEvent($SH_BTN_DELETEALL, '_TabItem_Shortcuts_Events')
	GUICtrlSetOnEvent($SH_BTN_MOVEUP, '_TabItem_Shortcuts_Events')
	GUICtrlSetOnEvent($SH_BTN_MOVEDOWN, '_TabItem_Shortcuts_Events')
	; =--------------=
	;  SetEnvironment
	; =--------------=
	$Ti_SETENVIRONMENT = GUICtrlCreateTabItem($_LNG_TABNAME[7])
	$E_BTN_ADD = GUICtrlCreateButton('', 10, 80, 40, 40)
	$E_BTN_EDIT = GUICtrlCreateButton('', 10, 125, 40, 40)
	$E_BTN_DELETE = GUICtrlCreateButton('', 10, 170, 40, 40)
	$E_BTN_DELETEALL = GUICtrlCreateButton('', 10, 215, 40, 40)
	$E_BTN_MOVEUP = GUICtrlCreateButton('', 10, 260, 40, 40)
	$E_BTN_MOVEDOWN = GUICtrlCreateButton('', 10, 305, 40, 40)
	$E_LIST = GUICtrlCreateListView($_LNG_TAB_ENV[1], 55, 80, 535, 315, BitOR($LVS_SHOWSELALWAYS, $LVS_NOLABELWRAP))
	GUICtrlSendMsg($E_LIST, $LVM_SETCOLUMNWIDTH, 0, 150)
	GUICtrlSendMsg($E_LIST, $LVM_SETCOLUMNWIDTH, 1, 380)
	GUICtrlSetTip($E_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($E_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($E_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($E_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($E_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($E_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	_GUICtrlButton_SetImageList($E_BTN_ADD, $iBtnList_large[0], 4)
	_GUICtrlButton_SetImageList($E_BTN_EDIT, $iBtnList_large[1], 4)
	_GUICtrlButton_SetImageList($E_BTN_DELETE, $iBtnList_large[2], 4)
	_GUICtrlButton_SetImageList($E_BTN_DELETEALL, $iBtnList_large[3], 4)
	_GUICtrlButton_SetImageList($E_BTN_MOVEUP, $iBtnList_large[4], 4)
	_GUICtrlButton_SetImageList($E_BTN_MOVEDOWN, $iBtnList_large[5], 4)
	GUICtrlSetOnEvent($E_BTN_ADD, '_TabItem_Variables_Events')
	GUICtrlSetOnEvent($E_BTN_EDIT, '_TabItem_Variables_Events')
	GUICtrlSetOnEvent($E_BTN_DELETE, '_TabItem_Variables_Events')
	GUICtrlSetOnEvent($E_BTN_DELETEALL, '_TabItem_Variables_Events')
	GUICtrlSetOnEvent($E_BTN_MOVEUP, '_TabItem_Variables_Events')
	GUICtrlSetOnEvent($E_BTN_MOVEDOWN, '_TabItem_Variables_Events')
	; =--------------=
	;  Output Config
	; =--------------=
	$Ti_OUTPUT = GUICtrlCreateTabItem($_LNG_TABNAME[8])
	$O_EDIT = GUICtrlCreateEdit('', 10, 80, 580, 315, BitOR($ES_WANTRETURN, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $WS_VSCROLL, $WS_HSCROLL, $ES_READONLY))
	GUICtrlSetState($O_EDIT, $GUI_DROPACCEPTED)
	GUICtrlSetBkColor($O_EDIT, 0xFFFFFF)
;~ 	GUICtrlSetColor($O_EDIT, 0x00dd00)
	; =------------=
	;  SFX Setings
	; =------------=
	$Ti_SFX = GUICtrlCreateTabItem($_LNG_TABNAME[9])
	$S_BTN_SFX_OPTS = GUICtrlCreateButton($_LNG_TAB_SFX[3], 15, 338, 150, 50, 0x2000)
	$S_BTN_RESEDIT = GUICtrlCreateButton($_LNG_TAB_SFX[4], 175, 338, 150, 50, 0x2000)
	$S_BTN_MAKESFX = GUICtrlCreateButton($_LNG_TAB_SFX[2], 335, 338, 150, 50, 0x2000)
	$S_BTN_ARCINFO = GUICtrlCreateButton('', 462, 159, 34, 22)
	$S_BTN_SFXINFO = GUICtrlCreateButton('', 462, 204, 34, 22)
	$S_BTN_RUNSFX = GUICtrlCreateButton('', 462, 249, 34, 22)
;~ 	$S_BTN_ICNINFO = GUICtrlCreateButton('', 465, 294, 34, 22)
	$S_BTN_CONFIG = GUICtrlCreateButton('', 502, 97, 34, 22)
	$S_BTN_ARCHIVE = GUICtrlCreateButton('', 502, 159, 34, 22)
	$S_BTN_SFXMOD = GUICtrlCreateButton('', 502, 204, 34, 22)
	$S_BTN_SFXPATH = GUICtrlCreateButton('', 502, 249, 34, 22)
	$S_BTN_SFXICON = GUICtrlCreateButton('', 502, 294, 34, 22)
	$S_SEL_CONFIG = GUICtrlCreateButton('', 542, 97, 34, 22)
	$S_SEL_ARCHIVE = GUICtrlCreateButton('', 542, 159, 34, 22)
	$S_SEL_SFXMOD = GUICtrlCreateButton('', 542, 204, 34, 22)
	$S_SEL_SFXPATH = GUICtrlCreateButton('', 542, 249, 34, 22)
	$S_SEL_SFXICON = GUICtrlCreateButton('', 542, 294, 34, 22)
	$S_INP_CONFIG = GUICtrlCreateInput('', 15, 98, 480, 20)
	$S_INP_ARCHIVE = GUICtrlCreateInput('', 25, 160, 430, 20)
	$S_INP_SFXMOD = GUICtrlCreateInput('', 25, 205, 430, 20)
	$S_INP_SFXPATH = GUICtrlCreateInput('', 25, 250, 430, 20)
	$S_INP_SFXICON = GUICtrlCreateInput('', 25, 295, 470, 20)
	$S_CHK_EXTCFG = GUICtrlCreateCheckbox($_LNG_TAB_SFX[13], 150, 76, 300)
	$S_CHK_ARCHIVE = GUICtrlCreateCheckbox($_LNG_TAB_SFX[5], 150, 138, 300)
	$S_CHK_SFXMOD = GUICtrlCreateCheckbox($_LNG_TAB_SFX[5], 150, 183, 300)
	$S_CHK_SFXPATH = GUICtrlCreateCheckbox($_LNG_TAB_SFX[5], 150, 228, 300)
	$S_CHK_SFXICON = GUICtrlCreateCheckbox($_LNG_TAB_SFX[5], 150, 273, 300)
	$S_GRP_SFX_FILES = GUICtrlCreateGroup($_LNG_TAB_SFX[6], 15, 120, 570, 210)
	GUICtrlCreateGroup('', 495, 330, 90, 62)
	$S_LBL_CONFIG = GUICtrlCreateLabel($_LNG_TAB_SFX[8], 15, 77, 530)
	$S_LBL_ARCHIVE = GUICtrlCreateLabel($_LNG_TAB_SFX[9], 25, 142, 120)
	$S_LBL_SFXMOD = GUICtrlCreateLabel($_LNG_TAB_SFX[10], 25, 187, 120)
	$S_LBL_SFXPATH = GUICtrlCreateLabel($_LNG_TAB_SFX[11], 25, 232, 120)
	$S_LBL_SFXICON = GUICtrlCreateLabel($_LNG_TAB_SFX[12], 25, 277, 120)
	$S_ICO_SFX = GUICtrlCreateIcon($ScriptFPath, 0, 516, 340, 48, 48)
	GUICtrlSetImage($S_ICO_SFX, '')
	If $ModeEXTCFG = 0 Then
		GUICtrlSetState($S_INP_CONFIG, $GUI_DISABLE)
		GUICtrlSetState($S_SEL_CONFIG, $GUI_DISABLE)
	EndIf
	If $USE_DEFMOD[0] = 1 Then
		GUICtrlSetState($S_INP_SFXMOD, $GUI_DISABLE)
		GUICtrlSetState($S_SEL_SFXMOD, $GUI_DISABLE)
	EndIf
	_GUICtrlButton_SetImageList($S_BTN_ARCINFO, $iBtnList_small[1], 4)
	_GUICtrlButton_SetImageList($S_BTN_SFXINFO, $iBtnList_small[0], 4)
	_GUICtrlButton_SetImageList($S_BTN_RUNSFX, $iBtnList_small[13], 4)
;~ 	_GUICtrlButton_SetImageList($S_BTN_ICNINFO, $iBtnList_small[0], 4)
	_GUICtrlButton_SetImageList($S_SEL_CONFIG, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($S_SEL_ARCHIVE, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($S_SEL_SFXMOD, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($S_SEL_SFXPATH, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($S_SEL_SFXICON, $iBtnList_small[3], 4)
	_GUICtrlButton_SetImageList($S_BTN_CONFIG, $iBtnList_small[4], 4)
	_GUICtrlButton_SetImageList($S_BTN_ARCHIVE, $iBtnList_small[4], 4)
	_GUICtrlButton_SetImageList($S_BTN_SFXMOD, $iBtnList_small[4], 4)
	_GUICtrlButton_SetImageList($S_BTN_SFXPATH, $iBtnList_small[4], 4)
	_GUICtrlButton_SetImageList($S_BTN_SFXICON, $iBtnList_small[4], 4)
	GUICtrlSetTip($S_SEL_CONFIG, $_LNG_GLOBAL[17])
	GUICtrlSetTip($S_SEL_ARCHIVE, $_LNG_GLOBAL[17])
	GUICtrlSetTip($S_SEL_SFXMOD, $_LNG_GLOBAL[17])
	GUICtrlSetTip($S_SEL_SFXPATH, $_LNG_GLOBAL[17])
	GUICtrlSetTip($S_SEL_SFXICON, $_LNG_GLOBAL[17])
	GUICtrlSetTip($S_BTN_CONFIG, $_LNG_GLOBAL[18])
	GUICtrlSetTip($S_BTN_ARCHIVE, $_LNG_GLOBAL[18])
	GUICtrlSetTip($S_BTN_SFXPATH, $_LNG_GLOBAL[18])
	GUICtrlSetTip($S_BTN_SFXMOD, $_LNG_GLOBAL[18])
	GUICtrlSetTip($S_BTN_SFXICON, $_LNG_GLOBAL[18])
	GUICtrlSetOnEvent($S_BTN_ARCINFO, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_SFXINFO, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_RUNSFX, '_MainGUI_Control_Events')
;~ 	GUICtrlSetOnEvent($S_BTN_ICNINFO, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_SEL_CONFIG, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_SEL_ARCHIVE, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_SEL_SFXMOD, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_SEL_SFXPATH, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_SEL_SFXICON, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_CONFIG, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_ARCHIVE, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_SFXMOD, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_SFXPATH, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_SFXICON, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_RESEDIT, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_SFX_OPTS, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_CHK_EXTCFG, '_MainGUI_Control_Events')
	GUICtrlSetOnEvent($S_BTN_MAKESFX, '_GUI_Make_SFX')
	; ----------------------------------------
	GUICtrlSetState($Ti_MAIN, $GUI_SHOW)
	#Region End --- TabItems
	; Close TabItem definition
	GUICtrlCreateTabItem('')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit')
	GUISetOnEvent($GUI_EVENT_DROPPED, '_DragNDrop')
	If Not @Compiled Then ConsoleWrite('MAIN GUI LOAD TIME = ' & TimerDiff($LaunchTimer) - $MainTimer & @CRLF)
;~ 	Check for command line options
	If $CmdLine[0] > 0 Then
		If $CmdLine[1] <> '' Then
			_FileLoad($CmdLine[1])
			If @error <> 0 Then
				_ClearImageList()
				_ClearTemp(3)
				Exit
			EndIf
			GUICtrlSetState($Ti_SFX, $GUI_SHOW)
		EndIf
	EndIf
	If $UseFONT Then _Set_Font_Main()
	_Update()
	$last_saved = $BuiltCONFIG[1]

	GUISetState(@SW_SHOW, $GUI_MAIN)
	GUIRegisterMsg($WM_NOTIFY, '_WM_NOTIFY')
	If Not @Compiled Then ConsoleWrite('LAUNCH TIME = ' & TimerDiff($LaunchTimer) & @CRLF)

	While 1
		Sleep(10)
	WEnd
EndFunc   ;==>_Main
Func _Set_Font_Main()
	GUICtrlSetFont($TAB_MAIN, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_INSTPATH, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_GUIFLAGS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_MISCFLAGS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_BPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_XDWidth, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_XPWidth, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_INP_VOLNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_TEMPMODE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_SKIPLOCKED, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_SELFDELETE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_BPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_XDWidth, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_XPWidth, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_CHK_VOLNAME, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_OMode[1], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_OMode[2], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_OMode[3], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_GMode[1], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_GMode[2], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_RAD_GMode[3], $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_GRP_OW_MODE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_GRP_GUI_MODE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_LBL_EXT_PATH, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($M_LBL_GF, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_GRP_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_GRP_TEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_EXT_PATH_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_EXT_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_ERR_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_WARN_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_PSWD_TITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_PSWD_TEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_LBL_CANCEL_TEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_BEGINPROMPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_XPATHTEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_XDIALOGTEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_FINISHMSG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_CANCELPROMPT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_HELPTEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($MS_BTN_TEST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_LIST, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_ADD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_EDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_DELETE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_DELETEALL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_MOVEUP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($R_BTN_MOVEDOWN, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_ADD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_EDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_DELETE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_DELETEALL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_MOVEUP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($D_BTN_MOVEDOWN, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_ADD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_EDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_DELETE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_DELETEALL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_MOVEUP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($SH_BTN_MOVEDOWN, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_ADD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_EDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_DELETE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_DELETEALL, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_MOVEUP, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($E_BTN_MOVEDOWN, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($O_EDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_BTN_MAKESFX, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_BTN_SFX_OPTS, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_BTN_RESEDIT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_CHK_EXTCFG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_CHK_ARCHIVE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_CHK_SFXMOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_CHK_SFXPATH, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_CHK_SFXICON, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_GRP_SFX_FILES, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_LBL_CONFIG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_LBL_ARCHIVE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_LBL_SFXMOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_LBL_SFXPATH, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_LBL_SFXICON, $Font[1], '', '', $Font[0])
	; input controls
	GUICtrlSetFont($T_INP_WINTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_XPATHWINTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_XTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_ERRORTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_WARNTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_PASSWDTITLE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_PASSWDTEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($T_INP_XCANCELTEXT, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_INP_CONFIG, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_INP_ARCHIVE, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_INP_SFXMOD, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_INP_SFXPATH, $Font[1], '', '', $Font[0])
	GUICtrlSetFont($S_INP_SFXICON, $Font[1], '', '', $Font[0])
EndFunc   ;==>_Set_Font_Main
; ***********************************************************
; ------------------------- UPDATE -------------------------*
; ***********************************************************
Func _Update($iMode = 0)
	Local $uInstPath = ''
	Local $uGF = ''
	Local $uMF = ''
	Local $uGM = ''
	Local $uOM = ''
	Local $SkipLocked = ''
	Local $uSelfDel = ''
	Local $uBPT = ''
	Local $uXDW = ''
	Local $uXPW = ''
	Local $uVNS = ''
	Local $uTT[9] = ['', '', '', '', '', '', '', '', '']
	Local $uDLG[7] = ['', '', '', '', '', '', '']
	Local $uEXC = ''
	Local $uRUN = ''
	Local $uDEL = ''
	Local $uSHC = ''
	Local $uENV = ''
	Local $uArchive = ''
	Local $uSFXMod = ''
	Local $uEXEName = ''
	Local $uEXEIcon = ''
	Local $uDefMod = ''
	Local $uUPX = ''
	Local $uVersionInfo = ''
	Local $uSFXFiles = ''
	Local $u7Zip = ''
	Local $uSplit
	Local $uQuote[2]
	Local $uMain
	Local $uExtra
	Local $uLSTCNT
	Local $uComment[2] = [';Config file generated by ' & $NameAPP & ' v' & $VersAPP & '. (' & $SiteAPP & ')', ';This SFX archive was created with ' & $NameAPP & ' v' & $VersAPP & '. (' & $SiteAPP & ')']
	GUICtrlSetData($INP_CUR_FILE, $CurFile)
	_FindCurMod()
	; ****************************************************************************
	;   InstPath | GuiFlags | MiscFlags | GUIMode| OverwriteMode  | SelfDelete   *
	; ****************************************************************************
	If GUICtrlRead($M_RAD_GMode[1]) = 1 Then
		$GuiMode = '0'
	ElseIf GUICtrlRead($M_RAD_GMode[2]) = 1 Then
		$GuiMode = '1'
	ElseIf GUICtrlRead($M_RAD_GMode[3]) = 1 Then
		$GuiMode = '2'
	EndIf
	If GUICtrlRead($M_RAD_OMode[1]) = 1 Then
		$OverWriteMode = '0'
	ElseIf GUICtrlRead($M_RAD_OMode[2]) = 1 Then
		$OverWriteMode = '1'
	ElseIf GUICtrlRead($M_RAD_OMode[3]) = 1 Then
		$OverWriteMode = '2'
	EndIf
	If GUICtrlRead($M_CHK_TEMPMODE) = $GUI_UNCHECKED And GUICtrlRead($M_INP_INSTPATH) <> '' Then $uInstPath = @CRLF & 'InstallPath="' & _FormatPathData(GUICtrlRead($M_INP_INSTPATH)) & '"'
	If GUICtrlRead($M_INP_GUIFLAGS) <> '' Then $uGF = @CRLF & 'GUIFlags="' & GUICtrlRead($M_INP_GUIFLAGS) & '"'
	If GUICtrlRead($M_INP_MISCFLAGS) <> '' Then $uMF = @CRLF & 'MiscFlags="' & GUICtrlRead($M_INP_MISCFLAGS) & '"'
	If GUICtrlRead($M_CHK_SKIPLOCKED) = 1 Then $SkipLocked = '+8'
	If $OverWriteMode <> '0' Then $uOM = @CRLF & 'OverwriteMode="' & $OverWriteMode & $SkipLocked & '"'
	If $OverWriteMode = '0' And $SkipLocked <> '' Then $uOM = @CRLF & 'OverwriteMode="8"'
	If $GuiMode <> '0' Then $uGM = @CRLF & 'GUIMode="' & $GuiMode & '"'
	If GUICtrlRead($M_CHK_SELFDELETE) = 1 Then $uSelfDel = @CRLF & 'SelfDelete="1"'
	; ************************************************************************************
	;   BeginPromptTimeout | ExtractDialogWidth | ExtractDialogWidth | VolumeNameStyle   *
	; ************************************************************************************
	If GUICtrlRead($M_CHK_BPT) = $GUI_CHECKED And StringIsInt(GUICtrlRead($M_INP_BPT)) Then
		$uBPT = @CRLF & 'BeginPromptTimeout="' & GUICtrlRead($M_INP_BPT) & '"'
	EndIf
	If GUICtrlRead($M_CHK_XDWidth) = $GUI_CHECKED And StringIsDigit(GUICtrlRead($M_INP_XDWidth)) Then
		$uXDW = @CRLF & 'ExtractDialogWidth="' & GUICtrlRead($M_INP_XDWidth) & '"'
	EndIf
	If GUICtrlRead($M_CHK_XPWidth) = $GUI_CHECKED And StringIsDigit(GUICtrlRead($M_INP_XPWidth)) Then
		$uXPW = @CRLF & 'ExtractPathWidth="' & GUICtrlRead($M_INP_XPWidth) & '"'
	EndIf
	If GUICtrlRead($M_CHK_VOLNAME) = $GUI_CHECKED And (GUICtrlRead($M_INP_VOLNAME) = 0 Or GUICtrlRead($M_INP_VOLNAME) = 1) Then
		$uVNS = @CRLF & 'VolumeNameStyle="' & GUICtrlRead($M_INP_VOLNAME) & '"'
	EndIf
	; ***************************************************************************************************************************
	;  Title | ExtractPathTitle | ExtractTitle | ErrorTitle | WarningTitle | PasswordTitle | PasswordText | ExtractCancelText   *
	; ***************************************************************************************************************************
	If GUICtrlRead($T_INP_WINTITLE) <> '' Then $uTT[1] = @CRLF & 'Title="' & GUICtrlRead($T_INP_WINTITLE) & '"'
	If GUICtrlRead($T_INP_XPATHWINTITLE) <> '' Then $uTT[2] = @CRLF & 'ExtractPathTitle="' & GUICtrlRead($T_INP_XPATHWINTITLE) & '"'
	If GUICtrlRead($T_INP_XTITLE) <> '' Then $uTT[3] = @CRLF & 'ExtractTitle="' & GUICtrlRead($T_INP_XTITLE) & '"'
	If GUICtrlRead($T_INP_ERRORTITLE) <> '' Then $uTT[4] = @CRLF & 'ErrorTitle="' & GUICtrlRead($T_INP_ERRORTITLE) & '"'
	If GUICtrlRead($T_INP_WARNTITLE) <> '' Then $uTT[5] = @CRLF & 'WarningTitle="' & GUICtrlRead($T_INP_WARNTITLE) & '"'
	If GUICtrlRead($T_INP_PASSWDTITLE) <> '' Then $uTT[6] = @CRLF & 'PasswordTitle="' & GUICtrlRead($T_INP_PASSWDTITLE) & '"'
	If GUICtrlRead($T_INP_PASSWDTEXT) <> '' Then $uTT[7] = @CRLF & 'PasswordText="' & GUICtrlRead($T_INP_PASSWDTEXT) & '"'
	If GUICtrlRead($T_INP_XCANCELTEXT) <> '' Then $uTT[8] = @CRLF & 'ExtractCancelText="' & GUICtrlRead($T_INP_XCANCELTEXT) & '"'
	$uTT[0] = $uTT[2] & $uTT[3] & $uTT[4] & $uTT[5] & $uTT[6] & $uTT[7] & $uTT[8]
	; *************************************************************************************************
	;   BeginPrompt | ExtractPathText | ExtractDialogText | FinishMessage | CancelPrompt | HelpText   *
	; *************************************************************************************************
	$MS_VALUES[1] = GUICtrlRead($MS_EDT_MESSAGES[1])
	$MS_VALUES[2] = GUICtrlRead($MS_EDT_MESSAGES[2])
	$MS_VALUES[3] = GUICtrlRead($MS_EDT_MESSAGES[3])
	$MS_VALUES[4] = GUICtrlRead($MS_EDT_MESSAGES[4])
	$MS_VALUES[5] = GUICtrlRead($MS_EDT_MESSAGES[5])
	$MS_VALUES[6] = GUICtrlRead($MS_EDT_MESSAGES[6])
	If $MS_VALUES[1] <> '' Then $uDLG[1] = @CRLF & 'BeginPrompt="' & $MS_VALUES[1] & '"'
	If $MS_VALUES[2] <> '' Then $uDLG[2] = @CRLF & 'ExtractPathText="' & $MS_VALUES[2] & '"'
	If $MS_VALUES[3] <> '' Then $uDLG[3] = @CRLF & 'ExtractDialogText="' & $MS_VALUES[3] & '"'
	If $MS_VALUES[4] <> '' Then $uDLG[4] = @CRLF & 'CancelPrompt="' & $MS_VALUES[4] & '"'
	If $MS_VALUES[5] <> '' Then $uDLG[5] = @CRLF & 'FinishMessage="' & $MS_VALUES[5] & '"'
	If $MS_VALUES[6] <> '' Then $uDLG[6] = @CRLF & 'HelpText="' & $MS_VALUES[6] & '"'
	$uDLG[0] = $uDLG[1] & $uDLG[2] & $uDLG[3] & $uDLG[4] & $uDLG[5] & $uDLG[6] & $uBPT & $uXDW & $uXPW
	; *************************************************************
	;   RunProgram | AutoInstall | AutoInstall(X) | ExecuteFile   *
	; *************************************************************
	Dim $uLSTCNT = _GUICtrlListView_GetItemCount($R_LIST)
	If $uLSTCNT > 0 Then
		For $_r = 0 To $uLSTCNT - 1
			Dim $uQuote[2] = ['\"', '\"']
			Dim $uSplit = StringSplit(_GUICtrlListView_GetItemTextString($R_LIST, $_r), '|')
			If Not @error Then
				$uSplit[3] = _FormatPathData($uSplit[3])
				If $uSplit[4] <> '' Then $uQuote[1] = '\" '
				If $uSplit[5] = 'False' Then
					$uQuote[0] = ''
					$uQuote[1] = ''
					If $uSplit[4] <> '' Then $uQuote[1] = ' '
				EndIf
				If $uSplit[1] = 'ExecuteFile' Then
					$uEXC &= @CRLF & 'ExecuteFile="' & $uSplit[3] & '"' & @CRLF & 'ExecuteParameters="' & $uSplit[4] & '"'
				Else
					$uRUN &= @CRLF & $uSplit[1] & '="' & $uSplit[2] & $uQuote[0] & $uSplit[3] & $uQuote[1] & $uSplit[4] & '"'
				EndIf
			EndIf
		Next
	EndIf
	; ************************
	;   Delete | Delete(X)   *
	; ************************
	Dim $uLSTCNT = _GUICtrlListView_GetItemCount($D_LIST)
	If $uLSTCNT > 0 Then
		For $_d = 0 To $uLSTCNT - 1
			Dim $uQuote[2] = ['="\"', '\""']
			Dim $uSplit = StringSplit(_GUICtrlListView_GetItemTextString($D_LIST, $_d), '|')
			If Not @error Then
				If $uSplit[3] = 'False' Then
					$uQuote[0] = '="'
					$uQuote[1] = '"'
				EndIf
				$uSplit[2] = _FormatPathData($uSplit[2])
				$uDEL &= @CRLF & $uSplit[1] & $uQuote[0] & $uSplit[2] & $uQuote[1]
			EndIf
		Next
	EndIf
	; ***************
	;   Variables   *
	; ***************
	Dim $uLSTCNT = _GUICtrlListView_GetItemCount($E_LIST)
	If $uLSTCNT > 0 Then
		For $_v = 0 To $uLSTCNT - 1
			Dim $uSplit = StringSplit(_GUICtrlListView_GetItemTextString($E_LIST, $_v), '|')
			If Not @error Then
				$uENV &= @CRLF & 'SetEnvironment="' & $uSplit[1] & '=' & $uSplit[2] & '"'
			EndIf
		Next
	EndIf
	; ****************************
	;   Shortcut | Shortcut(X)   *
	; ****************************
	Dim $uLSTCNT = _GUICtrlListView_GetItemCount($SH_LIST)
	If $uLSTCNT > 0 Then
		For $_sh = 0 To $uLSTCNT - 1
			Dim $uSplit = StringSplit(_GUICtrlListView_GetItemTextString($SH_LIST, $_sh), '|')
			If Not @error Then
				$uSplit[3] = _FormatPathData($uSplit[3])
				$uSplit[5] = _FormatPathData($uSplit[5])
				$uSplit[8] = _FormatPathData($uSplit[8])
				$uSplit[9] = _FormatPathData($uSplit[9])
				$uSHC &= @CRLF & $uSplit[1] & '="' & $uSplit[2] & ',{' & $uSplit[3] & '},{' & $uSplit[4] & '},{' & $uSplit[5] & '},{' & $uSplit[6] & '},{' & $uSplit[7] & '},{' & $uSplit[8] & '},{' & $uSplit[9] & '},{' & $uSplit[10] & '}"'
			EndIf
		Next
	EndIf
	;Shortcut="Du,{%%T\\source},{commands},{folder},{decription},{name},{workingdir},{iconfile},{iconindex}"
	; *****************
	;   Extra Lines   *
	; *****************
	If GUICtrlRead($S_INP_ARCHIVE) <> '' And GUICtrlRead($S_CHK_ARCHIVE) = 1 Then $uArchive = @CRLF & '7zSFXBuilder_7zArchive=' & GUICtrlRead($S_INP_ARCHIVE)
	If GUICtrlRead($S_INP_SFXMOD) <> '' And GUICtrlRead($S_CHK_SFXMOD) = 1 Then $uSFXMod = @CRLF & '7zSFXBuilder_SFXModule=' & GUICtrlRead($S_INP_SFXMOD)
	If GUICtrlRead($S_INP_SFXPATH) <> '' And GUICtrlRead($S_CHK_SFXPATH) = 1 Then $uEXEName = @CRLF & '7zSFXBuilder_SFXName=' & GUICtrlRead($S_INP_SFXPATH)
	If GUICtrlRead($S_INP_SFXICON) <> '' And GUICtrlRead($S_CHK_SFXICON) = 1 Then $uEXEIcon = @CRLF & '7zSFXBuilder_SFXIcon=' & GUICtrlRead($S_INP_SFXICON)
	If $USE_DEFMOD[0] = 1 Then $uDefMod = @CRLF & '7zSFXBuilder_UseDefMod=' & $USE_DEFMOD[1]
	If $USE_UPX[0] = 1 Then $uUPX = @CRLF & '7zSFXBuilder_UPXCommands=' & $USE_UPX[1]
	If $ModeINCLUDERES Then
		$uVersionInfo = @CRLF & '7zSFXBuilder_Res_FileVersion=' & $vFileVersion & _
				@CRLF & '7zSFXBuilder_Res_CompanyName=' & $vCompanyName & _
				@CRLF & '7zSFXBuilder_Res_Comments=' & $vComments & _
				@CRLF & '7zSFXBuilder_Res_FileDescription=' & $vFileDescription & _
				@CRLF & '7zSFXBuilder_Res_ProductVersion=' & $vProductVersion & _
				@CRLF & '7zSFXBuilder_Res_ProductName=' & $vProductName & _
				@CRLF & '7zSFXBuilder_Res_LegalCopyright=' & $vLegalCopyright & _
				@CRLF & '7zSFXBuilder_Res_LegalTrademarks=' & $vLegalTrademarks & _
				@CRLF & '7zSFXBuilder_Res_InternalName=' & $vInternalName & _
				@CRLF & '7zSFXBuilder_Res_OriginalFileName=' & $vOriginalFileName & _
				@CRLF & '7zSFXBuilder_Res_SpecialBuild=' & $vSpecialBuild & _
				@CRLF & '7zSFXBuilder_Res_PrivateBuild=' & $vPrivateBuild
	EndIf
	If $FilesToArc[0] > 0 Then
		For $c = 1 To $FilesToArc[0]
			$uSFXFiles &= @CRLF & '7zSFXBuilder_SFXFile_' & $c & '=' & $FilesToArc[$c]
		Next
	EndIf
	If $FilesToArc[0] > 0 Then
		$u7Zip &= @CRLF & '7zSFXBuilder_7Zip_Level=' & $7z_LVL[0]
		$u7Zip &= @CRLF & '7zSFXBuilder_7Zip_Method=' & $7z_METHOD[0]
		$u7Zip &= @CRLF & '7zSFXBuilder_7Zip_Dictionary=' & $7z_DICT[0]
		$u7Zip &= @CRLF & '7zSFXBuilder_7Zip_BlockSize=' & $7z_SOLID[0]
	EndIf
	$uMain = $uENV & $uInstPath & $uTT[1] & $uDLG[0] & $uGM & $uGF & $uMF & $uOM & $uSelfDel & $uTT[0] & $uEXC & $uRUN & $uDEL & $uSHC & $uVNS
	If $uMain = '' Then
		$uDefMod = ''
		$uUPX = ''
	EndIf
	$uExtra = $uArchive & $uSFXMod & $uEXEName & $uEXEIcon & $uDefMod & $uUPX & $uVersionInfo & $uSFXFiles & $u7Zip
	; ************
	;   RESULT   *
	; ************
	$BuiltCONFIG[0] = ';!@Install@!UTF-8!' & $uMain & @CRLF
	If $iMode = 0 Then
		$BuiltCONFIG[0] &= $uComment[0] & @CRLF & ';!@InstallEnd@!'
	Else
		$BuiltCONFIG[0] &= $uComment[1] & @CRLF & ';!@InstallEnd@!'
	EndIf
	$BuiltCONFIG[1] = $BuiltCONFIG[0] & $uExtra
	GUICtrlSetData($O_EDIT, $BuiltCONFIG[1])
	$LineCOUNT = StringSplit($BuiltCONFIG[1], @CR)
EndFunc   ;==>_Update
; *****************************************************
; 					CONTROL EVENTS
; *****************************************************
Func _WM_NOTIFY($hWndGUI, $MsgID, $wParam, $lParam)
	Local $tNMHDR, $hwndFrom, $code, $i_idNew, $dwFlags, $i_idOld
	Local $tNMTBHOTITEM
	Local $tip_Info, $tip_ID, $tip_code

	$tip_Info = DllStructCreate($tagNMTTDISPINFO, $lParam)
	$tip_code = DllStructGetData($tip_Info, "Code")

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hwndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	$code = DllStructGetData($tNMHDR, "Code")
	If $hwndFrom = $hToolbar Then
		Switch $code
			Case $NM_LDOWN
				Switch $iItem
					Case $id_Open
						_FileOpenDialog()
					Case $id_Save
						_CFG_Save()
					Case $id_SaveAs
						_CFG_SaveAs()
					Case $id_Close
						_FileCloseDialog()
					Case $id_Test
						_ShowMenu_Toolbar($GUI_MAIN, $id_Test, $c_Menu_Test)
					Case $id_Preset
						_ShowMenu_Toolbar($GUI_MAIN, $id_Preset, $c_Menu_Preset)
					Case $id_MakeSFX
						_GUI_Make_SFX()
					Case $id_Opts
						$cPos = WinGetPos($GUI_MAIN)
						GUISetState(@SW_DISABLE, $GUI_MAIN)
						_GUI_Options()
				EndSwitch
				$iItem = 0
			Case $TBN_HOTITEMCHANGE
				$tNMTBHOTITEM = DllStructCreate($tagNMTBHOTITEM, $lParam)
				$i_idOld = DllStructGetData($tNMTBHOTITEM, "idOld")
				$i_idNew = DllStructGetData($tNMTBHOTITEM, "idNew")
				$iItem = $i_idNew
				$dwFlags = DllStructGetData($tNMTBHOTITEM, "dwFlags")
		EndSwitch
	EndIf
	If $tip_code = $TTN_GETDISPINFOW Then
		$tip_ID = DllStructGetData($tip_Info, "IDFrom")
		Switch $tip_ID
			Case $id_Open
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[1])
			Case $id_Save
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[2])
			Case $id_SaveAs
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[3])
			Case $id_Close
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[4])
			Case $id_Test
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[5])
			Case $id_Preset
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[6])
			Case $id_MakeSFX
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[7])
			Case $id_Opts
				DllStructSetData($tip_Info, "aText", $_LNG_TOOLBAR[8])
		EndSwitch
	EndIf
EndFunc   ;==>_WM_NOTIFY
Func _MainGUI_Control_Events()
	Switch @GUI_CtrlId
		Case $BTN_CFG_OPEN
			Local $cfgPath = GUICtrlRead($INP_CUR_FILE)
			If $cfgPath = '' Then
				_MsgBoxEx(39)
				Return
			ElseIf Not FileExists($cfgPath) Then
				_MsgBoxEx(12)
				Return
			EndIf
			ShellExecute($cfgPath)
		Case $BTN_CFG_RELOAD
			If Not FileExists($CurFile) Then
				_MsgBoxEx(13)
				Return
			EndIf
			$iMsgBoxAnswer = _MsgBoxEx(110)
			If $iMsgBoxAnswer = 7 Then Return
			_CFG_Load($CurFile)
		Case $M_BTN_GUIFLAGS
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_GMFlags()
		Case $M_CHK_BPT
			If GUICtrlRead($M_CHK_BPT) = $GUI_CHECKED Then
				GUICtrlSetState($M_INP_BPT, $GUI_ENABLE)
			Else
				GUICtrlSetState($M_INP_BPT, $GUI_DISABLE)
			EndIf
			GUISetState(@SW_UNLOCK, $GUI_MAIN)
		Case $M_CHK_XDWidth
			If GUICtrlRead($M_CHK_XDWidth) = $GUI_CHECKED Then
				GUICtrlSetState($M_INP_XDWidth, $GUI_ENABLE)
			Else
				GUICtrlSetState($M_INP_XDWidth, $GUI_DISABLE)
			EndIf
			GUISetState(@SW_UNLOCK, $GUI_MAIN)
		Case $M_CHK_XPWidth
			If GUICtrlRead($M_CHK_XPWidth) = $GUI_CHECKED Then
				GUICtrlSetState($M_INP_XPWidth, $GUI_ENABLE)
			Else
				GUICtrlSetState($M_INP_XPWidth, $GUI_DISABLE)
			EndIf
			GUISetState(@SW_UNLOCK, $GUI_MAIN)
		Case $M_CHK_VOLNAME
			If GUICtrlRead($M_CHK_VOLNAME) = $GUI_CHECKED Then
				GUICtrlSetState($M_INP_VOLNAME, $GUI_ENABLE)
			Else
				GUICtrlSetState($M_INP_VOLNAME, $GUI_DISABLE)
			EndIf
			GUISetState(@SW_UNLOCK, $GUI_MAIN)
		Case $S_BTN_SFX_OPTS
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_SFX_Options()
		Case $S_BTN_RESEDIT
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_EditVersion()
			If $ModeRESCHANGE = 1 Then GUICtrlSetState($RES_CHK_USE, 1)
			If $ModeINCLUDERES Then GUICtrlSetState($RES_CHK_INCLUDE, 1)
			GUICtrlSetData($RES_INP_FILEVERS, $vFileVersion)
			GUICtrlSetData($RES_INP_COMPNAME, $vCompanyName)
			GUICtrlSetData($RES_INP_COMMENTS, $vComments)
			GUICtrlSetData($RES_INP_FILEDESC, $vFileDescription)
			GUICtrlSetData($RES_INP_PRODUCTVERS, $vProductVersion)
			GUICtrlSetData($RES_INP_PRODUCTNAME, $vProductName)
			GUICtrlSetData($RES_INP_COPYRIGHT, $vLegalCopyright)
			GUICtrlSetData($RES_INP_TRADEMARK, $vLegalTrademarks)
			GUICtrlSetData($RES_INP_INTNAME, $vInternalName)
			GUICtrlSetData($RES_INP_ORIGNAME, $vOriginalFileName)
			GUICtrlSetData($RES_INP_SPECIALBUILD, $vSpecialBuild)
			GUICtrlSetData($RES_INP_PRIVBUILD, $vPrivateBuild)
		Case $S_BTN_CONFIG
			If FileExists(GUICtrlRead($S_INP_CONFIG)) Then _
					Run(@WindowsDir & '\explorer.exe /select, "' & GUICtrlRead($S_INP_CONFIG) & '"')
		Case $S_BTN_ARCHIVE
			If FileExists(GUICtrlRead($S_INP_ARCHIVE)) Then _
					Run(@WindowsDir & '\explorer.exe /select, "' & GUICtrlRead($S_INP_ARCHIVE) & '"')
		Case $S_BTN_SFXMOD
			If FileExists(GUICtrlRead($S_INP_SFXMOD)) Then _
					Run(@WindowsDir & '\explorer.exe /select, "' & GUICtrlRead($S_INP_SFXMOD) & '"')
		Case $S_BTN_SFXPATH
			If FileExists(GUICtrlRead($S_INP_SFXPATH)) Then _
					Run(@WindowsDir & '\explorer.exe /select, "' & GUICtrlRead($S_INP_SFXPATH) & '"')
		Case $S_BTN_SFXICON
			If FileExists(GUICtrlRead($S_INP_SFXICON)) Then _
					Run(@WindowsDir & '\explorer.exe /select, "' & GUICtrlRead($S_INP_SFXICON) & '"')
		Case $S_CHK_EXTCFG
			If GUICtrlRead($S_CHK_EXTCFG) = 1 Then
				$ModeEXTCFG = 1
				GUICtrlSetState($S_INP_CONFIG, $GUI_ENABLE)
				GUICtrlSetState($S_SEL_CONFIG, $GUI_ENABLE)
			Else
				$ModeEXTCFG = 0
				GUICtrlSetState($S_INP_CONFIG, $GUI_DISABLE)
				GUICtrlSetState($S_SEL_CONFIG, $GUI_DISABLE)
			EndIf
		Case $M_CHK_TEMPMODE
			If GUICtrlRead($M_CHK_TEMPMODE) = $GUI_CHECKED Then
				GUICtrlSetState($M_INP_INSTPATH, $GUI_DISABLE)
				GUICtrlSetState($M_BTN_INSTPATH, $GUI_DISABLE)
			Else
				GUICtrlSetState($M_INP_INSTPATH, $GUI_ENABLE)
				GUICtrlSetState($M_BTN_INSTPATH, $GUI_ENABLE)
			EndIf
		Case $S_BTN_ARCINFO
			_GUI_ArcInfo()
		Case $S_BTN_SFXINFO
			Local $sfxPath = GUICtrlRead($S_INP_SFXMOD)
			If $sfxPath = '' Then
				_MsgBoxEx(39)
				Return
			ElseIf Not FileExists($sfxPath) Then
				_MsgBoxEx(12)
				Return
			EndIf
			_SFX_Info($sfxPath, $GUI_MAIN)
		Case $S_BTN_RUNSFX
			Local $exePath = GUICtrlRead($S_INP_SFXPATH)
			If $exePath = '' Then
				_MsgBoxEx(39)
				Return
			ElseIf Not FileExists($exePath) Then
				_MsgBoxEx(12)
				Return
			EndIf
			Run($exePath)
;~ 		Case $S_BTN_ICNINFO
;~ 			_IconInfo()
		Case $S_SEL_CONFIG
			$Dlg_CONFIG = FileOpenDialog('Select configuration file:', StringLeft(GUICtrlRead($S_INP_CONFIG), StringInStr(GUICtrlRead($S_INP_CONFIG), '\', '', -1)), 'Text files (*.txt)|All files (*.*)', 3, '', $GUI_MAIN)
			If @error Then Return
			GUICtrlSetData($S_INP_CONFIG, $Dlg_CONFIG)
		Case $S_SEL_ARCHIVE
			$Dlg_ARCHIVE = FileOpenDialog('Select 7z Archive:', StringLeft(GUICtrlRead($S_INP_ARCHIVE), StringInStr(GUICtrlRead($S_INP_ARCHIVE), '\', '', -1)), '7z archives (*.7z; *.001)', 3, '', $GUI_MAIN)
			If @error Then Return
			GUICtrlSetData($S_INP_ARCHIVE, $Dlg_ARCHIVE)
			GUICtrlSetState($S_CHK_ARCHIVE, $GUI_CHECKED)
		Case $S_SEL_SFXMOD
			$Dlg_SFXMOD = FileOpenDialog('Select SFX module:', StringLeft(GUICtrlRead($S_INP_SFXMOD), StringInStr(GUICtrlRead($S_INP_SFXMOD), '\', '', -1)), 'SFX modules (*.sfx)', 3, '', $GUI_MAIN)
			If @error Then Return
			GUICtrlSetData($S_INP_SFXMOD, $Dlg_SFXMOD)
			GUICtrlSetState($S_CHK_SFXMOD, $GUI_CHECKED)
		Case $S_SEL_SFXPATH
			$Dlg_SFXPATH = FileSaveDialog('Select SFX name:', StringLeft(GUICtrlRead($S_INP_SFXPATH), StringInStr(GUICtrlRead($S_INP_SFXPATH), '\', '', -1)), 'Executable files (*.exe)', 16, StringTrimLeft(GUICtrlRead($S_INP_SFXPATH), StringInStr(GUICtrlRead($S_INP_SFXPATH), '\', '', -1)), $GUI_MAIN)
			If @error Then Return
			If StringRight($Dlg_SFXPATH, 4) <> '.exe' Then
				GUICtrlSetData($S_INP_SFXPATH, $Dlg_SFXPATH & '.exe')
			Else
				GUICtrlSetData($S_INP_SFXPATH, $Dlg_SFXPATH)
			EndIf
			GUICtrlSetState($S_CHK_SFXPATH, $GUI_CHECKED)
		Case $S_SEL_SFXICON
			$Dlg_SFXICON = FileOpenDialog('Select SFX name:', StringLeft(GUICtrlRead($S_INP_SFXICON), StringInStr(GUICtrlRead($S_INP_SFXICON), '\', '', -1)), 'Icon files (*.ico)', 3, '', $GUI_MAIN)
			If @error Then Return
			GUICtrlSetData($S_INP_SFXICON, $Dlg_SFXICON)
			GUICtrlSetImage($S_ICO_SFX, $Dlg_SFXICON)
			GUICtrlSetState($S_CHK_SFXICON, $GUI_CHECKED)
	EndSwitch
EndFunc   ;==>_MainGUI_Control_Events
Func _MenuItem_Control_Events()
	Select
		Case @GUI_CtrlId = $Mi_RELOAD
			If Not FileExists($CurFile) Then
				_MsgBoxEx(13)
				Return
			EndIf
			$iMsgBoxAnswer = _MsgBoxEx(110)
			If $iMsgBoxAnswer = 7 Then Return
			_CFG_Load($CurFile)
		Case @GUI_CtrlId = $Mi_BP
			_Test(1)
		Case @GUI_CtrlId = $Mi_XPT
			_Test(2)
		Case @GUI_CtrlId = $Mi_XD
			_Test(3)
		Case @GUI_CtrlId = $Mi_CP
			_Test(6)
		Case @GUI_CtrlId = $Mi_FM
			_Test(4)
		Case @GUI_CtrlId = $Mi_HT
			_Test(5)
		Case @GUI_CtrlId = $Mi_CLEAR
			_MRU_Clear(True)
		Case @GUI_CtrlId = $Mi_OPTS
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_Options()
		Case @GUI_CtrlId = $Mi_HELPEN
			ShellExecute(@ScriptDir & '\7zSD_EN.chm')
		Case @GUI_CtrlId = $Mi_HELPRU
			ShellExecute(@ScriptDir & '\7zSD_RU.chm')
		Case @GUI_CtrlId = $Mi_PSITE
			_GotoWebPage('http://sourceforge.net/projects/s-zipsfxbuilder/')
		Case @GUI_CtrlId = $Mi_SFXMod
			_GotoWebPage('http://7zsfx.info')
		Case @GUI_CtrlId = $Mi_SFXSplit
			_GotoWebPage('http://7zsfx.info')
		Case @GUI_CtrlId = $Mi_UPX
			_GotoWebPage('http://upx.sourceforge.net')
		Case @GUI_CtrlId = $Mi_ABOUT
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_About()
	EndSelect
EndFunc   ;==>_MenuItem_Control_Events
Func _GotoWebPage($_webpage = '')
	If $_webpage = '' Then Return
	Run(@SystemDir & '\RUNDLL32.exe url.dll, FileProtocolHandler ' & $_webpage, @SystemDir)
EndFunc   ;==>_GotoWebPage
Func _Tab_Event()
	Local $CUR_TAB = _GUICtrlTab_GetCurSel($TAB_MAIN)
	If $CUR_TAB = 7 Then _Update()
EndFunc   ;==>_Tab_Event
Func _Tab_Dialogs_Events()
	GUICtrlSetState($MS_BTN_BEGINPROMPT, $GUI_ENABLE)
	GUICtrlSetState($MS_BTN_XPATHTEXT, $GUI_ENABLE)
	GUICtrlSetState($MS_BTN_XDIALOGTEXT, $GUI_ENABLE)
	GUICtrlSetState($MS_BTN_CANCELPROMPT, $GUI_ENABLE)
	GUICtrlSetState($MS_BTN_FINISHMSG, $GUI_ENABLE)
	GUICtrlSetState($MS_BTN_HELPTEXT, $GUI_ENABLE)
	GUICtrlSetState($MS_EDT_MESSAGES[1], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[2], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[3], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[4], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[5], $GUI_HIDE)
	GUICtrlSetState($MS_EDT_MESSAGES[6], $GUI_HIDE)
	Switch @GUI_CtrlId
		Case $MS_BTN_BEGINPROMPT
			GUICtrlSetState($MS_BTN_BEGINPROMPT, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[1], $GUI_SHOW)
		Case $MS_BTN_XPATHTEXT
			GUICtrlSetState($MS_BTN_XPATHTEXT, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[2], $GUI_SHOW)
		Case $MS_BTN_XDIALOGTEXT
			GUICtrlSetState($MS_BTN_XDIALOGTEXT, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[3], $GUI_SHOW)
		Case $MS_BTN_CANCELPROMPT
			GUICtrlSetState($MS_BTN_CANCELPROMPT, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[4], $GUI_SHOW)
		Case $MS_BTN_FINISHMSG
			GUICtrlSetState($MS_BTN_FINISHMSG, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[5], $GUI_SHOW)
		Case $MS_BTN_HELPTEXT
			GUICtrlSetState($MS_BTN_HELPTEXT, $GUI_DISABLE)
			GUICtrlSetState($MS_EDT_MESSAGES[6], $GUI_SHOW)
	EndSwitch
EndFunc   ;==>_Tab_Dialogs_Events

; ***********************************************************
; *					 SECTION EVENTS							*
; ***********************************************************
; RUN
Func _TabItem_Run_Events()
	Switch @GUI_CtrlId
		Case $R_BTN_ADD
			$Run_ListToEdit[0] = False
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_RunProgram()
		Case $R_BTN_EDIT
			If _GUICtrlListView_GetSelectedCount($R_LIST) = 1 Then
				$Run_ListToEdit[0] = True
				$Run_ListToEdit[1] = _GUICtrlListView_GetSelectionMark($R_LIST)
				$Run_StringSplit = _GUICtrlListView_GetItemTextArray($R_LIST, $Run_ListToEdit[1])
				$cPos = WinGetPos($GUI_MAIN)
				GUISetState(@SW_DISABLE, $GUI_MAIN)
				_GUI_RunProgram()
				If $Run_StringSplit[1] = 'RunProgram' Then
					GUICtrlSetData($RUN_COMBO_PARAM, 'RunProgram')
					GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
				ElseIf $Run_StringSplit[1] = 'AutoInstall' Then
					GUICtrlSetData($RUN_COMBO_PARAM, 'AutoInstall')
					GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
				ElseIf StringLen($Run_StringSplit[1]) = 12 Then
					GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_ENABLE)
					GUICtrlSetData($RUN_COMBO_PARAM, 'AutoInstallX')
					GUICtrlSetData($RUN_COMBO_PARAM_X, StringRight($Run_StringSplit[1], 1))
				ElseIf $Run_StringSplit[1] = 'ExecuteFile' Then
					$Run_StringSplit[2] = ''
					GUICtrlSetData($RUN_COMBO_PARAM, 'ExecuteFile')
					GUICtrlSetState($RUN_COMBO_PARAM_X, $GUI_DISABLE)
					GUICtrlSetState($RUN_BTN_ADD, $GUI_DISABLE)
					GUICtrlSetState($RUN_CHK_ADD_QUOTES, $GUI_DISABLE)
				EndIf
				GUICtrlSetData($RUN_INP_PREFIX, $Run_StringSplit[2])
				GUICtrlSetData($RUN_INP_FILE, $Run_StringSplit[3])
				GUICtrlSetData($RUN_EDT_CMDS, $Run_StringSplit[4])
				If $Run_StringSplit[5] = 'True' Then GUICtrlSetState($RUN_CHK_ADD_QUOTES, 1)
			Else
				_MsgBoxEx(35)
			EndIf
		Case $R_BTN_DELETE
			If _GUICtrlListView_GetSelectedCount($R_LIST) > 0 Then
				$iMsgBoxAnswer = _MsgBoxEx(36)
				If $iMsgBoxAnswer = 6 Then _GUICtrlListView_DeleteItemsSelected($R_LIST)
			Else
				_MsgBoxEx(34)
			EndIf
		Case $R_BTN_DELETEALL
			Local $__b = False
			$iMsgBoxAnswer = _MsgBoxEx(37)
			If $iMsgBoxAnswer = 6 Then
				_GUICtrlListView_DeleteAllItems($R_LIST)
			EndIf
		Case $R_BTN_MOVEUP
			_MoveListViewItem($R_LIST, 1)
		Case $R_BTN_MOVEDOWN
			_MoveListViewItem($R_LIST, 2)
	EndSwitch
EndFunc   ;==>_TabItem_Run_Events
; DELETE
Func _TabItem_Delete_Events()
	Switch @GUI_CtrlId
		Case $D_BTN_ADD
			$Del_ListToEdit[0] = False
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_Delete()
		Case $D_BTN_EDIT
			If _GUICtrlListView_GetSelectedCount($D_LIST) = 1 Then
				$Del_ListToEdit[0] = True
				$Del_ListToEdit[1] = _GUICtrlListView_GetSelectionMark($D_LIST)
				$Del_StringSplit = _GUICtrlListView_GetItemTextArray($D_LIST, $Del_ListToEdit[1])
				$cPos = WinGetPos($GUI_MAIN)
				GUISetState(@SW_DISABLE, $GUI_MAIN)
				_GUI_Delete()
				If StringLen($Del_StringSplit[1]) > 6 Then
					GUICtrlSetState($DEL_COMBO_PARAM_X, $GUI_ENABLE)
					GUICtrlSetData($DEL_COMBO_PARAM_X, StringRight($Del_StringSplit[1], 1))
					GUICtrlSetData($DEL_COMBO_PARAM, '')
					GUICtrlSetData($DEL_COMBO_PARAM, 'Delete|DeleteX', 'DeleteX')
				EndIf
				GUICtrlSetData($DEL_INP_FILE, $Del_StringSplit[2])
				If $Del_StringSplit[3] = 'True' Then GUICtrlSetState($DEL_CHK_ADD_QUOTES, 1)
			Else
				_MsgBoxEx(35)
			EndIf
		Case $D_BTN_DELETE
			If _GUICtrlListView_GetSelectedCount($D_LIST) > 0 Then
				$iMsgBoxAnswer = _MsgBoxEx(36)
				If $iMsgBoxAnswer = 6 Then _GUICtrlListView_DeleteItemsSelected($D_LIST)
			Else
				_MsgBoxEx(34)
			EndIf
		Case $D_BTN_DELETEALL
			$iMsgBoxAnswer = _MsgBoxEx(37)
			If $iMsgBoxAnswer = 6 Then
				_GUICtrlListView_DeleteAllItems($D_LIST)
			EndIf
		Case $D_BTN_MOVEUP
			_MoveListViewItem($D_LIST, 1)
		Case $D_BTN_MOVEDOWN
			_MoveListViewItem($D_LIST, 2)
	EndSwitch
EndFunc   ;==>_TabItem_Delete_Events
; SHORTCUTS
Func _TabItem_Shortcuts_Events()
	Switch @GUI_CtrlId
		Case $SH_BTN_ADD
			$Shc_ListToEdit[0] = False
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_Shortcuts()
		Case $SH_BTN_EDIT
			If _GUICtrlListView_GetSelectedCount($SH_LIST) = 1 Then
				$Shc_ListToEdit[0] = True
				$Shc_ListToEdit[1] = _GUICtrlListView_GetSelectionMark($SH_LIST)
				$Shc_StringSplit = _GUICtrlListView_GetItemTextArray($SH_LIST, $Shc_ListToEdit[1])
				$cPos = WinGetPos($GUI_MAIN)
				GUISetState(@SW_DISABLE, $GUI_MAIN)
				_GUI_Shortcuts()
				If StringLen($Shc_StringSplit[1]) > 8 Then
					GUICtrlSetState($SHC_COMBO_PARAM_X, $GUI_ENABLE)
					GUICtrlSetData($SHC_COMBO_PARAM_X, StringRight($Shc_StringSplit[1], 1))
					GUICtrlSetData($SHC_COMBO_PARAM, 'ShortcutX')
				EndIf
				GUICtrlSetData($SHC_INP_FILE, $Shc_StringSplit[3])
				GUICtrlSetData($SHC_INP_CMDS, $Shc_StringSplit[4])
				GUICtrlSetData($SHC_INP_DEST_FLDR, $Shc_StringSplit[5])
				GUICtrlSetData($SHC_INP_DESCRIPTION, $Shc_StringSplit[6])
				GUICtrlSetData($SHC_INP_NAME, $Shc_StringSplit[7])
				GUICtrlSetData($SHC_INP_WRK_DIR, $Shc_StringSplit[8])
				GUICtrlSetData($SHC_INP_ICON, $Shc_StringSplit[9])
				GUICtrlSetData($SHC_INP_ICON_INDEX, $Shc_StringSplit[10])
				Switch StringLeft($Shc_StringSplit[2], 1)
					Case 'D'
						GUICtrlSetState($SHC_RADIO_DESKTOP, $GUI_CHECKED)
					Case 'S'
						GUICtrlSetState($SHC_RADIO_STARTMENU, $GUI_CHECKED)
					Case 'P'
						GUICtrlSetState($SHC_RADIO_PROGRAMS, $GUI_CHECKED)
					Case 'T'
						GUICtrlSetState($SHC_RADIO_STARTUP, $GUI_CHECKED)
				EndSwitch
				If StringRight($Shc_StringSplit[2], 1) <> 'u' Then GUICtrlSetState($SHC_RADIO_ALL_USERS, $GUI_CHECKED)
			Else
				_MsgBoxEx(35)
			EndIf
		Case $SH_BTN_DELETE
			If _GUICtrlListView_GetSelectedCount($SH_LIST) > 0 Then
				$iMsgBoxAnswer = _MsgBoxEx(36)
				If $iMsgBoxAnswer = 6 Then _GUICtrlListView_DeleteItemsSelected($SH_LIST)
			Else
				_MsgBoxEx(34)
			EndIf
		Case $SH_BTN_DELETEALL
			$iMsgBoxAnswer = _MsgBoxEx(37)
			If $iMsgBoxAnswer = 6 Then
				_GUICtrlListView_DeleteAllItems($SH_LIST)
			EndIf
		Case $SH_BTN_MOVEUP
			_MoveListViewItem($SH_LIST, 1)
		Case $SH_BTN_MOVEDOWN
			_MoveListViewItem($SH_LIST, 2)
	EndSwitch
EndFunc   ;==>_TabItem_Shortcuts_Events
; SET_ENVIRONMENT
Func _TabItem_Variables_Events()
	Switch @GUI_CtrlId
		Case $E_BTN_ADD
			$Var_ListToEdit[0] = False
			$cPos = WinGetPos($GUI_MAIN)
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			_GUI_SetEnv()
		Case $E_BTN_EDIT
			If _GUICtrlListView_GetSelectedCount($E_LIST) = 1 Then
				$Var_ListToEdit[0] = True
				$Var_ListToEdit[1] = _GUICtrlListView_GetSelectionMark($E_LIST)
				$Var_StringSplit = _GUICtrlListView_GetItemTextArray($E_LIST, $Var_ListToEdit[1])
				$cPos = WinGetPos($GUI_MAIN)
				GUISetState(@SW_DISABLE, $GUI_MAIN)
				_GUI_SetEnv()
				GUICtrlSetData($ENV_INP_NAME, $Var_StringSplit[1], $Var_StringSplit[1])
				GUICtrlSetData($ENV_INP_VALUE, $Var_StringSplit[2])
			Else
				_MsgBoxEx(35)
			EndIf
		Case $E_BTN_DELETE
			If _GUICtrlListView_GetSelectedCount($E_LIST) > 0 Then
				$iMsgBoxAnswer = _MsgBoxEx(36)
				If $iMsgBoxAnswer = 6 Then _GUICtrlListView_DeleteItemsSelected($E_LIST)
			Else
				_MsgBoxEx(34)
			EndIf
		Case $E_BTN_DELETEALL
			$iMsgBoxAnswer = _MsgBoxEx(37)
			If $iMsgBoxAnswer = 6 Then
				_GUICtrlListView_DeleteAllItems($E_LIST)
			EndIf
		Case $E_BTN_MOVEUP
			_MoveListViewItem($E_LIST, 1)
		Case $E_BTN_MOVEDOWN
			_MoveListViewItem($E_LIST, 2)
	EndSwitch
EndFunc   ;==>_TabItem_Variables_Events
Func _MoveListViewItem($hList, $UpDown)
	If _GUICtrlListView_GetSelectedCount($hList) <> 1 Then Return SetError(1, 1)
	Local $sIndex = _GUICtrlListView_GetSelectionMark($hList)
	If $UpDown = 1 Then
		If $sIndex = 0 Then Return SetError(1, 2)
		Local $dIndex = $sIndex - 1
	ElseIf $UpDown = 2 Then
		If $sIndex + 1 = _GUICtrlListView_GetItemCount($hList) Then Return SetError(1, 2)
		Local $dIndex = $sIndex + 1
	Else
		Return SetError(1, 3)
	EndIf
	Local $sText = _GUICtrlListView_GetItemTextArray($hList, $sIndex)
	Local $dText = _GUICtrlListView_GetItemTextArray($hList, $dIndex)
	For $c = 1 To $dText[0]
		_GUICtrlListView_SetItem($hList, $dText[$c], $sIndex, $c - 1)
		_GUICtrlListView_SetItem($hList, $sText[$c], $dIndex, $c - 1)
	Next
	_GUICtrlListView_ClickItem($hList, $dIndex)
EndFunc   ;==>_MoveListViewItem
Func _CheckString($hCtrl)
	Local $i = 1, $quote, $string = GUICtrlRead($hCtrl)
	If $string = '' Then Return SetError(0, 1, True)
	Do
		$quote = StringInStr($string, '"', 0, $i)
		If $quote = 0 Then Return SetError(0, 2, True)
		If StringMid($string, $quote - 1, 1) <> '\' Then ExitLoop
		$i += 1
	Until 1 = 2
	GUICtrlSetState($hCtrl, $GUI_FOCUS)
	_GUICtrlEdit_SetSel($hCtrl, $quote - 1, $quote)
	Return SetError(1, 0, False)
EndFunc   ;==>_CheckString
; ***********************************************************
; *				      	  _MsgBoxEx							*
; ***********************************************************
Func _MsgBoxEx($MBoxID, $pHWND = $GUI_MAIN, $repData = '')
	; ----------------------------- ;
	; Error - 16					;
	; Question - 32					;
	; Warning - 48					;
	; Information - 64				;
	; ----------------------------- ;
	; OK, Cancel - 1				;
	; Abort, Retry, Ignore - 2		;
	; Yes, No, Cancel - 3			;
	; Yes, No - 4					;
	; Retry, Cancel - 5				;
	; Cancel, Retry, Continue - 6	;
	; ----------------------------- ;
	Local $MBoxRet
	Switch StringLeft($MBoxID, 1)
		Case 1 ; File open/save operations
			Switch StringMid($MBoxID, 2)
				Case 1
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX1[1], $repData), '', $pHWND)
					Return $MBoxRet
				Case 2
					$MBoxRet = MsgBox(48, $TitleINFO, _FormatMBoxData($LANG_MSGBOX1[2], $repData), '', $pHWND)
					Return $MBoxRet
				Case 3
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX1[3], $repData), '', $pHWND)
					Return $MBoxRet
				Case 4
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX1[4], $repData), '', $pHWND)
					Return $MBoxRet
				Case 5
					$MBoxRet = MsgBox(32 + 4, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX1[5], $repData), '', $pHWND)
					Return $MBoxRet
				Case 6
					$MBoxRet = MsgBox(48 + 4, $TitleWARN, _FormatMBoxData($LANG_MSGBOX1[6], $repData), '', $pHWND)
					Return $MBoxRet
				Case 7
					$MBoxRet = MsgBox(48 + 4, $TitleWARN, _FormatMBoxData($LANG_MSGBOX1[7], $repData), '', $pHWND)
					Return $MBoxRet
				Case 8
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX1[8], $repData), '', $pHWND)
					Return $MBoxRet
				Case 9
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX1[9], $repData), '', $pHWND)
					Return $MBoxRet
				Case 10
					$MBoxRet = MsgBox(32 + 4, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX1[10], $repData), '', $pHWND)
					Return $MBoxRet
				Case 11
					$MBoxRet = MsgBox(32 + 3, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX1[11], $repData), '', $pHWND)
					Return $MBoxRet
				Case 12
					$MBoxRet = MsgBox(16, $TitleWARN, _FormatMBoxData($LANG_MSGBOX1[12], $repData), '', $pHWND)
					Return $MBoxRet
			EndSwitch
		Case 2 ; SFX creation
			Switch StringMid($MBoxID, 2)
				Case 1
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[1], $repData), '', $pHWND)
					Return $MBoxRet
				Case 2
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[2], $repData), '', $pHWND)
					Return $MBoxRet
				Case 3
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[3], $repData), '', $pHWND)
					Return $MBoxRet
				Case 4
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[4], $repData), '', $pHWND)
					Return $MBoxRet
				Case 5
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[5], $repData), '', $pHWND)
					Return $MBoxRet
				Case 6
					$MBoxRet = MsgBox(48, $TitleERROR, _FormatMBoxData($LANG_MSGBOX2[6], $repData), '', $pHWND)
					Return $MBoxRet
				Case 7
					$MBoxRet = MsgBox(48 + 4, $TitleWARN, _FormatMBoxData($LANG_MSGBOX2[7], $repData), '', $pHWND)
					Return $MBoxRet
				Case 8
					$MBoxRet = MsgBox(48, $TitleWARN, _FormatMBoxData($LANG_MSGBOX2[8], $repData), '', $pHWND)
					Return $MBoxRet
				Case 9
					$MBoxRet = MsgBox(35, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX2[9], $repData), '', $pHWND)
					Return $MBoxRet
			EndSwitch
		Case 3 ; Other operations
			Switch StringMid($MBoxID, 2)
				Case 1
					$MBoxRet = MsgBox(64, $TitleINFO, _FormatMBoxData($LANG_MSGBOX3[1], $repData), '', $pHWND)
					Return $MBoxRet
				Case 2
					$MBoxRet = MsgBox(64, $TitleINFO, _FormatMBoxData($LANG_MSGBOX3[2], $repData), '', $pHWND)
					Return $MBoxRet
				Case 3
					$MBoxRet = MsgBox(32 + 3, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX3[3], $repData), '', $pHWND)
					Return $MBoxRet
				Case 4
					$MBoxRet = MsgBox(64, $TitleINFO, _FormatMBoxData($LANG_MSGBOX3[4], $repData), '', $pHWND)
					Return $MBoxRet
				Case 5
					$MBoxRet = MsgBox(64, $TitleINFO, _FormatMBoxData($LANG_MSGBOX3[5], $repData), '', $pHWND)
					Return $MBoxRet
				Case 6
					$MBoxRet = MsgBox(32 + 4, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX3[6], $repData), '', $pHWND)
					Return $MBoxRet
				Case 7
					$MBoxRet = MsgBox(32 + 4, $TitleQUEST, _FormatMBoxData($LANG_MSGBOX3[7], $repData), '', $pHWND)
					Return $MBoxRet
				Case 8
					$MBoxRet = MsgBox(16, $TitleERROR, _FormatMBoxData($LANG_MSGBOX3[8], $repData), '', $pHWND)
					Return $MBoxRet
				Case 9
					$MBoxRet = MsgBox(48, $TitleINFO, _FormatMBoxData($LANG_MSGBOX3[9], $repData), '', $pHWND)
					Return $MBoxRet
			EndSwitch
	EndSwitch
EndFunc   ;==>_MsgBoxEx
Func _FormatMBoxData($MBoxData, $repData)
	Local $MBoxRet = $MBoxData
	$MBoxRet = StringReplace($MBoxRet, '\n', @CRLF)
	$MBoxRet = StringReplace($MBoxRet, '\~n', @CRLF & @CRLF)
	$MBoxRet = StringReplace($MBoxRet, '\s', $repData)
	$MBoxRet = StringReplace($MBoxRet, '\~s', '"' & $repData & '"')
	Return $MBoxRet
EndFunc   ;==>_FormatMBoxData
Func _FormatPathData($iData = '')
	If $iData = '' Then Return ''
	If Not StringInStr($iData, '\') Then Return $iData
	Local $i = 1
	Do
		If StringMid($iData, $i, 1) = '\' Then
			If StringMid($iData, $i - 1, 1) <> '\' Then
				If StringMid($iData, $i + 1, 1) <> '"' And (StringMid($iData, $i + 1, 1) <> '\' Or StringMid($iData, $i + 1, 2) = '\"') Then
					$iData = StringLeft($iData, $i) & '\' & StringRight($iData, StringLen($iData) - $i)
				EndIf
			EndIf
		EndIf
		$i += 1
	Until StringLen($iData) = ($i - 1)
	Return $iData
EndFunc   ;==>_FormatPathData
; ***********************************************************
; *				  INSTPATH INSERT VARS						*
; ***********************************************************
Func _Toolbar_Menu_Events()
	Select
		Case @GUI_CtrlId = $TBi_BP
			_Test(1)
		Case @GUI_CtrlId = $TBi_EPT
			_Test(2)
		Case @GUI_CtrlId = $TBi_EDT
			_Test(3)
		Case @GUI_CtrlId = $TBi_CP
			_Test(4)
		Case @GUI_CtrlId = $TBi_FM
			_Test(5)
		Case @GUI_CtrlId = $TBi_HT
			_Test(6)
		Case @GUI_CtrlId = $TBi_WARN
			_Test(7)
		Case @GUI_CtrlId = $TBi_ERROR
			_Test(8)
		Case @GUI_CtrlId = $TBi_PASSWD
			_Test(9)
	EndSelect
EndFunc   ;==>_Toolbar_Menu_Events
Func _ShowMenu_Toolbar($hWnd, $CmdID, $nContextID)
	Local $arPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($nContextID)

	$arPos = _GUICtrlToolbar_GetButtonRect($hToolbar, $CmdID)

	$x = $arPos[0]
	$y = $arPos[1] + 45

	_ClientToScreen($hWnd, $x, $y)
	_TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>_ShowMenu_Toolbar

Func _Insert_Variables()
	Local $InsVar = ''
	Switch @GUI_CtrlId
		Case $M_BTN_INSTPATH
			_ShowMenu($GUI_MAIN, $M_BTN_INSTPATH, $c_Menu_InstPath)
		Case $Mi_IP[1]
			$InsVar = '%%M'
		Case $Mi_IP[2]
			$InsVar = '%%S'
		Case $Mi_IP[3]
			$InsVar = '%SystemDrive%'
		Case $Mi_IP[4]
			$InsVar = '%SystemRoot%'
		Case $Mi_IP[11]
			$InsVar = '%ProgramFiles%'
		Case $Mi_IP[8]
			$InsVar = '%WinDir%'
		Case $Mi_IP[7]
			$InsVar = '%Temp%'
		Case $Mi_IP[5]
			$InsVar = '%CommonDesktop%'
		Case $Mi_IP[9]
			$InsVar = '%CommonDocuments%'
		Case $Mi_IP[10]
			$InsVar = '%AllUsersProfile%'
		Case $Mi_IP[6]
			$InsVar = '%UserDesktop%'
		Case $Mi_IP[12]
			$InsVar = '%UserDocuments%'
		Case $Mi_IP[13]
			$InsVar = '%UserProfile%'
	EndSwitch
	If $InsVar <> '' Then GUICtrlSetData($M_INP_INSTPATH, $InsVar, 1)
EndFunc   ;==>_Insert_Variables
Func _ShowMenu($hWnd, $CtrlID, $nContextID)
	Local $arPos, $x, $y
	Local $hMenu = GUICtrlGetHandle($nContextID)

	$arPos = ControlGetPos($hWnd, '', $CtrlID)

	$x = $arPos[0]
	$y = $arPos[1] + $arPos[3]

	_ClientToScreen($hWnd, $x, $y)
	_TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc   ;==>_ShowMenu
Func _ClientToScreen($hWnd, ByRef $x, ByRef $y)
	Local $stPoint = DllStructCreate('int;int')

	DllStructSetData($stPoint, 1, $x)
	DllStructSetData($stPoint, 2, $y)

	DllCall('user32.dll', 'int', 'ClientToScreen', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($stPoint))

	$x = DllStructGetData($stPoint, 1)
	$y = DllStructGetData($stPoint, 2)
	$stPoint = 0
EndFunc   ;==>_ClientToScreen
Func _TrackPopupMenu($hWnd, $hMenu, $x, $y)
	DllCall('user32.dll', 'int', 'TrackPopupMenuEx', 'hwnd', $hMenu, 'int', 0, 'int', $x, 'int', $y, 'hwnd', $hWnd, 'ptr', 0)
EndFunc   ;==>_TrackPopupMenu
; ***********************************************************
; *				   	   RECENT FILES LIST					*
; ***********************************************************
Func _MRU_Load_Startup()
	Local $mruList, $m = 1
	$mruList = _MRU_Load_List()
	For $c = 1 To 5
		If $mruList[$c] <> '' Then
			$MRUData[$m] = $mruList[$c]
			$m += 1
		EndIf
	Next
	_MRU_CreateMenuItem()
	If $MRUData[1] = '' Then
		_GUICtrlCreateMenuItemEx('Empty', $sMenu_RECENT_FILES)
		GUICtrlSetState(-1, $GUI_DISABLE)
	EndIf
EndFunc   ;==>_MRU_Load_Startup
Func _MRU_Load_List()
	Local $mruList[6]
	If $RegMode = 1 Then
		$mruList[1] = RegRead($reg_mruPath, '1')
		$mruList[2] = RegRead($reg_mruPath, '2')
		$mruList[3] = RegRead($reg_mruPath, '3')
		$mruList[4] = RegRead($reg_mruPath, '4')
		$mruList[5] = RegRead($reg_mruPath, '5')
	Else
		$mruList[1] = IniRead($SetsINI, 'MRUList', 1, '')
		$mruList[2] = IniRead($SetsINI, 'MRUList', 2, '')
		$mruList[3] = IniRead($SetsINI, 'MRUList', 3, '')
		$mruList[4] = IniRead($SetsINI, 'MRUList', 4, '')
		$mruList[5] = IniRead($SetsINI, 'MRUList', 5, '')
	EndIf
	Return $mruList
EndFunc   ;==>_MRU_Load_List
Func _MRU_CreateMenuItem()
	If $MRUData[1] = '' Then Return
	_GUICtrlCreateMenuItemEx($MRUData[1], $sMenu_RECENT_FILES)
	GUICtrlSetOnEvent(-1, '_MRU_OpenFile_1')
	If $MRUData[2] = '' Then Return
	_GUICtrlCreateMenuItemEx($MRUData[2], $sMenu_RECENT_FILES)
	GUICtrlSetOnEvent(-1, '_MRU_OpenFile_2')
	If $MRUData[3] = '' Then Return
	_GUICtrlCreateMenuItemEx($MRUData[3], $sMenu_RECENT_FILES)
	GUICtrlSetOnEvent(-1, '_MRU_OpenFile_3')
	If $MRUData[4] = '' Then Return
	_GUICtrlCreateMenuItemEx($MRUData[4], $sMenu_RECENT_FILES)
	GUICtrlSetOnEvent(-1, '_MRU_OpenFile_4')
	If $MRUData[5] = '' Then Return
	_GUICtrlCreateMenuItemEx($MRUData[5], $sMenu_RECENT_FILES)
	GUICtrlSetOnEvent(-1, '_MRU_OpenFile_5')
EndFunc   ;==>_MRU_CreateMenuItem
Func _MRU_Load_Live($mrufile = '')
	Local $RecData[7], $mruexist = False
	If $mrufile = '' Then Return SetError(1)
	For $f = 1 To 5
		If $mrufile = $MRUData[$f] Then
			If $f <> 1 Then
				For $c = $f To 2 Step -1
					$MRUData[$f] = $MRUData[$f - 1]
				Next
			EndIf
			$MRUData[1] = $mrufile
			$mruexist = True
		EndIf
	Next
	If $mruexist = False Then
		$MRUData[5] = $MRUData[4]
		$MRUData[4] = $MRUData[3]
		$MRUData[3] = $MRUData[2]
		$MRUData[2] = $MRUData[1]
		$MRUData[1] = $mrufile
	EndIf
	_MRU_Clear(False)
	_MRU_CreateMenuItem()
	If $RegMode = 1 Then
		RegWrite($reg_mruPath, '1', 'REG_SZ', $MRUData[1])
		RegWrite($reg_mruPath, '2', 'REG_SZ', $MRUData[2])
		RegWrite($reg_mruPath, '3', 'REG_SZ', $MRUData[3])
		RegWrite($reg_mruPath, '4', 'REG_SZ', $MRUData[4])
		RegWrite($reg_mruPath, '5', 'REG_SZ', $MRUData[5])
	Else
		IniWrite($SetsINI, 'MRUList', '1', $MRUData[1])
		IniWrite($SetsINI, 'MRUList', '2', $MRUData[2])
		IniWrite($SetsINI, 'MRUList', '3', $MRUData[3])
		IniWrite($SetsINI, 'MRUList', '4', $MRUData[4])
		IniWrite($SetsINI, 'MRUList', '5', $MRUData[5])
	EndIf
EndFunc   ;==>_MRU_Load_Live
Func _MRU_Clear($i_empty = True)
	If _GUICtrlMenu_GetItemCount(GUICtrlGetHandle($sMenu_RECENT_FILES)) > 1 Then
		For $c = _GUICtrlMenu_GetItemCount(GUICtrlGetHandle($sMenu_RECENT_FILES)) - 1 To 2 Step -1
			_GUICtrlMenu_DeleteMenu(GUICtrlGetHandle($sMenu_RECENT_FILES), $c)
		Next
	EndIf
	If $RegMode = 1 Then
		RegWrite($reg_mruPath, '1', 'REG_SZ', '')
		RegWrite($reg_mruPath, '2', 'REG_SZ', '')
		RegWrite($reg_mruPath, '3', 'REG_SZ', '')
		RegWrite($reg_mruPath, '4', 'REG_SZ', '')
		RegWrite($reg_mruPath, '5', 'REG_SZ', '')
	Else
		IniWrite($SetsINI, 'MRUList', '1', '')
		IniWrite($SetsINI, 'MRUList', '2', '')
		IniWrite($SetsINI, 'MRUList', '3', '')
		IniWrite($SetsINI, 'MRUList', '4', '')
		IniWrite($SetsINI, 'MRUList', '5', '')
	EndIf
	If $i_empty = 1 Then
		_GUICtrlCreateMenuItemEx('Empty', $sMenu_RECENT_FILES)
		GUICtrlSetState(-1, $GUI_DISABLE)
	EndIf
EndFunc   ;==>_MRU_Clear
Func _MRU_OpenFile_1()
	If Not FileExists($MRUData[1]) Then
		_MsgBoxEx(12)
		Return SetError(1, 1, False)
	EndIf
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $MRUData[1])
	If $iMsgBoxAnswer = 6 Then _FileLoad($MRUData[1])
EndFunc   ;==>_MRU_OpenFile_1
Func _MRU_OpenFile_2()
	If Not FileExists($MRUData[2]) Then
		_MsgBoxEx(12)
		Return SetError(1, 1, False)
	EndIf
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $MRUData[2])
	If $iMsgBoxAnswer = 6 Then _FileLoad($MRUData[2])
EndFunc   ;==>_MRU_OpenFile_2
Func _MRU_OpenFile_3()
	If Not FileExists($MRUData[3]) Then
		_MsgBoxEx(12)
		Return SetError(1, 1, False)
	EndIf
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $MRUData[3])
	If $iMsgBoxAnswer = 6 Then _FileLoad($MRUData[3])
EndFunc   ;==>_MRU_OpenFile_3
Func _MRU_OpenFile_4()
	If Not FileExists($MRUData[4]) Then
		_MsgBoxEx(12)
		Return SetError(1, 1, False)
	EndIf
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $MRUData[4])
	If $iMsgBoxAnswer = 6 Then _FileLoad($MRUData[4])
EndFunc   ;==>_MRU_OpenFile_4
Func _MRU_OpenFile_5()
	If Not FileExists($MRUData[5]) Then
		_MsgBoxEx(12)
		Return SetError(1, 1, False)
	EndIf
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $MRUData[5])
	If $iMsgBoxAnswer = 6 Then _FileLoad($MRUData[5])
EndFunc   ;==>_MRU_OpenFile_5
; ***********************************************************
; *					  SELECT LANGUAGE						*
; ***********************************************************
Func _Lang_Create_MenuItem($LngArray)
	For $nL = 1 To $LngArray[0]
		Local $LngName = IniRead($LngArray[$nL], 'LangOptions', 'LANG_NAME', '')
		Local $LngNativeName = IniRead($LngArray[$nL], 'LangOptions', 'LANG_NATIVE_NAME', '')
		If $LngNativeName <> '' Then $LngNativeName = ' (' & $LngNativeName & ')'
		If $LngName <> '' Then
			$LngCount += 1
			$LangName[$LngCount] = StringMid($LngArray[$nL], StringInStr($LngArray[$nL], '\', 0, -1) + 1, StringLen($LngArray[$nL]) - StringInStr($LngArray[$nL], '\', 0, -1) - 4)
			$Mi_LANG[$LngCount] = _GUICtrlCreateMenuItemEx($LngName & $LngNativeName, $sMenu_LANG, '', 1)
			GUICtrlSetOnEvent($Mi_LANG[$nL], '_Select_Language')
			If $CurLang[0] = $LangName[$nL] Then
				GUICtrlSetState($Mi_LANG[$nL], $GUI_CHECKED)
				$CurLang[1] = $LngName & $LngNativeName
			EndIf
			$_LngList = $LngName & $LngNativeName & '|' & $_LngList
		EndIf
	Next
EndFunc   ;==>_Lang_Create_MenuItem
Func _Select_Language()
	Local $_LngIndex = '', $hMenu_Lang = GUICtrlGetHandle($sMenu_LANG)
	If $_LngText[1] = '' Then
		For $nL = 1 To _GUICtrlMenu_GetItemCount($hMenu_Lang)
			If @GUI_CtrlId = $Mi_LANG[$nL] Then
				$_LngIndex = $nL
				ExitLoop
			EndIf
		Next
	Else
		For $nL = 0 To _GUICtrlMenu_GetItemCount($hMenu_Lang) - 1
			If _GUICtrlMenu_GetItemText($hMenu_Lang, $nL) = $_LngText[1] Then
				$_LngIndex = $nL + 1
				ExitLoop
			EndIf
		Next
	EndIf
	If $_LngIndex <> '' Then
		Local $LangFullName = @ScriptDir & '\Lang\' & $LangName[$_LngIndex] & '.ini'
		If FileExists($LangFullName) Then
			$CurLang[0] = $LangName[$_LngIndex]
			GUISetState(@SW_LOCK, $GUI_MAIN)
			For $c = 1 To _GUICtrlMenu_GetItemCount($hMenu_Lang)
				_GUICtrlMenu_SetItemChecked($hMenu_Lang, $Mi_LANG[$c], False, False)
			Next
			GUICtrlSetState($Mi_LANG[$_LngIndex], $GUI_CHECKED)
			If $RegMode = 1 Then
				RegWrite($reg_Path, 'Lang', 'REG_SZ', $LangName[$_LngIndex])
			Else
				IniWrite($SetsINI, 'Main', 'Lang', $LangName[$_LngIndex])
			EndIf
			_Load_Language($LangFullName)
			_Change_Language()
			_Set_Font_Main()
			$CurLang[1] = $_LNG_ABOUT[1] & ' (' & $_LNG_ABOUT[2] & ')'
			GUISetState(@SW_UNLOCK, $GUI_MAIN)
		Else
			_MsgBoxEx(11)
		EndIf
	EndIf
EndFunc   ;==>_Select_Language
Func _FileListToArrayEx($sFilePath, $sFilter = '*')
	Local $aError[1] = [0], $hSearch, $sFile, $sReturn = ''

	If FileExists($sFilePath) = 0 Then
		Return SetError(1, 0, $aError)
	EndIf
	$hSearch = FileFindFirstFile($sFilePath & $sFilter)
	If $hSearch = -1 Then
		Return SetError(2, 0, $aError)
	EndIf

	While 1
		$sFile = FileFindNextFile($hSearch)
		If @error Then
			ExitLoop
		EndIf
		$sReturn &= $sFilePath & $sFile & '|'
	WEnd
	FileClose($hSearch)
	If $sReturn = "" Then
		Return SetError(3, 0, $aError)
	EndIf
	Return StringSplit(StringTrimRight($sReturn, 1), "|")
EndFunc   ;==>_FileListToArrayEx
Func _String_GetStrCount($_string, $search_str)
	If Not StringInStr($_string, $search_str) Then Return 0
	Local $_count = 0
	Do
		$_count += 1
	Until Not StringInStr($_string, $search_str, 0, $_count + 1)
	Return $_count
EndFunc   ;==>_String_GetStrCount
; ***********************************************************
; *					  		TEST							*
; ***********************************************************
Func _SFX_Info($module = '', $hWnd = $GUI_MAIN)
	If FileExists($module) Then
		Run($module & ' -sfxversion')
	Else
		_MsgBoxEx(12, $hWnd)
		Return SetError(1, 1, '')
	EndIf
EndFunc   ;==>_SFX_Info
Func _Button_Test_Events()
	Switch ($GUI_DISABLE + $GUI_SHOW)
		Case GUICtrlGetState($MS_BTN_BEGINPROMPT)
			_Test(1)
		Case GUICtrlGetState($MS_BTN_XPATHTEXT)
			_Test(2)
		Case GUICtrlGetState($MS_BTN_XDIALOGTEXT)
			_Test(3)
		Case GUICtrlGetState($MS_BTN_CANCELPROMPT)
			_Test(4)
		Case GUICtrlGetState($MS_BTN_FINISHMSG)
			_Test(5)
		Case GUICtrlGetState($MS_BTN_HELPTEXT)
			_Test(6)
	EndSwitch
EndFunc   ;==>_Button_Test_Events
Func _Test($d_index)
	; 1 = BeginPrompt | 2 = ExtractPathText | 3 = ExtractDialogText | 4 = FinishMessage | 5 = helpText | 6 = CancelPrompt
	Local $hTestCFG, $Test_PID, $Test_Cmd, $d_flag = ''
	; check for correct index
	If $d_index < 1 Or $d_index > 9 Then Return SetError(1, 1, False)
	; copy sfxmod into tempdir
	_Update()
	_ClearTemp(5)
	$TestCONFIG = _Path_GetTempName($TempTESTFLDR & '\test_', '.txt')
	If FileExists($cMod_Path) Then
		FileCopy($cMod_Path, $TestSFXMOD, 9)
	ElseIf FileExists($tMod_Path) Then
		FileCopy($tMod_Path, $TestSFXMOD, 9)
	Else
		Return SetError(1, 2, False)
	EndIf
	If Not FileExists($TestSFXMOD) Then Return SetError(1, 3, False)
	_FileOpenEx($TestCONFIG, 128 + 2, $BuiltCONFIG[0])
	If @error Then
		MsgBox(0, '', $TestCONFIG)
		_MsgBoxEx(112)
		Return SetError(1, 0, 0)
	EndIf
	Switch $d_index
		Case 1
			$Test_Cmd = ' -sfxtest:D:B -sfxconfig:"'
		Case 2
			$Test_Cmd = ' -sfxtest:D:P -sfxconfig:"'
		Case 3
			$Test_Cmd = ' -sfxtest:D:E:300 -sfxconfig:"'
		Case 4
			$Test_Cmd = ' -sfxtest:D:C -sfxconfig:"'
		Case 5
			$Test_Cmd = ' -sfxtest:D:F -sfxconfig:"'
		Case 6
			$Test_Cmd = ' -sfxtest:D:H -sfxconfig:"'
		Case 7
			$Test_Cmd = ' -sfxtest:D:W -sfxconfig:"'
		Case 8
			$Test_Cmd = ' -sfxtest:D:Z -sfxconfig:"'
		Case 9
			$Test_Cmd = ' -sfxtest:D:X -sfxconfig:"'
	EndSwitch
	$Test_PID = Run($TestSFXMOD & $Test_Cmd & $TestCONFIG & '"')
	If $d_index = 3 And $GuiMode = '1' And ProcessExists($Test_PID) Then
		GUISetState(@SW_DISABLE, $GUI_MAIN)
		_MsgBoxEx(32)
		ProcessClose($Test_PID)
		GUISetState(@SW_ENABLE, $GUI_MAIN)
		GUISetState(@SW_RESTORE, $GUI_MAIN)
	EndIf
EndFunc   ;==>_Test
Func _Path_GetTempName($_Path, $_Ext = '')
	Local $TmpN = 0, $_Return = ''
	Do
		$_Return = $_Path & $TmpN & $_Ext
		$TmpN += 1
	Until Not FileExists($_Return)
	Return $_Return
EndFunc   ;==>_Path_GetTempName
Func _Get_ArchiveInfo($arcPath)
	If Not FileExists($arcPath) Or StringRight($arcPath, 3) <> '.7z' Or Not FileExists($7ZIP_PATH) Or StringRight($7ZIP_PATH, 4) <> '.exe' Then Return ''
	Local $PID, $arcInfo
	$PID = Run($7ZIP_PATH & ' l "' & $arcPath & '"', '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	While ProcessExists($PID)
		$arcInfo &= StdoutRead($PID)
		If @error Then ExitLoop
	WEnd
	Return $arcInfo
EndFunc   ;==>_Get_ArchiveInfo
Func _ConvertArcValues()
	Switch $7z_LVL[0]
		Case 'Store'
			$7z_LVL[1] = ' -mx=0'
			$7z_METHOD[1] = ''
			$7z_DICT[1] = ''
			$7z_SOLID[1] = ''
			Return
		Case 'Fastest'
			$7z_LVL[1] = ' -mx=1'
		Case 'Fast'
			$7z_LVL[1] = ' -mx=3'
		Case 'Normal'
			$7z_LVL[1] = ' -mx=5'
		Case 'Maximum'
			$7z_LVL[1] = ' -mx=7'
		Case Else
			$7z_LVL[0] = 'Ultra'
			$7z_LVL[1] = ' -mx=9'
	EndSwitch
	Switch $7z_METHOD[0]
		Case 'LZMA'
			$7z_METHOD[1] = ' -mm=lzma'
;~ 		Case 'PPMd'
;~ 			$7z_METHOD[1] = ' -mm=ppmd'
;~ 		Case 'BZip2'
;~ 			$7z_METHOD[1] = ' -mm=bzip2'
		Case Else
			$7z_METHOD[0] = 'LZMA2'
			$7z_METHOD[1] = ' -mm=lzma2'
	EndSwitch
	Switch $7z_DICT[0]
		Case '64 KB'
			$7z_DICT[1] = ' -md=64k'
		Case '1 MB'
			$7z_DICT[1] = ' -md=1m'
		Case '2 MB'
			$7z_DICT[1] = ' -md=2m'
		Case '3 MB'
			$7z_DICT[1] = ' -md=3m'
		Case '4 MB'
			$7z_DICT[1] = ' -md=4m'
		Case '6 MB'
			$7z_DICT[1] = ' -md=6m'
		Case '8 MB'
			$7z_DICT[1] = ' -md=8m'
		Case '12 MB'
			$7z_DICT[1] = ' -md=12m'
		Case '16 MB'
			$7z_DICT[1] = ' -md=16m'
		Case '24 MB'
			$7z_DICT[1] = ' -md=24m'
		Case '32 MB'
			$7z_DICT[1] = ' -md=32m'
		Case '48 MB'
			$7z_DICT[1] = ' -md=48m'
		Case Else
			$7z_DICT[0] = '64 MB'
			$7z_DICT[1] = ' -md=64m'
	EndSwitch
	Switch $7z_SOLID[0]
		Case 'Non-solid'
			$7z_SOLID[1] = ' -ms=off'
		Case '1 MB'
			$7z_SOLID[1] = ' -ms=1m'
		Case '2 MB'
			$7z_SOLID[1] = ' -ms=2m'
		Case '4 MB'
			$7z_SOLID[1] = ' -ms=4m'
		Case '8 MB'
			$7z_SOLID[1] = ' -ms=8m'
		Case '16 MB'
			$7z_SOLID[1] = ' -ms=16m'
		Case '32 MB'
			$7z_SOLID[1] = ' -ms=32m'
		Case '64 MB'
			$7z_SOLID[1] = ' -ms=64m'
		Case '128 MB'
			$7z_SOLID[1] = ' -ms=128m'
		Case '256 MB'
			$7z_SOLID[1] = ' -ms=256m'
		Case '512 MB'
			$7z_SOLID[1] = ' -ms=512m'
		Case '1 GB'
			$7z_SOLID[1] = ' -ms=1g'
		Case '2 GB'
			$7z_SOLID[1] = ' -ms=2g'
		Case '4 GB'
			$7z_SOLID[1] = ' -ms=4g'
		Case '8 GB'
			$7z_SOLID[1] = ' -ms=8g'
		Case '16 GB'
			$7z_SOLID[1] = ' -ms=16g'
		Case '32 GB'
			$7z_SOLID[1] = ' -ms=32g'
		Case '64 GB'
			$7z_SOLID[1] = ' -ms=64g'
		Case Else
			$7z_SOLID[0] = 'Solid'
			$7z_SOLID[1] = ' -ms=on'
	EndSwitch
EndFunc   ;==>_ConvertArcValues
Func _FindCurMod()
	If $USE_DEFMOD[0] = 1 Then
		$cMod_Path = $Mods_Dir & '\' & $USE_DEFMOD[1] & '.sfx'
	Else
		$cMod_Path = GUICtrlRead($S_INP_SFXMOD)
	EndIf
	If StringRight($cMod_Path, 4) <> '.sfx' Or Not FileExists($cMod_Path) Then $cMod_Path = ''
EndFunc   ;==>_FindCurMod
Func _ReplaceVariables($sString)
	; get declared variables count
	Local $dvarCount = _GUICtrlListView_GetItemCount($E_LIST)
	; process errors
;~ 	If $dvarCount = 0 Then Return SetError(1, 1, $sString)
	If _StringGetStrCount($sString, '%') < 2 Then Return SetError(1, 2, $sString)
	; declare variables
	Local $aVars[100], $varPos[200]
	Local $dvarNames[100], $dvarVals[100]
	Local $p = 1, $v = 1, $n = 1
	; get % positions
	Do
		$varPos[$p] = StringInStr($sString, '%', 0, $p)
		If @error Or $varPos[$p] = 0 Then
			$varPos[0] = $p - 1
			ExitLoop
		EndIf
		$p += 1
	Until 1 = 2
	; retrieve variable names from given string
	Do
		$aVars[$v] = StringMid($sString, $varPos[$n] + 1, $varPos[$n + 1] - $varPos[$n] - 1)
		$v += 1
		$n += 2
		If $varPos[0] < $n Then
			$aVars[0] = $v - 1
			ExitLoop
		EndIf
	Until 1 = 2
	; set internal variables
	$dvarNames[1] = 'shortVers'
	$dvarNames[2] = 'longVers'
	$dvarVals[1] = $VersAPP
	$dvarVals[2] = $VersAPP2
	$dvarCount += 2
	; get declared variables list
	For $c = 3 To $dvarCount
		$dvarNames[$c] = _GUICtrlListView_GetItemText($E_LIST, $c - 3, 0)
		$dvarVals[$c] = _GUICtrlListView_GetItemText($E_LIST, $c - 3, 1)
	Next
	; replace variables
	For $c = 1 To $aVars[0]
		For $n = 1 To $dvarCount
			If StringLeft($aVars[$c], 1) = '^' Then
				$sString = StringReplace($sString, '%' & $aVars[$c] & '%', '%' & StringTrimLeft($aVars[$c], 1) & '%')
			ElseIf $aVars[$c] = $dvarNames[$n] Then
				$sString = StringReplace($sString, '%' & $dvarNames[$n] & '%', $dvarVals[$n])
			EndIf
		Next
	Next
	Return $sString
EndFunc   ;==>_ReplaceVariables
Func _reFormat_VersData($sVer)
	If Not StringIsDigit(StringLeft($sVer, 1)) Then Return ''
	Local $cNum[2] = ['', ''], $tPart = '', $nPart = ''
	Local $dotNum = 0, $nNum = 0
	Do
		$nNum += 1
		$cNum[0] = $cNum[1]
		$cNum[1] = StringMid($sVer, $nNum, 1)
		If $cNum[1] = '.' Then
			$dotNum += 1
			If $cNum[0] = '.' Then
				$nPart = StringLeft($sVer, $nNum - 1)
				$tPart = StringMid($sVer, $nNum)
				ExitLoop
			EndIf
			If $dotNum = 4 Then
				$nPart = StringLeft($sVer, $nNum - 1)
				$tPart = StringMid($sVer, $nNum)
				ExitLoop
			EndIf
		EndIf
		If Not StringIsDigit($cNum[1]) And $cNum[1] <> '.' Then
			$nPart = StringLeft($sVer, $nNum - 1)
			$tPart = StringMid($sVer, $nNum)
			ExitLoop
		EndIf
	Until 1 = 2
	If _StringGetStrCount($nPart, '.') < 3 Or Not StringIsDigit(StringRight($nPart, 1)) Then
		Do
			If StringIsDigit(StringRight($nPart, 1)) = '.' Then
				$nPart &= '0'
			Else
				$nPart &= '.'
			EndIf
		Until _StringGetStrCount($nPart, '.') = 3 And StringIsDigit(StringRight($nPart, 1))
	EndIf
	If StringLeft($tPart, 1) <> ' ' Then $tPart = ' ' & $tPart
	If StringInStr($tPart, '"') Then $tPart = StringReplace($tPart, '"', "'")
	Return $nPart & $tPart
EndFunc   ;==>_reFormat_VersData
Func _Path_Check($szPath)
	If Not StringInStr($szPath, '\') Then Return SetError(1, 0, False)
	If Not StringInStr($szPath, ':') Then Return SetError(2, 0, False)
	If StringInStr($szPath, ':', 0, 2) Then Return SetError(3, 0, False)
	If StringRegExp($szPath, '[/*?"<>|]') Then Return SetError(4, 0, False)
	If StringLen($szPath) <= 3 Then Return SetError(5, 0, False)
	Return True
EndFunc   ;==>_Path_Check
Func _FileGetPathData($szPath, $iMode = 0)
	Local $dir = ''
	Local $fname = ''
	Local $bname = ''
	Local $ext = ''
	Local $pos[2]
	If $iMode > 3 Or Not StringIsDigit($iMode) Then Return SetError(1, 1, '')

	; Check if we have full path to file
	If Not StringInStr($szPath, ':') Or _
			Not StringInStr($szPath, '\') Then Return SetError(2, 2, '')

	; Set the directory and file name
	$pos[0] = StringInStr($szPath, '\', 0, -1)
	$dir = StringLeft($szPath, $pos[0])
	$fname = StringRight($szPath, StringLen($szPath) - $pos[0])
	; remove trailing backslash
	$dir = StringTrimRight($dir, 1)
	If $iMode = 0 Then Return $dir
	If $iMode = 1 Then Return $fname

	; Set file extension
	$pos[1] = StringInStr($szPath, '.', 0, -1)
	If $pos[1] > $pos[0] Then
		$pos[1] = StringInStr($fname, '.', 0, -1)
		$ext = StringRight($fname, StringLen($fname) - $pos[1])
		$bname = StringTrimRight($fname, StringLen($ext) + 1)
	Else
		$bname = $fname
	EndIf
	If $iMode = 2 Then Return $bname
	If $iMode = 3 Then Return $ext
EndFunc   ;==>_FileGetPathData
Func _StringGetStrCount($Str, $sStr)
	If Not StringInStr($Str, $sStr) Then Return 0
	Local $_count = 0
	Do
		$_count += 1
	Until Not StringInStr($Str, $sStr, 0, $_count + 1)
	Return $_count
EndFunc   ;==>_StringGetStrCount
Func _Load_Int_Preset()
	Dim $pDataInt[1000][10]
	$pDataInt[0][0] = $pData[0][0]
	If $pData[0][0] = 0 Then Return
	For $c = 1 To $pData[0][0]
		$pDataInt[$c][0] = $pData[$c][0]
		$pDataInt[$c][1] = $pData[$c][1]
		$pDataInt[$c][2] = $pData[$c][2]
		$pDataInt[$c][3] = $pData[$c][3]
		$pDataInt[$c][4] = $pData[$c][4]
		$pDataInt[$c][5] = $pData[$c][5]
		$pDataInt[$c][6] = $pData[$c][6]
		$pDataInt[$c][7] = $pData[$c][7]
		$pDataInt[$c][8] = $pData[$c][8]
		$pDataInt[$c][9] = $pData[$c][9]
		_GUICtrlComboBox_AddString($PRE_CMB, $pDataInt[$c][0])
	Next
EndFunc   ;==>_Load_Int_Preset
Func _Reset_Preset()
	GUICtrlSetData($PRE_INP_TIT, '')
	GUICtrlSetData($PRE_INP_XCT, '')
	GUICtrlSetData($PRE_INP_XPT, '')
	GUICtrlSetData($PRE_INP_XT, '')
	GUICtrlSetData($PRE_EDT_BP, '')
	GUICtrlSetData($PRE_EDT_XPT, '')
	GUICtrlSetData($PRE_EDT_XDT, '')
	GUICtrlSetData($PRE_EDT_CP, '')
	GUICtrlSetData($PRE_EDT_FM, '')
EndFunc   ;==>_Reset_Preset
Func _Write_Preset()
	Dim $pData[1000][10]
	$pData[0][0] = $pDataInt[0][0]
	If $pData[0][0] > 0 Then
		For $c = 1 To $pData[0][0]
			$pData[$c][0] = $pDataInt[$c][0]
			$pData[$c][1] = $pDataInt[$c][1]
			$pData[$c][2] = $pDataInt[$c][2]
			$pData[$c][3] = $pDataInt[$c][3]
			$pData[$c][4] = $pDataInt[$c][4]
			$pData[$c][5] = $pDataInt[$c][5]
			$pData[$c][6] = $pDataInt[$c][6]
			$pData[$c][7] = $pDataInt[$c][7]
			$pData[$c][8] = $pDataInt[$c][8]
			$pData[$c][9] = $pDataInt[$c][9]
		Next
	EndIf
	_Preset_Create_MenuItem()
	If $RegMode = 1 Then
		RegDelete($reg_profPath & '\Presets')
		If $pData[0][0] <= 0 Then Return
		For $c = 1 To $pData[0][0]
			RegWrite($reg_profPath & '\Presets\' & $c, 'Name', 'REG_SZ', $pData[$c][0])
			RegWrite($reg_profPath & '\Presets\' & $c, 'Title', 'REG_SZ', $pData[$c][1])
			RegWrite($reg_profPath & '\Presets\' & $c, 'ExtractPathTitle', 'REG_SZ', $pData[$c][2])
			RegWrite($reg_profPath & '\Presets\' & $c, 'ExtractTitle', 'REG_SZ', $pData[$c][3])
			RegWrite($reg_profPath & '\Presets\' & $c, 'ExtractCancelText', 'REG_SZ', $pData[$c][4])
			RegWrite($reg_profPath & '\Presets\' & $c, 'BeginPrompt', 'REG_SZ', $pData[$c][5])
			RegWrite($reg_profPath & '\Presets\' & $c, 'ExtractPathText', 'REG_SZ', $pData[$c][6])
			RegWrite($reg_profPath & '\Presets\' & $c, 'ExtractDialogText', 'REG_SZ', $pData[$c][7])
			RegWrite($reg_profPath & '\Presets\' & $c, 'CancelPrompt', 'REG_SZ', $pData[$c][8])
			RegWrite($reg_profPath & '\Presets\' & $c, 'FinishMessage', 'REG_SZ', $pData[$c][9])
		Next
	Else
		Local $iniEnum = IniReadSectionNames($SetsINI)
		If Not @error Then
			For $i = 1 To $iniEnum[0]
				If StringLeft($iniEnum[$i], 10) = 'Preset_' Then IniDelete($SetsINI, $iniEnum[$i])
			Next
		EndIf
		If $pData[0][0] <= 0 Then Return
		For $c = 1 To $pData[0][0]
			IniWrite($SetsINI, 'Preset_' & $c, 'Name', $pData[$c][0])
			IniWrite($SetsINI, 'Preset_' & $c, 'Title', $pData[$c][1])
			IniWrite($SetsINI, 'Preset_' & $c, 'ExtractPathTitle', $pData[$c][2])
			IniWrite($SetsINI, 'Preset_' & $c, 'ExtractTitle', $pData[$c][3])
			IniWrite($SetsINI, 'Preset_' & $c, 'ExtractCancelText', $pData[$c][4])
			IniWrite($SetsINI, 'Preset_' & $c, 'BeginPrompt', $pData[$c][5])
			IniWrite($SetsINI, 'Preset_' & $c, 'ExtractPathText', $pData[$c][6])
			IniWrite($SetsINI, 'Preset_' & $c, 'ExtractDialogText', $pData[$c][7])
			IniWrite($SetsINI, 'Preset_' & $c, 'CancelPrompt', $pData[$c][8])
			IniWrite($SetsINI, 'Preset_' & $c, 'FinishMessage', $pData[$c][9])
		Next
	EndIf
EndFunc   ;==>_Write_Preset
Func _Preset_Create_MenuItem()
	; Delete existing
	If _GUICtrlMenu_GetItemCount($h_Menu_Preset) > 2 Then
		For $c = 3 To _GUICtrlMenu_GetItemCount($h_Menu_Preset)
			_GUICtrlMenu_DeleteMenu($h_Menu_Preset, 2)
		Next
		$Mi_PRESET[0] = 0
	EndIf
	If $pData[0][0] = 0 Then Return
	For $c = 1 To $pData[0][0]
		$Mi_PRESET[$c] = _GUICtrlCreateMenuItemEx($pData[$c][0], $c_Menu_Preset, $c + 1)
		$Mi_PRESET[0] += 1
		GUICtrlSetOnEvent($Mi_PRESET[$c], '_Select_Preset')
	Next
EndFunc   ;==>_Preset_Create_MenuItem
Func _Select_Preset()
	Local $owVal = False
	Local $indexVal = 0
	If $pData[0][0] < 1 Then Return
	For $c = 1 To $pData[0][0]
		If @GUI_CtrlId = $Mi_PRESET[$c] Then
			$indexVal = $c
			ExitLoop
		EndIf
	Next
	If $indexVal = 0 Then Return
	$iMsgBoxAnswer = _MsgBoxEx(33)
	If $iMsgBoxAnswer = 2 Then Return
	If $iMsgBoxAnswer = 6 Then $owVal = True
	If $owVal = True Then
		GUICtrlSetData($T_INP_WINTITLE, $pData[$indexVal][1])
		GUICtrlSetData($T_INP_XPATHWINTITLE, $pData[$indexVal][2])
		GUICtrlSetData($T_INP_XTITLE, $pData[$indexVal][3])
		GUICtrlSetData($T_INP_XCANCELTEXT, $pData[$indexVal][4])
		GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][5])
		GUICtrlSetData($MS_EDT_MESSAGES[2], $pData[$indexVal][6])
		GUICtrlSetData($MS_EDT_MESSAGES[3], $pData[$indexVal][7])
		GUICtrlSetData($MS_EDT_MESSAGES[4], $pData[$indexVal][8])
		GUICtrlSetData($MS_EDT_MESSAGES[5], $pData[$indexVal][9])
	Else
		If GUICtrlRead($T_INP_WINTITLE) = '' Then GUICtrlSetData($T_INP_WINTITLE, $pData[$indexVal][1])
		If GUICtrlRead($T_INP_XPATHWINTITLE) = '' Then GUICtrlSetData($T_INP_XPATHWINTITLE, $pData[$indexVal][2])
		If GUICtrlRead($T_INP_XTITLE) = '' Then GUICtrlSetData($T_INP_XTITLE, $pData[$indexVal][3])
		If GUICtrlRead($T_INP_XCANCELTEXT) = '' Then GUICtrlSetData($T_INP_XCANCELTEXT, $pData[$indexVal][4])
		If GUICtrlRead($MS_EDT_MESSAGES[1]) = '' Then GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][5])
		If GUICtrlRead($MS_EDT_MESSAGES[2]) = '' Then GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][6])
		If GUICtrlRead($MS_EDT_MESSAGES[3]) = '' Then GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][7])
		If GUICtrlRead($MS_EDT_MESSAGES[4]) = '' Then GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][8])
		If GUICtrlRead($MS_EDT_MESSAGES[5]) = '' Then GUICtrlSetData($MS_EDT_MESSAGES[1], $pData[$indexVal][9])
	EndIf
EndFunc   ;==>_Select_Preset
Func _Load_Preset()
	Local $c = 1
	Local $tmpName
	Local $pKey[1000]
	Dim $pData[1000][10]
	Do
		If $RegMode = 1 Then
			$pKey[$c] = RegEnumKey($reg_profPath & '\Presets', $c)
			If @error Then
				$pKey[0] = $c - 1
				ExitLoop
			EndIf
		Else
			IniReadSection($SetsINI, 'Preset_' & $c)
			If @error Then
				$pKey[0] = $c - 1
				ExitLoop
			EndIf
		EndIf
		$c += 1
		If $c = 1000 Then
			$pKey[0] = $c - 1
			ExitLoop
		EndIf
	Until 1 > 1
	$c = 1
	For $_c = 1 To $pKey[0]
		If $RegMode = 1 Then
			$tmpName = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'Name')
			If $tmpName <> '' Then
				$pData[$c][0] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'Name')
				$pData[$c][1] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'Title')
				$pData[$c][2] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'ExtractPathTitle')
				$pData[$c][3] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'ExtractTitle')
				$pData[$c][4] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'ExtractCancelText')
				$pData[$c][5] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'BeginPrompt')
				$pData[$c][6] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'ExtractPathText')
				$pData[$c][7] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'ExtractDialogText')
				$pData[$c][8] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'CancelPrompt')
				$pData[$c][9] = RegRead($reg_profPath & '\Presets\' & $pKey[$c], 'FinishMessage')
				$c += 1
			EndIf
		Else
			$tmpName = IniRead($SetsINI, 'Preset_' & $c, '', 'Name')
			If $tmpName <> '' Then
				$pData[$c][0] = IniRead($SetsINI, 'Preset_' & $c, '', 'Name')
				$pData[$c][1] = IniRead($SetsINI, 'Preset_' & $c, '', 'Title')
				$pData[$c][2] = IniRead($SetsINI, 'Preset_' & $c, '', 'ExtractPathTitle')
				$pData[$c][3] = IniRead($SetsINI, 'Preset_' & $c, '', 'ExtractTitle')
				$pData[$c][4] = IniRead($SetsINI, 'Preset_' & $c, '', 'ExtractCancelText')
				$pData[$c][5] = IniRead($SetsINI, 'Preset_' & $c, '', 'BeginPrompt')
				$pData[$c][6] = IniRead($SetsINI, 'Preset_' & $c, '', 'ExtractPathText')
				$pData[$c][7] = IniRead($SetsINI, 'Preset_' & $c, '', 'ExtractDialogText')
				$pData[$c][8] = IniRead($SetsINI, 'Preset_' & $c, '', 'CancelPrompt')
				$pData[$c][9] = IniRead($SetsINI, 'Preset_' & $c, '', 'FinishMessage')
				$c += 1
			EndIf
		EndIf
		$pData[0][0] = $c - 1
	Next
EndFunc   ;==>_Load_Preset
Func _Load_GMFlags()
	Local $hData = ''
	If $RegMode = 1 Then
		Local $gfN[100] = [0]
		Do
			$gfN[$gfN[0] + 1] = RegEnumVal($reg_profPath & '\GuiFlags', $gfN[0] + 1)
			If @error Then ExitLoop
			$gfN[0] += 1
		Until 1 > 1
		If $gfN[0] = 0 Then Return SetError(1, 1, '')
		For $c = 1 To $gfN[0]
			$hData &= RegRead($reg_profPath & '\GuiFlags', $gfN[$c]) & '|'
		Next
	Else
		Local $gfN = IniReadSection($SetsINI, 'GuiFlags')
		If @error Then Return SetError(1, 1, '')
		If $gfN[0][0] = 0 Then Return SetError(1, 1, '')
		For $c = 1 To $gfN[0][0]
			$hData &= $gfN[$c][1] & '|'
		Next
	EndIf
	Return $hData
EndFunc   ;==>_Load_GMFlags
Func _Write_GMFlags($cIndex, $cData = '')
	If $cIndex = -1 Then
		If $RegMode = 1 Then
			RegDelete($reg_profPath & '\GuiFlags')
			RegWrite($reg_profPath & '\GuiFlags')
		Else
			IniDelete($SetsINI, 'GuiFlags')
			IniWriteSection($SetsINI, 'GuiFlags', '')
		EndIf
		Return
	ElseIf Not StringIsDigit($cIndex) Or $cIndex < 1 Then
		Return
	EndIf
	If $RegMode = 1 Then
		RegWrite($reg_profPath & '\GuiFlags', $cIndex, 'REG_SZ', $cData)
	Else
		IniWrite($SetsINI, 'GuiFlags', $cIndex, $cData)
	EndIf
EndFunc   ;==>_Write_GMFlags
Func _Enum_GMFlags($iMode = 0)
	Local $gData = '', $mData = ''
	If GUICtrlRead($GFL_CHK[1]) = 1 Then $gData &= '+1'
	If GUICtrlRead($GFL_CHK[2]) = 1 Then $gData &= '+2'
	If GUICtrlRead($GFL_CHK[3]) = 1 Then $gData &= '+4'
	If GUICtrlRead($GFL_CHK[4]) = 1 Then $gData &= '+8'
	If GUICtrlRead($GFL_CHK[5]) = 1 Then $gData &= '+16'
	If GUICtrlRead($GFL_CHK[6]) = 1 Then $gData &= '+32'
	If GUICtrlRead($GFL_CHK[7]) = 1 Then $gData &= '+64'
	If GUICtrlRead($GFL_CHK[8]) = 1 Then $gData &= '+128'
	If GUICtrlRead($GFL_CHK[9]) = 1 Then $gData &= '+256'
	If GUICtrlRead($GFL_CHK[10]) = 1 Then $gData &= '+512'
	If GUICtrlRead($GFL_CHK[11]) = 1 Then $gData &= '+1024'
	If GUICtrlRead($GFL_CHK[12]) = 1 Then $gData &= '+2048'
	If GUICtrlRead($GFL_CHK[13]) = 1 Then $gData &= '+4096'
	If GUICtrlRead($GFL_CHK[14]) = 1 Then $gData &= '+8192'
	If GUICtrlRead($GFL_CHK[15]) = 1 Then $gData &= '+16384'
	If GUICtrlRead($GFL_CHK[16]) = 1 Then $mData &= '+1'
	If GUICtrlRead($GFL_CHK[17]) = 1 Then $mData &= '+2'
	If GUICtrlRead($GFL_CHK[18]) = 1 Then $mData &= '+4'
	If GUICtrlRead($GFL_CHK[19]) = 1 Then $mData &= '+8'
	If StringLeft($gData, 1) = '+' Then $gData = StringTrimLeft($gData, 1)
	If StringLeft($mData, 1) = '+' Then $mData = StringTrimLeft($mData, 1)
	If ($gData & $mData) = '' Then Return ''
	If $iMode = 0 Then
		Return 'G' & $gData & 'M' & $mData
	ElseIf $iMode = 1 Then
		Return $gData
	ElseIf $iMode = 2 Then
		Return $mData
	Else
		Return SetError(1, 0, '')
	EndIf
EndFunc   ;==>_Enum_GMFlags
Func _Set_GMFlags($hData)
	Local $gData = '', $mData = ''
	If $hData = '' Then Return SetError(1)
	If _StringGetStrCount($hData, 'G') > 1 Or _StringGetStrCount($hData, 'G') > 1 Then Return SetError(2)
	If Not (StringInStr($hData, 'G') And StringInStr($hData, 'M')) Then
		$gData = $hData
	Else
		If StringInStr($hData, 'G') Then
			$gData = StringMid($hData, StringInStr($hData, 'G') + 1)
			If StringInStr($gData, 'M') Then $gData = StringMid($gData, 1, StringInStr($gData, 'M') - 1)
		EndIf
		If StringInStr($hData, 'M') Then
			$mData = StringMid($hData, StringInStr($hData, 'M') + 1)
			If StringInStr($mData, 'G') Then $mData = StringMid($mData, 1, StringInStr($mData, 'G') - 1)
		EndIf
	EndIf
	_Reset_GMFlags()
	If $gData <> '' Then
		$gData = StringSplit($gData, '+')
		For $c = 1 To $gData[0]
			Switch $gData[$c]
				Case '1'
					GUICtrlSetState($GFL_CHK[1], 1)
				Case '2'
					GUICtrlSetState($GFL_CHK[2], 1)
				Case '4'
					GUICtrlSetState($GFL_CHK[3], 1)
				Case '8'
					GUICtrlSetState($GFL_CHK[4], 1)
				Case '16'
					GUICtrlSetState($GFL_CHK[5], 1)
				Case '32'
					GUICtrlSetState($GFL_CHK[6], 1)
				Case '64'
					GUICtrlSetState($GFL_CHK[7], 1)
				Case '128'
					GUICtrlSetState($GFL_CHK[8], 1)
				Case '256'
					GUICtrlSetState($GFL_CHK[9], 1)
				Case '512'
					GUICtrlSetState($GFL_CHK[10], 1)
				Case '1024'
					GUICtrlSetState($GFL_CHK[11], 1)
				Case '2048'
					GUICtrlSetState($GFL_CHK[12], 1)
				Case '4096'
					GUICtrlSetState($GFL_CHK[13], 1)
				Case '8192'
					GUICtrlSetState($GFL_CHK[14], 1)
				Case '16384'
					GUICtrlSetState($GFL_CHK[15], 1)
			EndSwitch
		Next
	EndIf
	If $mData <> '' Then
		$mData = StringSplit($mData, '+')
		For $c = 1 To $mData[0]
			Switch $mData[$c]
				Case '1'
					GUICtrlSetState($GFL_CHK[16], 1)
				Case '2'
					GUICtrlSetState($GFL_CHK[17], 1)
				Case '4'
					GUICtrlSetState($GFL_CHK[18], 1)
				Case '8'
					GUICtrlSetState($GFL_CHK[19], 1)
			EndSwitch
		Next
	EndIf
EndFunc   ;==>_Set_GMFlags
Func _Reset_GMFlags()
	For $c = 1 To 19
		GUICtrlSetState($GFL_CHK[$c], 4)
	Next
EndFunc   ;==>_Reset_GMFlags
Func _ExportSettings($hFile, $iMode = 0)
	If $iMode <> 1 And $iMode <> 2 Then Return SetError(1)
	Local $hData, $mruList = _MRU_Load_List()
	$cPos = WinGetPos($GUI_MAIN)
	If $iMode = 1 Then
		$hData = 'Windows Registry Editor Version 5.00' & @CRLF & @CRLF & _
				'[' & $reg_Path & ']' & @CRLF & _
				'"Lang"="' & $CurLang[0] & '"' & @CRLF & _
				'"XPos"="' & $cPos[0] & '"' & @CRLF & _
				'"YPos"="' & $cPos[1] & '"' & @CRLF & _
				'"UseUPX"="' & $USE_UPX[0] & '"' & @CRLF & _
				'"UPXCommands"="' & $USE_UPX[1] & '"' & @CRLF & _
				'"UseDefaultSFXMod"="' & $USE_DEFMOD[0] & '"' & @CRLF & _
				'"DefaultSFXMod"="' & $USE_DEFMOD[1] & '"' & @CRLF & _
				'"AutoSelectModule"="' & $ModeAUTOMOD & '"' & @CRLF & _
				'"IgnoreEmptyVersData"="' & $ModeNOVERS & '"' & @CRLF & _
				'"AutoDetermineSFXPath"="' & $ModeAUTOSFX & '"' & @CRLF & _
				'"OverwriteSFX"="' & $ModeOWSFX & '"' & @CRLF & @CRLF & _
				'[' & $reg_7zPath & ']' & @CRLF & _
				'"Path"="' & StringReplace($7ZIP_PATH, '\', '\\') & '"' & @CRLF & _
				'"Level"="' & $7z_LVL[0] & '"' & @CRLF & _
				'"Method"="' & $7z_METHOD[0] & '"' & @CRLF & _
				'"Dictionary"="' & $7z_DICT[0] & '"' & @CRLF & _
				'"BlockSize"="' & $7z_SOLID[0] & '"' & @CRLF & @CRLF & _
				'[' & $reg_mruPath & ']' & @CRLF & _
				'"1"="' & StringReplace($mruList[1], '\', '\\') & '"' & @CRLF & _
				'"2"="' & StringReplace($mruList[2], '\', '\\') & '"' & @CRLF & _
				'"3"="' & StringReplace($mruList[3], '\', '\\') & '"' & @CRLF & _
				'"4"="' & StringReplace($mruList[4], '\', '\\') & '"' & @CRLF & _
				'"5"="' & StringReplace($mruList[5], '\', '\\') & '"' & @CRLF & @CRLF & _
				'[' & $reg_Path & '\ResInfo]' & @CRLF & _
				'"FileVersion"="' & RegRead($reg_Path & '\ResInfo', 'FileVersion') & '"' & @CRLF & _
				'"CompanyName"="' & RegRead($reg_Path & '\ResInfo', 'CompanyName') & '"' & @CRLF & _
				'"Comments"="' & RegRead($reg_Path & '\ResInfo', 'Comments') & '"' & @CRLF & _
				'"FileDescription"="' & RegRead($reg_Path & '\ResInfo', 'FileDescription') & '"' & @CRLF & _
				'"ProductVersion"="' & RegRead($reg_Path & '\ResInfo', 'ProductVersion') & '"' & @CRLF & _
				'"ProductName"="' & RegRead($reg_Path & '\ResInfo', 'ProductName') & '"' & @CRLF & _
				'"LegalCopyright"="' & RegRead($reg_Path & '\ResInfo', 'LegalCopyright') & '"' & @CRLF & _
				'"LegalTrademarks"="' & RegRead($reg_Path & '\ResInfo', 'LegalTrademarks') & '"' & @CRLF & _
				'"InternalName"="' & RegRead($reg_Path & '\ResInfo', 'InternalName') & '"' & @CRLF & _
				'"OriginalFilename"="' & RegRead($reg_Path & '\ResInfo', 'OriginalFilename') & '"' & @CRLF & _
				'"SpecialBuild"="' & RegRead($reg_Path & '\ResInfo', 'SpecialBuild') & '"' & @CRLF & _
				'"PrivateBuild"="' & RegRead($reg_Path & '\ResInfo', 'PrivateBuild') & '"' & @CRLF & @CRLF
		_Load_Preset()
		If $pData[0][0] > 0 Then
			For $c = 1 To $pData[0][0]
				$hData &= '[' & $reg_profPath & '\Presets\' & $c & ']' & @CRLF & _
						'"Name"="' & $pData[$c][0] & '"' & @CRLF & _
						'"Title"="' & $pData[$c][1] & '"' & @CRLF & _
						'"ExtractPathTitle"="' & $pData[$c][2] & '"' & @CRLF & _
						'"ExtractTitle"="' & $pData[$c][3] & '"' & @CRLF & _
						'"ExtractCancelText"="' & $pData[$c][4] & '"' & @CRLF & _
						'"BeginPrompt"="' & $pData[$c][5] & '"' & @CRLF & _
						'"ExtractPathText"="' & $pData[$c][6] & '"' & @CRLF & _
						'"ExtractDialogText"="' & $pData[$c][7] & '"' & @CRLF & _
						'"CancelPrompt"="' & $pData[$c][8] & '"' & @CRLF & _
						'"FinishMessage"="' & $pData[$c][9] & '"' & @CRLF & @CRLF
			Next
		EndIf
		Local $gfData = _Load_GMFlags()
		If $gfData <> '' Then
			If StringRight($gfData, 1) = '|' Then $gfData = StringTrimRight($gfData, 1)
			$hData &= '[' & $reg_profPath & '\GuiFlags]' & @CRLF
			$gfData = StringSplit($gfData, '|')
			For $c = 1 To $gfData[0]
				$hData &= '"' & $c & '"="' & $gfData[$c] & '"' & @CRLF
			Next
		EndIf
	ElseIf $iMode = 2 Then
		$hData = '[Main]' & @CRLF & _
				'Lang=' & $CurLang[0] & @CRLF & _
				'XPos=' & $cPos[0] & @CRLF & _
				'YPos=' & $cPos[1] & @CRLF & _
				'UseUPX=' & $USE_UPX[0] & @CRLF & _
				'UPXCommands=' & $USE_UPX[1] & @CRLF & _
				'UseDefaultSFXMod=' & $USE_DEFMOD[0] & @CRLF & _
				'DefaultSFXMod=' & $USE_DEFMOD[1] & @CRLF & _
				'AutoSelectModule=' & $ModeAUTOMOD & @CRLF & _
				'IgnoreEmptyVersData=' & $ModeNOVERS & @CRLF & _
				'AutoDetermineSFXPath=' & $ModeAUTOSFX & @CRLF & _
				'OverwriteSFX=' & $ModeOWSFX & @CRLF & @CRLF & _
				'[7-Zip]' & @CRLF & _
				'Path=' & $7ZIP_PATH & @CRLF & _
				'Level=' & $7z_LVL[0] & @CRLF & _
				'Method=' & $7z_METHOD[0] & @CRLF & _
				'Dictionary=' & $7z_DICT[0] & @CRLF & _
				'BlockSize=' & $7z_SOLID[0] & @CRLF & @CRLF & _
				'[MRUList]' & @CRLF & _
				'1=' & $mruList[1] & @CRLF & _
				'2=' & $mruList[2] & @CRLF & _
				'3=' & $mruList[3] & @CRLF & _
				'4=' & $mruList[4] & @CRLF & _
				'5=' & $mruList[5] & @CRLF & @CRLF & _
				'[VersionInfo]' & @CRLF & _
				'FileVersion=' & IniRead($SetsINI, 'VersionInfo', 'FileVersion', '') & @CRLF & _
				'CompanyName=' & IniRead($SetsINI, 'VersionInfo', 'CompanyName', '') & @CRLF & _
				'Comments=' & IniRead($SetsINI, 'VersionInfo', 'Comments', '') & @CRLF & _
				'FileDescription=' & IniRead($SetsINI, 'VersionInfo', 'FileDescription', '') & @CRLF & _
				'ProductVersion=' & IniRead($SetsINI, 'VersionInfo', 'ProductVersion', '') & @CRLF & _
				'ProductName=' & IniRead($SetsINI, 'VersionInfo', 'ProductName', '') & @CRLF & _
				'LegalCopyright=' & IniRead($SetsINI, 'VersionInfo', 'LegalCopyright', '') & @CRLF & _
				'LegalTrademarks=' & IniRead($SetsINI, 'VersionInfo', 'LegalTrademarks', '') & @CRLF & _
				'InternalName=' & IniRead($SetsINI, 'VersionInfo', 'InternalName', '') & @CRLF & _
				'OriginalFilename=' & IniRead($SetsINI, 'VersionInfo', 'OriginalFilename', '') & @CRLF & _
				'SpecialBuild=' & IniRead($SetsINI, 'VersionInfo', 'SpecialBuild', '') & @CRLF & _
				'PrivateBuild=' & IniRead($SetsINI, 'VersionInfo', 'PrivateBuild', '') & @CRLF & @CRLF
		_Load_Preset()
		If $pData[0][0] > 0 Then
			For $c = 1 To $pData[0][0]
				$hData &= '[Preset_' & $c & ']' & @CRLF & _
						'Name=' & $pData[$c][0] & @CRLF & _
						'Title=' & $pData[$c][1] & @CRLF & _
						'ExtractPathTitle=' & $pData[$c][2] & @CRLF & _
						'ExtractTitle=' & $pData[$c][3] & @CRLF & _
						'ExtractCancelText=' & $pData[$c][4] & @CRLF & _
						'BeginPrompt=' & $pData[$c][5] & @CRLF & _
						'ExtractPathText=' & $pData[$c][6] & @CRLF & _
						'ExtractDialogText=' & $pData[$c][7] & @CRLF & _
						'CancelPrompt=' & $pData[$c][8] & @CRLF & _
						'FinishMessage=' & $pData[$c][9] & @CRLF & @CRLF
			Next
		EndIf
		Local $gfData = _Load_GMFlags()
		If $gfData <> '' Then
			If StringRight($gfData, 1) = '|' Then $gfData = StringTrimRight($gfData, 1)
			$hData &= '[GuiFlags]' & @CRLF
			$gfData = StringSplit($gfData, '|')
			For $c = 1 To $gfData[0]
				$hData &= $c & '=' & $gfData[$c] & @CRLF
			Next
		EndIf
	Else
		Return SetError(3)
	EndIf
	_FileOpenEx($hFile, 34, $hData)
	If @error Then
		_MsgBoxEx(112)
		Return SetError(2, 0, 0)
	EndIf
EndFunc   ;==>_ExportSettings
Func _ArcFiles_List()
	If _GUICtrlListView_GetSelectedCount($ARC_LST) = 1 Then
		Local $selText = _GUICtrlListView_GetItemText($ARC_LST, _GUICtrlListView_GetSelectionMark($ARC_LST))
		If StringRight($selText, 1) = '\' Then
			GUICtrlSetState($ARC_CHK, $GUI_ENABLE)
			GUICtrlSetState($ARC_CHK, $GUI_UNCHECKED)
		ElseIf StringRight($selText, 2) = '\*' Then
			GUICtrlSetState($ARC_CHK, $GUI_ENABLE)
			GUICtrlSetState($ARC_CHK, $GUI_CHECKED)
		Else
			GUICtrlSetState($ARC_CHK, $GUI_DISABLE)
		EndIf
	Else
		GUICtrlSetState($ARC_CHK, $GUI_DISABLE)
	EndIf
EndFunc   ;==>_ArcFiles_List
Func _GUI_LangInfo()
	$GUI_LANG = GUICreate('About Language', 300, 250, $cPos[0] + 150, $cPos[1] + 110, $WS_SYSMENU, -1, $GUI_OPTS)
	Local $lFont = 'Sylfaen'
	$GUI_LNG_BTN_OK = GUICtrlCreateButton('OK', 205, 185, 75, 23)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	; language name
	GUICtrlCreateLabel($_LNG_ABOUT[1], 10, 5, 280, 26)
	GUICtrlSetColor(-1, 0x003399)
	GUICtrlSetFont(-1, 16, 1000, '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; version
	GUICtrlCreateLabel('Version ' & $_LNG_ABOUT[3], 11, 35, 270)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 8, 1000, '', $lFont)
	; Author:
	GUICtrlCreateLabel('Author:', 10, 70, 90)
	GUICtrlSetColor(-1, 0x333333)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; ---
	GUICtrlCreateLabel($_LNG_ABOUT[4], 100, 70, 200)
	GUICtrlSetColor(-1, 0x4866DE)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; Contact:
	GUICtrlCreateLabel('Contact:', 10, 95, 90)
	GUICtrlSetColor(-1, 0x333333)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; ---
	$GUI_LNG_LBL_CONTACT = GUICtrlCreateLabel($_LNG_ABOUT[5], 100, 95, 200)
	GUICtrlSetColor(-1, 0x4866DE)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetCursor(-1, 0)
	; English Name:
	GUICtrlCreateLabel('English Name:', 10, 120, 90)
	GUICtrlSetColor(-1, 0x333333)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; ---
	GUICtrlCreateLabel($_LNG_ABOUT[1], 100, 120, 200)
	GUICtrlSetColor(-1, 0x4866DE)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; Native Name:
	GUICtrlCreateLabel('Native Name:', 10, 145, 90)
	GUICtrlSetColor(-1, 0x333333)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; ---
	GUICtrlCreateLabel($_LNG_ABOUT[2], 100, 145, 200)
	GUICtrlSetColor(-1, 0x4866DE)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetBkColor(-1, -2)
	; graphic
	; 1st white area
	GUICtrlCreateGraphic(0, 0, 294, 60)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	; blue line
	GUICtrlCreateGraphic(0, 60, 294, 5)
	GUICtrlSetBkColor(-1, 0x33ccff)
	; 2nd white area
	GUICtrlCreateGraphic(0, 65, 294, 108)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	; black line
	GUICtrlCreateGraphic(0, 173, 294, 1)
	GUICtrlSetBkColor(-1, 0x808080)
	GUICtrlSetOnEvent($GUI_LNG_BTN_OK, '_GUI_LangInfo_Events')
	GUICtrlSetOnEvent($GUI_LNG_LBL_CONTACT, '_GUI_LangInfo_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_LangInfo_Events')
	GUISetState(@SW_SHOW, $GUI_LANG)
EndFunc   ;==>_GUI_LangInfo
Func _GUI_LangInfo_Events()
	Select
		Case @GUI_CtrlId = $GUI_LNG_LBL_CONTACT
			_RunDos('start ' & $_LNG_ABOUT[6])
		Case @GUI_CtrlId = $GUI_LNG_BTN_OK Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_Close_Window($GUI_LANG, $GUI_OPTS)
	EndSelect
EndFunc   ;==>_GUI_LangInfo_Events
; ***********************************************************
; *				 			ABOUT							*
; ***********************************************************
Func _GUI_About()
	$GUI_ABOUT = GUICreate('About', 300, 280, $cPos[0] + 150, $cPos[1] + 110, $WS_SYSMENU, -1, $GUI_MAIN)
	Local $lFont = 'Sylfaen'
	$GUI_ABOUT_BUTTON_OK = GUICtrlCreateButton('OK', 200, 215, 80, 25)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetOnEvent($GUI_ABOUT_BUTTON_OK, '_GUI_About_Events')
	; appname
	GUICtrlCreateLabel($NameAPP, 10, 10, 270, 40)
	GUICtrlSetColor(-1, 0x003399)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 16, 1000, '', $lFont)
	; version
	GUICtrlCreateLabel('Version ' & $VersAPP, 10, 40, 270)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 9, 1000, '', $lFont)
	; publisher
	GUICtrlCreateLabel('Developed by:', 10, 80, 80, 25)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	; -
	$GUI_ABOUT_LABEL_MAIL = GUICtrlCreateLabel('Mirza Brunjadze', 100, 80, 180, 25)
	GUICtrlSetColor(-1, 0x33ccff)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetCursor(-1, 0)
	; contact
	GUICtrlCreateLabel('Project Site:', 10, 110, 80, 25)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	; -
	$GUI_ABOUT_LABEL_P_SITE = GUICtrlCreateLabel('SourceForge.net/Projects/...', 100, 110, 180, 25)
	GUICtrlSetColor(-1, 0x33ccff)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetCursor(-1, 0)
	; contact
	GUICtrlCreateLabel('Buuf icons by:', 10, 140, 80, 25)
	GUICtrlSetColor(-1, 0x000000)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	; -
	$GUI_ABOUT_LABEL_ICONS = GUICtrlCreateLabel('Paul Davey aka Mattahan', 100, 140, 180, 25)
	GUICtrlSetColor(-1, 0x33ccff)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 10, '', '', $lFont)
	GUICtrlSetCursor(-1, 0)
	; copyright
	GUICtrlCreateLabel('Copyright © 2012 - 2014 Mirza Brunjadze', 10, 180, 270, 20, 0x0002)
	GUICtrlSetColor(-1, 0x808080)
	GUICtrlSetBkColor(-1, -2)
	GUICtrlSetFont(-1, 9, '', '', $lFont)
	; graphic
	GUICtrlCreateGraphic(0, 0, 294, 70)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 70, 294, 5)
	GUICtrlSetBkColor(-1, 0x33ccff)
	GUICtrlCreateGraphic(0, 75, 294, 100)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 175, 294, 5)
	GUICtrlSetBkColor(-1, 0x33ccff)
	GUICtrlCreateGraphic(0, 180, 294, 23)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlCreateGraphic(0, 203, 294, 1)
	GUICtrlSetBkColor(-1, 0x808080)
	GUICtrlSetOnEvent($GUI_ABOUT_LABEL_P_SITE, '_GUI_About_Events')
	GUICtrlSetOnEvent($GUI_ABOUT_LABEL_ICONS, '_GUI_About_Events')
	GUICtrlSetOnEvent($GUI_ABOUT_LABEL_MAIL, '_GUI_About_Events')
	GUISetOnEvent($GUI_EVENT_CLOSE, '_GUI_About_Events')
	GUISetState(@SW_SHOW, $GUI_ABOUT)
EndFunc   ;==>_GUI_About
Func _GUI_About_Events()
	Select
		Case @GUI_CtrlId = $GUI_ABOUT_LABEL_P_SITE
			_GotoWebPage('http://sourceforge.net/projects/s-zipsfxbuilder/')
		Case @GUI_CtrlId = $GUI_ABOUT_LABEL_ICONS
			_GotoWebPage('http://mattahan.deviantart.com/')
			_GotoWebPage('mailto:mattahan@gmail.com')
		Case @GUI_CtrlId = $GUI_ABOUT_LABEL_MAIL
			_GotoWebPage('mailto:mirza.b.1695@gmail.com')
		Case @GUI_CtrlId = $GUI_ABOUT_BUTTON_OK Or @GUI_CtrlId = $GUI_EVENT_CLOSE
			_Close_Window($GUI_ABOUT, $GUI_MAIN)
	EndSelect
EndFunc   ;==>_GUI_About_Events
; ***********************************************************
; *						LOAD SFX							*
; ***********************************************************
Func _CFG_LoadExe($_exepath)
	$ModeEXE[0] = True
	$ModeEXE[1] = $_exepath
	_ClearTemp(4)
	If FileExists($Split_Dir) Then
		RunWait($Split_Dir & ' "' & $_exepath & '" -c "' & $TempSFXFLDR & '\sfx.txt" -b')
		If FileExists($TempSFXFLDR & '\sfx.txt') Then
			GUISetState(@SW_DISABLE, $GUI_MAIN)
			RunWait($Split_Dir & ' "' & $_exepath & '" -c "' & $TempSFXFLDR & '\sfx.txt" -b')
			RunWait($Split_Dir & ' "' & $_exepath & '" -m "' & $TempSFXFLDR & '\sfx.sfx" -b')
			RunWait($Split_Dir & ' "' & $_exepath & '" -a "' & $TempSFXFLDR & '\sfx.7z" -b')
			_ResExtractIcon($_exepath, $TempSFXFLDR & '\sfx.ico')
			GUISetState(@SW_ENABLE, $GUI_MAIN)

			_CFG_Load($TempSFXFLDR & '\sfx.txt')
			If FileExists($TempSFXFLDR & '\sfx.7z') Then
				GUICtrlSetData($S_INP_ARCHIVE, $TempSFXFLDR & '\sfx.7z')
				GUICtrlSetState($S_CHK_ARCHIVE, $GUI_CHECKED)
			EndIf
			If FileExists($TempSFXFLDR & '\sfx.sfx') Then
				GUICtrlSetData($S_INP_SFXMOD, $TempSFXFLDR & '\sfx.sfx')
				GUICtrlSetState($S_CHK_SFXMOD, $GUI_CHECKED)
			EndIf
			GUICtrlSetData($S_INP_SFXPATH, $_exepath)
			GUICtrlSetState($S_CHK_SFXPATH, $GUI_CHECKED)
			If FileExists($TempSFXFLDR & '\sfx.ico') Then
				GUICtrlSetData($S_INP_SFXICON, $TempSFXFLDR & '\sfx.ico')
				GUICtrlSetState($S_CHK_SFXICON, $GUI_CHECKED)
				GUICtrlSetImage($S_ICO_SFX, $TempSFXFLDR & '\sfx.ico')
			EndIf
		Else
			_MsgBoxEx(19)
			$ModeEXE[0] = False
			Return SetError(1, 1, '')
		EndIf
	Else
		MsgBox(18, $GUI_MAIN, ' -  SFXSPLIT.EXE')
		$ModeEXE[0] = False
		Return SetError(1, 2, '')
	EndIf
	$ModeEXE[0] = False
EndFunc   ;==>_CFG_LoadExe
; ***********************************************************
; *					   File Open Dialog						*
; ***********************************************************
Func _FileOpenDialog()
	Local $_FODLG = FileOpenDialog('Select file to open:', $CurFile, 'All supported formats (*.txt;*.exe;*.7z;*.001;*.sfx)|Text files (*.txt)|Executable files (*.exe)|7z archive files (*.7z;*.001)|SFX modules (*.sfx)|All files (*.*)', 3, '', $GUI_MAIN)
	If Not @error Then _FileLoad($_FODLG)
EndFunc   ;==>_FileOpenDialog
Func _DragNDrop()
	Local $DragFILE
	$DragFILE = StringReplace(@GUI_DragFile, @CRLF, '')
	$iMsgBoxAnswer = _MsgBoxEx(15, $GUI_MAIN, $DragFILE)
	If $iMsgBoxAnswer = 6 Then _FileLoad($DragFILE)
EndFunc   ;==>_DragNDrop
Func _FileLoad($_file)
	If Not FileExists($_file) Then
		_MsgBoxEx(12)
		Return SetError(1, 5)
	EndIf
	If StringRight($_file, 4) = '.exe' Then
		_CFG_LoadExe($_file)
		Return SetError(@error, 1)
	ElseIf StringRight($_file, 3) = '.7z' Or StringRight($_file, 4) = '.001' Then
		GUICtrlSetData($S_INP_ARCHIVE, $_file)
		GUICtrlSetState($S_CHK_ARCHIVE, $GUI_CHECKED)
		GUICtrlSetState($Ti_SFX, $GUI_SHOW)
		Return SetExtended(2)
	ElseIf StringRight($_file, 4) = '.sfx' Then
		GUICtrlSetData($S_INP_SFXMOD, $_file)
		GUICtrlSetState($S_CHK_SFXMOD, $GUI_CHECKED)
		GUICtrlSetState($Ti_SFX, $GUI_SHOW)
		GUICtrlSetState($S_INP_SFXMOD, $GUI_ENABLE)
		$USE_DEFMOD[0] = 0
		Return SetExtended(3)
	Else
		_CFG_Load($_file)
		Return SetError(@error, 4)
	EndIf
EndFunc   ;==>_FileLoad
; ***********************************************************
; *					    CHECK FILE							*
; ***********************************************************
Func _CFG_Check($_FileToCheck)
	Local $_Array
	Local $_isStart = False
	Local $_isEnd = False
	_FileReadToArray($_FileToCheck, $_Array)
	If Not @error Then
		For $_c = 1 To $_Array[0] Step 1
			If StringInStr($_Array[$_c], ";!@Install@!UTF-8") Then
				$_isStart = True
				For $_z = $_c To $_Array[0] Step 1
					If StringInStr($_Array[$_z], ";!@InstallEnd@") Then
						$_isEnd = True
						ExitLoop
					EndIf
				Next
				If $_isEnd Then ExitLoop
			EndIf
		Next
	EndIf
	If $_isStart And $_isEnd Then
		Return True
	Else
		Return SetError(1, 1, False)
	EndIf
EndFunc   ;==>_CFG_Check
; ***********************************************************
; *					    CONFIG SAVE							*
; ***********************************************************
Func _CFG_Save()
	_Update()
	If FileExists($CurFile) Then
		$last_saved = $BuiltCONFIG[1]
		_FileOpenEx($CurFile, 128 + 2, $last_saved)
		If @error Then
			_MsgBoxEx(112)
			Return SetError(1, 0, 0)
		EndIf
	Else
		_CFG_SaveAs()
	EndIf
EndFunc   ;==>_CFG_Save
Func _CFG_SaveAs()
	_Update()
	Local $_FSDLG = FileSaveDialog('Select File Name', $CurFile, 'All files (*.*)', 18, StringTrimLeft($CurFile, StringInStr($CurFile, '\', '', -1)), $GUI_MAIN)
	If @error Then Return
	If Not StringInStr($_FSDLG, '.') Then $_FSDLG &= '.txt'
	$last_saved = $BuiltCONFIG[1]
	If $CurFile = '' Then $CurFile = $_FSDLG
	_Update()
	_FileOpenEx($_FSDLG, 128 + 2, $last_saved)
	If @error Then
		_MsgBoxEx(112)
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_CFG_SaveAs
; ***********************************************************
; *						MAKE SFX							*
; ***********************************************************
Func _GUI_Make_SFX()
	$cPos = WinGetPos($GUI_MAIN)
	GUISetState(@SW_DISABLE, $GUI_MAIN)
	$GUI_MAKE_SFX = GUICreate($_LNG_MSFX[1], 400, 300, $cPos[0] + 100, $cPos[1] + 75, '', -1, $GUI_MAIN)
	$GUI_MSFX_PROGRESS = GUICtrlCreateProgress(5, 10, 385, 25)
	$GUI_MSFX_LST = GUICtrlCreateListView(' ', 5, 45, 385, 185, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER))
	$GUI_MSFX_OPEN = GUICtrlCreateButton($_LNG_MSFX[2], 5, 240, 120, 25)
	$GUI_MSFX_RUN = GUICtrlCreateButton($_LNG_MSFX[3], 137.5, 240, 120, 25)
	$GUI_MSFX_CLOSE = GUICtrlCreateButton($_LNG_MSFX[4], 270, 240, 120, 25)
	; image list
	$iListView = _GUIImageList_Create(16, 16, 5)
	If @Compiled Then
		_GUIImageList_AddIcon($iListView, $IconPath, -200, False) ; info
		_GUIImageList_AddIcon($iListView, $IconPath, -215, False) ; success
		_GUIImageList_AddIcon($iListView, $IconPath, -210, False) ; error
	Else
		_GUIImageList_AddIcon($iListView, $IconPath & '\Button\Info.ico', 0, False) ; info
		_GUIImageList_AddIcon($iListView, $IconPath & '\Button\Success.ico', 0, False) ; success
		_GUIImageList_AddIcon($iListView, $IconPath & '\Button\DeleteAll.ico', 0, False) ; error
	EndIf
	_GUICtrlListView_SetImageList($GUI_MSFX_LST, $iListView, 1)
	_GUICtrlButton_SetImageList($GUI_MSFX_OPEN, $iBtnList_small[4])
	_GUICtrlButton_SetImageList($GUI_MSFX_RUN, $iBtnList_small[13])
	_GUICtrlButton_SetImageList($GUI_MSFX_CLOSE, $iBtnList_small[10])
	_GUICtrlListView_SetColumnWidth($GUI_MSFX_LST, 0, 400)
	GUICtrlSetBkColor($GUI_MSFX_LST, 0xFFFFFF)
	GUICtrlSetFont($GUI_MSFX_LST, 8.5, '', '', $Font[0])
	GUICtrlSetState($GUI_MSFX_OPEN, $GUI_DISABLE)
	GUICtrlSetState($GUI_MSFX_RUN, $GUI_DISABLE)
	GUICtrlSetState($GUI_MSFX_CLOSE, $GUI_DISABLE)
	GUICtrlSetOnEvent($GUI_MSFX_OPEN, '_GUI_Make_SFX_Events')
	GUICtrlSetOnEvent($GUI_MSFX_RUN, '_GUI_Make_SFX_Events')
	GUICtrlSetOnEvent($GUI_MSFX_CLOSE, '_GUI_Make_SFX_Events')
	If $UseFONT Then _GUI_Make_SFX_Font()
	$BuiltSFX = _Make_SFX()
	If @extended = 1 Then _Close_Window($GUI_MAKE_SFX, $GUI_MAIN)
	If Not @error Then
		GUICtrlSetState($GUI_MSFX_OPEN, $GUI_ENABLE)
		GUICtrlSetState($GUI_MSFX_RUN, $GUI_ENABLE)
	EndIf
	GUICtrlSetState($GUI_MSFX_CLOSE, $GUI_ENABLE)
EndFunc   ;==>_GUI_Make_SFX
Func _GUI_Make_SFX_Events()
	Select
		Case @GUI_CtrlId = $GUI_MSFX_OPEN
			Run(@WindowsDir & '\explorer.exe /select, "' & $BuiltSFX & '"')
		Case @GUI_CtrlId = $GUI_MSFX_RUN
			Run($BuiltSFX)
		Case @GUI_CtrlId = $GUI_MSFX_CLOSE
			_GUIImageList_Destroy($iListView)
			_Close_Window($GUI_MAKE_SFX, $GUI_MAIN)
	EndSelect
EndFunc   ;==>_GUI_Make_SFX_Events
Func _GUI_Make_SFX_Font()
	GUICtrlSetFont($GUI_MSFX_OPEN, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($GUI_MSFX_RUN, $Font[2], '', '', $Font[0])
	GUICtrlSetFont($GUI_MSFX_CLOSE, $Font[2], '', '', $Font[0])
EndFunc   ;==>_GUI_Make_SFX_Font
Func _Write_SFXReport($iText, $iconindex = -1)
	If $iconindex = -1 Then
		_GUICtrlListView_AddItem($GUI_MSFX_LST, $iText)
	Else
		_GUICtrlListView_AddItem($GUI_MSFX_LST, $iText, $iconindex)
	EndIf
	_GUICtrlListView_SetColumnWidth($GUI_MSFX_LST, 0, $LVSCW_AUTOSIZE)
EndFunc   ;==>_Write_SFXReport
Func _Make_SFX()
	Local $MsgData = ''
	Local $ArcType = 0
	Local $ArcFList = $TempFOLDER & '\ArcFList.lst'
	Local $TempSFXCFG = $TempFOLDER & '\~.txt'
	Local $TempSFXMOD = $TempFOLDER & '\~.sfx'
	Local $Archive = GUICtrlRead($S_INP_ARCHIVE)
	Local $SFXModule = GUICtrlRead($S_INP_SFXMOD)
	Local $EXEIcon = GUICtrlRead($S_INP_SFXICON)
	Local $EXEName = GUICtrlRead($S_INP_SFXPATH)
	Local $EXTConfig = GUICtrlRead($S_INP_CONFIG)
	; check for external config
	If $ModeEXTCFG = 1 And Not FileExists($EXTConfig) Then
		_MsgBoxEx(14)
		Return SetError(1, 1, False)
	EndIf
	; auto determine sfx path
	If $ModeAUTOSFX = 1 And $EXEName = '' Then
		If FileExists($Archive) Then
			$EXEName = _FileGetPathData($Archive) & '\' & _FileGetPathData($Archive, 2) & '.exe'
		EndIf
	EndIf
	; check sfx path
	If Not _Path_Check($EXEName) Then
		_MsgBoxEx(21)
		Return SetError(1, 1, False)
	EndIf
	; correct sfxmod path
	If $USE_DEFMOD[0] = 1 Then $SFXModule = $Mods_Dir & '\' & $USE_DEFMOD[1] & '.sfx'
	; correct sfx path
	If StringRight($EXEName, 4) <> '.exe' Then $EXEName &= '.exe'
	; stop if sfxmod doesn't exist
	If $SFXModule = '' Then
		_MsgBoxEx(22)
		Return SetError(1, 1, False)
	ElseIf Not FileExists($SFXModule) Or StringRight($SFXModule, 4) <> '.sfx' Then
		_MsgBoxEx(23)
		Return SetError(1, 1, False)
	EndIf
	; stop if archive or archive files doesn't exist
	If $FilesToArc[0] <= 0 And Not FileExists($Archive) Then
		Return SetError(1, 1, False)
	EndIf
	If $FilesToArc[0] > 0 And FileExists($Archive) Then
		$iMsgBoxAnswer = _MsgBoxEx(29, $GUI_MAIN, $Archive)
		Switch $iMsgBoxAnswer
			Case 6 ;Yes
				$ArcType = 1
			Case 7 ;No
				$ArcType = 2
			Case 2 ;Cancel
				Return SetExtended(1)
		EndSwitch
	ElseIf $FilesToArc[0] > 0 Then
		$ArcType = 2
	ElseIf FileExists($Archive) Then
		$ArcType = 1
	EndIf
	; warn user to overwrite file
	If FileExists($EXEName) And $ModeOWSFX = 0 Then
		$iMsgBoxAnswer = _MsgBoxEx(27, $GUI_MAIN, $EXEName)
		If $iMsgBoxAnswer = 7 Then Return SetError(1, 1, False)
	EndIf
	; begin creation process
	GUISetState(@SW_SHOW, $GUI_MAKE_SFX)
	_Write_SFXReport($_LNG_MSFX[5], 0)
	_ClearTemp()
	_Update(1)
	Sleep(250)
	; create archive if required
	If $ArcType = 2 Then
		If Not FileExists($7ZIP_PATH) Or StringRight($7ZIP_PATH, 4) <> '.exe' Then
			_Write_SFXReport($_LNG_MSFX[8], 2) ; 7-zip doesn't exist
			Return
		EndIf
		_CreateArcFList($ArcFList)
		If @error Then
			_Write_SFXReport($_LNG_MSFX[13], 2) ; error while creating sfx
			Return SetError(1)
		EndIf
		If Not FileExists($ArcFList) Then
			_Write_SFXReport($_LNG_MSFX[13], 2) ; error while creating sfx
			Return SetError(1)
		EndIf
		_Write_SFXReport($_LNG_MSFX[6], 0)
		GUICtrlSetData($GUI_MSFX_PROGRESS, 16)
		$Archive = $TempFOLDER & '\CustomArc.7z'
		_ConvertArcValues()
		RunWait($7ZIP_PATH & ' a "' & $Archive & '" @"' & $ArcFList & '"' & $7z_LVL[1] & $7z_METHOD[1] & $7z_DICT[1] & $7z_SOLID[1], '', @SW_HIDE)
		If Not FileExists($Archive) Then
			_Write_SFXReport($_LNG_MSFX[10], 2)
			Return SetError(1)
		EndIf
	EndIf
	; use specified configuration file if defined
	If $ModeEXTCFG = 1 Then
		If Not FileExists($EXTConfig) Then
			_Write_SFXReport(_FormatMBoxData($_LNG_MSFX[11], $EXTConfig), 2)
			Return SetError(1)
		EndIf
		_CFG_Check($EXTConfig)
		If Not @error Then
			FileCopy($EXTConfig, $TempSFXCFG, 9)
		Else
			_Write_SFXReport(_FormatMBoxData($_LNG_MSFX[12], $EXTConfig), 2)
			Return SetError(1)
		EndIf
	Else
		_FileOpenEx($TempSFXCFG, 128 + 2, $BuiltCONFIG[0])
		If @error Then
			_MsgBoxEx(112)
			Return SetError(1, 0, 0)
		EndIf
	EndIf
	; copy sfx module into tempdir
	FileCopy($SFXModule, $TempSFXMOD, 9)
	; check for temporary sfx module
	If Not FileExists($TempSFXMOD) Then
		_Write_SFXReport($_LNG_MSFX[13], 2)
		Return SetError(1)
	EndIf
	; change icon
	If FileExists($EXEIcon) Then
		_Write_SFXReport($_LNG_MSFX[14], 0)
		_ResUpdateIcon($TempSFXMOD, $EXEIcon)
		If @error Then
			_Write_SFXReport($_LNG_MSFX[16], 2)
		Else
			_Write_SFXReport($_LNG_MSFX[15], 1)
		EndIf
	ElseIf $EXEIcon = '' Then
	Else
	EndIf
	; change version info
	If $ModeRESCHANGE Then
		_Write_SFXReport($_LNG_MSFX[17], 0)
		_ResUpdateVersion($TempSFXMOD)
		If @error Then
			_Write_SFXReport($_LNG_MSFX[19], 2)
		Else
			_Write_SFXReport($_LNG_MSFX[18], 1)
		EndIf
	EndIf
	; compress with upx
	If $USE_UPX[0] = 1 Then
		_Write_SFXReport($_LNG_MSFX[20], 0)
		If FileExists($UPX_Dir) Then
			GUICtrlSetData($GUI_MSFX_PROGRESS, 65)
			RunWait($UPX_Dir & ' ' & $USE_UPX[1] & ' "' & $TempSFXMOD & '"', '', @SW_HIDE)
			_Write_SFXReport($_LNG_MSFX[21], 1)
		Else
			_Write_SFXReport($_LNG_MSFX[22], 2)
		EndIf
	EndIf
	; build sfx
	_Write_SFXReport($_LNG_MSFX[23], 0)
	GUICtrlSetData($GUI_MSFX_PROGRESS, 85)
	_Build_EXE($TempSFXMOD, $TempSFXCFG, $Archive, $EXEName)
	If @error Then
		_Write_SFXReport($_LNG_MSFX[24], 2)
		Return SetError(1)
	EndIf
	_Write_SFXReport(_FormatMBoxData($_LNG_MSFX[25], $EXEName), 1)
	GUICtrlSetData($GUI_MSFX_PROGRESS, 100)
	Return $EXEName
EndFunc   ;==>_Make_SFX
Func _Build_EXE($_SFXMOD, $_SFX_CFG, $_ARCHIVE, $_EXENAME)
	If FileExists($_SFXMOD) And FileExists($_SFX_CFG) And FileExists($_ARCHIVE) Then
		GUISetState(@SW_LOCK, $GUI_MAIN)
		If Not FileExists(_FileGetPathData($_EXENAME)) Then
			DirCreate(_FileGetPathData($_EXENAME))
		EndIf
		_RunDos('copy /b "' & $_SFXMOD & '" + "' & $_SFX_CFG & '" + "' & $_ARCHIVE & '" "' & $_EXENAME & '"')
		GUISetState(@SW_UNLOCK, $GUI_MAIN)
		If FileExists($_EXENAME) Then
			Return 1
		Else
			Return SetError(1)
		EndIf
	Else
		Return SetError(1)
	EndIf
EndFunc   ;==>_Build_EXE

Func _ResUpdateIcon($pFile, $sIcon)
	If Not FileExists($pFile) Then Return SetError(1, 0, 0)
	If Not FileExists($sIcon) Then Return SetError(2, 0, 0)
	$rh = DllCall("kernel32.dll", "ptr", "BeginUpdateResourceW", "wstr", $pFile, "int", 0)
	$rh = $rh[0]
	Local $pFileIconInfo[3] = [$sIcon, '101', '1049']
	_EnumResourceNamesAndLangs($pFile, 14) ; RT_GROUPICON
	If $a_ResNamesAndLangs[0][0] > 0 Then
		If $a_ResNamesAndLangs[1][0] <> '' Then $pFileIconInfo[1] = $a_ResNamesAndLangs[1][0]
		If $a_ResNamesAndLangs[1][1] <> '' Then $pFileIconInfo[2] = $a_ResNamesAndLangs[1][1]
	EndIf
	Local $error = _Res_Update($rh, $pFileIconInfo[0], 3, $pFileIconInfo[1], $pFileIconInfo[2]) ; RT_ICON
	DllCall("kernel32.dll", "int", "EndUpdateResourceW", "ptr", $rh, "int", 0)
	Return SetError($error, 0, 0)
EndFunc   ;==>_ResUpdateIcon

Func _ResUpdateVersion($pFile)
	$rh = DllCall("kernel32.dll", "ptr", "BeginUpdateResourceW", "wstr", $pFile, "int", 0)
	$rh = $rh[0]
	Local $pFileIconInfo, $verLangs
	; enum RT_VERSION resources in target file
	If Not _EnumResourceNamesAndLangs($pFile, 16) Then ; RT_VERSION
		Dim $pFileIconInfo[2][2] = [[1, 0],[1, 1049]]
	Else
		$pFileIconInfo = $a_ResNamesAndLangs
	EndIf
	; Delete current resources for all but 1 and the input language
	For $x = 1 To $pFileIconInfo[0][0]
		$verLangs = StringSplit($pFileIconInfo[$x][1], ",") ; create temp array of languages for this name
		For $i = 1 To $verLangs[0]
			; remove any version info that is not 1 or our input language
			If ($pFileIconInfo[$x][0] <> 1) Or ($verLangs[$i] <> $pFileIconInfo[1][1]) Then _
					_Res_Update($rh, "", 16, $pFileIconInfo[$x][0], $verLangs[$i])
		Next
	Next
	_Create_TempDir()
	_Res_Create_RTVersion($TempRESFILE) ; Build the RT_VERSION structure
	Local $error = _Res_Update($rh, $TempRESFILE, 16, 1, $pFileIconInfo[1][1]) ; Update RT_VERSION in the Bin file
	FileDelete($TempRESFILE)
	DllCall("kernel32.dll", "int", "EndUpdateResourceW", "ptr", $rh, "int", 0)
	Return SetError($error, 0, 0)
EndFunc   ;==>_ResUpdateVersion

Func _ResExtractIcon($pFile, $sFile)
	_EnumResourceNamesAndLangs($pFile, 14) ; RT_GROUPICON
	If $a_ResNamesAndLangs[0][0] > 1 Then Return SetError(1, 0, 0)
	_ExtractIcon($pFile, $sFile, $a_ResNamesAndLangs[1][0], $a_ResNamesAndLangs[1][1])
	Return SetError(@error, 0, '')
EndFunc   ;==>_ResExtractIcon

Func _CreateArcFList($_lstpath)
	If $FilesToArc[0] = 0 Then Return SetError(1, 1)
	Local $_lstdata = ''
	For $c = 1 To $FilesToArc[0]
		$_lstdata &= _CorrectArcFPath($FilesToArc[$c])
	Next
	If $_lstdata = '' Then
		_Write_SFXReport($_LNG_MSFX[28], 2)
		Return SetError(1, 2)
	EndIf
	If FileExists($_lstpath) Then FileDelete($_lstpath)
	_FileOpenEx($_lstpath, 128 + 2, $_lstdata)
	If @error Then
		_MsgBoxEx(112)
		Return SetError(1, 0, 0)
	EndIf
EndFunc   ;==>_CreateArcFList
Func _CorrectArcFPath($f_path)
	If FileExists($f_path) Then
		Return '"' & $f_path & '"' & @CRLF
	Else
		_Write_SFXReport(_FormatMBoxData($_LNG_MSFX[23], $f_path), 2)
		Return ''
	EndIf
EndFunc   ;==>_CorrectArcFPath
; ***********************************************************
; *					 CONFIG CLOSE							*
; ***********************************************************
Func _FileCloseDialog()
	_Update()
	If $last_saved <> $BuiltCONFIG[1] And $LineCOUNT[0] > 3 Then
		$iMsgBoxAnswer = _MsgBoxEx(111)
		If $iMsgBoxAnswer = 6 Then
			_CFG_Save()
			_CFG_Close()
		ElseIf $iMsgBoxAnswer = 7 Then
			_CFG_Close()
		EndIf
	Else
		_CFG_Close()
	EndIf
EndFunc   ;==>_FileCloseDialog
Func _CFG_Close()
	GUICtrlSetData($M_INP_INSTPATH, '')
	GUICtrlSetData($M_INP_GUIFLAGS, '')
	GUICtrlSetData($M_INP_MISCFLAGS, '')
	GUICtrlSetState($M_INP_INSTPATH, $GUI_ENABLE)
	GUICtrlSetState($M_BTN_INSTPATH, $GUI_ENABLE)
	GUICtrlSetState($M_CHK_TEMPMODE, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_SKIPLOCKED, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_SELFDELETE, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_BPT, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_XDWidth, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_XPWidth, $GUI_UNCHECKED)
	GUICtrlSetState($M_CHK_VOLNAME, $GUI_UNCHECKED)
	GUICtrlSetState($M_INP_BPT, $GUI_DISABLE)
	GUICtrlSetState($M_INP_XDWidth, $GUI_DISABLE)
	GUICtrlSetState($M_INP_XPWidth, $GUI_DISABLE)
	GUICtrlSetState($M_INP_VOLNAME, $GUI_DISABLE)
	GUICtrlSetState($M_RAD_GMode[1], 1)
	GUICtrlSetState($M_RAD_OMode[1], 1)
	GUICtrlSetData($T_INP_WINTITLE, '')
	GUICtrlSetData($T_INP_XPATHWINTITLE, '')
	GUICtrlSetData($T_INP_XTITLE, '')
	GUICtrlSetData($T_INP_ERRORTITLE, '')
	GUICtrlSetData($T_INP_WARNTITLE, '')
	GUICtrlSetData($T_INP_PASSWDTEXT, '')
	GUICtrlSetData($T_INP_PASSWDTITLE, '')
	GUICtrlSetData($T_INP_XCANCELTEXT, '')
	GUICtrlSetData($MS_EDT_MESSAGES[1], '')
	GUICtrlSetData($MS_EDT_MESSAGES[2], '')
	GUICtrlSetData($MS_EDT_MESSAGES[3], '')
	GUICtrlSetData($MS_EDT_MESSAGES[4], '')
	GUICtrlSetData($MS_EDT_MESSAGES[5], '')
	GUICtrlSetData($MS_EDT_MESSAGES[6], '')
	$MS_VALUES[1] = ''
	$MS_VALUES[2] = ''
	$MS_VALUES[3] = ''
	$MS_VALUES[4] = ''
	$MS_VALUES[5] = ''
	$MS_VALUES[6] = ''
	_GUICtrlListView_DeleteAllItems($R_LIST)
	_GUICtrlListView_DeleteAllItems($D_LIST)
	_GUICtrlListView_DeleteAllItems($SH_LIST)
	_GUICtrlListView_DeleteAllItems($E_LIST)
	GUICtrlSetData($S_INP_ARCHIVE, '')
	GUICtrlSetData($S_INP_SFXMOD, '')
	GUICtrlSetData($S_INP_SFXPATH, '')
	GUICtrlSetData($S_INP_SFXICON, '')
	GUICtrlSetState($S_CHK_ARCHIVE, 4)
	GUICtrlSetState($S_CHK_SFXMOD, 4)
	GUICtrlSetState($S_CHK_SFXPATH, 4)
	GUICtrlSetState($S_CHK_SFXICON, 4)
	GUICtrlSetState($S_CHK_EXTCFG, 4)
	GUICtrlSetImage($S_ICO_SFX, '')
	$vFileVersion = ''
	$vCompanyName = ''
	$vComments = ''
	$vFileDescription = ''
	$vProductVersion = ''
	$vProductName = ''
	$vLegalCopyright = ''
	$vLegalTrademarks = ''
	$vInternalName = ''
	$vOriginalFileName = ''
	$vSpecialBuild = ''
	$vPrivateBuild = ''
	$ModeINCLUDERES = False
	$ModeRESCHANGE = 0
	Dim $FilesToArc[1000] = [0]
	$CurFile = ''
	_Update()
	$last_saved = $BuiltCONFIG[1]
	GUISetState(@SW_UNLOCK, $GUI_MAIN)
;~ 	_ClearTemp(4)
EndFunc   ;==>_CFG_Close
; ***********************************************************
; *					  	CONFIG LOAD							*
; ***********************************************************
Func _CFG_Load($_FileToLoad)
	Local $delparam, $delfile, $delquote
	Local $runparam, $runprefix, $runfile, $runcommand, $runquote, $pStr, $_p = 0, $p_last, $runfilestart, $_h
	Local $a_prefix, $l_prefix
	Local $shcparam, $shcvalue[10], $shcstart, $shcend
	Local $sArray, $a = 1, $execfile, $execparam
	If Not FileExists($_FileToLoad) Then Return SetError(1, 1, False)
	_CFG_Check($_FileToLoad)
	If @error Then
		$iMsgBoxAnswer = _MsgBoxEx(16, $GUI_MAIN, $_FileToLoad)
		If $iMsgBoxAnswer = 7 Then Return SetError(1, 2, False)
	EndIf
	If FileGetSize($_FileToLoad) > 131072 Then
		$iMsgBoxAnswer = _MsgBoxEx(17)
		If $iMsgBoxAnswer = 7 Then Return SetError(1, 3, False)
	EndIf
	Local $rFile = FileRead($_FileToLoad)
	If @error = 1 Then Return SetError(1, 4, False)
	If $rFile = '' Then
		$CurFile = $_FileToLoad
		Return SetError(0, 5, False)
	EndIf
	_Update()
	If FileExists($_FileToLoad) Then
		GUISetState(@SW_LOCK, $GUI_MAIN)
		If $ModeEXE[0] = True Then
			_MRU_Load_Live($ModeEXE[1])
		Else
			_MRU_Load_Live($_FileToLoad)
		EndIf
		_ClearTemp()
		_FileReadToArray($_FileToLoad, $sArray)
		FileWrite($TempINI, '[Main]' & @CRLF & FileRead($_FileToLoad))
		_CFG_Close()
		; ***********************
		; *		SFX OPTIONS		*
		; ***********************
		; ARCHIVE
		If IniRead($TempINI, 'Main', '7zSFXBuilder_7zArchive', '') <> '' Then
			GUICtrlSetData($S_INP_ARCHIVE, IniRead($TempINI, 'Main', '7zSFXBuilder_7zArchive', ''))
			GUICtrlSetState($S_CHK_ARCHIVE, 1)
		EndIf
		; SFX MODULE
		If IniRead($TempINI, 'Main', '7zSFXBuilder_SFXModule', '') <> '' Then
			GUICtrlSetData($S_INP_SFXMOD, IniRead($TempINI, 'Main', '7zSFXBuilder_SFXModule', ''))
			GUICtrlSetState($S_CHK_SFXMOD, 1)
			GUICtrlSetState($S_INP_SFXMOD, $GUI_ENABLE)
			GUICtrlSetState($S_SEL_SFXMOD, $GUI_ENABLE)
			$USE_DEFMOD[0] = 0
		EndIf
		; SFX NAME
		If IniRead($TempINI, 'Main', '7zSFXBuilder_SFXName', '') <> '' Then
			GUICtrlSetData($S_INP_SFXPATH, IniRead($TempINI, 'Main', '7zSFXBuilder_SFXName', ''))
			GUICtrlSetState($S_CHK_SFXPATH, 1)
		EndIf
		; SFX ICON
		If IniRead($TempINI, 'Main', '7zSFXBuilder_SFXIcon', '') <> '' Then
			GUICtrlSetData($S_INP_SFXICON, IniRead($TempINI, 'Main', '7zSFXBuilder_SFXIcon', ''))
			GUICtrlSetState($S_CHK_SFXICON, 1)
			If FileExists(IniRead($TempINI, 'Main', '7zSFXBuilder_SFXIcon', '')) Then GUICtrlSetImage($S_ICO_SFX, IniRead($TempINI, 'Main', '7zSFXBuilder_SFXIcon', ''))
		EndIf
		; DEFAULT MODULE
		If IniRead($TempINI, 'Main', '7zSFXBuilder_UseDefMod', '') <> '' Then
			$USE_DEFMOD[0] = 1
			$USE_DEFMOD[1] = IniRead($TempINI, 'Main', '7zSFXBuilder_UseDefMod', '')
			GUICtrlSetState($S_INP_SFXMOD, $GUI_DISABLE)
			GUICtrlSetState($S_SEL_SFXMOD, $GUI_DISABLE)
		Else
			$USE_DEFMOD[0] = 0
			GUICtrlSetState($S_INP_SFXMOD, $GUI_ENABLE)
			GUICtrlSetState($S_SEL_SFXMOD, $GUI_ENABLE)
		EndIf
		If Not $ModeEXE[0] And $ModeAUTOMOD And GUICtrlRead($S_INP_SFXMOD) = '' Then $USE_DEFMOD[0] = 1
		; UPX
		If IniRead($TempINI, 'Main', '7zSFXBuilder_UPXCommands', '') <> '' Then
			$USE_UPX[0] = 1
			$USE_UPX[1] = IniRead($TempINI, 'Main', '7zSFXBuilder_UPXCommands', '')
		Else
			$USE_UPX[0] = 0
		EndIf
		; VERSION INFO
		If Not $ModeEXE[0] Then
			$vFileVersion = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_FileVersion', '')
			$vCompanyName = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_CompanyName', '')
			$vComments = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_Comments', '')
			$vFileDescription = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_FileDescription', '')
			$vProductVersion = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_ProductVersion', '')
			$vProductName = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_ProductName', '')
			$vLegalCopyright = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_LegalCopyright', '')
			$vLegalTrademarks = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_LegalTrademarks', '')
			$vInternalName = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_InternalName', '')
			$vOriginalFileName = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_OriginalFileName', '')
			$vSpecialBuild = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_SpecialBuild', '')
			$vPrivateBuild = IniRead($TempINI, 'Main', '7zSFXBuilder_Res_PrivateBuild', '')
		ElseIf FileExists($ModeEXE[1]) Then
			$vFileVersion = FileGetVersion($ModeEXE[1], 'FileVersion')
			$vCompanyName = FileGetVersion($ModeEXE[1], 'CompanyName')
			$vComments = FileGetVersion($ModeEXE[1], 'Comments')
			$vFileDescription = FileGetVersion($ModeEXE[1], 'FileDescription')
			$vProductVersion = FileGetVersion($ModeEXE[1], 'ProductVersion')
			$vProductName = FileGetVersion($ModeEXE[1], 'ProductName')
			$vLegalCopyright = FileGetVersion($ModeEXE[1], 'LegalCopyright')
			$vLegalTrademarks = FileGetVersion($ModeEXE[1], 'LegalTrademarks')
			$vInternalName = FileGetVersion($ModeEXE[1], 'InternalName')
			$vOriginalFileName = FileGetVersion($ModeEXE[1], 'OriginalFilename')
			$vSpecialBuild = FileGetVersion($ModeEXE[1], 'SpecialBuild')
			$vPrivateBuild = FileGetVersion($ModeEXE[1], 'PrivateBuild')
		EndIf
		If $vFileVersion <> '' Or $vCompanyName <> '' Or $vComments <> '' Or $vFileDescription <> '' Or $vProductVersion <> '' Or $vProductName <> '' Or $vLegalCopyright <> '' Or _
				$vLegalTrademarks <> '' Or $vInternalName <> '' Or $vOriginalFileName <> '' Or $vSpecialBuild <> '' Or $vPrivateBuild <> '' Then
			If Not $ModeEXE[0] Then $ModeINCLUDERES = True
			$ModeRESCHANGE = 1
		EndIf
		; ARCHIVE FILES
		Do
			$FilesToArc[$a] = IniRead($TempINI, 'Main', '7zSFXBuilder_SFXFile_' & $a, '?')
			If $FilesToArc[$a] = '?' Then ExitLoop
			$FilesToArc[0] += 1
			$a += 1
		Until 1 = 2
		; 7-ZIP OPTIONS
		If IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Level', '') <> '' Then $7z_LVL[0] = IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Level', '')
		If IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Method', '') <> '' Then $7z_METHOD[0] = IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Method', '')
		If IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Dictionary', '') <> '' Then $7z_DICT[0] = IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_Dictionary', '')
		If IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_BlockSize', '') <> '' Then $7z_SOLID[0] = IniRead($TempINI, 'Main', '7zSFXBuilder_7Zip_BlockSize', '')
		;  InstPath
		GUICtrlSetData($M_INP_INSTPATH, IniRead($TempINI, 'Main', 'InstallPath', ''))
		;  GuiFlags
		GUICtrlSetData($M_INP_GUIFLAGS, IniRead($TempINI, 'Main', 'GUIFlags', ''))
		;  MiscFlags
		GUICtrlSetData($M_INP_MISCFLAGS, IniRead($TempINI, 'Main', 'MiscFlags', ''))
		;  GuiMode
		If IniRead($TempINI, 'Main', 'GUIMode', '0') = '0' Then
			GUICtrlSetState($M_RAD_GMode[1], 1)
		ElseIf IniRead($TempINI, 'Main', 'GUIMode', '') = '1' Then
			GUICtrlSetState($M_RAD_GMode[2], 1)
		ElseIf IniRead($TempINI, 'Main', 'GUIMode', '') = '2' Then
			GUICtrlSetState($M_RAD_GMode[3], 1)
		EndIf
		;  OverwriteMode
		If StringInStr(IniRead($TempINI, 'Main', 'OverwriteMode', '0'), '0') <> 0 Then
			GUICtrlSetState($M_RAD_OMode[1], 1)
		ElseIf StringInStr(IniRead($TempINI, 'Main', 'OverwriteMode', ''), '1') <> 0 Then
			GUICtrlSetState($M_RAD_OMode[2], 1)
		ElseIf StringInStr(IniRead($TempINI, 'Main', 'OverwriteMode', ''), '2') <> 0 Then
			GUICtrlSetState($M_RAD_OMode[3], 1)
		EndIf
		If StringInStr(IniRead($TempINI, 'Main', 'OverwriteMode', ''), '8') <> 0 Then
			GUICtrlSetState($M_CHK_SKIPLOCKED, 1)
		EndIf
		;  SelfDelete
		If StringInStr(IniRead($TempINI, 'Main', 'SelfDelete', ''), '1') <> 0 Then
			GUICtrlSetState($M_CHK_SELFDELETE, 1)
		EndIf
		;  BeginPromptTimeout
		If IniRead($TempINI, 'Main', 'BeginPromptTimeout', '') <> '' Then
			If StringIsInt(IniRead($TempINI, 'Main', 'BeginPromptTimeout', '')) Then
				GUICtrlSetState($M_CHK_BPT, $GUI_CHECKED)
				GUICtrlSetState($M_INP_BPT, $GUI_ENABLE)
				GUICtrlSetData($M_INP_BPT, IniRead($TempINI, 'Main', 'BeginPromptTimeout', ''))
			EndIf
		EndIf
		;  ExtractDialogWidth
		If IniRead($TempINI, 'Main', 'ExtractDialogWidth', '') <> '' Then
			If StringIsDigit(IniRead($TempINI, 'Main', 'ExtractDialogWidth', '')) Then
				GUICtrlSetState($M_CHK_XDWidth, $GUI_CHECKED)
				GUICtrlSetState($M_INP_XDWidth, $GUI_ENABLE)
				GUICtrlSetData($M_INP_XDWidth, IniRead($TempINI, 'Main', 'ExtractDialogWidth', ''))
			EndIf
		EndIf
		;  ExtractPathWidth
		If IniRead($TempINI, 'Main', 'ExtractPathWidth', '') <> '' Then
			If StringIsDigit(IniRead($TempINI, 'Main', 'ExtractPathWidth', '')) Then
				GUICtrlSetState($M_CHK_XPWidth, $GUI_CHECKED)
				GUICtrlSetState($M_INP_XPWidth, $GUI_ENABLE)
				GUICtrlSetData($M_INP_XPWidth, IniRead($TempINI, 'Main', 'ExtractPathWidth', ''))
			EndIf
		EndIf
		;  VolumeNameStyle
		If IniRead($TempINI, 'Main', 'VolumeNameStyle', '') <> '' Then
			If IniRead($TempINI, 'Main', 'VolumeNameStyle', '') = 0 Or IniRead($TempINI, 'Main', 'VolumeNameStyle', '') = 1 Then
				GUICtrlSetState($M_CHK_VOLNAME, $GUI_CHECKED)
				GUICtrlSetState($M_INP_VOLNAME, $GUI_ENABLE)
				GUICtrlSetData($M_INP_VOLNAME, IniRead($TempINI, 'Main', 'VolumeNameStyle', ''))
			EndIf
		EndIf
		;  Title/Text
		GUICtrlSetData($T_INP_ERRORTITLE, IniRead($TempINI, 'Main', 'ErrorTitle', ''))
		GUICtrlSetData($T_INP_WARNTITLE, IniRead($TempINI, 'Main', 'WarningTitle', ''))
		GUICtrlSetData($T_INP_WINTITLE, IniRead($TempINI, 'Main', 'Title', ''))
		GUICtrlSetData($T_INP_XCANCELTEXT, IniRead($TempINI, 'Main', 'ExtractCancelText', ''))
		GUICtrlSetData($T_INP_XPATHWINTITLE, IniRead($TempINI, 'Main', 'ExtractPathTitle', ''))
		GUICtrlSetData($T_INP_XTITLE, IniRead($TempINI, 'Main', 'ExtractTitle', ''))
		GUICtrlSetData($T_INP_PASSWDTEXT, IniRead($TempINI, 'Main', 'PasswordText', ''))
		GUICtrlSetData($T_INP_PASSWDTITLE, IniRead($TempINI, 'Main', 'PasswordTitle', ''))
		;  ExecuteFile
		$execfile = IniRead($TempINI, 'Main', 'ExecuteFile', '')
		$execparam = IniRead($TempINI, 'Main', 'ExecuteParameters', '')
		If $execfile <> '' Then
			GUICtrlCreateListViewItem('ExecuteFile|N/A|' & $execfile & '|' & $execparam & '|N/A', $R_LIST)
		EndIf
		; ------------------------------------------
		For $h = 1 To $sArray[0]
			; BeginPrompt
			If StringLeft($sArray[$h], 12) == 'BeginPrompt=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[1] = StringTrimRight(StringTrimLeft($sArray[$h], 13), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[1] = '' Then
							$MS_VALUES[1] = StringTrimLeft($sArray[$_h], 13)
						Else
							$MS_VALUES[1] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[1] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[1], $MS_VALUES[1])
				; ExtractPathText
			ElseIf StringLeft($sArray[$h], 16) == 'ExtractPathText=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[2] = StringTrimRight(StringTrimLeft($sArray[$h], 17), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[2] = '' Then
							$MS_VALUES[2] = StringTrimLeft($sArray[$_h], 17)
						Else
							$MS_VALUES[2] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[2] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[2], $MS_VALUES[2])
				; ExtractDialogText
			ElseIf StringLeft($sArray[$h], 18) == 'ExtractDialogText=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[3] = StringTrimRight(StringTrimLeft($sArray[$h], 19), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[3] = '' Then
							$MS_VALUES[3] = StringTrimLeft($sArray[$_h], 19)
						Else
							$MS_VALUES[3] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[3] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[3], $MS_VALUES[3])
				; CancelPrompt
			ElseIf StringLeft($sArray[$h], 13) == 'CancelPrompt=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[4] = StringTrimRight(StringTrimLeft($sArray[$h], 14), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[4] = '' Then
							$MS_VALUES[4] = StringTrimLeft($sArray[$_h], 14)
						Else
							$MS_VALUES[4] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[4] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[4], $MS_VALUES[4])
				; FinishMessage
			ElseIf StringLeft($sArray[$h], 14) == 'FinishMessage=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[5] = StringTrimRight(StringTrimLeft($sArray[$h], 15), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[5] = '' Then
							$MS_VALUES[5] = StringTrimLeft($sArray[$_h], 15)
						Else
							$MS_VALUES[5] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[5] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[5], $MS_VALUES[5])
				; HelpText
			ElseIf StringLeft($sArray[$h], 9) == 'HelpText=' Then
				If StringRight($sArray[$h], 1) = '"' And StringRight($sArray[$h], 2) <> '\"' Then
					$MS_VALUES[6] = StringTrimRight(StringTrimLeft($sArray[$h], 10), 1)
				Else
					$_h = $h
					Do
						If $MS_VALUES[6] = '' Then
							$MS_VALUES[6] = StringTrimLeft($sArray[$_h], 10)
						Else
							$MS_VALUES[6] &= @CRLF & $sArray[$_h]
						EndIf
						$_h = $_h + 1
					Until StringRight($sArray[$_h], 1) = '"' And StringRight($sArray[$_h], 2) <> '\"'
					$MS_VALUES[6] &= @CRLF & StringTrimRight($sArray[$_h], 1)
				EndIf
				GUICtrlSetData($MS_EDT_MESSAGES[6], $MS_VALUES[6])
				; RunProgram
			ElseIf StringLeft($sArray[$h], 11) == 'RunProgram=' Or StringLeft($sArray[$h], 11) == 'AutoInstall' Then
				$runparam = ''
				$runprefix = ''
				$l_prefix = ''
				$runfile = ''
				$runcommand = ''
				If StringLeft($sArray[$h], 12) == 'RunProgram="' Then
					$runparam = 'RunProgram'
				ElseIf StringLeft($sArray[$h], 13) == 'AutoInstall="' Then
					$runparam = 'AutoInstall'
				ElseIf StringLeft($sArray[$h], 11) == 'AutoInstall' And StringMid($sArray[$h], 12, 1) <> '=' Then
					$runparam = 'AutoInstall' & StringMid($sArray[$h], 12, 1)
				EndIf
				$runfile = StringRight($sArray[$h], StringLen($sArray[$h]) - StringLen($runparam) - 1)
				If StringLeft($runfile, 1) = '"' And StringRight($runfile, 1) = '"' Then
					$runfile = StringTrimLeft(StringTrimRight($runfile, 1), 1)
					If StringInStr($runfile, ':') Then
						$a_prefix = StringSplit(StringLeft($runfile, StringInStr($runfile, ':', 0, -1)), ':')
						$l_prefix = ''
						For $p = 1 To $a_prefix[0]
							If StringLeft($a_prefix[$p], 2) = 'fm' Then
								If StringIsDigit(StringRight($a_prefix[$p], StringLen($a_prefix[$p]) - 2)) Then
									If StringLen($a_prefix[$p]) > 5 Then
										$runprefix &= 'fm999:'
										$l_prefix = 'fm999:'
									Else
										$runprefix &= $a_prefix[$p] & ':'
										$l_prefix = $a_prefix[$p] & ':'
									EndIf
								EndIf
							ElseIf StringLeft($a_prefix[$p], 3) = 'del' Then
								If StringIsDigit(StringRight($a_prefix[$p], StringLen($a_prefix[$p]) - 3)) Then
									If StringLen($a_prefix[$p]) > 4 Then
										$runprefix &= 'del0:'
										$l_prefix = 'del0:'
									Else
										$runprefix &= $a_prefix[$p] & ':'
										$l_prefix = $a_prefix[$p] & ':'
									EndIf
								EndIf
							ElseIf StringLeft($a_prefix[$p], 3) = 'shc' Then
								If StringIsDigit(StringRight($a_prefix[$p], StringLen($a_prefix[$p]) - 3)) Then
									If StringLen($a_prefix[$p]) > 4 Then
										$runprefix &= 'shc0:'
										$l_prefix = 'shc0:'
									Else
										$runprefix &= $a_prefix[$p] & ':'
										$l_prefix = $a_prefix[$p] & ':'
									EndIf
								EndIf
							Else
								Switch $a_prefix[$p]
									Case 'forcenowait'
										$runprefix &= 'forcenowait:'
										$l_prefix = 'forcenowait:'
									Case 'hidcon'
										$runprefix &= 'hidcon:'
										$l_prefix = 'hidcon:'
									Case 'nowait'
										$runprefix &= 'nowait:'
										$l_prefix = 'nowait:'
									Case 'waitall'
										$runprefix &= 'waitall:'
										$l_prefix = 'waitall:'
									Case 'x64'
										$runprefix &= 'x64:'
										$l_prefix = 'x64:'
									Case 'x86'
										$runprefix &= 'x86:'
										$l_prefix = 'x86:'
								EndSwitch
							EndIf
						Next
					EndIf
					If $l_prefix <> '' Then
						$runfilestart = StringInStr($runfile, $l_prefix, 0, -1) + StringLen($l_prefix)
						$runfile = StringMid($runfile, $runfilestart, StringLen($runfile) - $runfilestart + 1)
					EndIf
					;-----------------------------
					If StringLeft($runfile, 2) = '\"' Then
						If _String_GetStrCount($runfile, '\"') > 1 Then
							If StringInStr($runfile, '\" ') Then
								$runcommand = StringRight($runfile, StringLen($runfile) - StringLen(StringLeft($runfile, StringInStr($runfile, '\" ', 0, 1) + 2)))
								$runfile = StringLeft($runfile, StringInStr($runfile, '\" ', 0, 1) + 1)
							EndIf
						EndIf
					Else
						If StringInStr($runfile, ' ') Then
							$runcommand = StringRight($runfile, StringLen($runfile) - StringLen(StringLeft($runfile, StringInStr($runfile, ' '))))
							$runfile = StringLeft($runfile, StringInStr($runfile, ' ') - 1)
						EndIf
					EndIf
					;-----------------------------
					If StringLeft($runfile, 2) = '\"' And StringRight($runfile, 2) = '\"' Then
						$runfile = StringTrimLeft(StringTrimRight($runfile, 2), 2)
						$runquote = 'True'
					Else
						$runquote = 'False'
					EndIf
					GUICtrlCreateListViewItem($runparam & '|' & $runprefix & '|' & $runfile & '|' & $runcommand & '|' & $runquote, $R_LIST)
					; Delete
				EndIf
			ElseIf StringLeft($sArray[$h], 6) == 'Delete' Then
				$delparam = ''
				$delfile = ''
				If StringMid($sArray[$h], 7, 1) <> '=' Then
					$delparam = StringLeft($sArray[$h], 7)
					If StringMid($sArray[$h], 9, 3) = '"\"' Then
						$delquote = 'True'
						$delfile = StringMid($sArray[$h], 12, StringLen($sArray[$h]) - 14)
					ElseIf StringMid($sArray[$h], 9, 1) = '"' Then
						$delquote = 'False'
						$delfile = StringMid($sArray[$h], 10, StringLen($sArray[$h]) - 10)
					EndIf
				Else
					$delparam = StringLeft($sArray[$h], 6)
					If StringMid($sArray[$h], 8, 3) = '"\"' Then
						$delquote = 'True'
						$delfile = StringMid($sArray[$h], 11, StringLen($sArray[$h]) - 13)
					ElseIf StringMid($sArray[$h], 8, 1) = '"' Then
						$delquote = 'False'
						$delfile = StringMid($sArray[$h], 9, StringLen($sArray[$h]) - 9)
					EndIf
				EndIf
				GUICtrlCreateListViewItem($delparam & '|' & $delfile & '|' & $delquote, $D_LIST)
				; Shortcuts
			ElseIf StringLeft($sArray[$h], 8) == 'Shortcut' Then
				If _StringGetStrCount($sArray[$h], '{') = 8 And _StringGetStrCount($sArray[$h], '}') = 8 Then
					Dim $shcvalue[10]
					$shcparam = ''
					$shcstart = ''
					$shcend = ''
					$shcparam = StringLeft($sArray[$h], 9)
					If StringRight($shcparam, 1) = '=' Then $shcparam = StringTrimRight($shcparam, 1)
					$shcvalue[0] = StringMid($sArray[$h], StringLen($shcparam) + 3, 2)
					If StringRight($shcvalue[0], 1) = ',' Then $shcvalue[0] = StringTrimRight($shcvalue[0], 1)
					For $c = 1 To 8
						$shcstart = StringInStr($sArray[$h], '{', 0, $c) + 1
						$shcend = StringInStr($sArray[$h], '}', 0, $c)
						$shcvalue[$c] = StringMid($sArray[$h], $shcstart, $shcend - $shcstart)
					Next
					$shcvalue[9] = $shcparam & '|' & $shcvalue[0] & '|' & $shcvalue[1] & '|' & $shcvalue[2] & '|' & $shcvalue[3] & '|' & $shcvalue[4] & '|' & $shcvalue[5] & '|' & $shcvalue[6] & '|' & $shcvalue[7] & '|' & $shcvalue[8]
					GUICtrlCreateListViewItem($shcvalue[9], $SH_LIST)
				EndIf
				; Variables
			ElseIf StringLeft($sArray[$h], 16) == 'SetEnvironment="' Then
				If StringRight($sArray[$h], 3) = '\""' And StringMid($sArray[$h], StringInStr($sArray[$h], '=', 0, 2) + 1, 2) = '\"' Then
					GUICtrlCreateListViewItem(StringMid($sArray[$h], 17, StringInStr($sArray[$h], '=', 0, 2) - 17) & '|' & StringMid($sArray[$h], StringInStr($sArray[$h], '=', 0, 2) + 3, StringLen($sArray[$h]) - StringInStr($sArray[$h], '=', 0, 2) - 5), $E_LIST)
				Else
					GUICtrlCreateListViewItem(StringMid($sArray[$h], 17, StringInStr($sArray[$h], '=', 0, 2) - 17) & '|' & StringMid($sArray[$h], StringInStr($sArray[$h], '=', 0, 2) + 1, StringLen($sArray[$h]) - StringInStr($sArray[$h], '=', 0, 2) - 1), $E_LIST)
				EndIf
			EndIf
		Next
		$CurFile = $_FileToLoad
		FileDelete($TempINI)
		GUISetState(@SW_UNLOCK, $GUI_MAIN)
	EndIf
	_Update()
	$last_saved = $BuiltCONFIG[1]
EndFunc   ;==>_CFG_Load
Func _Close_Window($_cWnd, $_pWnd)
	GUISetState(@SW_ENABLE, $_pWnd)
	GUISetState(@SW_RESTORE, $_pWnd)
	GUIDelete($_cWnd)
EndFunc   ;==>_Close_Window
Func _Create_TempDir($cMode = 1)
	If $cMode = 1 Then ;create main temp folder only
		If Not FileExists($TempFOLDER) Then DirCreate($TempFOLDER)
		FileSetAttrib($TempFOLDER, '+H')
	ElseIf $cMode = 2 Then ;create temp folder for loaded sfx files
		If Not FileExists($TempFOLDER) Then DirCreate($TempFOLDER)
		If Not FileExists($TempSFXFLDR) Then DirCreate($TempSFXFLDR)
		FileSetAttrib($TempFOLDER, '+H')
	ElseIf $cMode = 3 Then ;create temp folder for testing
		If Not FileExists($TempFOLDER) Then DirCreate($TempFOLDER)
		If Not FileExists($TempTESTFLDR) Then DirCreate($TempTESTFLDR)
		FileSetAttrib($TempFOLDER, '+H')
	EndIf
EndFunc   ;==>_Create_TempDir
Func _ClearTemp($DelMode = 1)
	If $DelMode = 1 Then
		If FileExists($TempFOLDER) Then
			FileDelete($TempFOLDER & '\*.*')
		Else
			_Create_TempDir()
		EndIf
	ElseIf $DelMode = 2 Then
		If FileExists($TempFOLDER) Then
			FileDelete($TempFOLDER & '\*.*')
		Else
			_Create_TempDir()
		EndIf
		If FileExists($TempSFXFLDR) Then FileDelete($TempSFXFLDR & '\*.*')
		If FileExists($TempTESTFLDR) Then FileDelete($TempTESTFLDR & '\*.*')
		DirRemove($TempSFXFLDR, 1)
		DirRemove($TempTESTFLDR, 1)
	ElseIf $DelMode = 3 Then
		FileDelete($TempSFXFLDR & '\*.*')
		FileDelete($TempTESTFLDR & '\*.*')
		FileDelete($TempFOLDER & '\*.*')
		DirRemove($TempSFXFLDR, 1)
		DirRemove($TempTESTFLDR, 1)
		DirRemove($TempFOLDER, 1)
	ElseIf $DelMode = 4 Then
		If FileExists($TempSFXFLDR) Then
			FileDelete($TempSFXFLDR & '\*.*')
		Else
			_Create_TempDir(2)
		EndIf
	ElseIf $DelMode = 5 Then
		If FileExists($TempTESTFLDR) Then
			FileDelete($TempTESTFLDR & '\*.*')
		Else
			_Create_TempDir(3)
		EndIf
	EndIf
EndFunc   ;==>_ClearTemp
Func _FileOpenEx($_file, $_mode = 0, $_wdata = '')
	; check path
	If Not _Path_Check($_file) Then Return SetError(1, 0, 0)
	; open file
	Local $hFile = FileOpen($_file, $_mode)
	If @error Then Return SetError(2, 0, 0)
	If $_wdata = '' Then Return $hFile
	; write file if defined
	Local $fWrite = FileWrite($hFile, $_wdata)
	; close handle
	FileClose($hFile)
	If $fWrite = 0 Then Return SetError(3, 0, 0)
	Return SetError(0, 0, 1)
EndFunc   ;==>_FileOpenEx
Func _GUICtrlCreateMenuEx($iText, $hMenu = '', $icPath = '', $icIndex = '')
	Local $hItem
	If $OSArch Then
		Return GUICtrlCreateMenu($iText, $hMenu)
	Else
		Return _GUICtrlCreateODMenu($iText, $hMenu, $icPath, $icIndex)
	EndIf
EndFunc   ;==>_GUICtrlCreateMenuEx
Func _GUICtrlCreateMenuItemEx($iText, $hMenu, $icPath = '', $icIndex = '')
	If $OSArch Then
		Return GUICtrlCreateMenuItem($iText, $hMenu)
	Else
		Return _GUICtrlCreateODMenuItem($iText, $hMenu, $icPath, $icIndex)
	EndIf
EndFunc   ;==>_GUICtrlCreateMenuItemEx
Func _Exit()
	$cPos = WinGetPos($GUI_MAIN)
	_Update()
	If $last_saved <> $BuiltCONFIG[1] And $LineCOUNT[0] > 3 Then
		$iMsgBoxAnswer = _MsgBoxEx(111)
		If $iMsgBoxAnswer = 6 Then
			_CFG_Save()
			_Write_INI()
			_ClearImageList()
			_ClearTemp(3)
			Exit
		ElseIf $iMsgBoxAnswer = 7 Then
			_Write_INI()
			_ClearImageList()
			_ClearTemp(3)
			Exit
		ElseIf $iMsgBoxAnswer = 2 Then
			GUISetState(@SW_RESTORE, $GUI_MAIN)
		EndIf
	Else
		_Write_INI()
		_ClearImageList()
		_ClearTemp(3)
		Exit
	EndIf
EndFunc   ;==>_Exit
Func _Write_INI()
	If FileExists($SetsINI) Or (Not FileExists($SetsINI) And $RegMode <> 1) Then
		IniWrite($SetsINI, 'Mode', 'RegMode', $RegMode)
	EndIf
	If $RegMode = 1 Then
		RegWrite($reg_Path, 'XPos', 'REG_SZ', $cPos[0])
		RegWrite($reg_Path, 'YPos', 'REG_SZ', $cPos[1])
		RegWrite($reg_Path, 'UseUPX', 'REG_SZ', $USE_UPX[0])
		RegWrite($reg_Path, 'UPXCommands', 'REG_SZ', $USE_UPX[1])
		RegWrite($reg_Path, 'UseDefaultSFXMod', 'REG_SZ', $USE_DEFMOD[0])
		RegWrite($reg_Path, 'DefaultSFXMod', 'REG_SZ', $USE_DEFMOD[1])
		RegWrite($reg_Path, 'AutoSelectModule', 'REG_SZ', $ModeAUTOMOD)
		RegWrite($reg_Path, 'IgnoreEmptyVersData', 'REG_SZ', $ModeNOVERS)
		RegWrite($reg_Path, 'AutoDetermineSFXPath', 'REG_SZ', $ModeAUTOSFX)
		RegWrite($reg_Path, 'OverwriteSFX', 'REG_SZ', $ModeOWSFX)
		RegWrite($reg_7zPath, 'Path', 'REG_SZ', $7ZIP_PATH)
		RegWrite($reg_7zPath, 'Level', 'REG_SZ', $7z_LVL[0])
		RegWrite($reg_7zPath, 'Method', 'REG_SZ', $7z_METHOD[0])
		RegWrite($reg_7zPath, 'Dictionary', 'REG_SZ', $7z_DICT[0])
		RegWrite($reg_7zPath, 'BlockSize', 'REG_SZ', $7z_SOLID[0])
	Else
		IniWrite($SetsINI, 'Main', 'XPos', $cPos[0])
		IniWrite($SetsINI, 'Main', 'YPos', $cPos[1])
;~ 		IniWrite($SetsINI, 'Main', 'Width', $cPos[2])
;~ 		IniWrite($SetsINI, 'Main', 'Height', $cPos[3])
		IniWrite($SetsINI, 'Main', 'UseUPX', $USE_UPX[0])
		IniWrite($SetsINI, 'Main', 'UPXCommands', $USE_UPX[1])
		IniWrite($SetsINI, 'Main', 'UseDefaultSFXMod', $USE_DEFMOD[0])
		IniWrite($SetsINI, 'Main', 'DefaultSFXMod', $USE_DEFMOD[1])
		IniWrite($SetsINI, 'Main', 'AutoSelectModule', $ModeAUTOMOD)
		IniWrite($SetsINI, 'Main', 'IgnoreEmptyVersData', $ModeNOVERS)
		IniWrite($SetsINI, 'Main', 'AutoDetermineSFXPath', $ModeAUTOSFX)
		IniWrite($SetsINI, 'Main', 'OverwriteSFX', $ModeOWSFX)
		IniWrite($SetsINI, '7-Zip', 'Path', $7ZIP_PATH)
		IniWrite($SetsINI, '7-Zip', 'Level', $7z_LVL[0])
		IniWrite($SetsINI, '7-Zip', 'Method', $7z_METHOD[0])
		IniWrite($SetsINI, '7-Zip', 'Dictionary', $7z_DICT[0])
		IniWrite($SetsINI, '7-Zip', 'BlockSize', $7z_SOLID[0])
	EndIf
EndFunc   ;==>_Write_INI
Func _ClearImageList()
	_GUIImageList_Destroy($LstImage)
	_GUIImageList_Destroy($iBtnMsgList)
	For $c = 0 To UBound($iBtnList_small) - 1
		_GUIImageList_Destroy($iBtnList_small[$c])
	Next
	For $c = 0 To UBound($iBtnList_large) - 1
		_GUIImageList_Destroy($iBtnList_large[$c])
	Next
EndFunc   ;==>_ClearImageList
