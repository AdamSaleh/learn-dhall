let welcome = \(name : Text) -> "Welcome {$name}!"
let _ = assert : welcome "Adam" === "Hello Adam!"
in welcome "Test"