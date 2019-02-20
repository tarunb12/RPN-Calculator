let generic_error = "Invalid RPN expression."

type token = 
  | Number      of float
  | Operator    of string
  | TokenError  of string ;;

type state =
  | TokenStack of float list
  | StateError of string ;;

let evaluate_operation (num_1 : float) (num_2 : float) (operator : string) : token =
  let token =
    match operator with
    | "^" -> (
      let result = num_1 ** num_2 in
        match Float.classify_float result with
        | FP_nan -> TokenError "Result is a complex number"
        | _ -> Number result)
    | "*" -> Number (num_1 *. num_2)
    | "/" -> (
      let result = num_1 /. num_2 in
        match num_2 = 0.0 with
        | true -> TokenError "Cannot divide by zero"
        | false -> Number result)
    | "+" -> Number (num_1 +. num_2)
    | "-" -> Number (num_1 -. num_2)
    | _ -> TokenError "Invalid Operation" in
  match token with
  | Number number -> (
    match Float.classify_float number with
    | FP_nan -> TokenError generic_error
    | FP_infinite -> TokenError "Result is too large"
    | _ -> Number number)
  | TokenError error -> TokenError error
  | _ -> TokenError generic_error ;;
  
let next_state (state : state) (token : token) : state = 
  match state with
  | StateError error -> state
  | TokenStack stack ->
    match token with
    | TokenError error -> StateError error
    | Number number -> TokenStack (number :: stack)
    | Operator operation ->
      match stack with
      | num_2 :: num_1 :: tl -> (
        let result = evaluate_operation num_1 num_2 operation in
          match result with
          | Number number -> TokenStack (number :: tl)
          | TokenError error -> StateError error
          | _ -> StateError generic_error)
      | _ -> StateError (("Not enough arguments for operator \"" ^ operation) ^ "\"") ;;

let tokenize (token : string) : token = 
  match token with
  | "^" | "*" | "/" | "+" | "-" -> Operator token
  | _ -> let is_float_valid = float_of_string_opt token in
    match is_float_valid with
    | Some number  -> Number number
    | None -> TokenError (("Unable to recognize token \"" ^ token) ^ "\"") ;;

let process_input (input : string) : state = input
  |> String.trim
  |> Str.split (Str.regexp " +")
  |> List.map tokenize
  |> List.fold_left next_state (TokenStack []) ;;

let evaluate_final_state (input : string) : token = 
  let state = process_input input in
    match state with
    | StateError error -> TokenError error
    | TokenStack stack -> 
      match stack with
      | hd :: [] -> Number hd
      | _ -> TokenError "Too many numerical arguments in the expression" ;;

let prompt_input (input : string) : unit =
  match input with
  | "" -> ()
  | token -> let result = evaluate_final_state input in
    match result with
    | TokenError error -> Printf.printf "Error: %s\n" error 
    | Number number -> Printf.printf "%.15f\n" number
    | _ -> () ;;

let rec start () = 
  let input = read_line () in
    match input with
    | "test" | "quit" | "exit" -> ()
    | _ -> prompt_input input;
  start () ;;

start () ;;