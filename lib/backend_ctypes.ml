open Ctypes
open Foreign

module Vector3 = struct
  type t

  let t : t Ctypes.structure typ = structure "Vector3"
  let x = field t "x" float
  let y = field t "y" float
  let z = field t "z" float
  let () = seal t

  let create x' y' z' =
    let v = make t in
    setf v x x';
    setf v y y';
    setf v z z';
    v
end

module Impl = struct
  let lib =
    Dl.dlopen ~filename:"./dllcore.so" ~flags:Dl.[ RTLD_NOW; RTLD_GLOBAL ]

  let core_bringup = foreign "core_bringup" (void @-> returning void) ~from:lib

  let core_shutdown =
    foreign "core_shutdown" (void @-> returning void) ~from:lib

  let should_window_close =
    foreign "should_exit" (void @-> returning bool) ~from:lib

  let frame_begin = foreign "frame_begin" (void @-> returning void) ~from:lib
  let frame_end = foreign "frame_end" (void @-> returning void) ~from:lib

  module Input = struct
    type mouse = { x : float; y : float; left_btn : bool }

    let get_mouse () = { x = 0.; y = 0.; left_btn = true }
    let get_key (_x : int) = true
  end

  module Scene = struct
    type t = unit ptr

    let t : t typ = ptr void

    let add_point_light _ _ _ _ _ =
      failwith "Starting with directional lights first"

    let add_dir_light =
      foreign "_scene_add_dir_light"
        (t @-> Vector3.t @-> Vector3.t @-> Vector3.t @-> Vector3.t
       @-> returning void)
        ~from:lib
  end
end

module HighLevel = struct
  type directional_light = { ambient : float }

  module Scene = struct
    (* let add_dir_light = *)
  end
end
