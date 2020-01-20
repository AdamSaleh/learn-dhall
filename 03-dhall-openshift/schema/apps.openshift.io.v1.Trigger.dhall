{ Type =
    { type : Text
    , imageChangeParams :
        Optional
          { automatic : Bool
          , containerNames : List Text
          , from : { kind : Text, name : Text, namespace : Text }
          }
    }
, default =
    { imageChangeParams =
        None
          { automatic : Bool
          , containerNames : List Text
          , from : { kind : Text, name : Text, namespace : Text }
          }
    }
}
