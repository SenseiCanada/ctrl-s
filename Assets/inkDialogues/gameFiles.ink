INCLUDE inkVariables_GameFiles.ink
EXTERNAL exitGameFiles()
EXTERNAL addCat()

->enter

=== enter ===
~locationText = ""
~ runAttempts++
~ countTurns = false
//conditional logic to redirect
-> classes

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

Enter file directory?_

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
{runAttempts == 1: 
    ~playerClass = "fileViewer"
}
~countTurns = true
{
- playerClass == "fileViewer": ->freeHome
- playerClass == "manager": ->restrictedHome
}

= freeHome
~locationText = ""
Select a file to enter _  #flash

+[>Assets_] ->assets
+[>Scripts_] -> scripts
+[>Scenes_] -> scenes


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
//+[>Dialogues_] ->dialogues
+[>return_] ->home
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
+[>return_] ->scenes
*{startCatQuest == true}[>inspect_]->testLevel1_inspect

=testLevel1_inspect
Inside one of the rings is a small cat licking its paw.

+[>collect_]
    ~foundCat = true
    {addCat()}
    ->mosspaws
+[>return_]->testLevel1

= mosspaws
~foundCat = true
PlayerCharacter.collected(Mosspaws)
+[>return_]->testLevel1

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

=== dialogues ===
File empty.
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
=== function exitGameFiles===
    ~return
