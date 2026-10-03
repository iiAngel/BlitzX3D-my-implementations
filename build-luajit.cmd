@echo off
setlocal
set LUAJIT_SRC=%~dp0vendor\LuaJIT\src
set LUAJIT_FLAGS=static
if /I "%~1"=="debug" set LUAJIT_FLAGS=debug static

if not defined INCLUDE (
    if defined VCINSTALLDIR (
        call "%VCINSTALLDIR%Auxiliary\Build\vcvarsall.bat" x86 >nul
    ) else (
        echo [build-luajit] INCLUDE is not defined and VCINSTALLDIR is unknown.
        exit /b 1
    )
)

pushd "%LUAJIT_SRC%"

if exist lua51.lib (
    popd
    exit /b 0
)

call msvcbuild.bat %LUAJIT_FLAGS%
set LUAJIT_RESULT=%errorlevel%
popd

exit /b %LUAJIT_RESULT%
