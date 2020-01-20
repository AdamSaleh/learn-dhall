-- Previously we had
-- [ { user = Some "scoady", login = None Text }, { login = Some "asaleh", user = None Text } ]
-- Dhall has type for specifying typed unions. Now the list doesn't complain,
-- that list elements have to be of the same type
let Account = < User : {user : Text } | Login : { login : Text }>
in [ Account.User { user = "scoady" }, Account.Login { login = "asaleh" } ]
