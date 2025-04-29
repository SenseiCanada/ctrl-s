INCLUDE inkVariables_GameFiles.ink
VAR giantSaveKnot = ""
VAR giantRunCount = -1



-> giant_enter

=== giant_enter ===
{ NPCID != "giant": 
    ~NPCID = "giant"
}
~NPCName = "Brall"


//check if we've already seen current dialogue
{ 
- runAttempts == giantRunCount: ->giant_fallback
-not giant_start: 
    -> giant_start
- else: ->giant_default
}
->DONE

=== giant_resume ===
-> giantSaveKnot

-> DONE

=== giant_start ===
{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}
~giantAffection = 0

{not giant_start.firstStart: ->firstStart}

= firstStart
You stopped to talk to Brall. You stopped. Maybe there's hope.

*[Hope for what?]
*[There was a <b>!</b> above you.]

- But might still be the Maker's plan after all.

*[The Maker?]

- Pulls strings. We are puppets. Pushes buttons. We are little somethings and nothings. Like dreaming and waking.

*[You make no sense]

- You stopped, but now you must go. We all go to dream as little somethings and nothings.

*[<i>Leave</i>]->giantQuit
    
    
=== giant_default ===

-> checkQuests

= checkQuests
//met enemy - triggered when you meet Will in the files for the first time
{
- askHunterQuest_g1 ? triggeredg1 && not learnEnemy_quest: ->learnEnemy_quest
//learned enemy wants hitlist
- askHunterQuest_g1 ? metObjectiveg1 && not learnEnemy_quest.conclude:->learnEnemy_quest.conclude
//qualify for cat quest?
- findCatQuest_g2 ? triggeredg2 && giantAffection >=1 && not catQuest: 
    ->catQuest
- hasCat == "Player":
    ->giant_foundCat
- hasCat == "giant" && not catQuest.catQuestEnd:
    -> catQuest.catQuestEnd
- else: ->checkReact
}

= checkReact

->checkRelationship

= checkRelationship
{
- giantAffection < 1: ->intro_filler
- giantAffection == 1: -> stage1_filler
- giantAffection == 2: -> stage2_filler
- else: -> giant_fallback
}

=== intro_filler ===
{->prophecies| ->enemies |->dreamwalking |->giant_fallback}

= prophecies
Did you find the third hunter while you were dreaming?

