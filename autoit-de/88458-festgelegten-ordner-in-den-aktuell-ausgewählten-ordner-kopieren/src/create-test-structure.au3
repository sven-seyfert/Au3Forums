#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

_Main()

Func _Main()
    _CreateTestFolderAndFileStructure()
EndFunc

Func _CreateTestFolderAndFileStructure()
    Local Const $sRootFolder = 'C:\tmp\'
    Local Const $aList[] = _
        [ _
            'source-folder\Info\#Im\file1.txt', _
            'source-folder\Info\#Im\file2.png', _
            'source-folder\Info\#Im\file3.mp3', _
            'source-folder\Info\#Im\subfolder1\fileA.txt', _
            'source-folder\Info\#Im\subfolder1\fileB.jpg', _
            'source-folder\Info\#Im\subfolder1\fileC.wav', _
            'source-folder\Info\#Im\subfolder1\subfolder2\fileD.xlsx', _
            'source-folder\Info\#Im\subfolder1\subfolder2\fileE.bmp', _
            'source-folder\Info\#Im\subfolder1\subfolder2\fileF.pdf', _
            'target-folder\#Im\file1.txt', _
            'target-folder\#Im\subfolder1\fileA.txt', _
            'target-folder\#Im\subfolder1\subfolder2\fileD.xlsx', _
            'target-folder\AAA.png', _
            'target-folder\subfolder1\BBB.jpg', _
            'target-folder\subfolder1\subfolder2\CCC.bmp' _
        ]

    For $sFile In $aList
        _CreateFile($sRootFolder & $sFile, 'dummy content')
        If @error Then
            ConsoleWrite(StringFormat( _
                'Oops! Handle this unexpected behavior for file "%s"\n', $sFile))
        EndIf
    Next
EndFunc

Func _CreateFile($sFile, $sText)
    Local Const $iUtf8WithoutBomWriteCreateMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomWriteCreateMode)
    If $hFile == -1 Then
        Return SetError(1)
    EndIf

    If FileWrite($hFile, $sText) == 0 Then
        Return SetError(1)
    EndIf

    FileClose($hFile)
EndFunc
