@echo off
rem Run m4 to generate the parser
m4 parser.m4 > parser.txt

rem Display the generated parser
type parser.txt