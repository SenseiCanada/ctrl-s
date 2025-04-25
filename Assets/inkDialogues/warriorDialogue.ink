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
~NPCName = "??"
To your station, now!
*[Station?]
*[Why was there a <b>!</b> above you?]

- The gate behind you. Come find me after the machine beams you back.

*[What machine?]
*[I will]
- Go, go, go!
*[<i>Leave</i>]->warriorQuit

=== warrior_default === //subsequent runs

->checkQuests//first check if there are any active quests

= checkQuests 
//qualify for hitlist?
{
- not warrior_hitlist && runAttempts >= 4: ->warrior_hitlist
- warrior_hitlist && hasList == "Player" && hitQuestComplete == false: -> warrior_hitlist.endQuest
//qualify for weapon quest?
- discoveredNoGun == true && weaponQuestComplete = false:
    -> warrior_weapon.weaponless
- warrior_hitlist.endQuest && not warrior_weapon && warriorAffection >= 2: 
    ->warrior_weapon //this will trigger before any filler

//no quests? check relationship
- else: -> checkRelationship
}

= checkRelationship// then check relationship for filler
{
- warriorAffection < 1: ->stage_intro
- warriorAffection == 1: ->stage1_filler
- warriorAffection == 2: ->stage2_filler
- else : ->warrior_fallback
}

=== stage_intro ===
{->first |->second |->last|->warrior_fallback}

=first
Knew you'd pull through.

