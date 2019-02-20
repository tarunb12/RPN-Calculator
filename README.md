# Reverse Polish Notation Calculator #
This RPN calculator runs by entering tokens, i.e. operators or numbers, seperated by spaces, entered through stdin.
## Compiling the rpn.ml Calculator ##
```console
$ ocamlc str.cma rpn.ml -o rpn
$ ./rpn
```
Note: Any floating point numbers will be cut off 12 digits after the decimal.

Any invalid RPN expression will produce an error, as well as an expression which produces an infinite result.
## Testing ##
The unit tests are set up so that all input test expressions are in the file "test.txt", with only one expression on each line. Each expression is ran through the rpn program, and the output is compared with the results in "result.txt". Each input expression's expected output corresponds to the the same line in "result.txt".

To run the unit tests, run:
```console
$ ocamlfind ocamlc str.cma -o test -package oUnit -linkpkg -g rpn.ml test.ml
$ ./test
```
Tests will be read in from test.txt and results will be compared with result.txt.
When testing, the program will prompt for input. To prevent any expression from being evaluated/producing errors, hit enter or type one of the following: "test", "quit", or "exit", and then enter to skip straight to testing results.

All invalid inputs will correspond to some error in the program, and these different types of failures are tested through test.ml. Refer to the following table to see which kind of inputs throw certain types of errors.

| Input Type            | Error Message                          | Example    |
|:----------------------|:--------------------------------------:|:-----------|
| Division by Zero      | Cannot divide by zero                  | `1 0 /`    |
| Complex Number        | Result is a complex number             | `-1 0.5 ^` |
| (±) Infinite Result   | Result is too large                    | `2 1024 ^` |
| Too Many Operators    | Not enough arguments for operator <op> | `1 2 + +`  |
| Too Many Numbers      | Too many numerical arguments           | `2 3`      |
| Invalid Token         | Unable to recognize token <token>      | `2 1 =`    |

When testing numbers with an infinite decimal representation as the result, the tests will fail due to there being no exact representation which you can feed to the program for it to equal the result, for example you will not be able to test `1 3 /` through test.ml, though it will still run in the rpn calculator, since floating point division eventually becomes unpredictable and inaccurate after a certain number of digits (This is not apparent in the printed result of the expression).