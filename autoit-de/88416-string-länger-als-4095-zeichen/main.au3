#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

#include-once
#include <Array.au3>

_Main()

Func _Main()
    Local Const $iLineCharacters = 150
    Local Const $vImage = _BinaryToBase64('C:\Store\Media\Images\icon-appium.png')
    Local Const $aImage = _SplitStringByCountToArray($vImage, $iLineCharacters)

    _ArrayDisplay($aImage)

    ClipPut(_GenerateMultilineString($aImage))
EndFunc

Func _BinaryToBase64($sFilePath)
    Local Const $iBinaryMode = 16

    Local $hFile        = FileOpen($sFilePath, $iBinaryMode)
    Local $vFileContent = FileRead($hFile)
    FileClose($hFile)

    Local $oXml           = ObjCreate('MSXML2.DOMDocument')
    Local $oNode          = $oXml.createElement('b64')
    $oNode.dataType       = 'bin.base64'
    $oNode.nodeTypedValue = $vFileContent

    Return StringReplace($oNode.Text, @LF, '')
EndFunc

Func _SplitStringByCountToArray($sString, $iCount = 80)
    Local $iParts = Ceiling(StringLen($sString) / $iCount)
    Local $aContent[$iParts + 1], $x = 1

    For $i = 1 To $iParts Step 1
        $aContent[$i] = StringMid($sString, $x, $iCount)
        $x += $iCount
    Next

    $aContent[0] = $iParts

    Return $aContent
EndFunc

Func _GenerateMultilineString($aArray)
    Local $sResult

    For $i = 1 To $aArray[0]
        $sResult &= StringFormat("'%s' & _\n", $aArray[$i])
    Next

    Local Const $iEndCharactersToRemove = 6

    Return StringTrimRight(StringFormat('Global $sMultilineString = _\n%s', $sResult), $iEndCharactersToRemove)
EndFunc
