/*
INCLUDE inkVariables_GameFiles.ink

->enter

=== enter ===
~ runAttempts++
-> home

===home===
~locationText = ""
Select a file to enter _
(for testing: you are currently carrying the {key} key)

+[Characters]-> characters
+[Environment] -> environment
+[Weapons] -> weapons

=== denied ===

Access denied.

+[Return?_]
-> home

===characters===
~locationText = "characters"

{ key != "characters": 
    -> denied
- else: 
    -> charactersRoom
}

=charactersRoom
Access granted.
file empty.

+[Return?_]
-> home

===environment===
~locationText = "environment"

{key != "environment": 
    -> denied
- else: 
    -> environmentRoom
}

=environmentRoom
Access granted!
file empty.

+[Return?_]
-> home

====weapons===
~locationText = "weapons"

file empty.

+[Return?_]
-> home


==== function displayTurns ===
   {TURNS()}

*/