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

{giant_start.firstStart: ->repeatStart}
{not giant_start.firstStart: ->firstStart}

= firstStart
Brall doesn't like the look of you.

*[Feeling's mutual]
*[At least you're easy on the eyes]

- <i>Nothing but stony silence.</i>

*[<i>Leave</i>]->giantQuit

->DONE

= repeatStart
Brall is done talking
- +[Leave]->giantQuit
    
=== giant_default ===

-> checkQuests

= checkQuests
//qualify for cat quest?
{ not catQuest && visitTestLevel == true: 
    ->catQuest
}
{
- hasCat == "Player":
    ->giant_foundCat
- hasCat == "giant":
    -> catQuest.catQuestEnd
- else: ->checkRelationship
}

= checkRelationship
{
- giantAffection < 1: -> stage0_filler
- else: -> giant_fallback
}

====giant_fallback===
Brall is done speaking.

+[Trade(Testing)]->giant_trade
+[Increase Rel (testing)] 
    ~giantAffection++
    ->giant_fallback
+[<i>Leave</i>]->giantQuit
->DONE

==== stage0_filler ===
{!->game|->clouds|->tower}//->catQuest}

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

==== catQuest ===
You, you have small fingers. Scratch Brall's shoulder.

*[Rocks get itchy?]

- Brall didn't used to get itchy. Not with Mosspaws.

*[Who's Mosspaws?]

- Brall's kitty. Gone now.

*[I could look]
    ~startCatQuest = true

- Brall may have misjudged you. She likes hiding where only she can fit. She's very, very small.

*[Thanks for the tip]

- Brall's shoulder still needs scratching.

*[<i>Scratch his shoulder</i>]
    ~giantAffection++
*[I'd rather not]

- Brall misses Mosspaws.

*[Leave]->giantQuit

->DONE

= catQuestEnd
Maybe Brall was wrong about you. <i>This is the end of Brall's story for this version of the demo. </i>

*[Leave]->giantQuit

->DONE

=== giant_foundCat ===
Mosspaws?

*[I found her]->giant_trade

= reunited
Brall's shoulder will no longer be itchy. Thank you.

*[Leave]->giantQuit

-> DONE

=== giant_trade === //trade
{hasCat != "Player": Want to trade?}
{hasCat == "Player": It's been so long!}


+[Yes]-> giant_trade.options
    
+[No]-> giant_start.repeatStart
    

=options
{openTradeWindow()}
Here's what Brall has.

+[Back]
    {
    - hasCat != "giant": -> giant_start.repeatStart
    - else: -> giant_foundCat.reunited
    }
    

->DONE

=== giant_refuseItem ===
//{closeTradeWindow()}
Brall has no need.

+[Trade something else]->giant_trade.options
+[Back]{closeTradeWindow()} -> giant_enter

->DONE


=== giantQuit ===
~giantRunCount = runAttempts //confirms we've been here before
~giantSaveKnot = ->giant_enter
    {quitDialogue()}
->DONE