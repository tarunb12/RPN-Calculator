open OUnit2


let test_fixture = "Rpn" >:::
[
  "test.txt" >:: (fun test_ctxt ->
  let ic_t = open_in "test.txt" in
    let ic_r = open_in "result.txt" in
      try
        while true do
          let expr = input_line ic_t in
            let result = input_line ic_r in
            assert_equal (Rpn.read_expr expr) (float_of_string result)
        done;
    with End_of_file ->
      close_in ic_t;
      close_in ic_r;
  );
]
let () = run_test_tt_main test_fixture;;

(* 
ocamlfind ocamlc str.cma -o b -package ounit -linkpkg -g rpn.ml test.ml
ITERATE THROUGH TESTS WITH TEST.TXT AND RESULT.TXT
*)