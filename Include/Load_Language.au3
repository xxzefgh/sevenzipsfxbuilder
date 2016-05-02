Local $LngLoadTimer = TimerInit()

Global $ini_LANG
If $RegMode = 1 Then
	$ini_LANG = RegRead($reg_Path, 'Lang')
Else
	$ini_LANG = IniRead($SetsINI, 'Main', 'Lang', '')
EndIf

If FileExists(@ScriptDir & '\Lang\' & $ini_LANG & '.ini') Then
	$ini_LANG = @ScriptDir & '\Lang\' & $ini_LANG & '.ini'
ElseIf FileExists(@ScriptDir & '\Lang\English.ini') Then
	$ini_LANG = @ScriptDir & '\Lang\English.ini'
Else
	$ini_LANG = ''
EndIf

_Load_Language($ini_LANG)

ConsoleWrite('LANGUAGE LOAD TIME = ' & TimerDiff($LngLoadTimer) & @CRLF)

Func _Load_Language($_LangPath)
;~ 	ABOUT
	Global $_LNG_ABOUT[7]
	$_LNG_ABOUT[1] = IniRead($_LangPath, "LangOptions", "LANG_NAME", "English")
	$_LNG_ABOUT[2] = IniRead($_LangPath, "LangOptions", "LANG_NATIVE_NAME", "Default")
	$_LNG_ABOUT[3] = IniRead($_LangPath, "LangOptions", "VERSION", "1.6")
	$_LNG_ABOUT[4] = IniRead($_LangPath, "LangOptions", "NAME", "M. Brunjadze")
	$_LNG_ABOUT[5] = IniRead($_LangPath, "LangOptions", "CONTACT", "mailto:mirza.b.@gmail.com")
	If StringLeft($_LNG_ABOUT[5], 7) = 'mailto:' Then $_LNG_ABOUT[5] = StringTrimLeft($_LNG_ABOUT[5], 7)
	$_LNG_ABOUT[6] = IniRead($_LangPath, "LangOptions", "CONTACT", "mailto:mirza.b.@gmail.com")
;~ 	GLOBAL
	Global $_LNG_GLOBAL[19]
	$_LNG_GLOBAL[1] = IniRead($_LangPath, "Global", "TIP_ADD", "Add") ;Button Add
	$_LNG_GLOBAL[2] = IniRead($_LangPath, "Global", "TIP_EDIT", "Edit") ;Button Edit
	$_LNG_GLOBAL[3] = IniRead($_LangPath, "Global", "TIP_DELETE", "Delete") ;Button Delete
	$_LNG_GLOBAL[4] = IniRead($_LangPath, "Global", "TIP_DELETE_ALL", "Delete All") ;Button DeleteAll
	$_LNG_GLOBAL[15] = IniRead($_LangPath, "Global", "TIP_MOVE_UP", "Move Up")
	$_LNG_GLOBAL[16] = IniRead($_LangPath, "Global", "TIP_MOVE_DOWN", "Move Down")
	$_LNG_GLOBAL[5] = IniRead($_LangPath, "Global", "BTN_SAVE", "Save") ;Button Save
	$_LNG_GLOBAL[6] = IniRead($_LangPath, "Global", "BTN_CANCEL", "Cancel") ;Button Cancel
	$_LNG_GLOBAL[7] = IniRead($_LangPath, "Global", "CHK_QUOTES", "Enclosed in quotes") ;CheckBox Enclose In Quotes
	$_LNG_GLOBAL[8] = IniRead($_LangPath, "Global", "LST_SEC_QUOTES", "Quotes") ;ListSection Quotes
	$_LNG_GLOBAL[9] = IniRead($_LangPath, "Global", "ERROR_MSG_TITLE", "Error!") ;Error Message Title
	$_LNG_GLOBAL[10] = IniRead($_LangPath, "Global", "BTN_OK", "OK") ;Error Message Title
	$_LNG_GLOBAL[11] = IniRead($_LangPath, "Global", "WARNING_MSG_TITLE", "Warning") ;Warning Message Title
	$_LNG_GLOBAL[12] = IniRead($_LangPath, "Global", "INFORMATION_MSG_TITLE", "Information") ;Information Message Title
	$_LNG_GLOBAL[13] = IniRead($_LangPath, "Global", "QUESTION_MSG_TITLE", "Question") ;Question Message Title
	$_LNG_GLOBAL[14] = IniRead($_LangPath, "Global", "TEST", "Test")
	$_LNG_GLOBAL[17] = IniRead($_LangPath, "Global", "TIP_BROWSE", "Browse for file")
	$_LNG_GLOBAL[18] = IniRead($_LangPath, "Global", "TIP_OPEN", "Open file location")
	Global $TitleERROR = $NameAPP & ' - ' & $_LNG_GLOBAL[9]
	Global $TitleWARN = $NameAPP & ' - ' & $_LNG_GLOBAL[11]
	Global $TitleINFO = $NameAPP & ' - ' & $_LNG_GLOBAL[12]
	Global $TitleQUEST = $NameAPP & ' - ' & $_LNG_GLOBAL[13]
;~ 	MENU
	Global $_LNG_MENU[18]
	$_LNG_MENU[1] = IniRead($_LangPath, "Menu", "MENU_FILE", "&File")
	$_LNG_MENU[2] = IniRead($_LangPath, "Menu", "MENU_SETTINGS", "&Settings")
	$_LNG_MENU[3] = IniRead($_LangPath, "Menu", "MENU_HELP", "&Help")
	$_LNG_MENU[4] = IniRead($_LangPath, "Menu", "MI_OPEN", "&Open file...") & @TAB & 'Ctrl+O'
	$_LNG_MENU[5] = IniRead($_LangPath, "Menu", "MI_RELOAD", "R&eopen") & @TAB & 'Ctrl+R'
	$_LNG_MENU[6] = IniRead($_LangPath, "Menu", "MI_SAVE", "&Save") & @TAB & 'Ctrl+S'
	$_LNG_MENU[7] = IniRead($_LangPath, "Menu", "MI_SAVE_AS", "Save &as...") & @TAB & 'Ctrl+Shift+S'
	$_LNG_MENU[8] = IniRead($_LangPath, "Menu", "MI_CLOSE", "&Close") & @TAB & 'Ctrl+W'
	$_LNG_MENU[9] = IniRead($_LangPath, "Menu", "SUB_MENU_RECENT_FILES", "&Recent Files")
	$_LNG_MENU[10] = IniRead($_LangPath, "Menu", "MI_CLEAR_LIST", "C&lear list")
	$_LNG_MENU[11] = IniRead($_LangPath, "Menu", "MI_EXIT", "E&xit") & @TAB & 'Ctrl+Q'
	$_LNG_MENU[12] = IniRead($_LangPath, "Menu", "MI_OPTIONS", "&Options")
	$_LNG_MENU[13] = IniRead($_LangPath, "Menu", "SUB_MENU_LANG", "&Language")
	$_LNG_MENU[14] = IniRead($_LangPath, "Menu", "MI_HELP", "Hel&p")
	$_LNG_MENU[15] = IniRead($_LangPath, "Menu", "MI_SITE", "Project &site")
	$_LNG_MENU[16] = IniRead($_LangPath, "Menu", "MI_ABOUT", "A&bout")
	$_LNG_MENU[17] = IniRead($_LangPath, "Menu", "MI_PRESET_MANAGER", "Preset Manager")
;~ 	TOOLBAR TIPS
	Global $_LNG_TOOLBAR[10]
	$_LNG_TOOLBAR[1] = IniRead($_LangPath, "ToolbarTips", "OPEN", "Open file")
	$_LNG_TOOLBAR[2] = IniRead($_LangPath, "ToolbarTips", "SAVE", "Save")
	$_LNG_TOOLBAR[3] = IniRead($_LangPath, "ToolbarTips", "SAVE_AS", "Save as")
	$_LNG_TOOLBAR[4] = IniRead($_LangPath, "ToolbarTips", "CLOSE", "Close file")
	$_LNG_TOOLBAR[5] = IniRead($_LangPath, "ToolbarTips", "TEST", "Test")
	$_LNG_TOOLBAR[6] = IniRead($_LangPath, "ToolbarTips", "PRESET", "Manage presets")
	$_LNG_TOOLBAR[7] = IniRead($_LangPath, "ToolbarTips", "MAKE_SFX", "Make SFX")
	$_LNG_TOOLBAR[8] = IniRead($_LangPath, "ToolbarTips", "OPTIONS", "Program options")
;~ 	TABNAMES
	Global $_LNG_TABNAME[10]
	$_LNG_TABNAME[1] = IniRead($_LangPath, "TabNames", "MAIN", "Main") ;Tab Main
	$_LNG_TABNAME[2] = IniRead($_LangPath, "TabNames", "TITLE_TEXT", "Title/Text") ;Tab Title.Text
	$_LNG_TABNAME[3] = IniRead($_LangPath, "TabNames", "DIALOGS", "Dialogs") ;Tab Dialogs
	$_LNG_TABNAME[4] = IniRead($_LangPath, "TabNames", "RUN", "Run") ;Tab RunProgram
	$_LNG_TABNAME[5] = IniRead($_LangPath, "TabNames", "DELETE", "Delete") ;Tab Delete
	$_LNG_TABNAME[6] = IniRead($_LangPath, "TabNames", "SHORTCUTS", "Shortcuts") ;Tab Shortcuts
	$_LNG_TABNAME[7] = IniRead($_LangPath, "TabNames", "SET_ENV", "SetEnvironment") ;Tab SetEnvironment
	$_LNG_TABNAME[8] = IniRead($_LangPath, "TabNames", "OUTPUT", "Output") ;Tab Output
	$_LNG_TABNAME[9] = IniRead($_LangPath, "TabNames", "SFX", "SFX") ;Tab SFX
;~ 	MAINTAB SECTION
	Global $_LNG_TAB_MAIN[22]
	$_LNG_TAB_MAIN[0] = IniRead($_LangPath, "Tab_Main", "CHK_TEMP_MODE", "TempMode")
	$_LNG_TAB_MAIN[1] = IniRead($_LangPath, "Tab_Main", "CHK_SKIP_LOCKED", "Skip system locked files")
	$_LNG_TAB_MAIN[2] = IniRead($_LangPath, "Tab_Main", "CHK_DELETE_SFX", "Delete SFX File after extraction")
	$_LNG_TAB_MAIN[3] = IniRead($_LangPath, "Tab_Main", "CHK_BPT", "BeginPrompt Timeout:")
	$_LNG_TAB_MAIN[4] = IniRead($_LangPath, "Tab_Main", "CHK_XDWIDTH", "ExtractDialog Width:")
	$_LNG_TAB_MAIN[5] = IniRead($_LangPath, "Tab_Main", "CHK_XPWIDTH", "ExtractPath Width:")

	$_LNG_TAB_MAIN[21] = IniRead($_LangPath, "Tab_Main", "CHK_VOLNAME", "Volume name style:")

	$_LNG_TAB_MAIN[6] = IniRead($_LangPath, "Tab_Main", "RAD_OW_MODE_1", "Overwrite all files")
	$_LNG_TAB_MAIN[7] = IniRead($_LangPath, "Tab_Main", "RAD_OW_MODE_2", "Do not overwrite files")
	$_LNG_TAB_MAIN[8] = IniRead($_LangPath, "Tab_Main", "RAD_OW_MODE_3", "Overwrite older files")
	$_LNG_TAB_MAIN[9] = IniRead($_LangPath, "Tab_Main", "RAD_GUI_MODE_1", "Show all GUI (Default)")
	$_LNG_TAB_MAIN[10] = IniRead($_LangPath, "Tab_Main", "RAD_GUI_MODE_2", "Disable Cancel when extracting")
	$_LNG_TAB_MAIN[11] = IniRead($_LangPath, "Tab_Main", "RAD_GUI_MODE_3", "Hide all GUI window")
	$_LNG_TAB_MAIN[12] = IniRead($_LangPath, "Tab_Main", "GRP_OW_MODE", "Overwrite Mode:")
	$_LNG_TAB_MAIN[13] = IniRead($_LangPath, "Tab_Main", "GRP_GUI_MODE", "GUI Mode:")
	$_LNG_TAB_MAIN[14] = IniRead($_LangPath, "Tab_Main", "LBL_EXT_PATH", "Extraction Path:")
	$_LNG_TAB_MAIN[15] = IniRead($_LangPath, "Tab_Main", "MI_SFX_NAME", "SFX Name")
	$_LNG_TAB_MAIN[16] = IniRead($_LangPath, "Tab_Main", "MI_SFX_PATH", "SFX Path")
	$_LNG_TAB_MAIN[17] = IniRead($_LangPath, "Tab_Main", "TIP_EDIT", "Click to edit")
	$_LNG_TAB_MAIN[18] = IniRead($_LangPath, "Tab_Main", "TIP_INSERT", "Click to insert variables")
	$_LNG_TAB_MAIN[19] = IniRead($_LangPath, "Tab_Main", "TIP_RELOAD", "Reload")
	$_LNG_TAB_MAIN[20] = IniRead($_LangPath, "Tab_Main", "TIP_OPEN", "Open with default text editor")
;~ 	TITLE/TEXT SECTION
	Global $_LNG_TAB_TT[11]
	$_LNG_TAB_TT[1] = IniRead($_LangPath, "Tab_TitleText", "GRP_TITLE", "Title")
	$_LNG_TAB_TT[2] = IniRead($_LangPath, "Tab_TitleText", "GRP_TEXT", "Text")
	$_LNG_TAB_TT[3] = IniRead($_LangPath, "Tab_TitleText", "LBL_WIN_TITLE", "Window Title:")
	$_LNG_TAB_TT[4] = IniRead($_LangPath, "Tab_TitleText", "LBL_EXT_PATH_WIN_TITLE", "Extract Path Window Title:")
	$_LNG_TAB_TT[5] = IniRead($_LangPath, "Tab_TitleText", "LBL_EXT_WIN_TITLE", "Extract Title:")
	$_LNG_TAB_TT[6] = IniRead($_LangPath, "Tab_TitleText", "LBL_ERROR_WIN_TITLE", "Error Message Title:")
	$_LNG_TAB_TT[7] = IniRead($_LangPath, "Tab_TitleText", "LBL_WARN_WIN_TITLE", "Warning Message Title:")
	$_LNG_TAB_TT[8] = IniRead($_LangPath, "Tab_TitleText", "LBL_PASSWD_TITLE", "Password Title:")
	$_LNG_TAB_TT[9] = IniRead($_LangPath, "Tab_TitleText", "LBL_PASSWD_TEXT", "Password Text:")
	$_LNG_TAB_TT[10] = IniRead($_LangPath, "Tab_TitleText", "LBL_EXT_CANCEL_TEXT", "Extract Cancel Text:")
;~ 	RUNPROGRAM SECTION
	Global $_LNG_TAB_RUN[6]
	$_LNG_TAB_RUN[2] = IniRead($_LangPath, "Tab_RunProgram", "LST_SEC_PARAMETER", "Parameter")
	$_LNG_TAB_RUN[3] = IniRead($_LangPath, "Tab_RunProgram", "LST_SEC_PREFIX", "Prefix")
	$_LNG_TAB_RUN[4] = IniRead($_LangPath, "Tab_RunProgram", "LST_SEC_FILE_FOLDER", "File/Folder Path")
	$_LNG_TAB_RUN[5] = IniRead($_LangPath, "Tab_RunProgram", "LST_SEC_COMMANDS", "Commands")
	$_LNG_TAB_RUN[1] = $_LNG_TAB_RUN[2] & '|' & $_LNG_TAB_RUN[3] & '|' & $_LNG_TAB_RUN[4] & '|' & $_LNG_TAB_RUN[5] & '|' & $_LNG_GLOBAL[8]
;~ 	DELETE SECTION
	Global $_LNG_TAB_DEL[4]
	$_LNG_TAB_DEL[2] = IniRead($_LangPath, "Tab_Delete", "LST_SEC_PARAMETER", "Parameter")
	$_LNG_TAB_DEL[3] = IniRead($_LangPath, "Tab_Delete", "LST_SEC_FILE_FOLDER", "File/Folder Path")
	$_LNG_TAB_DEL[1] = $_LNG_TAB_DEL[2] & '|' & $_LNG_TAB_DEL[3] & '|' & $_LNG_GLOBAL[8]
;~ 	SHORTCUTS SECTION
	Global $_LNG_TAB_SHC[12]
	$_LNG_TAB_SHC[2] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_PARAMETER", "Parameter")
	$_LNG_TAB_SHC[3] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_PATH", "Path")
	$_LNG_TAB_SHC[4] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_SRC", "Source")
	$_LNG_TAB_SHC[5] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_CMDS", "Commands")
	$_LNG_TAB_SHC[6] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_DEST", "Destination")
	$_LNG_TAB_SHC[7] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_DESC", "Description")
	$_LNG_TAB_SHC[8] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_NAME", "Name")
	$_LNG_TAB_SHC[9] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_WD", "Working Directory")
	$_LNG_TAB_SHC[10] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_ICON", "Icon")
	$_LNG_TAB_SHC[11] = IniRead($_LangPath, "Tab_Shortcuts", "LST_SEC_INDEX", "Index")
	$_LNG_TAB_SHC[1] = $_LNG_TAB_SHC[2] & '|' & $_LNG_TAB_SHC[3] & '|' & $_LNG_TAB_SHC[4] & '|' & $_LNG_TAB_SHC[5] & '|' & $_LNG_TAB_SHC[6] & '|' & $_LNG_TAB_SHC[7] & '|' & $_LNG_TAB_SHC[8] & '|' & $_LNG_TAB_SHC[9] & '|' & $_LNG_TAB_SHC[10] & '|' & $_LNG_TAB_SHC[11]
;~ 	SETENVIRONMENT SECTION
	Global $_LNG_TAB_ENV[4]
	$_LNG_TAB_ENV[2] = IniRead($_LangPath, "Tab_SetEnvironment", "LST_SEC_NAME", "Variable Name")
	$_LNG_TAB_ENV[3] = IniRead($_LangPath, "Tab_SetEnvironment", "LST_SEC_VALUE", "Value")
	$_LNG_TAB_ENV[1] = $_LNG_TAB_ENV[2] & '|' & $_LNG_TAB_ENV[3]
;~ 	SFX SECTION
	Global $_LNG_TAB_SFX[14]
	$_LNG_TAB_SFX[1] = IniRead($_LangPath, "Tab_SFX", "BTN_SELECT", "Select...")
	$_LNG_TAB_SFX[2] = IniRead($_LangPath, "Tab_SFX", "BTN_MAKE_SFX", "Make SFX")
	$_LNG_TAB_SFX[3] = IniRead($_LangPath, "Tab_SFX", "BTN_SFX_OPTIONS", "SFX Options")
	$_LNG_TAB_SFX[4] = IniRead($_LangPath, "Tab_SFX", "BTN_EDIT_VERS", "Edit Version Info")
	$_LNG_TAB_SFX[5] = IniRead($_LangPath, "Tab_SFX", "CHK_INCLUDE_PATH", "Include path into configuration file")
	$_LNG_TAB_SFX[6] = IniRead($_LangPath, "Tab_SFX", "GRP_SFX_FILES", "SFX Files")
	$_LNG_TAB_SFX[7] = IniRead($_LangPath, "Tab_SFX", "GRP_SFX_ICON", "Icon")
	$_LNG_TAB_SFX[8] = IniRead($_LangPath, "Tab_SFX", "LBL_CONFIG_FILE", "Configuration file:")
	$_LNG_TAB_SFX[9] = IniRead($_LangPath, "Tab_SFX", "LBL_7Z_ARCHIVE", "7z Archive:")
	$_LNG_TAB_SFX[10] = IniRead($_LangPath, "Tab_SFX", "LBL_SFX_MODULE", "SFX Module:")
	$_LNG_TAB_SFX[11] = IniRead($_LangPath, "Tab_SFX", "LBL_SFX_PATH", "SFX Path:")
	$_LNG_TAB_SFX[12] = IniRead($_LangPath, "Tab_SFX", "LBL_SFX_ICON", "SFX Icon:")
	$_LNG_TAB_SFX[13] = IniRead($_LangPath, "Tab_SFX", "CHK_USE_SELECTED_CFG", "Use selected configuration file")
;~ 	GUI PROGRAM OPTIONS
	Global $_LNG_GUI_APPOPTS[14]
	$_LNG_GUI_APPOPTS[1] = IniRead($_LangPath, "GUI_ProgramOptions", "GUI_TITLE", "Program options")
	$_LNG_GUI_APPOPTS[2] = IniRead($_LangPath, "GUI_ProgramOptions", "BTN_INTEGRATE", "Integrate program in the context menu")
	$_LNG_GUI_APPOPTS[10] = IniRead($_LangPath, "GUI_ProgramOptions", "BTN_EXPORT", "Export...")
	$_LNG_GUI_APPOPTS[11] = IniRead($_LangPath, "GUI_ProgramOptions", "MI_REGISTRY", "Registry file...")
	$_LNG_GUI_APPOPTS[12] = IniRead($_LangPath, "GUI_ProgramOptions", "MI_INI", "INI file...")
	$_LNG_GUI_APPOPTS[3] = IniRead($_LangPath, "GUI_ProgramOptions", "CHK_IGNORE_EMPTY", "Don't create empty version info keys")
	$_LNG_GUI_APPOPTS[13] = IniRead($_LangPath, "GUI_ProgramOptions", "CHK_AUTODEFMOD", "Automatically use default module if loaded config doesn't contain it")
	$_LNG_GUI_APPOPTS[4] = IniRead($_LangPath, "GUI_ProgramOptions", "CHK_AUTO_NAME_SFX", "Create SFX file in the config's directory if SFX path isn't defined")
	$_LNG_GUI_APPOPTS[5] = IniRead($_LangPath, "GUI_ProgramOptions", "CHK_OVERWRITE_FILES", "Overwrite existing files")
	$_LNG_GUI_APPOPTS[6] = IniRead($_LangPath, "GUI_ProgramOptions", "CHK_USERMODE", "Save settings in the registry")
	$_LNG_GUI_APPOPTS[7] = IniRead($_LangPath, "GUI_ProgramOptions", "GRP_PROGRAM", "Program related")
	$_LNG_GUI_APPOPTS[8] = IniRead($_LangPath, "GUI_ProgramOptions", "GRP_SFX", "SFX creation related")
	$_LNG_GUI_APPOPTS[9] = IniRead($_LangPath, "GUI_ProgramOptions", "LBL_LANGUAGE", "Interface language:")
;~ 	GUI PRESET MANAGER
	Global $_LNG_GUI_PRESET[10]
	$_LNG_GUI_PRESET[1] = IniRead($_LangPath, "GUI_PresetManager", "GUI_TITLE", "Preset Manager")
	$_LNG_GUI_PRESET[2] = IniRead($_LangPath, "GUI_PresetManager", "GUI_TITLE2", "New Preset")
	$_LNG_GUI_PRESET[3] = IniRead($_LangPath, "GUI_PresetManager", "GUI_TITLE3", "Rename Preset")
	$_LNG_GUI_PRESET[4] = IniRead($_LangPath, "GUI_PresetManager", "BTN_NEW", "New")
	$_LNG_GUI_PRESET[5] = IniRead($_LangPath, "GUI_PresetManager", "BTN_LOAD", "Load")
	$_LNG_GUI_PRESET[6] = IniRead($_LangPath, "GUI_PresetManager", "BTN_SAVE", "Save")
	$_LNG_GUI_PRESET[7] = IniRead($_LangPath, "GUI_PresetManager", "BTN_EDIT", "Edit name")
	$_LNG_GUI_PRESET[8] = IniRead($_LangPath, "GUI_PresetManager", "BTN_DELETE", "Delete")
	$_LNG_GUI_PRESET[9] = IniRead($_LangPath, "GUI_PresetManager", "LBL_NAME", "Type preset name:")
;~ 	GUI ARCSETS
	Global $_LNG_GUI_ARCSETS[5]
	$_LNG_GUI_ARCSETS[1] = IniRead($_LangPath, "GUI_ArchiveSets", "CHK_SUBFILES", "Archive only files/folders located in given folder")
	$_LNG_GUI_ARCSETS[2] = IniRead($_LangPath, "GUI_ArchiveSets", "LBL_DRAGDROP", "You can use Drag and Drop function to add files/folders")
	$_LNG_GUI_ARCSETS[3] = IniRead($_LangPath, "GUI_ArchiveSets", "TIP_ADDFILE", "Add file(s)")
	$_LNG_GUI_ARCSETS[4] = IniRead($_LangPath, "GUI_ArchiveSets", "TIP_ADDFOLDER", "Add folder")
;~ 	GUI SFXOPTS
	Global $_LNG_GUI_SFXOPTS[23]
	$_LNG_GUI_SFXOPTS[1] = IniRead($_LangPath, "GUI_SFXOpts", "GUI_TITLE", "SFX Options")
	$_LNG_GUI_SFXOPTS[4] = IniRead($_LangPath, "GUI_SFXOpts", "TAB_SFX_OPTIONS", "SFX Options")
	$_LNG_GUI_SFXOPTS[5] = IniRead($_LangPath, "GUI_SFXOpts", "TAB_ARCHIVE_FILES", "Archive Files")
	$_LNG_GUI_SFXOPTS[2] = IniRead($_LangPath, "GUI_SFXOpts", "CHK_USE_UPX", "Compress SFX module with UPX")
	$_LNG_GUI_SFXOPTS[3] = IniRead($_LangPath, "GUI_SFXOpts", "CHK_USE_SFX_MOD", "Use following SFX module:")
	$_LNG_GUI_SFXOPTS[6] = IniRead($_LangPath, "GUI_SFXOpts", "CMB_USE_7ZIP1", "Always use 7-Zip")
	$_LNG_GUI_SFXOPTS[7] = IniRead($_LangPath, "GUI_SFXOpts", "CMB_USE_7ZIP2", "Use 7-Zip only if archive files are specified")
	$_LNG_GUI_SFXOPTS[8] = IniRead($_LangPath, "GUI_SFXOpts", "CMB_USE_7ZIP3", "Don't use 7-Zip if 7z Archive is specified")
	$_LNG_GUI_SFXOPTS[9] = IniRead($_LangPath, "GUI_SFXOpts", "CMB_USE_7ZIP4", "Never use 7-Zip")
	$_LNG_GUI_SFXOPTS[10] = $_LNG_GUI_SFXOPTS[6] & '|' & $_LNG_GUI_SFXOPTS[7] & '|' & $_LNG_GUI_SFXOPTS[8] & '|' & $_LNG_GUI_SFXOPTS[9]
	$_LNG_GUI_SFXOPTS[11] = IniRead($_LangPath, "GUI_SFXOpts", "LBL_PATH", "7-Zip path")
	$_LNG_GUI_SFXOPTS[12] = IniRead($_LangPath, "GUI_SFXOpts", "TIP_BROWSE", "Select 7-Zip path")
	$_LNG_GUI_SFXOPTS[13] = IniRead($_LangPath, "GUI_SFXOpts", "TIP_CONFIG", "7-Zip configuration")
	$_LNG_GUI_SFXOPTS[18] = IniRead($_LangPath, "GUI_SFXOpts", "7ZIP_TITLE", "7-Zip configuration")
	$_LNG_GUI_SFXOPTS[19] = IniRead($_LangPath, "GUI_SFXOpts", "7ZIP_LEVEL", "Compression level:")
	$_LNG_GUI_SFXOPTS[20] = IniRead($_LangPath, "GUI_SFXOpts", "7ZIP_METHOD", "Compression method:")
	$_LNG_GUI_SFXOPTS[21] = IniRead($_LangPath, "GUI_SFXOpts", "7ZIP_DICT", "Dictionary size:")
	$_LNG_GUI_SFXOPTS[22] = IniRead($_LangPath, "GUI_SFXOpts", "7ZIP_SOLID", "Solid Block size:")
;~ 	GUI VERSION INFO
	Global $_LNG_GUI_VERS[9]
	$_LNG_GUI_VERS[1] = IniRead($_LangPath, "GUI_VersionInfo", "GUI_TITLE", "Edit file version info")
	$_LNG_GUI_VERS[2] = IniRead($_LangPath, "GUI_VersionInfo", "BTN_LOAD", "Load")
	$_LNG_GUI_VERS[3] = IniRead($_LangPath, "GUI_VersionInfo", "MI_LOAD_SFXMOD", "From selected SFX module...")
	$_LNG_GUI_VERS[4] = IniRead($_LangPath, "GUI_VersionInfo", "MI_LOAD_FILE", "From file...")
	$_LNG_GUI_VERS[5] = IniRead($_LangPath, "GUI_VersionInfo", "MI_LOAD_VALUES", "Load saved")
	$_LNG_GUI_VERS[6] = IniRead($_LangPath, "GUI_VersionInfo", "MI_SAVE_VALUES", "Save current values")
	$_LNG_GUI_VERS[7] = IniRead($_LangPath, "GUI_VersionInfo", "CHK_INCLUDE", "Include information into configuration file")
	$_LNG_GUI_VERS[8] = IniRead($_LangPath, "GUI_VersionInfo", "CHK_CHANGE_VERS", "Change version info")
;~ 	GUI GUI/MISC FLAGS
	Global $_LNG_GUI_GF[25]
	$_LNG_GUI_GF[1] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "GUI_TITLE", "Edit GUI/Misc Flags")
	$_LNG_GUI_GF[2] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_1", "Show the extraction percentage in the TitleBar on the right (by default - on the left)")
	$_LNG_GUI_GF[3] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_2", "Don't display the extraction percentage in the TitleBar")
	$_LNG_GUI_GF[4] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_4", "Show the extraction percentage under ProgressBar")
	$_LNG_GUI_GF[5] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_8", "Use Windows XP styles (scheme)")
	$_LNG_GUI_GF[6] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_16", "Use bold font for the extraction percentage")
	$_LNG_GUI_GF[7] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_32", "Display an icon in the window of the extraction progress")
	$_LNG_GUI_GF[8] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_64", "Use window 'BeginPrompt' to specify extraction path")
	$_LNG_GUI_GF[9] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_128", "Use separate window to specify extraction path")
	$_LNG_GUI_GF[10] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_256", "Confirm the abolition of the installation/extraction")
	$_LNG_GUI_GF[11] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_512", "Don't display an icon in the TitleBar of all the windows and on [Alt+Tab]")
	$_LNG_GUI_GF[12] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_1024", "Display an icon in the window for specifying extraction path")
	$_LNG_GUI_GF[13] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_2048", "Display an icon in the window 'BeginPrompt'")
	$_LNG_GUI_GF[14] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_4096", "Change an icon and button names. Instead of 'Yes'-'No' would be 'OK'-'Cancel'")
	$_LNG_GUI_GF[15] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_8192", "Don't show ProgressBar on the TaskBar (only for Windows 7)")
	$_LNG_GUI_GF[16] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_GUI_FLAG_16384", "Show '&&' symbol in the texts")
	$_LNG_GUI_GF[17] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_MISC_FLAG_1", "Don't verify free disk space needed for the extraction")
	$_LNG_GUI_GF[18] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_MISC_FLAG_2", "Don't verify free RAM needed for the extraction")
	$_LNG_GUI_GF[19] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_MISC_FLAG_4", "Require administrator privilegies for the all operation")
	$_LNG_GUI_GF[20] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "LBL_MISC_FLAG_8", "Show password request window after 'BeginPrompt' and 'ExtractPath' windows")
	$_LNG_GUI_GF[21] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "BTN_NEW", "New")
	$_LNG_GUI_GF[22] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "BTN_LOAD", "Load")
	$_LNG_GUI_GF[23] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "BTN_RESET", "Reset")
	$_LNG_GUI_GF[24] = IniRead($_LangPath, "GUI_Gui.MiscFlags", "BTN_DELETE", "Delete")
