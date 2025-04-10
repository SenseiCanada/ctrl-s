INCLUDE inkVariables_GameFiles.ink
EXTERNAL exitGameFiles()
EXTERNAL addCat()
EXTERNAL addList()
->enter

=== enter ===
~locationText = ""
~ runAttempts++
~ countTurns = false
//conditional logic to redirect
-> classes //eventually, only if you begin by talking with GM

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

=== denied === //redirect for errors

= class
Incompatible. Methods inherited from the wrong class. Change inheritance to continue.
+[>return_] ->home

= namespace
No definition found for "SentientPlayer." Are you missing a namespace?

+[>return_] ->home

=== home ===
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
- playerClass == "fileViewer": ->freeHome
- playerClass == "manager": ->restrictedHome
}

= rewind
Anchor detected. Returning through quantum tunnel.
+[>Continue_]->class_choice

= freeHome
~locationText = ""
Select a file to enter _  #flash

+[>Assets_] 
    ~countTurns = true
    ->assets
+[>Scripts_] 
    ~countTurns = true
    -> scripts
+[>Scenes_] 
    ~countTurns = true
    -> scenes


=restrictedHome
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
