let is_op s = 
  let ops = ["^";"*";"/";"+";"-"] in
    List.mem s ops;;

let remove l =
  match l with
  | [] -> []
  | hd :: tl -> tl;;

let pop stack = 
  let rev_stack = List.rev stack in
  match rev_stack with
  | [] -> []
  | hd :: tl -> List.rev tl;;

let push stack elem = List.append stack [elem];;

let eval_op op num_1 num_2 =
  match op with
  | "^" -> num_1 ** num_2
  | "*" -> num_1 *. num_2
  | "/" -> num_1 /. num_2
  | "+" -> num_1 +. num_2
  | "-" -> num_1 -. num_2
  | _ -> Float.nan;;

let rec eval_expr expr float_stack =
  if List.length expr <= 0 then
    if List.length float_stack == 1 then (List.hd float_stack)
    else Float.nan 
  else
    let token = List.hd expr in
      let is_float t = try ignore (float_of_string t); true with _ -> false in
        let new_expr = remove expr in
          if is_float token then
            let num = float_of_string token in
              (eval_expr (new_expr) (push float_stack num))
          else
            if is_op token then
              if List.length float_stack >= 2 then
                let num_2 = List.hd (List.rev float_stack) in
                  let num_1 = List.hd (List.rev (pop float_stack)) in
                    let pop_then_push stack = push (pop (pop stack)) in
                      eval_expr new_expr (pop_then_push float_stack (eval_op token num_1 num_2))
              else Float.nan
            else Float.nan;;

let read_expr expression =
  let spaceSplit = Str.(split(regexp " +")) in
    let expr = spaceSplit (String.trim expression) in
      eval_expr expr [];;

let classify_float result =
  match Float.classify_float result with
  | FP_infinite -> Printf.printf "RPN Expression produces an infinite result.\n"
  | FP_nan -> Printf.printf "Invalid RPN Expression\n"
  | _ -> Printf.printf "%f\n" result;;

let input = read_line () in
  let result = read_expr input in
    match input with
    | "" -> Printf.printf ""
    | _ -> classify_float result;;