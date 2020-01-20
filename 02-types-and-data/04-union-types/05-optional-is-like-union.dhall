-- in theory Optional x : <Some x | None>, and we even can use merge
let noneToFalse = \(wrapped : Optional Bool ) -> merge { None = False, Some = \(b : Bool) → b } wrapped
let example = assert : noneToFalse (Some True) === True
in noneToFalse (None Bool)