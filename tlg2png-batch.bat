@echo off
setlocal enabledelayedexpansion

set tool=%~dp0tlg2png.exe
set input_folder=%~1
set output_folder=%~2


if "%tool%"=="" (
	echo tlg2png.exe tidak ada di direktori sekarang!
)

if "%~dp0libpng3.dll"=="" (
	echo Dependensi tlg2png "(libpng3.dll)" tidak ada di direktori sekarang!
)

if "%~dp0zlib1.dll"=="" (
	echo Dependensi tlg2png "(zlib1.dll)" tidak ada di direktori sekarang!
)

if "%~dp0%input_folder%"=="" (
	echo Penggunaan: tlg2png-batch input_folder output_folder
	echo Jalur direktori relatif dengan direktori sekarang.
	exit /b
)

if "%~dp0%output_folder%"=="" (
	echo Penggunaan: tlg2png-batch input_folder output_folder
	echo Jalur direktori relatif dengan direktori sekarang.
	exit /b
)

mkdir "%~dp0%output_folder%"

for %%F in ("%~dp0%input_folder%\*.*") do (
	set input=%%~nxF
	set output=%~dp0!output_folder!\%%~nF.png

	"%tool%" "%~dp0!input_folder!\!input!" "!output!"

	echo Processing: %~dp0!input_folder!\!input!
	echo Output: !output!
)

endlocal
