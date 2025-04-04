INCLUDE inkVariables_GameFiles.ink
VAR warriorSaveKnot = ""

-> warrior_enter

=== warrior_enter ===
~NPCName = "Warrior"
~NPCID = "warrior"

{runAttempts > 0: 
    ->warrior_restart
- else: -> warrior_start
}


=== warrior_resume===
-> warriorSaveKnot

//first run
=== warrior_start ===
~warriorAffection = 0 //define variables before knot navigation

{playerClass == "": // null check for player class
    ~playerClass = "fileViewer"
}

{warrior_start.firstStart: ->repeatStart}
{not warrior_start.firstStart: ->firstStart}


= firstStart
~NPCName = "??"

You still got my back?

*[Yes...]

- That's good to hear. Really good to hear.

*[Who...?]

- Our new target. Unclear. Directives in the game files are all redacted. GM's being super cagey, My money's on rocky horror over there though. //add alternative text if spoken/not spoken to Brall and GM before

*[No, who are you?]

- <i>A look flashes across her face. Suprise? Betrayal?</i>

*[<i>Continue</i>]

- That's classified I'm afraid. <i>She taps the side of her nose</i>

*[No, I'm serious]

- And I have a reputation to uphold. You won't break me that easily.

*[Fine. When do we move out?]

- Also classified. Although, truth be told, we all seem to end up just where we started everytime we get compiled.

*[We're stuck?]

- We're "ascending," if you believe GM's drivel. It's slow going. What I wouldn't give to take a peek inside some of those files. But I always compile too quickly.

*[I could check]

- See, I knew you had my back. You'd better get to your loading bay then.

*[<i>Leave</i>] ->warriorQuit

= repeatStart
Still here?
+[Leave] ->warriorQuit

=== warrior_restart === //subsequent runs
{ discoveredNoGun == true:
    -> weaponless
}
{ not warrior_restart.punch && runAttempts == 2: 
    ->warrior_restart.punch
- else: -> default
}

= default
Need something?
+[Trade(Testing)]->warrior_trade
+[Leave] ->warriorQuit
    -> warrior_restart
->DONE

= punch
<i>She punches you</i>

+[Trade(Testing)]->warrior_trade
*[What the hell?!] -> findWeapon
*[Hit her back]
    <i>She effortlessly ducks under your blow and lands a savage kick, doubling you over.</i>
    **[groan]
    **[...]
    -- ->findWeapon
    
= weaponless
Find anything?

+[Yeah...]-> badNews
+[Nothing yet]
- Please keep looking.
    ++[Leave] ->warriorQuit
        ->DONE

= badNews
Best news I've had all day. Alright, what are we talking? Blaster? Sniper riffle? Something old fashioned? You know, I think I could really dig an axe.
*[Nothing, you don't get a weapon]
- No, no that can't be possible!
*[I'm so sorry]
- Can it. I don't need this right now. <i>End of Nova's story in current build</i>
*[Leave] ->warriorQuit

    

->DONE
=== findWeapon === //start weapon quest
You did feel that, that's a relief.

*[Are you ok?]
    Oh yeah, much better. Still got it.
    **[You're strange]-> quest
    **[You're not very nice] ->quest
*[What was that for?]
    Just needed to prove something to myself.
    **[You're strange]-> quest
    **[You're not very nice] ->quest

= quest
Ha. You have no idea. Listen, I need a favor.
    *[You're kidding]
    *[Ok, just don't hit me]
-   Next time you're back in the files, check to see if I'm supposed to have a weapon.
    *[I'll look]
        ~startGunQuest = true
    *[You're already dangerous enough]
        ~startGunQuest = true

- I'm going to need to be three times as deadly if we're going to beat this game.

    *[Leave]->warriorQuit
        -> warrior_enter

->DONE


=== warrior_trade === //trade
Want to trade?

+[Yes]-> warrior_trade.options
    
+[No]-> warrior_start.repeatStart
    

=options
{openTradeWindow()}
Here's what I have.

+[Back]{closeTradeWindow()}-> warrior_start.repeatStart
    

->DONE


=== warriorQuit ===
~warriorSaveKnot = ->warrior_enter
    {quitDialogue()}
->DONE

=== warrior_refuseItem ===
{closeTradeWindow()}
I don't want this.

+[Trade something else]->warrior_trade.options
+[Back] -> warrior_enter

->DONE
