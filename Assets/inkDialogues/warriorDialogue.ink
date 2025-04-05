INCLUDE inkVariables_GameFiles.ink
VAR warriorSaveKnot = ""

-> warrior_enter

=== warrior_enter ===
~NPCID = "warrior"

{
- not warrior_start: ->warrior_start
- not warrior_hitlist: ->warrior_hitlist
- else: ->warrior_restart.default
}

=== warrior_resume===
-> warriorSaveKnot

//first run
=== warrior_start ===
~warriorAffection = 0 //define variables before knot navigation
~hasAnchor = "warrior"
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

*{seenNovaName == true}[You're the Nova Warrior?]
    ~NPCName = "Nova"
    ->named
*{seenNovaName == false}[Who...?]->target

=target
Our new target. Unclear. Directives are in the game files, but GM's being super cagey. My money's on rocky horror over there though. //add alternative text if spoken/not spoken to Brall and GM before

*[No, who are you?]
- <i>A look flashes across her face. Suprise? Betrayal?</i>

*[<i>Continue</i>]->named

=named
That's classified I'm afraid. <i>She taps the side of her nose.</i>
*{target} [No, I'm serious]
    And I have a reputation to uphold. You won't break me that easily.
        **[Fine. When do we move out?]->classified
*[Fine. When do we move out?]->classified

-(classified) Also classified. We're headed to the past though, I'm sure of it.
*[Solid guess]->mentionhim
*[The past? How?]->jumpamnesia

= mentionhim
That's where he was from. Figured if he's not here, he'd be back there...then... you know what I mean.
*[Who are you talking about?]
- You're right, we shouldn't be talking about it. It won't happen again.
*[Shouldn't have asked]
*[Tell me more]
- -> exit

= jumpamnesia
<i>Her eyes scan you rapidly.</i> Got some lingering jump amnesia? Should we send you back to HQ?
*[I'm fine]
*[I need a check up]
- Not sure anyone can even get there. We all seem to end up back here anytime we get compiled.
*[We're stuck?]
    -> exit

= exit
You'd better get to your loading bay. We can talk more after compilation.

*[<i>Leave</i>] ->warriorQuit

->DONE

= repeatStart
Still here?
+[Leave] ->warriorQuit

= scraps
- Although, truth be told, we all seem to end up just where we started everytime we get compiled.

*[We're stuck?]

- We're "ascending," if you believe GM's drivel. It's slow going. What I wouldn't give to take a peek inside some of those files. But I always compile too quickly.

*[I could check]

- See, I knew you had my back. You'd better get to your loading bay then.

*[<i>Leave</i>] ->warriorQuit

=== warrior_hitlist ===
Any luck finding our target list?

*[Needle in a haystack]
*[It's a mess in there]
- Ha, can't be worse than that time the three of us had to take out Kissinger's clone from 2095.
*[Any tips?]
- Did you try something like "Mission Objectives" or "Quest log"? Maybe "Boss Fights"?
*[Never saw those files]
- Then they must be deeper in the game code. I see you reappear after I finish compiling. How fast do you get compiled?
*[4 processes]
- Not complex enough. Hmm...see if this helps.
*[<i>Hold out your hand</i>]->warrior_trade.firstTrade

=resume
I know it's anchor, but don't get it wet, ok?

*[What does it do?]
- When I was coming up, we used these to jump back instantly, without all the energy needed to accelerate into the future. Of course, if you've got someone to open a portal back, not much use for these.
*[But I'm not time jumping]
- Sure, but it might still help conserve energy.
*[I guess]
- Come on, can't hurt to try.
*[I'll find those files]
- 10/4. <i>She salutes</i>
*[<i>Leave</i>] ->warriorQuit

->DONE

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

=firstTrade
{openTradeWindow()}
Go on, take it. You need it more than me.
+[<i>Back</i>]->backCheck

->DONE

=backCheck
{hasAnchor == "Player": {closeTradeWindow()}-> warrior_hitlist.resume}
{hasAnchor == "warrior": {closeTradeWindow()}->firstTrade}
-> DONE

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