;~ 	GUI MISCFLAGS
	Global $_LNG_GUI_MF[6]
	$_LNG_GUI_MF[1] = IniRead($_LangPath, "GUI_MiscFlags", "GUI_TITLE", "Edit GUIFlags")

;~  GUI RUNPROGRAM
	Global $_LNG_GUI_RUN[8]
	$_LNG_GUI_RUN[1] = IniRead($_LangPath, "GUI_RunProgram", "GUI_TITLE", "Add programs to run after extraction")
	$_LNG_GUI_RUN[2] = IniRead($_LangPath, "GUI_RunProgram", "GUI_PFX_TITLE", "Edit prefixes")
	$_LNG_GUI_RUN[3] = IniRead($_LangPath, "GUI_RunProgram", "LBL_PARAMETER", "Parameter:")
	$_LNG_GUI_RUN[4] = IniRead($_LangPath, "GUI_RunProgram", "LBL_FILE", "File/Program:")
	$_LNG_GUI_RUN[5] = IniRead($_LangPath, "GUI_RunProgram", "LBL_PREFIX", "Prefix:")
	$_LNG_GUI_RUN[6] = IniRead($_LangPath, "GUI_RunProgram", "LBL_COMMANDS", "Commands:")
;~ 	GUI DELETE
	Global $_LNG_GUI_DEL[4]
	$_LNG_GUI_DEL[1] = IniRead($_LangPath, "GUI_Delete", "GUI_TITLE", "Add files to delete after extraction")
	$_LNG_GUI_DEL[2] = IniRead($_LangPath, "GUI_Delete", "LBL_PARAMETER", "Parameter:")
	$_LNG_GUI_DEL[3] = IniRead($_LangPath, "GUI_Delete", "LBL_FILE", "File/Folder:")
