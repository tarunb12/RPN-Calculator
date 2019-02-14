# Reverse Polish Notation Calculator #
This RPN calculator runs by entering tokens, i.e. operators or numbers, seperated by spaces, entered through stdin.\
No need to worry about extra whitespace anywhere, because it is stripped in the program.
## Compiling the rpn.ml Calculator ##
```console
$ ocamlc str.cma rpn.ml -o rpn
$ ./rpn
```
Note: Any floating point numbers will be cut off 12 digits after the decimal.\
Any invalid RPN expression will produce an error, as well as an expression which produces an infinite result.
## Testing ##
The unit tests are set up so that all input test expressions are in the file "test.txt", with only one expression on each line. Each expression is ran through the rpn program, and the output is compared with the results in "result.txt". Each input expression's expected output corresponds to the the same line in "result.txt".\
To run the unit tests, run:
```console
$ ocamlfind ocamlc str.cma -o test -package oUnit -linkpkg -g rpn.ml test.ml
$ ./test
```
Tests will be read in from test.txt and results will be compared with result.txt.
When testing, the program will prompt for input. To prevent any expression from being evaluated/producing errors, hit enter or type "test" and enter to skip straight to testing results.\
Note that invalid expressions produce a nan result by the program, and any invalid result in test.txt matches to "failure" in the result.txt file, as well as +/-infinite matching to "infinite".\
When testing numbers with an infinite decimal representation as the result, the tests will fail due to there being no exact representation which you can feed to the program for it to equal the result, for example you will not be able to test `1 3 /`
since floating point division eventually becomes unpredictable and inaccurate after a certain number of digits (This is not apparent in the printed result of the expression).