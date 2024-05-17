(** Defines the interface for celeritas-core *)

module type Core = sig
  val core_bringup : unit -> unit
  val core_shutdown : unit -> unit
  val should_window_close : unit -> bool

  val frame_begin : unit -> unit
  val frame_end : unit -> unit
end


