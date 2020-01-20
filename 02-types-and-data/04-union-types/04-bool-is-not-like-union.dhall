-- in theory Bool : <True | False>, in practice we don't use `merge`
let not = \(x : Bool) -> if x then False else True
let example0 = assert : not True === False
let example0 = assert : not False === False
in False