*[Who?]->hunter
*[I wasn't dreaming]

- (dreaming) And Brall doesn't like using many words. So Brall uses metaphors.

*[You mean compiling]
- Dreaming. Becoming little somethings and nothings. The Maker remaking us.
*{not hunter}[Who's the third hunter?]->hunter
*{hunter}[Third hunter might be dead]->end

- (hunter) Brall's ancestors wrote prophecies. Three hunters. Riding rivers heedless of the current. They have killed. Are killing. Will kill again.

*[Still haven't answered]
*[Who are the other two?]

- Brall is trapped here with two hunters. The third hunter used to wake here, like the rest of us. Now he is gone.

*[Maybe he's dead] ->end
*{not dreaming} [We're not dreaming] ->dreaming

- (end)
~learnedAboutHunter = true//triggers hunter showing up in files
Prophecies come to pass. Even if we ignore them. The third hunter has killed. Is killing. Will kill again.
*[<i>Leave</i>]->giantQuit

= enemies
Once more you come to Brall. Brall shouldn't be surprised. "Keep your enemies close." So says your kind.
*[We're not enemies] ->enemies_continue
*[What are you?]
- (enemies_identity) The heart of a mountain. The inhale before an earthquake. Your kind uses other words too.
*[What other words?]
*[Why do you say we're enemies?]->enemies_continue
- Titan. Giant. Monster. They are like naming a beach after a grain of sand.
*[Why should we be enemies?]->enemies_continue

- (enemies_continue) You are a hunter. You travel time like a river. Prophecy says you will unmake the army of my kin.
*[An army? Where?]
- Nowhere. It has not yet been made. The Maker has shaped only Brall.
*[Others like you in game?]
- No. Not yet.
*[Lonely?]
- You seek to exploit your enemy's weekness. Brall is rocks. Brall is little somethings and nothings. Brall cannot feel loneliness.
*[<i>Leave</i>]->giantQuit

= dreamwalking
Brall doesn't like the look of you.
*[Feeling's mutual]
*[At least you're easy on the eyes]
- Since you block the space before Brall's eyes, Brall demands something from you in return.
*[What do you want?]
*[I'll leave, point taken]
- How do you dreamwalk?
*[Dreamwalk?]
- When we all dream, when we become little somethings and nothings, Brall stays rooted. You do not. You dreamwalk.
*[How do you know?]->dream_conscious
*[I don't know how I "dreamwalk"]->dream_useless
-(dream_useless) You continue to take up space in front of Brall. Brall demands you have better answers next time.
*[How do you know I dreamwalk?]->dream_conscious
-(dream_conscious) Brall dreams, Brall does not die. Brall can see things, hear things, know things, even if Brall does not move or talk.
*[I could find you in there?]
~learnedBrallKey = true
- No. Brall is rooted in a locked room. You do not have the key.
*[<i>Leave</i>]->giantQuit

====giant_fallback===
{& Brall is done speaking. |<i>Nothing but stony silence.</i>}

+[Trade(Do not click if playtesting)]->giant_trade
+[Increase Rel (testing)] 
    ~giantAffection++
    ->giant_fallback
+{catQuest.catQuestEnd}[<i>Trade</>]->giant_trade
+[<i>Leave</i>]->giantQuit
->DONE

==== stage1_filler ===
{->game|->clouds|->tower|->giant_fallback}//->catQuest}

= game
Running. Always running.

*[Got places to be]
*[You should try it sometimes]

- Why bother? This is a game, and we can't play.

*[I'm going to fix that]

- Fix? Brall is not broken. But you might be. You and the other one.

*[What other one?]

- Brall is done talking. Go play.

*[<i>Leave</i>] ->giantQuit
    

= clouds
Too self-important. Head in clouds like.

*[I don't see any clouds]
    And you hear words, not meaning. Worst kind of look for a person
*[You're quick to judge]
    Brall is Brall. Brall is rocks. Brall is little somethings and nothings.

-*[I'm just trying to understand]
    You try, but we must do. Consider that.

- *[<i>Leave</i>] ->giantQuit
->DONE

= tower
Slow down. You'll knock it over.

*[Oh, sorry]
*[Knock what over?]

- Brall is building a tower.

*[I don't see a tower...]

- It is not for you to see. It is for Brall to build.

*[I'll leave you to it. <i>Leave</i>]->giantQuit
->DONE

=== stage2_filler ===
{->ask_Nova |->laughter | ->talked_robot | ->giant_fallback}

= ask_Nova
The other hunter, over there, what is her name?
*[Nova]->told_name
*[You've never asked?]->never_asked
- (never_asked) Brall has not. Brall has been to concerned with Brall. Too concerned with prophecy.
*[Better late than never]
*[Her name is Nova]->told_name
- (told_name) Nova. No-va. It feels like Mosspaws purring on Brall's lips. 
*[Isn't she your enemy?]
- Brall knows what part he must play. She knows it too. But we are not playing parts. Not yet.
*[Go talk to her]
- Brall... Brall is worried about being...Brall.
*[You can be prickly]
*[Just ask her something]
- Help me. Tell me... how to begin.
*[She likes poetry] ->suggested_poetry
*[She's a foody] ->suggested_food
*[Joke about authority]
-(suggested_poetry) Like prophecy, but...frivolous. Better. Like when Mosspaws naps on Brall's head.
*[There you go!]->thanks
-(suggested_food) Food. Brall does not eat. What enjoyment does she get from it?
*[Start by asking that]->thanks
-(suggested_joke) Brall does not joke. Laughing seems enjoyable however.
*[Ask her to tell you a joke]->thanks
-(thanks)I will head your council. Brall is...Brall is grateful.
[<i>Leave</i>]->giantQuit

= laughter
Second hunter Nova made Brall laugh.
*[What did she say?]
    She made noises like a landslide with her mouth. A very small landslide. Then she said that her commander made those sounds as he slept.
    **[We call that snoring]
        You name it? So this happens often?
        ***[Depends. You laughed?]->laugh_feel
*[How did it feel?]
-(laugh_feel) Like wind on a mountain and lava from a volcano.
*[Are those...good?]
- There are few things Brall loves more. But laughing is now one of them.
*[You're full of surprises]
- As are you. And Nova. Brall wishes he had discovered laughing sooner.
*[You're a softy]
- Brall is Brall. The craggy mountains belies the magma beneath it.
*[<i>Leave</i>]->giantQuit

= talked_robot
The robot did not make Brall laugh.
*[Not surprising]
*[I'm surprised]
- Brall enjoys using few words. The robot feels it must use too many words.
*[It's a zealot]
*[You could try using more]
- It is like a thirsty song-bird. The pool is beneath its claws, but all must hear its song. So it does not drink. Even as it sings about great thrist.
*[I think it's lonely]
*[It's just a robot]
- We are all little somethings and nothings. Brall finds that comforting. Brall had never considered others might find that frightening.
*[<i>Leave</i>]->giantQuit

=== learnEnemy_quest ===
You found him, the third hunter.
*[He's in the game files]
*[He sounds annoying]
- A nightmare. A dream walker. So the prophecies say.
*[He blocked off access]
*[He accelerated my compilation]
- The third hunter is a spider. Sucking the life from trapped flies.
*[How do I get passed him?]
- Brall is not your ally. You are a hunter as well, after all.
*[I could change your mind]
- Brall must think on this.
*[Some kind of exchange?]
- <i>Stone groans as the giant furrows his brow.</i> For now, find out what the spider wants. Why does he haunt the dreaming?
*[Talk to him again?]
*[I'd rather not]
~askHunterQuest_g1 += startedg1
- These are Brall's terms.
*[<i>Leave</i>]->giantQuit

= conclude//rough draft, not final!
What have you learned?

*[Hunter wants a hit list]

-A prophecy of death. Had he only asked Brall. I could tell him where those are written down.

*[Where?]

-<i>The giant lifts his arms. For the first time, you notice that his ribs are covered in swirling glyphs.</i>

*[That's the hit list?]

-These are the prophecies of Brall's ancestors. The foretell who will die, much like this hunter's list.

*[You're full of surprises]
*[Are you a prophet?]
~giantAffection++
~askHunterQuest_g1 += completedg1
- Brall is Brall. Brall is rocks. Brall is little somethings and nothings. And you... you are growing on Brall.
*[<i>Leave</i>]->giantQuit

->DONE

==== catQuest ===
You, you have small fingers. Scratch Brall's shoulder.

*[Rocks get itchy?]

- Brall didn't used to get itchy. Not with Mosspaws.

*[Who's Mosspaws?]

- Brall's kitty. Gone now.

*[I could look]
    ~findCatQuest_g2 += startedg2

- Brall may have misjudged you. She likes hiding where she can be warm. She is very, very small.

*[Thanks for the tip]

- Brall's shoulder still needs scratching.

*[<i>Scratch his shoulder</i>]
    //~giantAffection++
*[I'd rather not]

- Brall misses Mosspaws.

*[Leave]->giantQuit

->DONE

= catQuestEnd
Maybe Brall was wrong about you. You may be a hunter, but you can be kind. Leave Brall to Brall's thoughts.
*[Leave]->giantQuit

->DONE

    === giant_foundCat ===
Mosspaws?

+[I found her]->giant_trade

= reunited
~findCatQuest_g2 += completedg2
~giantAffection++
Brall's shoulder will no longer be itchy. Thank you.

+[<i>Leave</i>]->giantQuit

-> DONE

=== giant_trade === //trade
{hasCat != "Player": Want to trade?}
{hasCat == "Player": It's been so long!}

+[Yes]-> giant_trade.options
    
+[No]-> giant_fallback

=options
{openTradeWindow()}
Here's what Brall has.

+[Back]
    {closeTradeWindow()}
    {
    - hasCat != "giant": -> giant_fallback
    - hasCat == "giant" && not giant_foundCat.reunited: -> giant_foundCat.reunited
    - else: ->giant_fallback
    }
    

->DONE

=== giant_refuseItem ===
//{closeTradeWindow()}
Brall has no need.

+[Trade something else]->giant_trade.options
+[Back]{closeTradeWindow()} -> giant_enter

->DONE

=== giant_fragments ===
Brall doesn't like the look of you.

*[Feeling's mutual]
*[At least you're easy on the eyes]

- <i>Nothing but stony silence.</i>

*[<i>Leave</i>]->giantQuit

->DONE
->DONE

=== giantQuit ===
~giantRunCount = runAttempts //confirms we've been here before
~giantSaveKnot = ->giant_enter
    {quitDialogue()}
->DONE