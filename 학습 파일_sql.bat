@echo off
setlocal enabledelayedexpansion

:: 기준 월: 25년 06월
set BASE=2506
set PREFIX=25.06

:: 폴더 생성
if not exist "%BASE%" (
    mkdir "%BASE%"
)

:: 날짜 반복 (1~31)
for /L %%D in (1,1,31) do (
    set "DAY=0%%D"
    set "DAY=!DAY:~-2!"

    set "FILENAME=%PREFIX%.!DAY!.sql"
    break> "%BASE%\!FILENAME!"
)

endlocal