INCLUDE inkVariables_GameFiles.ink
VAR robotItem = "glass"
VAR seenRobotStart = "false"
VAR robotSaveKnot = ""

-> robot_enter

=== robot_enter === //knot that directs active story
~NPCName = "GameManager"
~NPCID = "robot"

{runAttempts > 0: 
    ->robot_restart
- else: -> robot_start
}

->DONE


=== robot_resume ===
-> robotSaveKnot

->DONE


=== robot_start ===
{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

{not firstStart: -> firstStart}
{firstStart: ->repeatStart}
//{seenRobotStart == true: ->repeatStart}
//{seenRobotStart == false: ->firstStart}


= firstStart
~NPCName = "??"
~robotAffection = 0
~seenRobotStart = true
May the thoroughness of the almighty developer guide your path, my child.
+[(testing) Rel++]
    ~robotAffection++
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

*[<i>Leave</i>] 
    ~robotSaveKnot = ->robot_enter
    {quitDialogue()}
    //->resume //to test in ink
    
->DONE

= repeatStart
Only 3 cyles until compilation. Please return to your loading bay.
+[Leave]
    ~robotSaveKnot = ->robot_enter
    {quitDialogue()} 
    -> robot_enter


->END //first run


=== robot_restart ===//subsequent runs
{startCatQuest == true || startGunQuest == true && runAttempts >= 3:
    ->robot_ChangeClass
}
{not robot_restart.dialogue && runAttempts == 2:
    -> robot_restart.dialogue
- else:
    -> robot_restart.default
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

*[Leave]
    ~robotSaveKnot = ->robot_enter
    {quitDialogue()} 
    -> robot_enter
    ->DONE

=default
Please prepare for compilation.

+[Leave]
    ~robotSaveKnot = ->robot_enter
    {quitDialogue()} 
    -> robot_enter
->DONE



=== robot_ChangeClass ===
My child?

+[Can you change my class?]

- It won't do you much good, but that is within my power. Your current class is <i>{playerClass}</i>.

+[Change class: fileViewer]
    ~playerClass = "fileViewer"
+[Change class: manager]
    ~playerClass = "manager"

- It is done.

+[Leave]
    ~robotSaveKnot = ->robot_enter
    {quitDialogue()} 
    -> robot_enter

->DONE

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

+[<i>Back</i>]-> robot_start.repeatStart
    
    