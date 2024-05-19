(** Higher level wrappers around the C API *)

[@@@ocaml.warning "-26-27-33-34"]

module Input = struct
  type mouse_btn_state = Unpressed | JustPressed | Held | JustReleased
end

type model
type 'a handle = int

module Scene = struct
  type t

  let get_default_scene () : t = failwith "TODO"

  (** Add a model to the scene *)
  let add_model model scene = failwith "TODO"

  (** Add a directional light to the scene *)
  let add_dir_light ambient diffuse specular direction (scene : t) : t =
    failwith "TODO"

  (** Add a point light to the scene *)
  let add_point_light _ _ _ _ (scene : t) : t = failwith "TODO"

  (* Getters & Setters *)

  (** Sets the transform of a model in the **default** scene (so you don't need to pass a scene ptr around) and marks
      the affine 4x4 matrix as dirty *)
  let set_model_transform pos rot scale model = failwith "TODO"

  let set_camera pos front = failwith "TODO"
end

module Cel = struct
  let core_bringup () = ()
  let core_shutdown () = ()
  let should_exit () = true
  let frame_begin () = ()
  let frame_end () = ()
  let load_model (_path : string) : model handle = failwith "TODO"

  include Scene

  type frame_data = { delta_time : float; mutable should_exit : bool }

  let run (f : frame_data -> unit) =
    let rec loop f prev_frame =
      if prev_frame.should_exit then ()
      else
        let now = 0.0 in
        f prev_frame;
        let frame = { prev_frame with delta_time = 5. } in
        loop f frame
    in
    loop f { delta_time = 0.0; should_exit = false }
end

let v3 _ _ _ = failwith "oo"

let init_example_scene () =
  let a_model = Cel.load_model "assets/backpack.obj" in
  let s : Scene.t =
    Scene.get_default_scene ()
    |> Scene.add_dir_light (v3 1. 1. 1.) (v3 1. 1. 1.) (v3 1. 1. 1.)
         (v3 0. (-1.) 0.2)
    |> Scene.add_point_light (v3 1. 1. 1.) (v3 1. 1. 1.) (v3 1. 1. 1.)
    |> Scene.add_model a_model
  in
  s
(* set_model_transform (v3 1. 1. 1.) *)

let main_loop (frame : Cel.frame_data) : unit =
  match Cel.should_exit () with
  | true -> print_endline "Shutting down..."
  | false ->
      Printf.printf "Delta time %f\n" frame.delta_time;
      Cel.frame_begin ();
      (* TODO: Cel.Render.draw_scene () *)
      Cel.frame_end ()

let () =
  Cel.core_bringup ();
  print_endline "Celeritas engine running!";
  let _scene = init_example_scene () in
  Cel.run main_loop;
  Cel.core_bringup ()
