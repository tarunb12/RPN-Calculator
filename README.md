# Reverse Polish Notation Calculator #
## Compiling the rpn.ml Calculator ##
```console
$ ocamlc str.cma rpn.ml -o rpn
$ ./rpn
```
## Testing ##
```console
$ ocamlfind ocamlc str.cma -o test -package oUnit -linkpkg -g rpn.ml test.ml
$ ./test
```