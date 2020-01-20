-- Fix the type error
-- Dhall doesn't infer the type of the empty list, so you need to provide it
-- The whole expression is anotated as list of list of text, with the `: List (List Text)`
[ [], [ "a" ], [ "a", "b" ], [ "a", "b", "c" ] ] : List (List Text)
