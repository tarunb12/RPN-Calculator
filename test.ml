open OUnit

let test_fixture = "rpn" >:::
[
  "add" >:: ( fun () ->
    assert_equal 4 (rpn.read_expr "2 2 +");
  );
]
let _ = run_test_tt test_fixture
(* 
ocamlfind ocamlc -o b -package ounit -linkpkg -g rpn.ml test.ml
15 7 1 1 + − ÷ 3 × 2 1 1 + + − = 
*)