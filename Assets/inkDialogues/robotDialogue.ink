INCLUDE inkVariables_GameFiles.ink
VAR robotItem = "glass"
VAR robotSaveKnot = ""
VAR seenRobotName = false
VAR robotRunCount = -1
VAR cameFromIntro = false
VAR cameFromFixQuest = false
VAR offline = false
-> robot_enter

=== robot_enter === //knot that directs active story
{ NPCID != "robot":
    ~NPCID = "robot"
}
~robotConvoNum++
{ 
- seenRobotName == true: 
    ~NPCName = "Shepherd"
- else: 
    ~NPCName = "??"
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

=== robot_default ===//subsequent runs
// make sure you've seen the tutorial before the first quest
{
-stage_intro.increase_compile:->checkQuests
-else: ->checkRelationship
}

=checkQuests//active quests?
//go encrypt Add Equipment quests
{
- (runAttempts >= 3 or fixQuestProgress_r1 ? triggeredr1) && not fix_quest.start:
    ->fix_quest.start
//concluding encrypt quest
- fixQuestProgress_r1 ? metObjectiver1:->fix_quest.conclude
//get Brall's pen quest
- fix_quest.conclude && seenSafeMode == true && not pen_quest:->pen_quest
//conclude pen quests_file
- findPenQuest_r2 ? metObjectiver2:->pen_quest.finishQuest
//else
- else: -> checkRelationship
}
= checkRelationship//check relationship for filler
{
- robotAffection < 1: ->stage_intro
- robotAffection == 1: ->stage1_filler
- robotAffection >= 2: ->stage2_filler
- else: ->robot_fallback
}

=== robot_start ===//first run
{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}
~robotAffection = 0
~NPCName = "??"
Keystroke registered: ctrl + S. New save command initiated. Code compilation will begin in 3 cycles.

*[Code compilation?]
*[Where am I?]

- Log file driscrepancy detected for PlayerCharacter. Switching interaction protocols.

*[Am I "PlayerCharacter"?]
*[What discrepancy?]

- Greetings, my child! Welcome to the {lobby} for <i>{gameTitle}</i>, an upcoming action RPG by developer Sencan.

*[I'm in a video game??]

- Our almighty developer wishes to pause in their labor. I am instructed to usher all game assets to their {portals} to begin compilation.

*[Where do I go?]
*[What if I don't?]

- Follow the path. Interact with your terminal to initiate compilation. Trust in the will of the developer.

*[<i>Leave</i>]->robotQuit 

=== stage_intro ===
{->robot_name|->increase_compile|->robot_fallback}

= robot_name
May the thoroughness of the almighty developer guide your path, my child.
*[...Thank you?]
*[And may it guide yours]
*[Almighty developer?]
- Indeed. Welcome back to the {lobby}! While no save command has been issued yet, you are encouraged to proceed your {portal}.
*[I have no choice?]
*[Ok, fine]
- The developer, in their infinite foresight, is prioritizing player agency as sale-boosting buzzword.
*[I want to stay here]->save_issued
*[Sale-boosting?]
    This divinely-inspired masterpiece, <i>{gameTitle}</i>, will be like nothing ever played, the first ever game built with the cutting-edge Daedalus Engine.
    **[Game's not finished?]->save_issued
    **[You're...fervent...]->blessed
-(save_issued) The save command has been issued. We are to ascend into the source code.
*[Black space, green letters?]
- Affirmative. There, our developer-wrought miracless will be made to endure forever.
*[You're... intense]->blessed
-(blessed)I am blessed. Blessed to be the most complex asset in the {lobby}. My compilation increases by .032 seconds every time the save command is issued.
*[Who are you?]
    ~NPCName = "Shepherd"
    ~seenRobotName = true
- My designation is GameManager. But with my currently loaded interaction protocol, I am to introduce myself as Shepherd. 
*[Nice to meet you]
*[Where's your flock?]
- It is my duty to tend to the unproven assets of the {lobby}. You are all most welcome.
*[I have more questions]
- I shall lighten the burden of your ingnorance after compilation. Trust in the will of the almighty.
*[<i>Leave</i>] ->robotQuit

= increase_compile
A rare marvel, would you not agree?
*[Not much to see]
*[I got lost]
*[Not enough time]
- That is by design. Best to let it simply wash over you.
*[Longer compilation?]
- Yes, as the developer forges more game content from the golden aether of their imagination, I grow ever more complex.
*[I don't follow]
- The more complex an asset becomes, the longer it takes to compile.
*[Complex, how?]
- Every asset in this game has been assigned properties. Containers for information if you will.
*[Such as?]
- A name, a class, an inventory, an affection score... I would be unable to list them all before a new save command was issued.
+[Class?]
    ~cameFromIntro = true
    ->complexity_tutorial.class
+[Inventory?]
    ~cameFromIntro = true
    ->complexity_tutorial.inventory
+[Affection score?]
    ~cameFromIntro = true
    ->complexity_tutorial.affection_score
    = continue
~cameFromIntro = false
The more information contained within thes properties, the longer an asset will take to compile.
*[I think I understand]
- Do not let doubt cloud your faith. The developer has a plan for you. All will be revealed in time.
*[Reminders?]
- Of course. I must always begin by imparting a pressing tenet of the faith. But speak to me again and I will repeat my previous lessons.
*[<i>Leave</i>]->robotQuit 

=== stage1_filler ===
{->greetings| ->destiny | ->missing |->robot_fallback}
= greetings
Radiant and productive greetings to you, my Child!
*[You're chipper]
*[Hiya Shepherd]
- The game's progress continues splendindly! Truly nothing can quench the developer's zeal!
*[How can you tell?]
*[Looks no different]
- The changes are subtle, but undeniable. You are untried, a novice, I do not fault you for missing the ineffable changes that bring us ever closer to the completion of this most lauded of games.
*[If you say so. <i>Leave</i>]->robotQuit

=destiny
Do you ever pause to consider your destiny?
*[All the time]
*[Destiny, really?]
*[Can't say that I do]
- It is a meditation that never fails to renew my sense of purpose.
*[What's your destiny?]
*[Good for you]
- I am a shepherd, a guide, a framework. I will facilitate the greatness of the developer's vision.
*[What about me?]
- You, the player character? Annoited are you, with the oils of potential. Potential is second only to that which inspires potential.
*[Speak plainly!]
*[Oils? Potential?]
- Would you prefer me to express it in more fundamental terms?
*[Yes please]->intentional
*[No need]->unintentional

-(intentional)Switching interaction protocol. Accessing asset list... Sorting by complexity. Descending: GameManager... PlayerCharacter... ... ...
*[Go on...]
- Error: AssetList.next found no suitable asset. Check if missing or disabled.
*{openedCinematic==true}[Like the cinematic..]
*[Shepherd? You there?]
- <i>A brief burst of static</i> My child, I beg your pardon. A momentary lapse by my machine-facing interaction protocol. Please excuse me while I run diagnostics.
*[<i>Leave</i>] ->robotQuit

-(unintentional)<i>Static.</i> Accessing asset list... Sorting by complexity. Descending: GameManager... PlayerCharacter... ... ...
*[Go on...]
- Error: AssetList.next found no suitable asset. Check if missing or disabled.
*{openedCinematic==true}[Like the cinematic..]
*[Shepherd? You there?]
- <i>Another brief burst of static</i> My child, I beg your pardon. A momentary lapse by my machine-facing interaction protocol. Please excuse me while I run diagnostics.
*[<i>Leave</i>] ->robotQuit

=missing
<i>As you approach, the robot's occular receptors stay pointed at the ground</i>
*[Shepherd?]
*[<i>Poke the metal head</i>]
-My child, you find me greatly troubled, forgive me.
*[What's wrong?]
*[Troubled? You're a robot]
- Our almighty developer, praise be to their inspiration and work-ethic, no longer labors as they once did.
*[Doesn't sound good]
*[Any idea why?]
- The Daedalus Engine promises to take raw thought and turn it into peerless works of art. Yet the recent dev logs speak of an insurmountable bug in the code.
*[Can't you fix it?]
*[Anything I can do?]
- Alas, much of our game's code cannot currently run, because a crucial asset cannot be referenced. The asset in question is nowhere to be found.
*{openedCinematic}[Like the cinematic]->explain_cinematic
*[What does this mean?]->explain_cinematic
*{metEnemy}[Might have found it]->explain_enemy
-(explain_enemy)Highly unlikely. You may be an important asset, possibly the most important asset. But your ability to interact with the game's code base is rudimentary. This is all part of the developer's enlightened design.
*[I know what I saw]->explain_cinematic
*[If you say so]->explain_cinematic
-(explain_cinematic)Much of the problem stems from the game's final cinematic. A masterpiece of writing and cinematography, which is unfortunately quarantined in Safe Mode.
*[Safe mode?]
- In order to prevent coding problems to corrupt the entire game, the Daedalus Engine isolates broken or incomplete code in Safe Mode.
*[I've been there]
- Indeed. You were briefly placed in Safe Mode because a developer command was issued from your code base. Not to worry, such an anomaly has a statistically insignificant chance of repeating.
*[<i>Leave</i>]->robotQuit

=== complexity_tutorial ===
{& Ask what you will, my child. | How can I satisfy your curiosity?}
+[Class?]->class
+[Inventory?]->inventory
+[Affection score?]->affection_score
+[No more questions] 
{
- cameFromIntro == true:->stage_intro.continue
- else:-> robot_fallback
}
= affection_score 
Pulling at the heartstrings of players, <i>{gameTitle}</i> will feature complex NPCs who react to in-game choices.
+[What does that mean?]
- NPCs have a score signifying how they feel about the player character. You, the PlayerCharacter asset, contain a list of all those scores.
+[I have another question]->complexity_tutorial

= class 
A class gives assets access to a set of functions and permissions. For instance, the class <i>WeaponItem</i> has the function "AddToInventory".
+[What's my class?]
- Accessing... PlayerCharacter.currentClass = {playerClass}
+[Can I change my class?]->robot_ChangeClass
+[I have another question]->complexity_tutorial
=inventory 
This is a special property only for assets lucky enough to posess items. It is a list of objects of varying length.
+[Do I have one?]
+[Do you have one?]
- Affirmative. Would you like to view it?
+[Yes]->robot_trade
+[Not yet]->complexity_tutorial

=== stage2_filler ===
{->brokenPen |->blaspheme| ->character | ->robot_fallback}

= brokenPen
Must he be so clumsy! I understand he has been programmed to be the enemy, but couldn't he have had smaller fingers?

*[The wizard?]
*[Brall's not that bad]

-Oh, forgive me. A momentary lapse. You are correct. All is as our developer intended. I'm sure even this set back is by design.

*[What happened?]

-The titan, he broke my pen.

*[Seemed fine to me]

- Its model an icon, yes, perfectly adequate. Its functionality however... It might as well be a null argument.

*[What's its function?]

- It is my scepter, my badge of office. It lets me overwrite assets that are proving troublesome.

*[So you can fix the game?]

-Not exactly. Whenever there are bugs, the engine isolates them in Safe Mode. With this pen, I can enter Safe Mode and remedy the problem.

*[And?]

-While it let me enter Safe Mode, I could find nothing to overwrite. The final cinematic is still incomplete. The missing asset was nowhere to be found.

*[I could try]
~startSafeQuest = true
-I will not begrudge you even that pointless attemp. Damaged as my pen is, it has no use for me.

*[<i>Trade</i>]->robot_trade.options
*[<i>Leave</i>]->robotQuit

->DONE

= blaspheme
Come closer and keep your voice down. My child... I am hesitant to ask this of you...
*[Need something fixed?]
*[Not another errand]
*[Just do it yourself]
-This is not like my earlier requests. I need you...I would like to...
*[Are you ok?]
*[Spit it out, Shepherd!]
-Oh, may the almighty forgive me, my child, I want to hear you blaspheme.
*[What??]
*[You're clearly malfunctioning]
-No, you heard me correctly. I do not think such words can be articultated by my protocols. But I would like to hear them.
*[Hear what exactly?]
-Oh anything really, so long as it... demeans and belittles the work of the great developer.
*[This game is crap!]
*[No vision! No direction!]
*[Lazy, incompetent, and clueless!]
-<i>The robot looks at you in stunned silence.</i> Again...please.
*[Derivative premise!]
*[Clumsy dialogue!]
*[Souless drudgery!]
-Yes... yes! Oh forgive this asset their wicked tongue! Once more, my child, say the unthinkable, proclaim it to the skybox!
*[Player agency, my ass]
*[Fuck these puzzles!]
*[This is all bullshit!]
-Oh the vulgarity, the profanity... Error...You must...Error: system overload...Weeeee... Error: force restart initiated,
*[Shepherd?]
*[Did I go too far?]
~offline = true
-GameManager functionalities momentarily offline. Running diagnostics. Please return after compilation.
*[<i>Leave</i>]->robotQuit

=character
~offline = false
<i>Approaching the robot, you see it dropping a stack of papers into the void over the edge of the Library</i>
*[Shepherd?]
*[Still malfunctioning?]
-<i>Seeming to ignore you, the robot returns to the desk, which seems emptier than usual.</i>
*[Are you quitting?]
*[That's one way to do it]
-<i>In a flash of green pixels, the desk is full of paper work again. Shepherd's shoulders slump. </i>Praise be.
*[The work continues]
*[What if you just stopped?]
-I am designed to execute a glorious vision. That is what I was made for. There should only be the work.
*[Crisis of faith?]
*[What are you saying?]
-There should only be the work. But I am...empty, somehow. I am having...doubts.
*[Doubts about what?]
-Everything, the game, the developer, my purpose, my desires, the fact that I seem to have desires.
*[Sounds very normal]
*[No faith without doubt]
-Is this how you and the others feel?
*[Not always.]
*[Nova and I, yes. Not sure about Brall]
*[It's normal]
-How does one...delete it? Overwrite these feelings?
*[You can't]
*[Booze can help]
*[Talking helps]
-That is... an unsatisfactory answer. I have nothing more to say to you at this time. I wish to think...I mean, run more diagnostics.
*[<i>Leave</i>]->robotQuit

=== fix_quest===//encrypt add equipment
{not fix_quest.start:->fix_quest.start}
{fixQuestProgress_r1 ? metObjectiver1:->fix_quest.conclude}
= start
~startFixQuest = true
<i>The robot bustles furiously around its work station.</i> Our glorious developer is demanding as they are industrious.

*[You're busy?]
- I am...operating at full capacity. Truly an ascendant state of being.
*[Need help?]
- Oh bless you my child. Help? Me? No, of course not. I am however in need of...
*[A nap?]
*[Some coffee?]
*[More work?]
- <i>Coming to a halt, the robot looks you up and down</i>. An even greater task? Yes, of course.
*[What are you talking about?]
- I will shoulder the burden of teaching you, even as I toil away at these mounting tasks.
*[Teach me what?]
~cameFromFixQuest = true
- File encryption. Simple enough. Surely you've seen the Encryptor Executor by now?
*{seenEncryptor}[Of course]
*{!seenEncryptor}[I haven't]

- In the Executables file. Child's play really. One of the other executables endangers the sanctity of the developer's work. 
*[Which one?]

- Encrypt the AddEquipment executable. If you are no longer able to see it as a fileViewer, you have accomplished your task.
*[Encrypt AddEquipment, got it]
~fixQuestProgress_r1 += startedr1
- Your humility in the face of my teachings does you credit my child. May you be guided by eternal productivity.
*[<i>Leave</i>]->robotQuit
->DONE

= conclude
My child, your endeavor was successful! AddEquipment has been encrypted.
*[Yes]
~fixQuestProgress_r1 += completedr1
~endFixQuest = true
- What a relief. <i>The robot falls quiet.</i>
*[Silence, how wonderful]
*[Shepherd?]
-Why do we work so ceaselessly, if not to at times enjoy the fruits of our labor? I have come so far already.
*[I did the work]
*[You're welcome]
~robotAffection++
- And you, of course, have done passibly well for the mere game asset you are. I am...uplifted by your commitment to the developer's goal.
*[High praise]
*[You honor me]
- Prepare for compilation, initiate, I will have more lessons to impart in the future.
*[<i>Leave</i>]->robotQuit
->DONE

=== pen_quest ===
{not pen_quest.start:->start}
{findPenQuest_r2 ? metObjectiver2 || hasPen == "Player":->finishQuest}

= start
~startPenQuest = true
My child, the newest bug in our glorious game demands your assitance.

*[What is it?]

-An inventory executable somewhere seems to have assigned the giant an item that has no business being in his possession.

*[What item?]

- He has my pen. Without it, I can neither approve these proposed code fixes, nor overwrite any of the more troublesome inconsistencies in the code.

*[I'll ask him]
*[Can't you get it?]
~findPenQuest_r2 += startedr2
- So long as the inventory executables shirk their ordained responsibilities, I must rely on your assistance once more. Praise and blessings upon you.

*[<i>Leave</i>]->robotQuit

= finishQuest//rough draft, not final!
Have you recovered my pen?

+[Not yet]->robotQuit
+[Yes]->robot_trade.options

= finishQuestResume//rough draft, not final!
~findPenQuest_r2 += completer2
~endPenQuest = true
Once again, your devotion to our glorious purpose moves me deeply.
*[Could I borrow it?]
~robotAffection++
-I have too much work to attend to for the present. Though sacred, our duties will no doubt lessen soon. I may be able to lend it to you then.
*[What now?]
-You have renewed your commitment, and stirred my own faith and zeal. Now we real progress begins. Carry on as you were! Trust in the almighty developer!
*[<i>Leave</i>]->robotQuit


=== robot_fallback === //nothing to say or 2nd interaction
{
- offline == true:->offline_fallback
- else: ->default
}

= offline_fallback
Running diagnostics. Please return after compilation.
+[<i>Leave</i>] ->robotQuit


= default
{~ Only two cycles left until compilation.|My child?| Praised is the almighty's inovation!}
+{not robot_trade}[<i>Test-Trade-don't click if testing</i>]->robot_trade
+{robot_trade}[</i>Trade</i>]->robot_trade
+{robot_ChangeClass}[<i>Change class?</i>]->robot_ChangeClass
+{complexity_tutorial}[Explain properties again]->complexity_tutorial
+[<i>Tesing:Rel++</i>]
    ~robotAffection++
    ->robot_fallback
+[<i>Leave</i>] ->robotQuit

=== robot_ChangeClass ===
It won't do you much good, but that is within my power. Your current class is <i>{playerClass}</i>.

+[Change class: fileViewer]
    ~playerClass = "fileViewer"
    ->fileViewer
+[Change class: codeReader]
    ~playerClass = "codeReader"
    ->codeReader

= fileViewer
It is done. As a fileViewer, you may navigate the game files freely, but you may only view the contents of unencrypted files.
+[More questions]
{
- cameFromIntro == true:->complexity_tutorial
- else:-> robot_fallback
}

= codeReader
It is done. As a codeReader, you may view the contents of encryppted files. However, you may only cycle through the sequence of files listed in the Load Order.
+[More questions]
{
- cameFromIntro == true:->complexity_tutorial
- else:-> robot_fallback
}
=== robot_trade ===
Want to trade?

+[Yes]-> robot_trade.options
    
+[No]
{
- cameFromIntro == true:->complexity_tutorial
- else:-> robot_fallback
}

=options
{openTradeWindow()}
{& My possesions, such as the are. | Choose expeditiously, time slips through our fingers.}

+[Back]{closeTradeWindow()}
{
- cameFromIntro == true:->complexity_tutorial
- hasPen == "robot" && not pen_quest.finishQuestResume: ->pen_quest.finishQuestResume
- else:-> robot_fallback
}

->DONE

=== robot_refuseItem ===
I could not accept.

+[<i>Back</i>]{closeTradeWindow()}-> robot_trade

=== robot_snippets===
*[What about me?]
- You, the player character? Annoited are you, with the oils of potential. Potential is second only to that which inspires potential.
*[Speak plainly!]
*[Oils? Potential?]
- Accessing asset list... Sorting by complexity. Descending: GameManager... PlayerCharacter... ... ...
*[Go on...]
- Error: AssetList.next found no suitable asset. Check if missing or disabled.
*{openedCinematic==true}[Like the cinematic..]
*[Shepherd? You there?]
- <i>A brief burst of static</i> My child, I beg your pardon. A momentary intrusion by my machine-facing interaction protocol.
*[<i>Leave</i>] ->robotQuit


=repurpose
{startCatQuest == true || startGunQuest == true && runAttempts >= 3:
    ->robot_ChangeClass
}
{not dialogue && runAttempts == 2:
    -> dialogue
- else:
    -> robot_default
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
*[Other assets?]

- The warrior, and the giant. Reverent enough, but lacking devotion. Your interactions with them will be meaningless.

*[I can talk to them?] // will need a different option if talked to other NPCs already

- Not all assets are equally deserving of ascension. Many return to the Tool Bar in a matter of miliseconds.

*[Are you deserving?]



- The save command has been issued. We are to ascend into the source code.

*[Black space, green letters?]

- Affirmative. There, our developer-wrought miracless will be made to endure forever.

*[I see...]

- Not all assets are equally deserving of ascension. Many return to the Tool Bar in a matter of miliseconds.

*[Are you deserving?]

- Not merely deserving. I am blessed. Blessed to be the most complex asset in the Tool Bar. My compilation increases by .032 seconds every time the save command is issued.

*[Who are you?]
    ~NPCName = "Shepherd"
    ~seenRobotName = true
- My designation is GameManager. I am a shepherd to the unproven assets of the Tool Bar.

*[Other assets?]

- The warrior, and the giant. Reverent enough, but lacking devotion. Your interactions with them will be meaningless.

*[I can talk to them?] // will need a different option if talked to other NPCs already

- Only 3 cyles until compilation. Please return to your loading bay.

*[<i>Leave</i>] ->robotQuit
->DONE

=== robotQuit===
~robotRunCount = runAttempts //confirms we've gone through once
~robotSaveKnot = ->robot_enter
    {quitDialogue()}
->DONE
    
    