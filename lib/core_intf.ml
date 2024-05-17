(** Defines the interface for celeritas-core *)

module type Core = sig
  val core_bringup : unit -> unit
  val core_shutdown : unit -> unit
end


