EnableExplicit

; https://www.purebasic.fr/english/viewtopic.php?f=4&t=67329&p=573061&hilit=GetStdHandle#p573061
Import ""
  GetStdHandle.i(nStdHandle.l)
  WriteFile.i(hConsoleOutput.l, lpBuffer.p-Ascii, nNumberOfCharsToWrite.l, *lpNumberOfCharsWritten, *lpReserved)
EndImport

Import "takecmd.lib"
  QueryIsFile_(*lpszString) As "?QueryIsFile@@YAHPEB_W@Z"
  ; QueryIsTCMD_() As "?QueryIsTCMD@@YAHXZ"
EndImport

Structure PLUGININFO_STRUCT
  *pszDll
	*pszAuthor
	*pszEmail
	*pszWWW
	*pszDescription
	*pszFunctions	
	nMajor.l
	nMinor.l
	nBuild.l
	hModule.i
	*pszModule
EndStructure

ProcedureDLL.i InitializePlugin()
  ProcedureReturn #Null  
EndProcedure

ProcedureDLL.i ShutdownPlugin(bEndProcess.b)
  ProcedureReturn #Null  
EndProcedure

ProcedureDLL.i GetPluginInfo()
  Static pi.PLUGININFO_STRUCT
  Static DLLname.s
  Static DLLauth.s
  Static DLLmail.s
  Static DLLwww.s
  Static DLLdesc.s
  Static DLLfuns.s
  
  DLLname = "PBPlugin"
  DLLauth = "Joe Caverly"
  DLLmail = "jlcaverlyca@yahoo.ca"
  DLLwww  = "https://github.com/joec4281/PureBasicTCCPlugin"
  DLLdesc = "TCC Plugin Template written using Purebasic"
  DLLfuns = "Dummy,@Reverse,@PlusOne,_hello"
  
  pi\pszDll         = @DLLname
  pi\pszAuthor      = @DLLauth
  pi\pszEmail       = @DLLmail
  pi\pszWWW         = @DLLwww
  pi\pszDescription = @DLLdesc
  pi\pszFunctions	= @DLLfuns
  pi\nMajor.l       = 2021
  pi\nMinor.l       = 10
  pi\nBuild.l       = 11

  ProcedureReturn @pi
EndProcedure

Procedure.i WriteConsoleN(String$)
  Protected Written.l
  String$ + #CRLF$
  WriteFile(GetStdHandle(#STD_OUTPUT_HANDLE), String$, Len(String$), @Written, #Null)
  ProcedureReturn Written
EndProcedure

; Command
ProcedureDLL.i Dummy(*lpszString)
  Static theString.s
  Static theValue.i
  Static result.l
  Static ws.l
  
  theString = PeekS(*lpszString)
  
  If Len(theString) < 1
    WriteConsoleN("USAGE: Dummy <text>")
  Else
    theString = LTrim(RTrim(theString))
    WriteConsoleN(theString)
  EndIf
  
  ProcedureReturn #Null
EndProcedure

; Function
ProcedureDLL.i f_Reverse(*lpszString)
  Static theString.s
  Static theValue.i
  
  theString = PeekS(*lpszString)
  theString = ReverseString(theString)
  
  PokeS(*lpszString,theString)
  
  ProcedureReturn #Null
EndProcedure

; Function
ProcedureDLL.i f_PlusOne(*lpszString)
  Static theString.s
  Static theValue.i
  
  theString = PeekS(*lpszString)
  
  theValue = Val(theString)
  theValue = theValue + 1
  
  theString = Str(theValue)
  
  PokeS(*lpszString,theString)
  
  ProcedureReturn #Null
EndProcedure

; Internal Variable
ProcedureDLL.i _hello(*lpszString)
  PokeS(*lpszString,"Hello!")
  
  ProcedureReturn #Null
EndProcedure

; IDE Options = PureBasic 6.10 LTS (Windows - x64)
; ExecutableFormat = Shared dll
; CursorPosition = 66
; FirstLine = 36
; Folding = --
; EnableXP
; Executable = PBPlugin.dll