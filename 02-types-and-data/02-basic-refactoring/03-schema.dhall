{ Type =
    { login : Text
    , home : Optional Text
    , password : Optional Text
    , groups : List Text
    }
, default = { home = None Text, password = None Text, groups = [] : List Text }
}
