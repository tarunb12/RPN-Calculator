open Str
open List
open String

type associativity = Left | Right;;

let assoc op =
  match op with
  | "^" -> Right
  | _ -> Left;;

let precedence op =
  match op with
  | "^" -> 3
  | "*" -> 2
  | "/" -> 2
  | "+" -> 1
  | "-" -> 1
  | _ -> -1;;

(* let rec split_on_chars exp_list sep =
  match sep with
  | [] -> exp_list
  | x :: _ -> split_on_chars()
  ;; *)

let ops = ["^";"*";"/";"+";"-"];;

let in_channel = open_in "test.txt";;
try
  while true do
    let in_line = input_line in_channel in
      let oc = open_out "result.txt" in
        let split = Str.split(Str.regexp " +") in
          let exprs = split in_line in
            (* let toks = List.iter split_on_chars (expr ops); *)
            Printf.fprintf oc "%s" (String.concat "\n" exprs);
            close_out oc;
  done
with End_of_file -> close_in in_channel;;

(* ["^";"*";"/";"+";"-"] *)