let User = ./03-schema.dhall
in [ User :: {  groups = ["wheel"] } ] : List User.Type