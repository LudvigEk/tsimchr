# Microsoft Developer Studio Project File - Name="tsimchr" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=tsimchr - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "tsimchr.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "tsimchr.mak" CFG="tsimchr - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "tsimchr - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "tsimchr - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "tsimchr - Win32 Release"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /YX /FD /c
# ADD BASE RSC /l 0x41d /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x41d /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "tsimchr - Win32 Debug"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "../" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /YX /FD /GZ /c
# ADD BASE RSC /l 0x41d /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x41d /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "tsimchr - Win32 Release"
# Name "tsimchr - Win32 Debug"
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Group "format"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\format\IFormat.h
# End Source File
# Begin Source File

SOURCE=..\format\lingo.cpp
# End Source File
# Begin Source File

SOURCE=..\format\lingo.h
# End Source File
# Begin Source File

SOURCE=..\format\Parser.cpp
# End Source File
# Begin Source File

SOURCE=..\format\Parser.h
# End Source File
# Begin Source File

SOURCE=..\format\stx.cpp
# End Source File
# Begin Source File

SOURCE=..\format\stx.h
# End Source File
# Begin Source File

SOURCE=..\format\StxParser.cpp
# End Source File
# Begin Source File

SOURCE=..\format\StxParser.h
# End Source File
# Begin Source File

SOURCE=..\format\StxTllComposer.cpp
# End Source File
# Begin Source File

SOURCE=..\format\StxTllComposer.h
# End Source File
# Begin Source File

SOURCE=..\format\StxTllParser.cpp
# End Source File
# Begin Source File

SOURCE=..\format\StxTllParser.h
# End Source File
# Begin Source File

SOURCE=..\format\tll.cpp
# End Source File
# Begin Source File

SOURCE=..\format\tll.h
# End Source File
# Begin Source File

SOURCE=..\format\treecomposer.cpp
# End Source File
# Begin Source File

SOURCE=..\format\treecomposer.h
# End Source File
# Begin Source File

SOURCE=..\format\treeparser.cpp
# End Source File
# Begin Source File

SOURCE=..\format\treeparser.h
# End Source File
# End Group
# Begin Group "types"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\types\claimable.h
# End Source File
# Begin Source File

SOURCE=..\types\identtable.cpp
# End Source File
# Begin Source File

SOURCE=..\types\identtable.h
# End Source File
# Begin Source File

SOURCE=..\types\IPropertyList.cpp
# End Source File
# Begin Source File

SOURCE=..\types\IPropertyList.h
# End Source File
# Begin Source File

SOURCE=..\types\map.cpp
# End Source File
# Begin Source File

SOURCE=..\types\map.h
# End Source File
# Begin Source File

SOURCE=..\types\ref.h
# End Source File
# Begin Source File

SOURCE=..\types\singlelist.h
# End Source File
# Begin Source File

SOURCE=..\types\stringfun.cpp
# End Source File
# Begin Source File

SOURCE=..\types\stringfun.h
# End Source File
# Begin Source File

SOURCE=..\types\stringref.h
# End Source File
# Begin Source File

SOURCE=..\types\taggedlist.cpp
# End Source File
# Begin Source File

SOURCE=..\types\taggedlist.h
# End Source File
# Begin Source File

SOURCE=..\types\taggedtree.cpp
# End Source File
# Begin Source File

SOURCE=..\types\taggedtree.h
# End Source File
# Begin Source File

SOURCE=..\types\text.cpp
# End Source File
# Begin Source File

SOURCE=..\types\text.h
# End Source File
# Begin Source File

SOURCE=..\types\unsignedset.cpp
# End Source File
# Begin Source File

SOURCE=..\types\unsignedset.h
# End Source File
# Begin Source File

SOURCE=..\types\vector.cpp
# End Source File
# Begin Source File

SOURCE=..\types\vector.h
# End Source File
# End Group
# Begin Group "system"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\system\ChildProcess.cpp
# End Source File
# Begin Source File

SOURCE=..\system\ChildProcess.h
# End Source File
# Begin Source File

SOURCE=..\system\consoleapp.cpp
# End Source File
# Begin Source File

SOURCE=..\system\consoleapp.h
# End Source File
# Begin Source File

SOURCE=..\system\debug.h
# End Source File
# Begin Source File

SOURCE=..\system\environment.cpp
# End Source File
# Begin Source File

SOURCE=..\system\environment.h
# End Source File
# Begin Source File

SOURCE=..\system\filefilter.cpp
# End Source File
# Begin Source File

SOURCE=..\system\filefilter.h
# End Source File
# Begin Source File

SOURCE=..\system\filesystem.cpp
# End Source File
# Begin Source File

SOURCE=..\system\filesystem.h
# End Source File
# Begin Source File

SOURCE=..\system\registry.cpp
# End Source File
# Begin Source File

SOURCE=..\system\registry.h
# End Source File
# Begin Source File

SOURCE=..\system\stderr.cpp
# End Source File
# Begin Source File

SOURCE=..\system\stderr.h
# End Source File
# Begin Source File

SOURCE=..\system\stdout.cpp
# End Source File
# Begin Source File

SOURCE=..\system\stdout.h
# End Source File
# Begin Source File

SOURCE=..\system\TextOutput.h
# End Source File
# Begin Source File

SOURCE=..\system\TimeHelpers.h
# End Source File
# End Group
# Begin Group "app"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\tsimchr.cpp
# End Source File
# Begin Source File

SOURCE=.\tsimchr.rc
# End Source File
# End Group
# Begin Group "table"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\table\tablefun.cpp
# End Source File
# Begin Source File

SOURCE=..\table\tablefun.h
# End Source File
# Begin Source File

SOURCE=..\table\tableindex.cpp
# End Source File
# Begin Source File

SOURCE=..\table\tableindex.h
# End Source File
# End Group
# Begin Group "math"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\math\rand.cpp
# End Source File
# Begin Source File

SOURCE=..\math\rand.h
# End Source File
# End Group
# End Target
# End Project
