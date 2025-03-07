#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

HotKeySet('^!g', '_Copy')
HotKeySet('{ESC}', '_Exit')

While True
    Sleep(100)
WEnd

Func _Exit()
    Exit
EndFunc

Func _Copy()
    Local Const $sSourceFolder = 'C:\tmp\source-folder\Info\#Im'
    Local Const $aFolderMatch = StringRegExp($sSourceFolder, "([^\\]+)$", 1)
    If @error Or Not IsArray($aFolderMatch) Then
        ConsoleWrite('Oops! Handle this unexpected behavior.' & @CRLF)
        Return
    EndIf

    ; Assumption: You clicked ones the target folder
    ; by mouse (on Windows Explorer).
    Send('^{c}')

    Local $sTargetFolder = ClipGet()
    If $sTargetFolder == '' Or StringRegExp($sTargetFolder, '[a-z|A-Z]:\\') == 0 Then
        ConsoleWrite('Oops! Handle this unexpected behavior.' & @CRLF)
        Return
    EndIf

    Local Const $sFolder = $aFolderMatch[0]

    $sTargetFolder = $sTargetFolder & '\' & $sFolder

    ConsoleWrite('Source: ' & $sSourceFolder & @CRLF)
    ConsoleWrite('Target: ' & $sTargetFolder & @CRLF)

    Run(StringFormat('robocopy "%s" "%s" /E /XO', $sSourceFolder, $sTargetFolder), '', @SW_HIDE)
    ConsoleWrite('Done!' & @CRLF)
EndFunc
