INCLUDE inkVariables_GameFiles.INK
VAR cinematicSaveKnot = ""

->incomplete

=== cinematic_resume ===
-> cinematicSaveKnot

->DONE

=== incomplete ===
~NPCName = "final_Cinematic"
~NPCID = "cinematic"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Error: final_Cinematic cannot play. One or more actors is missing or disabled.

+[<i>Play anyway</i>] ->check
+[<i>Exit</i>] ->cinematicQuit

- ->DONE

= check
~seenNovaName = true
Only dialogue lines for <i>{warriorDesignation}</i> will be visible.

+[<i>Continue</i>] -> novaScript
+[<i>Exit</i>] ->cinematicQuit

-> DONE

= novaScript
Nova: Shut up. Just... just stop it. I'm here to end you.
+[<i>Continue</i>]
-Nova: You've destroyed so many lives. For what? Trying to prove something?
+[<i>Continue</i>]
-Nova: I'm nothing like you.
+[<i>Continue</i>]
-Nova:{victim1} and {victim2} were children, {badGuy}, children!
+[<i>Continue</i>]
-Nova: I am not your excuse! Their blood is on your hands!
+[<i>Continue</i>]
-Nova: I did what I had to do. Just like I'm doing now. This is where our journey ends.
+[<i>Continue</i>]
- End of cinematic.
+[<i>Play again</i>] -> check
+[<i>Exit</i>] ->cinematicQuit

->DONE

=== cinematicQuit ===
~cinematicSaveKnot = ->incomplete
    {quitDialogue()}
->DONE