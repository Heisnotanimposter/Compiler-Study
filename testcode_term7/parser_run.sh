#!/bin/sh

# Run m4 to generate the parser
m4 parser.m4 > parser.txt

# Display the generated parser
cat parser.txt
