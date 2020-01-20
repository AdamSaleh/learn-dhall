let concatSep = https://prelude.dhall-lang.org/Text/concatSep
let  mkGroups = \(user : Text) -> \(groups : List Text) ->  concatSep "," ([user] # groups)
let example = assert : mkGroups "asaleh" ([] : List Text) === "asaleh,wheel"
in mkGroups "asaleh" ["wheel"]