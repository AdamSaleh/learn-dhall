-- Definition for our deployment
let schema = ./openshift-schema.dhall

let probe =
      { Type = schema.Probe.Type
      , default = schema.Probe::{
        , failureThreshold = 3
        , initialDelaySeconds = 30
        , periodSeconds = 10
        , successThreshold = 1
        , timeoutSeconds = 10
        }
      }

let templateObjectTypes =
      < DeploymentConfig : schema.DeploymentConfig.Type
      | Route : schema.Route.Type
      | Service : schema.Service.Type
      >

in  { apiVersion = "template.openshift.io/v1"
    , kind = "Template"
    , metadata = { name = "bodhi-template" }
    , parameters =
      [ { description = "Namespace, mostly for image building"
        , name = "NAMESPACE"
        , value = "asaleh-test"
        }
      , { description = "Domain to serve apps on"
        , name = "APPDOMAIN"
        , value = "app.os.stg.fedoraproject.org"
        }
      ]
    , objects =
      [ templateObjectTypes.Service
          schema.Service::{
          , metadata =
              { labels = { app = "bodhi", service = "postgres" }
              , name = "postgres"
              }
          , spec = schema.ServiceSpec::{
            , ports =
              [ { name = "postgres"
                , port = 5432
                , protocol = "TCP"
                , targetPort = 5432
                }
              ]
            , selector = { deploymentconfig = "postgresql" }
            }
          }
      , templateObjectTypes.DeploymentConfig
          { apiVersion = "apps.openshift.io/v1"
          , kind = "DeploymentConfig"
          , metadata =
              { labels = { app = "bodhi", service = "postgres" }
              , name = "postgresql"
              }
          , spec = schema.DeploymentConfigSpec::{
            , replicas = 1
            , selector = { deploymentconfig = "postgresql" }
            , strategy = schema.Strategy::{
              , type = "Recreate"
              , recreateParams =
                  { timeoutSeconds = 600
                  , pre = None schema.LifecycleHook.Type
                  , mid = None schema.LifecycleHook.Type
                  , post = Some
                      { execNewPod =
                          { command =
                            [ "/bin/sh"
                            , "-c"
                            , "export PGPASSWORD=password && export PGUSER=postgres && export PGPORT=5432 && export PGHOST=postgres && export LD_LIBRARY_PATH=/opt/rh/rh-postgresql96/root/usr/lib64/:\$LD_LIBRARY_PATH && export PATH=/opt/rh/rh-postgresql96/root/usr/bin:\$PATH && hostname && sleep 5 && echo \$PATH && psql  -c 'CREATE DATABASE bodhi2;' && psql -c 'CREATE ROLE bodhi2 SUPERUSER;' && psql -c 'GRANT bodhi2 TO postgres;' && curl https://infrastructure.fedoraproject.org/infra/db-dumps/bodhi2.dump.xz -o /tmp/bodhi2.dump.xz && xzcat /tmp/bodhi2.dump.xz | psql bodhi2"
                            ]
                          , containerName = "postgresql"
                          , volumes = [] : List Text
                          }
                      , failurePolicy = "ignore"
                      }
                  }
              }
            , template =
                { metadata =
                    { labels =
                        { app = "bodhi", deploymentconfig = "postgresql" }
                    }
                , spec = schema.DeploymentConfigTemplateSpec::{
                  , containers =
                    [ schema.Container::{
                      , image =
                          "registry.hub.docker.com/centos/postgresql-96-centos7:latest"
                      , imagePullPolicy = "IfNotPresent"
                      , env =
                        [ { name = "POSTGRESQL_USER", value = "postgres" }
                        , { name = "POSTGRESQL_PASSWORD", value = "password" }
                        ]
                      , livenessProbe = Some probe::{
                        , exec = Some
                            { command =
                              [ "/usr/libexec/check-container", "--live" ]
                            }
                        }
                      , readinessProbe = Some probe::{
                        , exec = Some
                            { command = [ "/usr/libexec/check-container" ] }
                        }
                      , name = "postgresql"
                      , volumeMounts =
                        [ schema.VolumeMount::{
                          , mountPath = "/var/lib/pgsql/data"
                          , name = "postgresql-data"
                          }
                        ]
                      }
                    ]
                  , volumes =
                    [ schema.Volume::{
                      , emptyDir = Some {=}
                      , name = "postgresql-data"
                      }
                    ]
                  }
                }
            }
          }
      ]
    }
