let UserType = ./02-type.dhall

let userDefault =
      { home = None Text, password = None Text, groups = [] : List Text }

in  [ userDefault ⫽ {  groups = ["wheel"] } ] : List UserType
