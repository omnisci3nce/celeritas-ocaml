open Core_intf

type binding_backend = Bindgen | Ctypes

let get_backend (backend: binding_backend) = 
   match backend with
  | Bindgen -> (module Backend_bindgen.Impl : Core)
  | Ctypes -> (module Backend_ctypes.Impl : Core)