*[I hated that]
*[Wasn't so bad]

- Kinda like when my first SO didn't know what to do with us anymore. Stuck staring at plastiglass targets until he came back with new orders.

*[Why can't I interact with anything]

- What, like the cubes and stuff? Beats me. But hey, least we can still chat between the stupid save commands.

*[Seems like prison]
*[Why am I back?]

- Everything's still a work in progress. You, me, this library, or whatever the robot is calling this place.  

*[So what now?]

- Hustle and wait for orders. Same as always.

*[<i>Leave</i>]->warriorQuit

=second
Remember the mission to Frontenac? 1200s, I'm pretty sure, because Europeans were finally using zeros.
*[Yeah, totally]
*[No..I can't]
- It's ok, I'm not judging. Hell, if a whole castle fell on me, I'd gladly lose some memories if it meant I could get back up the next day.
*[A whole castle?]
- Our mark was digging a secret escape tunnel under the keep. Tunnel collapsed right when we got there, under the castle foundations. We thought you were a goner.
*[Was this part of the game?]
-</i>She frowns.</i> I remember it happening. The dust. The screams. And I remember you talking to me before last compilation. So it has to be, right?
*[You seem unsure]
- My logic is sound, ok? Plus, I might compile pretty fast, but I've still poked around some in the game files.
*[What have you found?]
- A scene with the location tag "France-medieval". Frontenac is in France. But every time I try to go deeper, my compilation completes and I'm back here.
*[I'm having the same experience]

- Hey, what's one more shot in the dark? Tell me what you find this time around.
*[<i>Leave</i>]->warriorQuit

=last
You still got my back?
*[Yes...]
- That's good to hear. Really good to hear.

*{seenNovaName == true}[Are you the Nova Warrior?]
    ~NPCName = "Nova"
    ->named
*{seenNovaName == false}[Who...?]->target

=target
Our new target. Unclear. Directives are in the game files, but too deep for me to find. My money's on rocky horror over there though. //add alternative text if spoken/not spoken to Brall and GM before

*[No, who are you?]
- <i>A look flashes across her face. Suprise? Betrayal?</i>

*[<i>Continue</i>]->named

=named
That's classified I'm afraid. <i>She taps the side of her nose.</i>
*{target} [No, I'm serious]
    And I have a reputation to uphold. You won't break me that easily.
        **[Fine. When do we move out?]->classified
*[Fine. When do we move out?]->classified

-(classified) Also classified. We're headed to the past though, I'm sure of it. That's where he was from after all.
*[Frontenac again?]->mentionhim
*[The past? How?]->jumpamnesia

= mentionhim
No, he wouldn't go there. But if he's not here, he'd be back then, at least.
*[Who are you talking about?]
- You're right, we shouldn't be talking about it. It won't happen again.
*[Shouldn't have asked]
*[Tell me more]
- -> exit

= jumpamnesia
<i>Her eyes scan you rapidly.</i> Got some lingering amnesia? Should we send you back to HQ?
*[I'm fine]
*[I need a check up]
- Not sure anyone can even get there. We all seem to end up back here anytime we get compiled.
*[So we're actually stuck?]
    -> exit

= exit
Probably some bug in the system. Get to your {portal}. We can talk more after compilation.
*[<i>Leave</i>]->warriorQuit

=== stage1_filler ===
{->food |->workout|->purpose|->warrior_fallback}
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

=== stage2_filler===
{->stare |->anger |->depressed |->warrior_fallback}

= stare
<i>Nova stares past you as you approach her.</i>
*[Penny for your thoughts?]
- I had a lisp when I was a kid. And I stuttered. No big deal. Speech therapist was a pro.
*[<i>Stay silent</i>]
*[Why are you telling me this?]
- Everyone was chill about it at school. Except this litte brat, Denis. I was super smart for my age. Just took me longer to get things out. Denis was probably jealous, or something.
*[He made fun of you?]
*[Kids are the worst]
- Without fail, every time I raised my hand, he'd mimmick what I was trying to say. Only loud enough for his friends and me to hear. They'd all cover their mouths, but I still could see them laughing.
*[What did you do?]
*[That's awful]
- I hit him a few times. Nothing changed. I used to be pretty scrawny.
*[Hard to imagine]
*[No one else intervened?]
One day in class, I stood up, picked up my chair, and swung it at the little twerp's head.
*[He deserved it]
*[Your chair?]
- I don't think he was seriously hurt. Got picked up by HQ almost immediately after. Said I would be an incredible asset.
*[I agree with them]
*[That's messed up]
- Even afterwards, I knew I should feel bad. But in the moment, it felt...euphoric... Gripping the chair legs, feeling its momentum. I was in control. I had the power.
*[This is about your weapon, right?]
- You'll find something. I'm sure about it. Just keep digging through those files.
*[<i>Leave</i>]->warriorQuit

= anger
Not right now. <i>She clenches and unclenches her fists. Her breath huffs in and out</i> Leave me... alone.
*[Ok. <i>Leave</i>]->warriorQuit
*[You alright?]
    No. I want to break something. Hurt someone. I'm stuck in place. Nothing within arms reach. Except you.
    **[Get a grip!] ->angerContinues
    **[Slowly back away. <i>Leave</i>]->warriorQuit

-(angerContinues) No! I'm done. I'm sick and tired of being told what to do. My chest is on fire. I want to let it out! Out! <i>She lashes out with a fist.</i>
*[<i>Let her hit you</i>]
    ~NPCName = ""
    <i>Pain flashes across your jawline. Your head spins. Nova's ouline glows white hot.</i>
    **[<i>Try to focus</i>]->glow
*[<i>Try to evade</i>]
    ~NPCName = ""
    <i>You step clear of the punch just in time. Nova's body radiates a burning white light</i>
    **[<i>Try to focus</i>]->glow

- (glow)~NPCName = "Nova" 
<i>The white light pulses rapidly a few times, then slows, almost like a heartbeat.</i>

*[Nova?]
*[You're glowing]
~seenNovaGlow = true
- <i>The light around Nova flickers, then is gone </i> Just go. Please.

*[<i>Leave</i>]->warriorQuit

= depressed
Still came to talk? I'm surprised.
*[Got your back, remember]
*[For everyone else's safety]
- Good for you. I mean really. You care. You're such a saint. That's just... wow.
*[Nova, I'm worried]
*[You were violent]
- I know my limits. My fists. My body. All I am is limits. What can we hope to achieve with those?
*[We'll figure it out]
*[So you're just gonna mope?]
- Stop, just stop. This is where we're at right now. I've almost convinced myself of that. Stages of grief and all that.
*[About that white light?]
- Kick them while they're down while your at it. Another failure.
*[What do you mean?]
- {timeCorp} wanted elite volunteers. Best and brightest. I signed up. Let them pump me full of performance enhancers, measure my vitals while jumped off buildings and punched through walls.
*[Super-soldiers?]
- That's what it seemed like. Except, I couln't handle it. My body didn't react well to the drugs. I always needed more to perform like the others. Eventually they cut me. Just another name crossed off a ledger.
*[So you don't have abilities?]
- My chest burns when I'm angry and I turn into a human flare. I'm sure the forces of evil are quaking in their boots.
*[You're a friend]
*[Your an ally]
*[You're a partner]

- Ha, doens't feel like it right now.

*[<i>Leave</i>]->warriorQuit

->DONE

=== warrior_hitlist ===//first quest
{hasList == "Player": ->endQuest}
Any luck finding our target list?
*[Needle in a haystack]
*[It's a mess in there]
- Ha, can't be worse than that time the three of us had to take out Kissinger's clone from 2095.
*[Any tips?]
- Did you try something like "Mission Objectives" or "Quest log"? Maybe "Boss Fights"?
*[Never saw those files]
- Then they must be deeper in the game code. Or maybe they're encrypted. I see you reappear after I finish compiling. How fast do you get compiled?
*[Too fast]
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
~hitQuestComplete = true
~warriorAffection++
<i>For the first time, a smile lifts her lips. Then she regains her stoic demeanor.</i>
+[Good news?]
+[You're welcome]
- I have all these memories, instincts, but I'm always either here, or blinking through code compilation. Been feeling like a hamster on a wheel.
*[You wanted orders]
*[You needed purpose]
- I think I was looking for a promise. That there was more coming. That there's a plan.
*[Trust in the hamster wheel]
*[Told you I got your back]
- <i>She punches your shoulder playfully</i>. Save command's been issued. See you after compilation.
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
~weaponQuestComplete = true
- No, no that can't be possible!
*[I'm so sorry]
~warriorAffection++
- Can it. I don't need this right now.
*[Leave] ->warriorQuit
->DONE

=== warrior_fallback === //nothing to say or 2nd interaction
{&Still here?|Need something?}
+{not warrior_trade.firstTrade}[<i>Testing-trade-do not click if testing</i>]->warrior_trade
+{warrior_trade.firstTrade}[<i>Trade</i>]->warrior_trade
+[<i>Leave</i>] ->warriorQuit
->DONE

=== warrior_trade === //trade
{& Want to trade? | What do you need?}

+[Yes]-> warrior_trade.options
    
+[No]-> warrior_fallback
    

=options
{openTradeWindow()}
{& Here's what I have. | As long as I can have it back.}

+[Back]{closeTradeWindow()}-> warrior_fallback
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

=== warrior_snippets ===


= scraps
- Although, truth be told, we all seem to end up just where we started everytime we get compiled.

*[We're stuck?]

- We're "ascending," if you believe GM's drivel. It's slow going. What I wouldn't give to take a peek inside some of those files. But I always compile too quickly.

*[I could check]

- See, I knew you had my back. You'd better get to your loading bay then.

*[<i>Leave</i>] ->warriorQuit

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
