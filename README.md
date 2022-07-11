# reverse-polish-notation
The Reverse Polish Notation is a notation that expresses mathematical expressions without the use of parenthesis. 

'calcRevPolishNotation' is a function that calculates the results of an expression that is stored in a vector of word. In particular:
- if the first bit is 0 the next number is a positive number between 0 and 2^31-1
- if the first bit is 1 the word contains an operator. Sum = -1, subtraction = -2, multiplication = -3, division = -4

There is not overflow as a hypothesis and the procedure receives the address of the expression and the length of the it.

# Technology
- ASSEMBLY MIPS

# Logic of the program
The stack is used to keep track of the operations. During the scan of the elements in the vector: if it is encountered a number it is pushed in the stack and if it is encoutered an operator the last two elements in stack are taken and the operation is executed between them. The result is pushed again in the stack and at the end of the sequence only the end result remains.
