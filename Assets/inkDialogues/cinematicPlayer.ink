INCLUDE inkVariables_GameFiles.INK
EXTERNAL hideWizard()
VAR cinematicSaveKnot = ""
VAR cinematicAffection = ""
{
- hasPen != "Player":->incomplete
-else: ->complete
}

=== cinematic_resume ===
-> cinematicSaveKnot

->DONE

=== incomplete ===
~NPCName = "final_Cinematic"
~NPCID = "cinematic"
~openedCinematic = true

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
{hasList == "Player": New: Stage directions activated.}
+[<i>Continue</i>] -> novaScript
+[<i>Exit</i>] ->cinematicQuit

-> DONE

= novaScript
Nova: Shut up. Just... just stop it. I'm here to end you.
{hasList == "Player": <i>Will turns his back. Nova stays frozen in place.</i>}
+[<i>Continue</i>]
-Nova: You've destroyed so many lives. For what? Trying to prove something?
+[<i>Continue</i>]
-Nova: I'm nothing like you.
+[<i>Continue</i>]
-Nova:{victim1} and {victim2} were children, {badGuy}, children!
+[<i>Continue</i>]
-Nova: I am not your excuse! Their blood is on your hands!
{hasList == "Player": <i>White, flickering light begins to pulse from under Nova's skin.</i>}
+[<i>Continue</i>]
-Nova: I did what I had to do. Just like I'm doing now. This is where our journey ends.
{hasList == "Player": <i>Nova steps forward. A blinding flash explodes from her. Before the explosion fills the screen, we see Will with his arms reaching out.</i>}
+[<i>Continue</i>]
- End of cinematic.
+[<i>Play again</i>] -> check
+[<i>Exit</i>] ->cinematicQuit

->DONE

=== complete ===
~NPCName = "final_Cinematic"
~NPCID = "cinematic"
~openedCinematic = true

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Error: final_Cinematic cannot play. One or more actors is missing or disabled.

+[<i>Use Pen: Replace missing actor</i>]->full_cinematic
+[<i>Play anyway</i>] ->incomplete.check
+[<i>Exit</i>] ->cinematicQuit

=== full_cinematic ===
{not noWizard}->noWizard

~NPCName = "final_Cinematic"
-{badGuy}: You know the last thing {victim1} Bard told me before he died?
+[<i>Continue</i>]
Nova: Shut up. Just... just stop it. I'm here to end you.
{hasList == "Player": <i>Will turns his back. Nova stays frozen in place.</i>}
+[<i>Continue</i>]
-{badGuy}: Alright, alright.
{hasList == "Player": <i>{badGuy} turns his back Nova stays frozen in place.</i>}
+[<i>Continue</i>]
-Nova: You've destroyed so many lives. For what? Trying to prove something?
+[<i>Continue</i>]
-{badGuy}: You've killed as much as I have. And I bet it's for the same reason.
+[<i>Continue</i>]
-Nova: I'm nothing like you.
+[<i>Continue</i>]
-{badGuy}: Competent?Self-assured? Dare I say, righteous?
+[<i>Continue</i>]
-Nova:{victim1} and {victim2} were children, {badGuy}, children!
+[<i>Continue</i>]
-{badGuy}: And they would have become cruel, unrepentant adults. I took action, so you wouldn't have to.
+[<i>Continue</i>]
-Nova: I am not your excuse! Their blood is on your hands!
{hasList == "Player": <i>White, flickering light begins to pulse from under Nova's skin.</i>}
+[<i>Continue</i>]
-{badGuy}: And what about {victim3}? {victim4}? {victim5}? {victim6}?
{hasList == "Player": <i>{badGuy} advances with each name.</i>}
+[<i>Continue</i>]
-{badGuy}: Were their deaths justified just because they were fully grown?
+[<i>Continue</i>]
-Nova: I did what I had to do. Just like I'm doing now. This is where our journey ends.
+[<i>Continue</i>]
-{badGuy}: The last thing {victim1} Bard said was, at least I won't have nightmares anymore.
+[<i>Continue</i>]
{hasList == "Player": <i>Nova steps forward. A blinding flash explodes from her. Before the explosion fills the screen, we see Will with his arms reaching out.</i>} <i>Cue title Screen</i>
+[<i>Continue</i>]
-End of cinematic.
+[<i>Play again</i>] -> full_cinematic
+[<i>Exit</i>] ->cinematicQuit

= noWizard
~NPCName = ""
{hideWizard()}
<i>Behind you, there is a gentle pop. You turn around and {badGuy} has disappeared.</i>
+[<i>Continue</i>]->full_cinematic

=== cinematicQuit ===
~cinematicSaveKnot = ->incomplete
    {quitDialogue()}
->DONE

=== function hideWizard ===
~return