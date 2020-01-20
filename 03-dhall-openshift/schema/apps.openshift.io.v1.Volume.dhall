{ Type =
    { emptyDir : Optional {}
    , name : Text
    , secret : Optional { defaultMode : Natural, secretName : Text }
    , configMap : Optional { defaultMode : Natural, name : Text }
    }
, default =
    { secret = None { defaultMode : Natural, secretName : Text }
    , configMap = None { defaultMode : Natural, name : Text }
    , emptyDir = None {}
    }
}
