INCLUDE inkVariables_GameFiles.ink
VAR warriorSaveKnot = ""
VAR warriorRunCount = -1

-> warrior_enter

=== warrior_resume===//where save picks up
-> warriorSaveKnot

=== warrior_enter ===
~NPCID = "warrior"
{
-seenNovaName:
    ~NPCName = "Nova"
- else:
    ~NPCName = "??"
}
//check if runAttempts has changed = have we seen this before
{
- runAttempts == warriorRunCount: ->warrior_fallback //yes, go fallback
- - not warrior_start: ->warrior_start
- else: ->warrior_default
}

->DONE

=== warrior_start === //first run
~warriorAffection = 0 //define variables before knot navigation
//add any items warrior starts with
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

*{seenNovaName == true}[Are you the Nova Warrior?]
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

*[<i>Leave</i>]->warriorQuit

->DONE

= repeatStart
Still here?
+[Leave]
    ~warriorSaveKnot = ->repeatStart
    {quitDialogue()}

->DONE

= scraps
- Although, truth be told, we all seem to end up just where we started everytime we get compiled.

*[We're stuck?]

- We're "ascending," if you believe GM's drivel. It's slow going. What I wouldn't give to take a peek inside some of those files. But I always compile too quickly.

*[I could check]

- See, I knew you had my back. You'd better get to your loading bay then.

*[<i>Leave</i>] ->warriorQuit

=== warrior_hitlist ===//first quest
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
    ~startHitListQuest = true
- 10/4. <i>She salutes</i>
*[<i>Leave</i>] ->warriorQuit

->DONE

= endQuest
We still flying blind?

+[I found the list!]->warrior_trade.listTrade
->DONE

= endQuestResume
~startHitListQuest = false
~warriorAffection++
<i>For the first time, a smile lifts her lips. Then she regains her stoic demeanor.</i>
*[Good news?]
*[You're welcome]
- I have all these memories, instincts, but I'm always either here, or blinking through code compilation. Been feeling like a hamster on a wheel.
*[You wanted orders]
*[You needed purpose]
- I think I was looking for a promise. That there was more coming. That there's a plan.
*[Trust in the hamster wheel]
*[Told you I got your back]
- <i>She punches your shoulder playfully</i>. Save command's been issued. See you after compilation.
*[<i>Leave</i>]->warriorQuit

->DONE

=== warrior_default === //subsequent runs

->checkQuests

= checkQuests //first check if there are any active quests
//qualify for hitlist?
{
- not warrior_hitlist && runAttempts >= 4: ->warrior_hitlist
- warrior_hitlist && hasList == "Player": -> warrior_hitlist.endQuest
//qualify for weapon quest?
- discoveredNoGun == true:
    -> warrior_weapon.weaponless
- warrior_hitlist.endQuest && not warrior_weapon && warriorAffection >= 2: 
    ->warrior_weapon

//no quests? check relationship
- else: -> checkRelationship
}

= checkRelationship// then check relationship for filler
{
- warriorAffection < 1: ->stage0_filler
- else : ->warrior_fallback
}

=== stage0_filler ===
{!->food |->workout|->purpose|->warrior_fallback}
= food
If you were in charge of {timeCorp}, how would you boost recruitment?
*[Officers Training program]
*[Better dental]
*[Intra-mural softball league]
- Ha. Cute. Know what I'd do? Taco Tuesdays in the canteen.
*[My idea's better]
*[For recruitment? Really?]
- I'm telling you, we'd have ship-loads of recruits docking at HQ every kilosecond.
*[Just for tacos?]
- I forget you're from a time with lots of cows. 
*[I take it you're not]
- Think about it. {timeCorp} goes back and recruits you. They send us back for hits. You're telling me they haven't gone back for some steak and cheese?
*[Never thought of it]
*[Sounds like you're hungry]
- Taco Tuesdays. HQ could at least do that much for the troops...
*[<i>Leave</i>]->warriorQuit

=workout
You should join me for my workout some time.
*[Yeah, sure]
*[I have my own routine]
- Only thing that makes pumping iron in Zero-Grav worth it.
*[What's that?]
- Not doing it alone. A spotter out here isn't to keep you getting crushed by the weights. They're keeping you from being crushed by your thoughts.
*[Going soft?]
*[Need a psych eval?]
-Calm down, I just need a gym buddy. Let me know, yeah?
*[<i>Leave</i>]->warriorQuit

->DONE

=purpose
You know that whole thing about killing Hitler as a baby?
*[Would you do it?] ->purpose_continue
*[Who's Hitler?]
    Seriously? I know you're from cowboy times, but common! Were you asleep during all of basic training?
    **[Hitler, oh sure] ->purpose_continue
-(purpose_continue)
~NPCName = "Nova"
When I was recruited, O'brien asked to me, "Nova, what if you could do it when he was in college? Or when he was running for election?"
*[I would do it]
*[Don't see the difference]
- That's why I agreed to work for {timeCorp}. A different approach. A smart approach. Principled. A hope for a better future.
*[That's honorable]
*[A bit cliched, no?]
- I'm just a soldier. I take orders, I do my job well. Helps that I'm doing it for the right reasons.
*[<i>Leave</i>]->warriorQuit 

->DONE

==== warrior_weapon ===//weapon quest
<i>She punches you</i>
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

= findWeapon //start weapon quest
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

= badNews
Best news I've had all day. Alright, what are we talking? Blaster? Sniper riffle? Something old fashioned? You know, I think I could really dig an axe.
*[Nothing, you don't get a weapon]
- No, no that can't be possible!
*[I'm so sorry]
- Can it. I don't need this right now. <i>End of Nova's story in current build</i>
*[Leave] ->warriorQuit

    

->DONE//second quest

=== warrior_fallback === //nothing to say or 2nd interaction
Need something?
+{warrior_trade.firstTrade}[<i>Trade</i>]->warrior_trade
+[<i>Leave</i>] ->warriorQuit
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
+[<i>Back</i>]->anchorBackCheck

->DONE

=listTrade
{openTradeWindow()}
Let me see it!
+[<i>Back</i>]->listBackCheck

->DONE

=anchorBackCheck
{hasAnchor == "Player": {closeTradeWindow()}-> warrior_hitlist.resume}
{hasAnchor == "warrior": {closeTradeWindow()}->firstTrade}
-> DONE

=listBackCheck
{hasList == "warrior": {closeTradeWindow()}-> warrior_hitlist.endQuestResume}
{hasList == "Player": {closeTradeWindow()}->listTrade}

->DONE
=== warriorQuit ===
~warriorRunCount = runAttempts //basically: we've gone through once
~warriorSaveKnot = ->warrior_enter
    {quitDialogue()}
->DONE

=== warrior_refuseItem ===
You'll need it more than me.

+[Trade something else]->warrior_trade.options
+[Back]{closeTradeWindow()} -> warrior_enter

->DONE
