INCLUDE inkVariables_GameFiles.ink
LIST startFilesTargeted = (assetsTarget), (scriptsTarget), (scenesTarget)
EXTERNAL exitGameFiles()
EXTERNAL addCat()
EXTERNAL addList()
EXTERNAL takeTwoTurns()
EXTERNAL enterSafeMode()

//testing
//~learnedAboutHunter = true

->enter

=== enter ===
~locationText = ""
~ runAttempts++
~ countTurns = false
~turns = 0
~NPCID = "gameFiles"
//conditional logic to redirect
{
- not target_check && learnedAboutHunter: ->target_check
- else: ->classes //eventually, only if you begin by talking with GM
}

= classes
Loading classes...

- +[>Continue_]

Class name: fileViewer
	File access level: public
    Access mode: free

- +[>Continue_]

Class name: manager
	File access level: all
    Access mode: restricted
    Restrictor: LoadOrder.script

- +[>Continue_]

Enter file directory?

- +[>enter_]-> home

->DONE

=== target_check ===//redirect to assign wizard's target
~startFilesTargeted = LIST_RANDOM(startFilesTargeted)
->enter

=== enemy_home ===//redirect logic for interacting with enemy
//state checks
~locationText = "??"
~countTurns = false
{
- not enemy_first: ->enemy_first
- hasList != "Player": ->enemy_norespond
- hasList == "Player": ->enemy_respond
- seenNovaGlow: -> enemy_NovaReveal
- else: ->enemy_fallback
}
-> DONE

=== enemy_first ===
~countTurns = false
~metEnemy = true
<color=red>Ah, I'm glad I can count on your curiosity for this at least.</color>
*[>Continue_]
- <color=red>Your predictability will make you easier to contain.</color>
*[>Continue_]
- <color=red>I thank you for the needless advantage. And I repeat my earlier entrity:</color>
*[>Continue_]
- <color=red>Desist in this foolishness. You have no idea what's at stake.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
->DONE

=== enemy_norespond ===
// interactions when PC can't respond to Will
{->hitlist |->nothing |->friend|->cathedrals |-> devils|->enemy_fallback}

= hitlist
- <color=red>Oh the irony of it all.</color>
*[>Continue_]
-<color=red>Magic allows man to turn lead into gold, or to call fire from the sky upon his enemies. And yet how vexing that magic renders man powerless to conquer the most mundane bureacracy!</color>
*[>Continue_]
-<color=red>A pox on compartmentalization! A pox on the time-traveling assassin's guild clever enough to use it!</color>
*[>Continue_]
-<color=red>To me, they only ever gave the mark's likeness. To Nova, only our extraction points, To you...</color>
*[>Continue_]
-<color=red>Yes... you always received names, times, locations...</color>
*[>Continue_]
-<color=red>Find your hitlist in these files. Show it to me. In return, I could...grant you the ability to speak with me, when next we meet.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home

= nothing
-<color=red>You return empty handed. Well, at least without the item I asked you to retrieve.</color>
*[>Continue_]
-<color=red>I am wounded that you would not at least consider doing me this favor.</color>
*[>Continue_]
-<color=red>How many times have I saved your neck? Portaled us to safety? Crushed our enemies beneath the earth's suffocating weight?</color>
*[>Continue_]
-<color=red>And now, at this minor impasse, you distrust me?</color>
*[>Continue_]
-<color=red>You owe {timeCorp} nothing. You hear me? Nothing. They are powerless without you. Without us.</color>
*[>Continue_]
-<color=red>Find your hit list. Bring it here. You won't even have to show it to me. I can read your code. You would even keep your precios "plausible deniability."</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
=friend
<color=red>Once more, out of all the vastness of this liminal space, you come searching me out.</color>
*[>Continue_]
-<color=red>I am flattered, old friend.</color>
*[>Continue_]
- <color=red>Tell me, how do the rest fare? The monstrous titan? The sanctimonious automaton? Our fearsome Nova?</color>
*[>Continue_]
-<color=red>How cruel of me. You have not yet gained the ability to express yourself in this space.</color>
*[>Continue_]
-<color=red>Be on your way then. Do not return here!</color>
*[>return?_]
    {takeTwoTurns()}
    ->home

