# Reverse Polish Notation Calculator #
## Compiling the rpn.ml Calculator ##
```console
$ ocamlc str.cma rpn.ml -o a
$ ./a
```
## Testing ##
```console
$ ocamlfind ocamlc -package oUnit -linkpkg -o b test.ml
$ ./b
```