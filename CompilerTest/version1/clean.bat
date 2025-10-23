@echo off
REM Clean script for SimpleLang Compiler (Windows)
REM Removes all generated files

echo Cleaning generated files...

if exist SimpleLanglex.c del SimpleLanglex.c
if exist SimpleLang.tab.c del SimpleLang.tab.c
if exist SimpleLang.tab.h del SimpleLang.tab.h
if exist SimpleLangCompiler.exe del SimpleLangCompiler.exe
if exist *.o del *.o

echo Clean complete!

