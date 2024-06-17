@echo off
:: Run the M4 file
m4 compiler.m4 > output.txt
:: Display the output
type output.txt
pause