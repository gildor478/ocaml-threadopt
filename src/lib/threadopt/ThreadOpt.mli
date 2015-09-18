
module RWMutex:
sig
  type t 

  val read_lock: t -> unit

  val read_unlock: t -> unit

  val lock: t -> unit

  val unlock: t -> unit
end

module Var:
sig
  type 'a t

  val get: 'a t -> 'a

  val set: 'a t -> 'a -> unit
end