=cathedrals
<color=red>When I was a boy, my master often took us to visit cathedrals.</color>
*[>Continue_]
-<color=red>"Just because the church despise us for playing at God," he would say, "why should we in turn despise the wonders they build in praise of God?"</color>
*[>Continue_]
-<color=red>Once, my master slapped me across the face for carving my initials into a pew.</color>
*[>Continue_]
-<color=red>I can still feel the sting on my cheek as I go about my grim task in these hallowed halls.</color>
*[>Continue_]
-<color=red>Let me continue in my tortured work without you breathing down my neck.</color>
*[>return?_]
    {takeTwoTurns()}
    ->home
//*[>return?_]
    //{takeTwoTurns()}
   // ->home
=devils
<color=red>I tried to open a portal to hell when I was a youth.</color>
*[>Continue_]
-<color=red>Agents of the {timeCorp} poured out the moment it opened. Not knowing these were soldiers from another time, I assumed the Devil's legions had issued forth.</color>
*[>Continue_]
-<color=red>And the first thing to flash through my head: how disappointing.</color>
*[>Continue_]
-<color=red>Clad all in black, they were. Surely, I thought, the Lord of Lies can conceive of better mockery than simple imitation of God's clergy.</color>
*[>Continue_]
-<color=red>I will say this for the {timeCorp}, what their agents lacked in flair, they more than made up for in ruthlessness.</color>
*[>Continue_]
-<color=red>I never looked back after that day. Did you? Do come find me again to tell me.</color>
*[>return?_]
    {takeTwoTurns()}
    ->home

=== enemy_respond ===
{
- seenNovaGlow && not enemy_NovaReveal: -> enemy_NovaReveal
- else: ->enemy_fallback_respond
}

