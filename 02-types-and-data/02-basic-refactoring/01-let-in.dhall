let UserType =
      { login : Text
      , home : Optional Text
      , password : Optional Text
      , groups : List Text
      }

let userDefault =
      { home = None Text, password = None Text, groups = [] : List Text }

in  [ userDefault ⫽ {  groups = ["wheel"] } ] : List UserType
