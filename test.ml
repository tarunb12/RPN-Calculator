open OUnit2
open Rpn

let token_of_string (result : string) : token =
  let is_float_valid = float_of_string_opt result in
    match is_float_valid with
    | Some number -> Number number
    | None -> TokenError result ;;

let rec tests index test_list ic_test ic_result : test list =
  try
    let expr = input_line ic_test in
      let result = String.trim (input_line ic_result) in
        let test_name = "Test #" ^ (string_of_int index) in
          let add_to_test_list t_list = List.append test_list t_list in
            let test_assertion = fun test_ctxt ->
              assert_equal (evaluate_final_state expr) (token_of_string result) in
                let new_test = test_name >:: test_assertion in
                  tests (index + 1) (add_to_test_list [new_test]) ic_test ic_result;
  with End_of_file -> test_list;;

let ic_test = open_in "test.txt" in
  let ic_result = open_in "result.txt" in
    try
      let test_fixture = "RPN" >::: (tests 0 [] ic_test ic_result) in
        run_test_tt_main test_fixture
    with _ -> 
      close_in ic_test;
      close_in ic_result;;