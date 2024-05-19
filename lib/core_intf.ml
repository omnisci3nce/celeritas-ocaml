(** Defines the interface for celeritas-core *)

type model_handle = int
type texture_handle = int

module type Input = sig
  type mouse = { x : float; y : float; left_btn : bool }

  val get_mouse : unit -> mouse
  val get_key : int -> bool
end

module type Scene = sig
  (* include Maths *)
  type t
  type vec3

  val add_point_light : vec3 -> vec3 -> vec3 -> vec3 -> t -> unit
  val add_dir_light : _ -> _ -> _ -> _ -> t -> unit
  (* val add_model : string -> unit *)
  (* val set_camera : vec3 -> vec3 -> t -> unit *)
  (* val set_model_transform : model_handle -> vec3 -> vec4 -> float -> t -> unit *)
end

module type Core = sig
  val core_bringup : unit -> unit
  val core_shutdown : unit -> unit
  val should_window_close : unit -> bool

  val frame_begin : unit -> unit
  (** This update inputs and begins recording commands for rendering *)

  val frame_end : unit -> unit
  (** Submits rendering and resets state *)

  (* include Maths *)
  (* include Input *)
  (* include Scene *)
end
