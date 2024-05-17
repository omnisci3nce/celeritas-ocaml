open Ctypes
(* open Foreign *)

module Impl = struct
  let core_bringup () = ()
  let core_shutdown () = ()
end

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
    setf v x y';
    setf v x z';
    v

end