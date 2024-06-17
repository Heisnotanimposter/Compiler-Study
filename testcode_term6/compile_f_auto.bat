@echo off
echo Compiling Finite Automata Definitions...
m4 finite_automata.m4 > finite_automata.txt
type finite_automata.txt
pause