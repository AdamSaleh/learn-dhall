let ServiceName = <bodhi-web | bodhi-proxy>
let Service = {
    Type = {name :  Text, port : Natural}
}
let Route = {
    Type = {service : ServiceName, path : Text, port : Natural},
    default = {path = "/", port = 8080}
}
let mkServiceSettings = \(route : Route.Type) -> merge {
  bodhi-web = { name = "web", port = 6543 }
, bodhi-proxy = { name = "proxy", port = 8080 }
} route.service
let map = https://prelude.dhall-lang.org/List/map
let routes = [
  Route::{service = ServiceName.bodhi-web},
  Route::{service = ServiceName.bodhi-proxy, port = 8888}
]
let services = map Route.Type Service.Type mkServiceSettings routes
in { routes = routes, services = services}