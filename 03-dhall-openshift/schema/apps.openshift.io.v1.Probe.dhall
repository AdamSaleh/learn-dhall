{ Type =
    { failureThreshold : Natural
    , httpGet : Optional { path : Text, port : Natural, scheme : Text }
    , exec : Optional { command : List Text }
    , initialDelaySeconds : Natural
    , periodSeconds : Natural
    , successThreshold : Natural
    , timeoutSeconds : Natural
    }
, default =
    { failureThreshold = 3
    , initialDelaySeconds = 30
    , periodSeconds = 10
    , successThreshold = 1
    , timeoutSeconds = 10
    , httpGet = None { path : Text, port : Natural, scheme : Text }
    , exec = None { command : List Text }
    }
}
