{ Type =
    { execNewPod :
        { command : List Text, containerName : Text, volumes : List Text }
    , failurePolicy : Text
    }
, default = { failurePolicy = "abort" }
}
