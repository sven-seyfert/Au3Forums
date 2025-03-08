#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Outfile_x64=my-robocopy-action.exe

HotKeySet('^!g', '_Copy')
HotKeySet('{ESC}', '_Exit')

While True
    Sleep(100)
WEnd

Func _Exit()
    Exit
EndFunc

Func _Copy()
    Local Const $iErrorIcon      = 16
    Local Const $iInfoIcon       = 64
    Local Const $iArrayMatchFlag = 1

    Local Const $sSourceFolder = 'C:\tmp\source-folder\Info\#Im'
    Local Const $aFolderMatch  = StringRegExp($sSourceFolder, '([^\\]+)$', $iArrayMatchFlag)
    If @error Or Not IsArray($aFolderMatch) Then
        MsgBox($iErrorIcon, 'Error', 'Oops! Check source folder path and RegEx pattern.')
        _Exit()
    EndIf

    Local Const $sFolder = $aFolderMatch[0]

    ; Assumption: You have opened your target folder
    ; via Windows Explorer.
    Local $sTargetFolder = _GetWindowsExplorerFolderPath()
    If @error Then
        MsgBox($iErrorIcon, 'Error', 'Error code: ' & @error)
        _Exit()
    EndIf
    If $sTargetFolder == '' Or StringRegExp($sTargetFolder, '[a-z|A-Z]:\\') == 0 Then
        MsgBox($iErrorIcon, 'Error', 'Oops! Unexpected target folder path structure.')
        _Exit()
    EndIf

    ; Robocopy copies without overwriting
    Run(StringFormat('robocopy "%s" "%s" /E /XO', $sSourceFolder, $sTargetFolder & '\' & $sFolder), '', @SW_HIDE)
    If @error Then
        MsgBox($iErrorIcon, 'Error', 'Oops! Robocopy Run() was not okay.')
        _Exit()
    EndIf

    Local Const $iTimeout = 30
    MsgBox($iInfoIcon, 'Done', 'Copy action completed.', $iTimeout)
EndFunc

Func _GetWindowsExplorerFolderPath()
    Local Const $oShell = ObjCreate('Shell.Application')
    If @error Then
        Return SetError(1)
    EndIf

    Local Const $hActiveWindows = WinGetHandle('[ACTIVE]')
    If @error Then
        Return SetError(2)
    EndIf

    For $oWindow In $oShell.Windows
        If $oWindow.HWND <> $hActiveWindows Then
            ContinueLoop
        EndIf

        Return $oWindow.document.Folder.Self.Path
    Next

    Return SetError(3)
EndFunc