;~ 	GUI SHORTCUTS
	Global $_LNG_GUI_SHC[19]
	$_LNG_GUI_SHC[1] = IniRead($_LangPath, "GUI_Shortcuts", "GUI_TITLE", "Add shortcuts to create")
	$_LNG_GUI_SHC[2] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_DESKTOP", "Desktop")
	$_LNG_GUI_SHC[3] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_START_MENU", "Start Menu")
	$_LNG_GUI_SHC[4] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_PROGRAMS", "Start Menu\Programs")
	$_LNG_GUI_SHC[5] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_STARTUP", "Startup")
	$_LNG_GUI_SHC[6] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_CURRENT_USER", "Current User")
	$_LNG_GUI_SHC[7] = IniRead($_LangPath, "GUI_Shortcuts", "RAD_ALLUSERS", "All Users")
	$_LNG_GUI_SHC[8] = IniRead($_LangPath, "GUI_Shortcuts", "GRP_CREATION_PATH", "Where to create")
	$_LNG_GUI_SHC[9] = IniRead($_LangPath, "GUI_Shortcuts", "GRP_CREATE_FOR", "Create for")
	$_LNG_GUI_SHC[10] = IniRead($_LangPath, "GUI_Shortcuts", "GRP_PARAMETER", "Parameter:")
	$_LNG_GUI_SHC[11] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_SOURCE_FILE", "Source file:")
	$_LNG_GUI_SHC[12] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_ARGUMENTS", "Arguments:")
	$_LNG_GUI_SHC[13] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_DEST_FOLDER", "Destination folder:")
	$_LNG_GUI_SHC[14] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_DESCRIPTION", "Shortcut description:")
	$_LNG_GUI_SHC[15] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_NAME", "Shortcut name:")
	$_LNG_GUI_SHC[16] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_WORKING_DIR", "Working directory:")
	$_LNG_GUI_SHC[17] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_ICON_FILE", "Icon file:")
	$_LNG_GUI_SHC[18] = IniRead($_LangPath, "GUI_Shortcuts", "LBL_ICON_INDEX", "Icon index:")
