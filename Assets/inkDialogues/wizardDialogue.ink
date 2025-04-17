INCLUDE inkVariables_GameFiles.ink
VAR wizardSaveKnot = ""

->wizard_enter

=== wizard_enter ===
~NPCID = "wizard"
I having nothing to say to you yet.

+[<i>Leave</i>]->wizardQuit

=== wizard_resume ===
->wizardSaveKnot


=== wizardQuit ===
~wizardSaveKnot = ->wizard_enter
    {quitDialogue()}
    ->DONE