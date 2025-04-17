INCLUDE inkVariables_GameFiles.ink
LIST startFilesTargeted = (assetsTarget), (scriptsTarget), (scenesTarget)
EXTERNAL exitGameFiles()
EXTERNAL addCat()
EXTERNAL addList()
EXTERNAL takeTwoTurns()

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

=== target_check ===
~startFilesTargeted = LIST_RANDOM(startFilesTargeted)
->enter

=== enemy_home ===//redirect logic for interacting with enemy
//state checks
~locationText = "??"
~turns++
~turns++//check how to make two processes load

{
- not enemy_first: ->enemy_first
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

- <color=red>Desist in this foolishness. You have no idea what's at stake.:</color>

*[>return?_]
    {takeTwoTurns()}
    ->home

->DONE

=== enemy_fallback ===
~countTurns = false
<color=red>Caught once again. You're slipping.</color>

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
Select a file to enter _  #flash

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

+[>Models_] ->models
+[>Animations_] ->animations
+[>QuestLog_] ->quests
+[>return?_] ->home
->END

=== scripts ===
~locationText = "scripts"
Protection :: Public

+[>open: LoadOrder.script_]->loadOrder

= loadOrder
~locationText = "scripts/LoadOrder"
gameManager.script> characters.script > weapons.script >

+[>return_] ->home

=== scenes ===
~locationText = "scenes"

Select a file to enter _

+[>MainMenu_] ->mainMenu
+[>TestLevel1_] ->testLevel1
+[>GameOver_] ->gameOver
+[>return_] ->home

=mainMenu
~locationText = "scenes/MainMenu"
Only three buttons so far. None of them work.
+[>return_] ->scenes

=testLevel1
~locationText = "testLevel1"
~visitTestLevel = true
A flat plane with several small rings floating above the ground.

*{startCatQuest == true}[>inspect_]->testLevel1_inspect
+[>return?_] ->scenes

=testLevel1_inspect
Inside one of the rings is a small cat licking its paw.

+[>collect_]
    ~hasCat = "Player"
    {addCat()}
    ->mosspaws
+[>return?_]->testLevel1

= mosspaws
PlayerCharacter.collected(Mosspaws)
+[>return?_]->testLevel1

->DONE

=gameOver
~locationText = "gameOver"
Crushed beneath the sole of giants.
+[>return_] ->scenes

=== models ===
{playerClass != "NPC":-> denied.class}
~locationText = "Assets/Models"

There will be more models soon.
+[>return_] ->assets
->END

=== animations ===
File empty.
+[>return_] ->home
->END

=== quests ===
~locationText = "Assets/QuestLog"

+[>MainCampaign_]->mainCampaign
+[>TimeHits_]->timeHits
//+[SideQuests]
+[>return?_] -> home
->END

=mainCampaign
~locationText = "Assets/Quests/MainCampaign"
File empty.

Dev log: The Twin Emperors rally a force of space titans to destroy {timeCorp} and its agents. The agency sends time-traveling assassins back and forward in time to find the {crux}, the one person who will prevent the Twin Emperors plans from ever coming to fruition.

+[>return?_] -> home
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

=== blank_knot ===
~locationText = ""
~countTurns = true
Please wait. Refreshing file navigation.

->DONE