# Compiler Design Project using Flex and Bison

## Overview
This project implements a simple compiler using **Flex** (Fast Lexical Analyzer) and **Bison** (GNU Parser Generator). The compiler processes a high-level programming language with basic constructs such as variable declarations, arithmetic operations, conditional statements, loops, and print statements.

### Key Features
- **Lexical Analysis**: Tokenizes keywords, identifiers, numeric values, and operators.
- **Syntax Parsing**: Validates and processes the syntax of the input code.
- **Semantic Actions**: Executes actions like variable declaration, assignment, arithmetic calculations, and control flow handling.
- **Symbol Table**: Maintains information about variables, their types, and values.
- **Output**: Generates a trace of the operations in an output file.

---

## Project Structure
### Files
- **lexer.l**: Lexical analyzer definition written in Flex.
- **parser.y**: Syntax and grammar rules written in Bison.
- **variables.c**: Implementation of the symbol table and helper functions.
- **variables.h**: Header file for symbol table definitions.
- **input.txt**: Sample input file containing code to be compiled.
- **output.txt**: File to capture the compiler’s output.

---

## Prerequisites
- **Flex**: Install using `sudo apt install flex` or equivalent.
- **Bison**: Install using `sudo apt install bison` or equivalent.
- **GCC**: Ensure a C compiler is available for building the project.

---

## How to Build
1. **Generate the Lexer**:
   ```bash
   flex lexer.l
   ```
   This generates the `lex.yy.c` file.

2. **Generate the Parser**:
   ```bash
   bison -d parser.y
   ```
   This generates `parser.tab.c` and `parser.tab.h`.

3. **Compile the Files**:
   ```bash
   gcc lex.yy.c parser.tab.c variables.c
   ```
   This creates the executable `a.exe`.

---

## How to Run
1. Prepare the input file `input.txt` with code written in the supported syntax.
2. Run the compiler:
   ```bash
   a.exe
   ```
3. View the output in `output.txt`.

---

## Language Syntax
### Data Types
- `int`: Integer values
- `float`: Floating-point values

### Statements
- **Variable Declaration**:
  ```
  int x = 10;
  float y = 20.5;
  ```
- **Assignment**:
  ```
  x = 5;
  y = x + 2.5;
  ```
- **Print Statement**:
  ```
  print(x);
  print(25.5);
  ```

### Control Flow
- **If-Else**:
  ```
  if (x > 10) {
      print(x);
  } elif (x == 10) {
      print(10);
  } else {
      print(0);
  }
  ```
- **While Loop**:
  ```
  while (x < 10) {
      x = x + 1;
  }
  ```
- **For Loop**:
  ```
  for (x = 0; x < 10; x = x + 1) {
      print(x);
  }
  ```

---



## Contributions
- **Lexer and Parser**: Handles tokenization and parsing.
- **Symbol Table**: Manages variables and their values.
- **Execution Engine**: Interprets input and generates outputs.

---

## Acknowledgements
- **Flex and Bison Documentation**: Essential guides for building the lexer and parser.
- **GNU Compiler Collection (GCC)**: For compiling the generated code.

---

## Future Improvements
- Add support for functions and procedures.
- Implement error recovery for syntax errors.
- Extend language features (e.g., arrays, strings).

---

## License
This project is open-source and available under the MIT License.

---

## Contact
Feel free to reach out for any questions or discussions:

- Email: ma5740@fayoum.edu.eg
- LinkedIn: https://www.linkedin.com/in/mahmoud-ahmed-3291b7229/
