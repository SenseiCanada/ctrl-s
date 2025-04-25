INCLUDE inkVariables_GameFiles.ink
VAR wizardSaveKnot = ""
VAR wizardAffection = ""
->wizard_enter

=== wizard_enter ===
~NPCID = "wizard"
//if final item in player inventory, go to wizard end

I having nothing to say to you yet.

+[<i>Leave</i>]->wizardQuit

=== wizard_resume ===
->wizardSaveKnot


=== wizard_end ===
How droll. That such a small item could be my undoing. The pen is truly mightier than the sword.

*[I'm putting you back in]
*[Convince me otherwise]

- You may cann my choice selfish. And I might even agree. Survival is the epitome of selfishness afterall.

*[You're not selfish]
*[You can change my mind]

- Verily, my actions thus far spring from my deepest devotion to another. All I desire is to prevent Nova from sacrificing herself.

*[I want that too]
*[She gets to make her choices]

- But she cannot alter her fate! You and I have miraculously become stage hands and playwrights as well as actors. The show needn't go on! Curtains before intermission.

*[But we'd be trapped]
*[We do have a responsibility]

- Together. So that we may enjoy each other's company! Can't you see that this is the only choice I can make?

*[I agree with you]
*[Nova can't choose]

- There are only two choices: let the game maker complete their work and Nova's sacrifice becomes our tale's grand finale, or do everything in our power to make sure this adventure never comes to an end.

*[We''ll stop the end]
*[Nova deserves choice]
*[Special: there must be a third option]

- I have made my choice. Help me do this. For Nova. I am powerless to stop you. But I beg you to act with compassion.

*[Alright]->wizardQuit
*[No, I won't] ->wizardQuit
*[I need to think] ->wizardQuit


=== wizardQuit ===
~wizardSaveKnot = ->wizard_enter
    {quitDialogue()}
    ->DONE