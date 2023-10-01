# Array-and-Indexing-Python-Parser using Flex and Bison

### lexer - is a flex code file 
Lexers attach meaning by classifying lexemes (strings of symbols from the input) as the particular tokens. E.g. All these lexemes: *, ==, <=, ^ will be classified as "operator" token by the C/C++ lexer.

### lex.yy.c - is generated by flex code

### parser - is a bison code file
Parsers attach meaning by classifying strings of tokens from the input (sentences) as the particular nonterminals and building the parse tree. E.g. all these token strings: [number][operator][number], [id][operator][id], [id][operator][number][operator][number] will be classified as "expression" nonterminal by the C/C++ parser.

### parser.tab.c & parser.tab.h - are files generated by parser 

### a.exe
is executable file where we can check the Array and Indexing in python syntax

## How to execute the code and generate files:

1) Open CMD (inside the folder where we have created "lexer" and "parser" files
   On CMD:
  2) flex lexer.l
  3) bison -d "parser.y" 
  4) gcc lex.yy.c parser.tab.c -o parser
  5) a.exe

      




