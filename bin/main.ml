open Celeritas_ocaml.Lib

let backend_module = get_backend (Ctypes)

let rec main_loop (module Cel : Core) =
  match Cel.should_window_close () with
  | true -> print_endline "Shutting down..."
  | false ->
      Cel.frame_begin ();
      (* core_input_update (); *)
      (* Do drawing here *)
      Cel.frame_end ();
      main_loop (module Cel)

let () =
  let module Cel = (val backend_module : Core) in
  Cel.core_bringup ();
  print_endline "Celeritas engine running!";
  main_loop (module Cel);
  Cel.core_shutdown ()
