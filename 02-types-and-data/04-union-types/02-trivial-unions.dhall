let Service = <bodhi-web | bodhi-proxy>
let Route = {
    Type = {service : Service, path : Text, port : Natural},
    default = {path = "/", port = 8080}
}
in
[
  Route::{service = Service.bodhi_web},
  Route::{service = Service.bodhi-proxy, port = 8888}
]