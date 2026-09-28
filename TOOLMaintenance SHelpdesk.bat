@echo off
title PROFESSIONAL MAINTENANCE TOOLKIT v1.0
color 0A
mode con: cols=80 lines=32

:: ============================================
:: Administrator Check
:: ============================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo  ============================================
    echo        PLEASE RUN THIS TOOL AS ADMINISTRATOR
    echo  ============================================
    echo.
    pause
    exit
)

:MENU
cls
echo  ============================================
echo          PROFESSIONAL MAINTENANCE TOOLKIT
echo  ============================================
echo.
echo   1. Clean Temporary Files
echo   2. Empty Recycle Bin
echo   3. Flush DNS Cache
echo   4. Reset Network Settings
echo   5. Enable High Performance Mode
echo   6. Disk Cleanup
echo   7. Check System Files (SFC)
echo   8. Repair Windows Image (DISM)
echo   9. System Information
echo  10. Optimize All
echo.
echo   0. Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto CLEANTEMP
if "%choice%"=="2" goto EMPTYBIN
if "%choice%"=="3" goto FLUSHDNS
if "%choice%"=="4" goto RESETNET
if "%choice%"=="5" goto HIGHPERF
if "%choice%"=="6" goto DISKCLEAN
if "%choice%"=="7" goto SFC
if "%choice%"=="8" goto DISM
if "%choice%"=="9" goto SYSINFO
if "%choice%"=="10" goto OPTIMIZEALL
if "%choice%"=="0" goto END
echo Pilihan tidak valid, coba lagi.
pause
goto MENU

:CLEANTEMP
cls
echo Membersihkan temporary files...
del /q /f /s "%temp%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
echo Selesai.
pause
goto MENU

:EMPTYBIN
cls
echo Mengosongkan Recycle Bin...
powershell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo Selesai.
pause
goto MENU

:FLUSHDNS
cls
echo Flushing DNS Cache...
ipconfig /flushdns
pause
goto MENU

:RESETNET
cls
echo Resetting network settings (Winsock & TCP/IP)...
netsh winsock reset
netsh int ip reset
echo.
echo Selesai. Disarankan restart komputer.
pause
goto MENU

:HIGHPERF
cls
echo Mengaktifkan High Performance Power Plan...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Selesai.
pause
goto MENU

:DISKCLEAN
cls
echo Menjalankan Disk Cleanup...
cleanmgr /d C:
pause
goto MENU

:SFC
cls
echo Menjalankan System File Checker (SFC)...
echo Proses ini bisa memakan waktu beberapa menit...
sfc /scannow
pause
goto MENU

:DISM
cls
echo Memperbaiki Windows Image (DISM)...
echo Proses ini butuh koneksi internet dan bisa cukup lama...
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto MENU

:SYSINFO
cls
systeminfo
pause
goto MENU

:OPTIMIZEALL
cls
echo Menjalankan semua proses optimasi secara otomatis...
echo.
echo [1/6] Membersihkan temporary files...
del /q /f /s "%temp%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1

echo [2/6] Mengosongkan Recycle Bin...
powershell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"

echo [3/6] Flushing DNS...
ipconfig /flushdns >nul

echo [4/6] Mengaktifkan High Performance Mode...
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

echo [5/6] Menjalankan SFC Scan (mohon tunggu)...
sfc /scannow

echo [6/6] Menjalankan Disk Cleanup...
cleanmgr /d C:

echo.
echo Semua proses optimasi selesai!
pause
goto MENU

:END
cls
echo Terima kasih telah menggunakan Professional Maintenance Toolkit.
timeout /t 2 >nul
exit