;~ 	GUI SETENVIRONMENT
	Global $_LNG_GUI_ENV[4]
	$_LNG_GUI_ENV[1] = IniRead($_LangPath, "GUI_SetEnvironment", "GUI_TITLE", "Create environment variable")
	$_LNG_GUI_ENV[2] = IniRead($_LangPath, "GUI_SetEnvironment", "LBL_NAME", "Name:")
	$_LNG_GUI_ENV[3] = IniRead($_LangPath, "GUI_SetEnvironment", "LBL_VALUE", "Value:")
;~ 	MAKE SFX
	Global $_LNG_MSFX[26]
	$_LNG_MSFX[1] = IniRead($_LangPath, "GUI_MakeSFX", "GUI_TITLE", "Creating SFX...")
	$_LNG_MSFX[2] = IniRead($_LangPath, "GUI_MakeSFX", "BTN_OPEN", "Browse")
	$_LNG_MSFX[3] = IniRead($_LangPath, "GUI_MakeSFX", "BTN_RUN", "Run SFX")
	$_LNG_MSFX[4] = IniRead($_LangPath, "GUI_MakeSFX", "BTN_CLOSE", "Close")
	$_LNG_MSFX[5] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_PREP", "Preparing...")
	$_LNG_MSFX[6] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ARCHIVE1", "Creating archive...")
	$_LNG_MSFX[7] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ARCHIVE2", "7-Zip doesnt exist!")
	$_LNG_MSFX[8] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ARCHIVE3", "File doesn't exist: \~s")
	$_LNG_MSFX[9] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ARCHIVE4", "Archive created successfully")
	$_LNG_MSFX[10] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ARCHIVE5", "Couldn't create archive!")
	$_LNG_MSFX[11] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ERROR1", "Can't find configuration file: \~s")
	$_LNG_MSFX[12] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ERROR2", "The following file isn't 7z SFX configuration file: \~s")
	$_LNG_MSFX[13] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ERROR3", "Error while creating SFX!")
	$_LNG_MSFX[14] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ICON1", "Changing SFX icon...")
	$_LNG_MSFX[15] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ICON2", "SFX icon changed successfully")
	$_LNG_MSFX[16] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_ICON3", "Can't change SFX icon!")
	$_LNG_MSFX[17] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_VERSINFO1", "Updating version info...")
	$_LNG_MSFX[18] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_VERSINFO2", "Version info updated successfully")
	$_LNG_MSFX[19] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_VERSINFO3", "Can't update version info!")
	$_LNG_MSFX[20] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_UPX1", "Compressing with UPX...")
	$_LNG_MSFX[21] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_UPX2", "Compression completed successfully")
	$_LNG_MSFX[22] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_UPX3", "Can't find ""upx.exe""!")
	$_LNG_MSFX[23] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_BUILD1", "Building SFX...")
	$_LNG_MSFX[24] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_BUILD2", "Error while building SFX!")
	$_LNG_MSFX[25] = IniRead($_LangPath, "GUI_MakeSFX", "REPORT_FINISH", "SFX created successfully at: \~s")
