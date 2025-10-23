@echo off
REM Build script for SimpleLang Compiler (Windows)
REM This script automates the compilation process

echo ========================================
echo SimpleLang Compiler - Build Script
echo ========================================
echo.

REM Check if flex and bison executables exist
if not exist "..\Application\win_flex.exe" (
    echo ERROR: win_flex.exe not found in Application directory
    echo Please ensure Flex and Bison are properly installed
    pause
    exit /b 1
)

if not exist "..\Application\win_bison.exe" (
    echo ERROR: win_bison.exe not found in Application directory
    pause
    exit /b 1
)

REM Step 1: Generate Lexer
echo [1/3] Generating lexer from SimpleLang.l...
..\Application\win_flex --wincompat -o SimpleLanglex.c SimpleLang.l
if errorlevel 1 (
    echo ERROR: Lexer generation failed
    pause
    exit /b 1
)
echo Lexer generated successfully!
echo.

REM Step 2: Generate Parser
echo [2/3] Generating parser from SimpleLang.y...
..\Application\win_bison -d -o SimpleLang.tab.c SimpleLang.y
if errorlevel 1 (
    echo ERROR: Parser generation failed
    pause
    exit /b 1
)
echo Parser generated successfully!
echo.

REM Step 3: Compile everything
echo [3/3] Compiling SimpleLangCompiler...
gcc -o SimpleLangCompiler.exe SimpleLang.tab.c SimpleLanglex.c SimpleLang.c
if errorlevel 1 (
    echo ERROR: Compilation failed
    echo Make sure GCC is installed and in your PATH
    pause
    exit /b 1
)
echo Compilation successful!
echo.

echo ========================================
echo Build Complete!
echo ========================================
echo.
echo To run the compiler:
echo   SimpleLangCompiler.exe ^< sample.sl
echo.
pause

