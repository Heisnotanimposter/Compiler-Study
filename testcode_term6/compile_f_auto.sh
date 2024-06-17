#!/bin/bash
echo "Compiling Finite Automata Definitions..."
m4 finite_automata.m4 > finite_automata.txt
cat finite_automata.txt
