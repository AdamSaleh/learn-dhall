-- You don't actually need the let ... in, just writing the type is sufficient
let UserType =
      { login : Text
      , home : Optional Text
      , password : Optional Text
      , groups : List Text
      }

in  UserType
