# Reverse Polish Notation Calculator #
## Compiling the rpn.ml Calculator ##
```console
$ ocamlc str.cma rpn.ml -o rpn
$ ./rpn
```
Note: Any floating point numbers will be cut off 12 digits after the decimal.
Any invalid RPN expression will produce an error, as well as an expression which produces an infinite result.
## Testing ##
```console
$ ocamlfind ocamlc str.cma -o test -package oUnit -linkpkg -g rpn.ml test.ml
$ ./test
```
Tests will be read in from test.txt and results will be compared with result.txt.
When testing, the program will prompt for input. To prevent any expression from being evaluated/producing errors, hit enter or type "test" and enter to skip straight to testing results.
Note that invalid expressions produce a nan result by the program, and any invalid result in test.txt matches to "failure" in the result.txt file, as well as +/-infinite matching to "infinite."
When testing numbers with an infinite decimal representation as the result, the tests will fail due to there being no exact representation which you can feed to the program for it to equal the result.