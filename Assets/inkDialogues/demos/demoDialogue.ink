INCLUDE inkVariables_GameFiles.ink

EXTERNAL quitDialogue()

-> enter
=== enter ===

{runAttempts > 0: 
    ->restart
- else: -> start
}

=== start ===

This NPC says something interesting.

 + [Agree]
 + [Disagree]

- NPC says something else making you wonder if they even heard. Click go to game files.

* [Name?]
    ~NPCName = "Lorelei"
    Rather fitting, don't you think?
    ** [Leave] {quitDialogue()}
        -> enter
+ [Leave] {quitDialogue()}
    -> enter

 
 === restart ===
 You went to the game files! Where do you want to go in there?
 
 *[Characters]
    You'll need this: a key to unlock the Chatacters file.
        ~key = "characters"
        ** [Leave] {quitDialogue()}
        -> enter
 *[Environments]
    You'll need this: a key to unlock the Environment file.
        ~key = "environment"
        ** [Leave] {quitDialogue()}
        -> enter
 
 
===function quitDialogue===
    ~return
   
