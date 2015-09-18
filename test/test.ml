open OUnit2
open ThreadOpt

let tests = 
  [
    "Simple" >::
    (fun test_ctxt ->
      ())
  ]

let run vrt =
  run_test_tt_main
    ("ThreadOpt(" ^ vrt ^ ")" >::: tests)
