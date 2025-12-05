@echo off
setlocal enabledelayedexpansion
set BatPath=%~dp0
set /P str=<napcat_path.txt
:napcat_path
if exist "%str%\napcat.bat" (
	cd %str%
	wmic process where "name='cmd.exe' and commandline like '%%napcat.bat%%'" get processid 2>nul | findstr /r "[0-9]" > nul
	if ERRORLEVEL 1 (
		echo 检测到napcat.bat未运行，请在弹出的窗口登录napcat
		start napcat.bat
		echo 等待napcat登录。。。
		timeout /t 10 >nul
	)
	cd %BatPath%
	python autowater.py
) else (
	set /p str=请输入napcat.bat所在目录的路径，如C:\Users\wyd123\NapCat.Shell.Windows.OneKey\NapCat.41785.Shell：
	echo %str% > napcat_path.txt
	goto napcat_path
)
pause