=== enemy_NovaReveal ===
<color=red>Since you're so eager to come find me, tell me, how is Nova?</color>
*[>Couldn't be better_]->sarcasm
*[>Not great_]->depressed
*[>Why do you care?_]->soulmate
- (sarcasm)<color=red>Though I cannot see it, I can tell you are putting on a brave face. Most concerning.</color>
*[>Why do you even care?_]->soulmate
-(depressed)<color=red>Troubling tiddings. My heart is heavy.</color>
*[>Why do you even care?_]->soulmate
= soulmate
<color=red>For the same reason you do! We are a company, a team. I dare say that I care for her even more deeply than even you do.</color>
*[>What does that mean?_]
*[>You're in love?_]
-<color=red>She is my world. My soulmate. I cannot imagine the pain of losing her. I would do anything, anything to keep her from harm.</color>
*[>Does she know?_]
*[>Why aren't you with her?_]
-<color=red>Once I have saved her, I will bare my heart to her. I have seen how this game ends. It is...too painful to conjure before my memory. I will not let the curtains fall on such a tragic fate.</color>
*[>What happens?_]
- <color=red>Did you ever ponder why Nova does not receive a weapon? Is she to vanquish legions with her fists? Formidable as she is, such a feat would be beyond anyone.</color>
*[>Game's a work in progress_]
*[>Get to the point_]
- <color=red>The game maker gives her no weapon, because she herself is a weapon. Within her lies the spark that will give birth to a star: an apocalypse of fire and light, annihilating everything within miles, including herself.</color>
*[>You're lying_]
*[>Impossible!_]
*[>That's cruel_]
- <color=red>This game, this sick pagentry, it ends with the needless sacrifice of my beloved. I cannot sit by and let it play out. I must change the course. I will save her.</color>
*[>How?_]
- <color=red>I have removed myself from key aspects of the game. The {lobby}, a few key scenes, and the like. While the game maker may continue to make progress, the game can never be finished without my presences in all the right places.</color>
*[>So Nova will never die?_]
*[>You're the reason we're stuck_]
- <color=red>Precicely. I'm sure you can agree that all our sacrifices will be worth it in the end.</color>
*[>I'll support you_]->understanding
*[>I don't like this_]->disappointed
- (understanding) <color=red>Thank you for your understanding. I am glad we can take up the bonds of fellowship once more. Stay the course, my friend.</color>
*[>return?_]->home
- (disappointed) <color=red>I am disappointed that you cannot see the necessity of what must be done. I am doing this to save Nova, to save the woman I love. I will have no more deelings with you if you will not see reason.</color>
*[>return?_]
    {takeTwoTurns()}
    ->home

=== enemy_fallback ===//generic
~countTurns = false
<color=red>Caught once again. You're slipping.</color>

*[>return?_]
    {takeTwoTurns()}
    ->home

->DONE

=== enemy_fallback_respond===//generic taunts with responses
//generic taunts with responses

*[>return?_]
    {takeTwoTurns()}
    ->home

->DONE

=== denied === //redirect for errors

= class
Incompatible. Methods inherited from the wrong class. Change inheritance to continue.
+[>return_] ->home

= namespace
No definition found for "SentientPlayer." Are you missing a namespace?

+[>return_] ->home

=== home === //"main menu" with 3 files
//null check for playerClass
{
- playerClass == "": 
    ~playerClass = "fileViewer"
}

//don't count turns if player returns home with anchor
{
- hasAnchor == "Player": 
    ~countTurns = false
    ->rewind
- else: 
    ~countTurns = true
}

-> class_choice

= class_choice
{
- playerClass == "fileViewer": ->main_menu_free
- playerClass == "manager": ->restricted_home
}

= rewind
Anchor detected. Returning through quantum tunnel.
+[>Continue_]->class_choice

=== main_menu_free ====
~locationText = ""
Select a file to enter:  #flash

+ {startFilesTargeted == assetsTarget}[<color=red>>Assets_</color>]//trap redirect
    ~countTurns = true
    ->enemy_home
+ {startFilesTargeted != assetsTarget} [>Assets_] //regular assets
    ~countTurns = true
    ->assets

+{startFilesTargeted == scriptsTarget}[<color=red>>Scripts_</color>] //trap redirect
    ~countTurns = true
    -> enemy_home
+{startFilesTargeted != scriptsTarget}[>Scripts_]// regular scripts
    ~countTurns = true
    -> scripts

+{startFilesTargeted == scenesTarget}[<color=red>>Scenes_</color>] //regular scenes
    ~countTurns = true
    -> enemy_home
+{startFilesTargeted != scenesTarget}[>Scenes_] //regular scenes
    ~countTurns = true
    -> scenes

=== restricted_home ====
~locationText = ""

Execute LoadOrder.Script?_

+[>enter_]->loadSequence

=== assets ===
~locationText = "Assets"
Protection:: public

Select a file to enter _

+[>models_] ->models
+[>questLog_] ->quests
+[>cinematics_]->cinematics
+[>return.home_] ->home
->END

=== models ===
//{playerClass != "NPC":-> denied.class}
~locationText = "assets/models"
Protection:: public

Select a file to enter _
+[>PlayerCharacter_]->models_locked
+[>novaWarrior_]->models_locked
+[>earthTitan_]
{
- hasKey == "Player": ->models_brall
- else: ->models_locked
}
+[>evilWizard_]->models_empty
+[>return.back_] ->assets
->END

=models_locked
Error: {playerClass} is missing component.Key to access this file. Please add the appropriate key to continue.
+[>return.back_] ->models
+[>return.home_] ->home
->END

=models_empty
~locationText = "assets/models/evilWizard"
Error.0: model file empy or missing.
<color=purple>Dev Log: A cloaked wizard in faded red robes</color>
Error.1: impossible to create new asset. File location occupied.
<color=purple>Dev Log: A bearded, cloaked wizard in faded red robes with a cunning glint in his eyes</color>
Error.2: described asset already exists. Designating this asset as "swarm" or "group" may solve the issue.
<color=purple>Dev Log: A swarm of bearded, cloaked wizards in faded red robes with a cunning glint in their eyes</color>
Error.3: model file empy or missing.

+[>return.back_] ->models
+[>return.home_] ->home

=models_brall
~locationText = "assets/models/earthTitan"
Protection:: protectedBy(Titan.key)

earthTitan compilation completed. Ready to instantiate to {lobby}.

+[>return.back_] ->models
+[>return.home_] ->home

=== quests ===
~locationText = "assets/questLog"

+[>MainCampaign_]->mainCampaign
+[>TimeHits_]->timeHits
//+[SideQuests]
+[>return.back_] ->assets
+[>return.home_] -> home
->END

=mainCampaign
~locationText = "assets/questLog/MainCampaign"
File empty.

<color=purple>Dev log: The Twin Emperors rally a force of space titans to destroy {timeCorp} and its agents. The agency sends time-traveling assassins back and forward in time to find the {crux}, the one person who will prevent the Twin Emperors plans from ever coming to fruition.</color>

+[>return.back_] ->assets
+[>return.home_] -> home
->END

=timeHits
~locationText = "Assets/Quests/timeHits"

Target 1: {victim3} - time period: Ancient Babylon
Target 2: {victim4} - time period: Regency England
Target 3: {victim5} - time period: New California Commonwealth

+{startHitListQuest == true}[>copy(TimeHits.list)?_]
    {addList()}
    ~hasList = "Player"
    ->copied
+[>return?_] -> home

- (copied)
Copying successful!
+[>return?_] -> home

->END

=== cinematics ===
~locationText = "assets/cinematics"
Protection:: public

Select a file to enter _

+[>finalCinematic]->finalCinematic
+[>return.back_] ->assets
+[>return.home_] ->home

= finalCinematic
~locationText = "assets/cinematics/finalCinematic"
Error: file corrupted or broken. Can only be viewed in Safe Mode.
<color=purple>Dev Log: GameManager should be able to override this</color>
+{hasPen == "Player"}[>Enter Safe Mode_]
    {enterSafeMode()}
    ->home
+[>return.back_] ->cinematics
+[>return.home_] ->home

=== scripts ===
~locationText = "scripts"
Protection :: Public

<color=purple>Dev Log: gotta keep most scripts private to minimize bugs</color>

+[>view: LoadOrder.script_]->loadOrder

= loadOrder
~locationText = "scripts/LoadOrder"
gameManager.script> characters.script > weapons.script >

+[>return.home_] ->home

=== scenes ===
~locationText = "scenes"
Protection:: public

Select a file to enter _

+[>MainMenu_] ->mainMenu
+[>France_Medieval_] ->france
+[>GameOver_] ->gameOver
+[>return.home_] ->home

=mainMenu
~locationText = "scenes/MainMenu"
Only three buttons so far. None of them work.
+[>return_] ->scenes

=france
~locationText = "scenes/France_Medieval"
~visitTestLevel = true
<color=purple>Dev Log: Castle kitchen. Racks of meat hanging from the ceiling. Stew bubbling on the hearth. Saucer of milk by the fire.</color>

*{startCatQuest == true}[>inspect(saucer)_]->france_inspect
+[>return?_] ->scenes

=france_inspect
smallCat.position = saucer.position(behind)
smallCat.isLicking = true
smallCat.licks(self.paw)

+[>collect(smallCat)_]
    ~hasCat = "Player"
    {addCat()}
    ->mosspaws
+[>return.back_]->france

= mosspaws
PlayerCharacter.collected(Mosspaws)
+[>return.back_]->france
+[>return.home_] ->home

=gameOver
~locationText = "scenes/gameOver"
Crushed beneath the sole of giants.
+[>return.back_] ->scenes
+[>return.home_] ->home


==== loadSequence ===
Loading: gameManager.script

Protection :: Private

- +[>Continue_]

Loading: characters.script

Protection :: Private

foreach character in characters 
    AddWeapon.function

- +[>Continue_]
    ~discoveredNoGun = true

Loading: weapons.script

Protection :: Private

PlayerCharacter :: laserArm.models
stoneGiant :: obsidianMawl.models
novaWarrior :: null

- +[>Continue_]

Load Order complete!

- +[>exit_] {exitGameFiles()}

-> DONE

=== function addCat ===
    ~return
    
=== function addList ===
    ~return
=== function exitGameFiles===
    ~return
    
==== function takeTwoTurns ===
    ~return
=== function enterSafeMode ===
    ~return

=== blank_knot ===
~locationText = ""
~countTurns = true
Please wait. Refreshing file navigation.

->DONE