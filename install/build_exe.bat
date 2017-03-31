REM delete old build files
rmdir /s /q build
rmdir /s /q dist

REM build porcupine.exe.exe
pyinstaller install\pyinstaller.spec -y

REM sign porcupine.exe
signtool.exe sign /v /d "Porcupine" /a /tr http://timestamp.globalsign.com/scripts/timstamp.dll /fd sha256 dist\porcupine\porcupine.exe

REM build an installer, dist\Porcupine_Setup.exe
makensis.exe install\porcupine.nsi

REM sign Porcupine_Setup.exe
signtool.exe sign /v /d "Porcupine" /a /tr http://timestamp.globalsign.com/scripts/timstamp.dll /fd sha256 dist\Porcupine_Setup.exe
