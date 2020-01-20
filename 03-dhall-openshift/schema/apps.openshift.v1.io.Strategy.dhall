let RollingParams = ./apps.openshift.io.RollingParams.dhall

let LifecycleHook = ./apps.openshift.io.v1.LifecycleHook.dhall

in  { Type =
        { activeDeadlineSeconds : Natural
        , recreateParams :
            { timeoutSeconds : Natural
            , post : Optional LifecycleHook.Type
            , mid : Optional LifecycleHook.Type
            , pre : Optional LifecycleHook.Type
            }
        , resources : {}
        , rollingParams : Optional RollingParams.Type
        , type : Text
        }
    , default =
        { activeDeadlineSeconds = 21600
        , recreateParams =
            { timeoutSeconds = 600
            , pre = None LifecycleHook.Type
            , mid = None LifecycleHook.Type
            , post = None LifecycleHook.Type
            }
        , resources = {=}
        , rollingParams = None RollingParams.Type
        , type = "Rolling"
        }
    }