;~ 	MSGBOXES
	Global $LANG_MSGBOX1[13]
	$LANG_MSGBOX1[1] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_1", "Unable to find language file!")
	$LANG_MSGBOX1[2] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_2", "Specified file doesn't exist!")
	$LANG_MSGBOX1[3] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_3", "File isn't loaded or doesn't exist!")
	$LANG_MSGBOX1[4] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_4", "Specified configuration file doesn't exist!")
	$LANG_MSGBOX1[5] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_5", "Do you want to open file: \~n\~s - ?")
	$LANG_MSGBOX1[6] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_6", "\~s\nisn't 7z SFX configuration file!\~nDo you want to load it anyway?")
	$LANG_MSGBOX1[7] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_7", "The file size is larger than normal configuration file! Would you like to load it anyway?")
	$LANG_MSGBOX1[8] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_8", "File required for current operation is missing:\n\s")
	$LANG_MSGBOX1[9] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_9", "This file doesn't contain configuration file! Unable to continue!")
	$LANG_MSGBOX1[10] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_10", "Are you sure you want to reload file?")
	$LANG_MSGBOX1[11] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_11", "Current configuration isn't saved. Do you want to save it now?")
	$LANG_MSGBOX1[12] = IniRead($_LangPath, "MessageBoxes", "MSGBOX1_13", "Can't obtain file permissions! Make sure that you have administrator privilegies.")
	Global $LANG_MSGBOX2[10]
	$LANG_MSGBOX2[1] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_1", "Path to the specified SFX file doesn't exist!")
	$LANG_MSGBOX2[2] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_2", "SFX module isn't specified!")
	$LANG_MSGBOX2[3] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_3", "Specified SFX module doesn't exist or doesn't have required format!")
	$LANG_MSGBOX2[4] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_4", "Archive files aren't specified!")
	$LANG_MSGBOX2[5] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_5", "Archive isn't specified!")
	$LANG_MSGBOX2[6] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_6", "Specified archive doesn't exist or doesn't have required format!")
	$LANG_MSGBOX2[7] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_7", "Do you want to overwrite existing file: \~n\~s - ?")
	$LANG_MSGBOX2[8] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_8", "7-Zip doesnt exist!")
	$LANG_MSGBOX2[9] = IniRead($_LangPath, "MessageBoxes", "MSGBOX2_9", "Do you want to use following archive file: \~n\~s - ?\~nClick 'No' if you want to create new archive from files defined in configuration file.")
	Global $LANG_MSGBOX3[10]
	$LANG_MSGBOX3[1] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_1", "Program successfully integrated in the context menu.")
	$LANG_MSGBOX3[2] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_2", "Press 'OK' to close window for testing")
	$LANG_MSGBOX3[3] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_3", "Do you want to overwrite existing values?")
	$LANG_MSGBOX3[4] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_4", "Please, select at least one item.")
	$LANG_MSGBOX3[5] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_5", "Please, select only one item.")
	$LANG_MSGBOX3[6] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_6", "Are you sure you want to delete selected item(s)?")
	$LANG_MSGBOX3[7] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_7", "Are you sure you want to delete all items?")
	$LANG_MSGBOX3[8] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_8", "Specified data is invalid or empty!")
	$LANG_MSGBOX3[9] = IniRead($_LangPath, "MessageBoxes", "MSGBOX3_9", "File isn't specified!")
