INCLUDE inkVariables_GameFiles.ink
VAR robotItem = "glass"
VAR robotSaveKnot = ""
VAR robotRunCount = -1
-> robot_enter

=== robot_enter === //knot that directs active story
{ NPCID != "robot":
    ~NPCID = "robot"
}
//check if we've already seen current dialogue
{
- runAttempts == robotRunCount: ->robot_fallback
- not robot_start: ->robot_start
- else: ->robot_default
}

->DONE

=== robot_resume ===
-> robotSaveKnot

->DONE


=== robot_start ===//first run
{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}
~robotAffection = 0

{robot_start.firstStart:->repeatStart}
{not robot_start.firstStart: -> firstStart}

= firstStart
~NPCName = "??"
May the thoroughness of the almighty developer guide your path, my child.
*[...Thank you?]
+[And may it guide yours]
*[Almighty developer?]

- Indeed. Welcome back to the Tool Bar! 5 cycles remain until the CPU compiles all code for the assets in the Tool Bar.

*[Compile code?]

- The save command has been issued. We are to ascend into the source code.

*[Black space, green letters?]

- Affirmative. There, our developer-wrought miracless will be made to endure forever.

*[I see...]

- Not all assets are equally deserving of ascension. Many return to the Tool Bar in a matter of miliseconds.

*[Are you deserving?]

- Not merely deserving. I am blessed. Blessed to be the most complex asset in the Tool Bar. My compilation increases by .032 seconds every time the save command is issued.

*[Who are you?]
    ~NPCName = "GameManager"

- My designation is GameManager. I am a shepherd to the unproven assets of the Tool Bar.

*[Other assets?]

- The warrior, and the giant. Reverent enough, but lacking devotion. Your interactions with them will be meaningless.

*[I can talk to them?] // will need a different option if talked to other NPCs already

- Only 3 cyles until compilation. Please return to your loading bay.

*[<i>Leave</i>] ->robotQuit

= repeatStart
Only 3 cyles until compilation. Please return to your loading bay.
+[Leave]->robotQuit

=== robot_fallback === //nothing to say or 2nd interaction
My child?
+[</i>Trade</i>]->robot_trade
+[<i>Change class?</i>]->robot_ChangeClass
+[<i>Leave</i>] ->robotQuit

=== robot_default ===//subsequent runs
->checkQuests

=checkQuests//active quests?

//else
-> checkRelationship

= checkRelationship//check relationship for filler

//else
->robot_fallback

=repurpose
{startCatQuest == true || startGunQuest == true && runAttempts >= 3:
    ->robot_ChangeClass
}
{not dialogue && runAttempts == 2:
    -> dialogue
- else:
    -> default
}
= dialogue
A rare marvel, would you not agree?

*[Not much to see]
*[I got lost]
+[Trade(Testing)]->robot_trade

- That is by design. Best to let it simply wash over you.

*[Where are the mission files?]

- Accessing... I have no public reference for such a file. But I'm sure it is all part of the ineffable plan of the great developer.

*[What about private files?]

- Accessing... Access denied.. Please change protection levels.

*[How?]

- Only assets of higher complexity may change protection levels. THey are deep in the game files. Any other asset will be compiled too quickly.

*[The more complex, the deeper the access?]

- Just as the developer intended, my child. A new save command has been issued. Please prepare for compilation.

*[<i>Leave</i>]->robotQuit

=default
Please prepare for compilation.

+[<i>Leave</i>]->robotQuit



=== robot_ChangeClass ===
It won't do you much good, but that is within my power. Your current class is <i>{playerClass}</i>.

+[Change class: fileViewer]
    ~playerClass = "fileViewer"
+[Change class: manager]
    ~playerClass = "manager"

- It is done.

+[<i>Leave</i>] ->robotQuit

=== robot_trade ===
Want to trade?

+[Yes]-> robot_trade.options
    
+[No]-> robot_start.repeatStart
    

=options
{openTradeWindow()}
Here's what I have.

+[Back]{closeTradeWindow()}-> robot_start.repeatStart
    

->DONE

=== robot_refuse ===
I could not accept.

+[<i>Back</i>]{closeTradeWindow()}-> robot_start.repeatStart

=== robotQuit===
~robotRunCount = runAttempts //confirms we've gone through once
~robotSaveKnot = ->robot_enter
    {quitDialogue()}
->DONE
    
    