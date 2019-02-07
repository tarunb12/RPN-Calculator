open Str

let in_channel = open_in "test.txt";;
try
  while true do
    let in_line = input_line in_channel in
      let split = Str.split(Str.regexp " +") in
        let exprs = split in_line in
        print_string (String.concat "\n" exprs);
        print_string "\n"
        (* toRpn here *)
  done
with End_of_file ->
  close_in in_channel;;