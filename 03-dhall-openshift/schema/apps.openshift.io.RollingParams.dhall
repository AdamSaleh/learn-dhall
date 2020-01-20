let LifecycleHook = ./apps.openshift.io.v1.LifecycleHook.dhall
in
{ Type =
    { intervalSeconds : Natural
    , maxSurge : Text
    , maxUnavailable : Text
    , timeoutSeconds : Natural
    , updatePeriodSeconds : Natural
    , pre : Optional LifecycleHook.Type
    }
, default =
      { intervalSeconds = 1
      , maxSurge = "25%"
      , maxUnavailable = "25%"
      , timeoutSeconds = 600
      , updatePeriodSeconds = 1
      , pre = None  LifecycleHook.Type
      }
}