EndFunc   ;==>_Load_Language

Func _Change_Language()
	GUICtrlSetData($Menu_FILE, $_LNG_MENU[1])
	_GUICtrlODMenuItemSetText($Mi_OPEN, $_LNG_MENU[4])
	_GUICtrlODMenuItemSetText($Mi_RELOAD, $_LNG_MENU[5])
	_GUICtrlODMenuItemSetText($Mi_SAVE, $_LNG_MENU[6])
	_GUICtrlODMenuItemSetText($Mi_SAVEAS, $_LNG_MENU[7])
	_GUICtrlODMenuItemSetText($Mi_CLOSE, $_LNG_MENU[8])
	_GUICtrlODMenuItemSetText($sMenu_RECENT_FILES, $_LNG_MENU[9])
	_GUICtrlODMenuItemSetText($Mi_CLEAR, $_LNG_MENU[10])
	_GUICtrlODMenuItemSetText($Mi_EXIT, $_LNG_MENU[11])
	GUICtrlSetData($Menu_SETS, $_LNG_MENU[2])
	_GUICtrlODMenuItemSetText($Mi_PRESET_MAN2, $_LNG_MENU[17])
	_GUICtrlODMenuItemSetText($Mi_OPTS, $_LNG_MENU[12])
	_GUICtrlODMenuItemSetText($sMenu_LANG, $_LNG_MENU[13])
	GUICtrlSetData($Menu_HELP, $_LNG_MENU[3])
	_GUICtrlODMenuItemSetText($Mi_HELPEN, $_LNG_MENU[14])
	_GUICtrlODMenuItemSetText($Mi_HELPRU, $_LNG_MENU[14])
	_GUICtrlODMenuItemSetText($Mi_PSITE, $_LNG_MENU[15])
	_GUICtrlODMenuItemSetText($Mi_ABOUT, $_LNG_MENU[16])
	_GUICtrlODMenuItemSetText($Mi_PRESET_MAN, $_LNG_MENU[17])
	GUICtrlSetData($Ti_MAIN, $_LNG_TABNAME[1])
	GUICtrlSetData($M_CHK_TEMPMODE, $_LNG_TAB_MAIN[0])
	GUICtrlSetData($M_CHK_SKIPLOCKED, $_LNG_TAB_MAIN[1])
	GUICtrlSetData($M_CHK_SELFDELETE, $_LNG_TAB_MAIN[2])
	GUICtrlSetData($M_CHK_BPT, $_LNG_TAB_MAIN[3])
	GUICtrlSetData($M_CHK_XDWidth, $_LNG_TAB_MAIN[4])
	GUICtrlSetData($M_CHK_XPWidth, $_LNG_TAB_MAIN[5])
	GUICtrlSetData($M_RAD_OMode[1], $_LNG_TAB_MAIN[6])
	GUICtrlSetData($M_RAD_OMode[2], $_LNG_TAB_MAIN[7])
	GUICtrlSetData($M_RAD_OMode[3], $_LNG_TAB_MAIN[8])
	GUICtrlSetData($M_RAD_GMode[1], $_LNG_TAB_MAIN[9])
	GUICtrlSetData($M_RAD_GMode[2], $_LNG_TAB_MAIN[10])
	GUICtrlSetData($M_RAD_GMode[3], $_LNG_TAB_MAIN[11])
	GUICtrlSetData($M_GRP_OW_MODE, $_LNG_TAB_MAIN[12])
	GUICtrlSetData($M_GRP_GUI_MODE, $_LNG_TAB_MAIN[13])
	GUICtrlSetData($M_LBL_EXT_PATH, $_LNG_TAB_MAIN[14])
	GUICtrlSetTip($M_BTN_GUIFLAGS, $_LNG_TAB_MAIN[17])
	GUICtrlSetTip($M_BTN_INSTPATH, $_LNG_TAB_MAIN[18])
	GUICtrlSetTip($BTN_CFG_RELOAD, $_LNG_TAB_MAIN[19])
	GUICtrlSetTip($BTN_CFG_OPEN, $_LNG_TAB_MAIN[20])
	_GUICtrlODMenuItemSetText($Mi_IP[1], '%%T (' & $_LNG_TAB_MAIN[15] & ')')
	_GUICtrlODMenuItemSetText($Mi_IP[2], '%%S (' & $_LNG_TAB_MAIN[16] & ')')
	GUICtrlSetData($Ti_TITLETEXT, $_LNG_TABNAME[2])
	GUICtrlSetData($T_GRP_TITLE, $_LNG_TAB_TT[1])
	GUICtrlSetData($T_GRP_TEXT, $_LNG_TAB_TT[2])
	GUICtrlSetData($T_LBL_TITLE, $_LNG_TAB_TT[3])
	GUICtrlSetData($T_LBL_EXT_PATH_TITLE, $_LNG_TAB_TT[4])
	GUICtrlSetData($T_LBL_EXT_TITLE, $_LNG_TAB_TT[5])
	GUICtrlSetData($T_LBL_ERR_TITLE, $_LNG_TAB_TT[6])
	GUICtrlSetData($T_LBL_WARN_TITLE, $_LNG_TAB_TT[7])
	GUICtrlSetData($T_LBL_PSWD_TITLE, $_LNG_TAB_TT[8])
	GUICtrlSetData($T_LBL_PSWD_TEXT, $_LNG_TAB_TT[9])
	GUICtrlSetData($T_LBL_CANCEL_TEXT, $_LNG_TAB_TT[10])
	GUICtrlSetData($Ti_MESSAGES, $_LNG_TABNAME[3])
	GUICtrlSetData($MS_BTN_TEST, $_LNG_GLOBAL[14])
	GUICtrlSetData($Ti_RUNPROGRAM, $_LNG_TABNAME[4])
	GUICtrlSetData($Ti_DELETE, $_LNG_TABNAME[5])
	GUICtrlSetData($Ti_SHORTCUTS, $_LNG_TABNAME[6])
	GUICtrlSetData($Ti_SETENVIRONMENT, $_LNG_TABNAME[7])
	GUICtrlSetData($R_LIST, $_LNG_TAB_RUN[1])
	GUICtrlSetData($D_LIST, $_LNG_TAB_DEL[1])
	GUICtrlSetData($SH_LIST, $_LNG_TAB_SHC[1])
	GUICtrlSetData($E_LIST, $_LNG_TAB_ENV[1])
	GUICtrlSetTip($R_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($R_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($R_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($R_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($R_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($R_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	GUICtrlSetTip($D_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($D_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($D_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($D_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($D_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($D_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	GUICtrlSetTip($SH_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($SH_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($SH_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($SH_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($SH_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($SH_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	GUICtrlSetTip($E_BTN_ADD, $_LNG_GLOBAL[1])
	GUICtrlSetTip($E_BTN_EDIT, $_LNG_GLOBAL[2])
	GUICtrlSetTip($E_BTN_DELETE, $_LNG_GLOBAL[3])
	GUICtrlSetTip($E_BTN_DELETEALL, $_LNG_GLOBAL[4])
	GUICtrlSetTip($E_BTN_MOVEUP, $_LNG_GLOBAL[15])
	GUICtrlSetTip($E_BTN_MOVEDOWN, $_LNG_GLOBAL[16])
	GUICtrlSetData($Ti_OUTPUT, $_LNG_TABNAME[8])
	GUICtrlSetData($Ti_SFX, $_LNG_TABNAME[9])
	GUICtrlSetData($S_BTN_MAKESFX, $_LNG_TAB_SFX[2])
	GUICtrlSetData($S_BTN_SFX_OPTS, $_LNG_TAB_SFX[3])
	GUICtrlSetData($S_BTN_RESEDIT, $_LNG_TAB_SFX[4])
	GUICtrlSetData($S_CHK_EXTCFG, $_LNG_TAB_SFX[13])
	GUICtrlSetData($S_CHK_ARCHIVE, $_LNG_TAB_SFX[5])
	GUICtrlSetData($S_CHK_SFXMOD, $_LNG_TAB_SFX[5])
	GUICtrlSetData($S_CHK_SFXPATH, $_LNG_TAB_SFX[5])
	GUICtrlSetData($S_CHK_SFXICON, $_LNG_TAB_SFX[5])
	GUICtrlSetData($S_GRP_SFX_FILES, $_LNG_TAB_SFX[6])
	GUICtrlSetData($S_LBL_CONFIG, $_LNG_TAB_SFX[8])
	GUICtrlSetData($S_LBL_ARCHIVE, $_LNG_TAB_SFX[9])
	GUICtrlSetData($S_LBL_SFXMOD, $_LNG_TAB_SFX[10])
	GUICtrlSetData($S_LBL_SFXPATH, $_LNG_TAB_SFX[11])
	GUICtrlSetData($S_LBL_SFXICON, $_LNG_TAB_SFX[12])
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
EndFunc   ;==>_Change_Language
