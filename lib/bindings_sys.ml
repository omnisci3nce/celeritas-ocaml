(* automatically generated by ocaml-bindgen 0.0.1 *)

type lifetime =
  | Function
      (** The value can live for the lifetime of the function call, which upon return will signal that the 
                value can be dropped (finalizer?) *)
  | Ocaml  (** The value is managed by the OCaml runtime *)
  | C
      (** The value is allocated and passed to C which is then in charge of cleaning it up *)

type 'a cptr = { lifetime : lifetime; addr : nativeint }

external bindgen_alloc : size:int -> nativeint = "bindgen_alloc"
external bindgen_free : nativeint -> unit = "bindgen_free"
external bindgen_alloc_string : string -> nativeint = "bindgen_alloc_string"

let sizeof _ = 4 (* TODO: how to handle different types? *)

let create_ptr (value : 'a) : 'a cptr =
  let addr = bindgen_alloc ~size:(sizeof value) in
  print_endline ("Addr: " ^ Nativeint.to_string addr);
  Gc.finalise bindgen_free addr;
  { lifetime = Ocaml; addr }

let make_cstr (s: string) : char cptr =
  let addr = bindgen_alloc_string s in
  { lifetime = Ocaml; addr }
  
type nonrec core
external core_bringup : unit -> unit = "caml_core_bringup"
external core_shutdown : unit -> unit = "caml_core_shutdown"
external should_window_close : unit -> bool = "caml_should_window_close"
type nonrec vec2 = {
  x: float ;
  y: float }
type nonrec vec3 = {
  x: float ;
  y: float ;
  z: float }
type nonrec vec4 = {
  x: float ;
  y: float ;
  z: float ;
  w: float }
type nonrec transform3d = {
  translation: vec3 ;
  rotation: vec4 ;
  scale: float }
external render_frame_begin : unit -> unit = "caml_render_frame_begin"
external render_frame_draw : unit -> unit = "caml_render_frame_draw"
external render_frame_end : unit -> unit = "caml_render_frame_end"
external model_load : filepath:char cptr -> int = "caml_model_load"
