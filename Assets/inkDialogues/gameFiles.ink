INCLUDE inkVariables_GameFiles.ink
INCLUDE fileProtectionLogic.ink
INCLUDE enemyDialogue_GameFiles.ink
EXTERNAL exitGameFiles()
EXTERNAL addCat()
EXTERNAL addList()
EXTERNAL enterSafeMode()
//list of enemy file targets
LIST startFilesTargeted = (assetsTarget), (scriptsTarget), (scenesTarget)

//TESTING
//~learnedAboutHunter = true
//~playerClass = "codeReader"

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
	File access level: decrypted
    Access mode: free

- +[>Continue_]

Class name: codeReader
	File access level: encrypted
    Access mode: restricted
    Restrictor: ExecutableSequence.exe

- +[>Continue_]

Enter file directory?

- +[>enter_]-> home

->DONE

=== target_check ===//redirect to assign wizard's target
~startFilesTargeted = LIST_RANDOM(startFilesTargeted)
->enter

=== home === //fork for fiewer or reader
//null check for playerClass
{
- playerClass == "": 
    ~playerClass = "fileViewer"
}

//don't count turns if player returns home with anchor
{
- hasAnchor == "Player" && TURNS_SINCE(->enter.classes) <=1: 
    ~countTurns = false
    ->rewind
- else: 
    ~countTurns = true
}

-> class_choice

= class_choice
{
- playerClass == "fileViewer": ->main_menu_free
- playerClass == "codeReader": ->restricted_home
}

= rewind
Anchor detected. Returning through quantum tunnel.
+[>Continue_]->class_choice

=== main_menu_free ====
~locationText = ""
Encryption :: Universal
<color=purple>Dev Log: universal files can't be encrypted</color>
Select a file to enter:

+ {startFilesTargeted == assetsTarget}[<color=red>>Assets_</color>]//trap redirect
    ~countTurns = true
    ->enemy_home
+ {startFilesTargeted != assetsTarget} [>Assets_] //regular assets
    ~countTurns = true
    ->assets_file

+{startFilesTargeted == scenesTarget}[<color=red>>Scenes_</color>] //regular scenes
    ~countTurns = true
    -> enemy_home
+{startFilesTargeted != scenesTarget}[>Scenes_] //regular scenes
    ~countTurns = true
    -> scenes_file

+{startFilesTargeted == scriptsTarget}[<color=red>>Executables_</color>] //trap redirect
    ~countTurns = true
    -> enemy_home
+{startFilesTargeted != scriptsTarget}[>Executables_]// regular scripts
    ~countTurns = true
    -> executables_file

=== restricted_home ====
~locationText = ""

Run ExecutableSequence.exe?

+[>OK_]->run_load_order

=== assets_file ===//ASSETS
~locationText = "Assets"
Protection:: Universal

Select a file to enter:

+{showIfPublic(models)}[>models_] ->models_file
+{showIfPublic(quests)}[>questLog_] ->quests_file
+{showIfPublic(cinematics)}[>cinematics_]->cinematics_file
+[>return.home_] ->home
->END

    === models_file ===//MODELS
~locationText = "assets/models"
Protection:: {printProtection(models)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
models_file
- ->->
=public
~seenNovaName = true
Select a file to enter:
+{showIfPublic(player)}[>PlayerCharacter_]->playerCharacter_file
+{showIfPublic(warrior)}[>novaWarrior_]->warrior_file
+{showIfPublic(giant)}[>earthTitan_]
{
- hasKey == "Player": ->giant_file
- else: ->models_giant_locked
}
+{showIfPublic(wizard)}[>evilWizard_]->wizard_file
+[>return.back_] ->assets_file
->END

        === playerCharacter_file ===
~locationText = "assets/models/playercharacter"
Protection:: {printProtection(player)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
Error: playerCharacter_file missing or disabled. Skipping...
- ->->
=public
ErrorError: playerCharacter_file missing or disabled.
+[>return.back_] ->models_file
+[>return.home_] ->home

        ====models_giant_locked===
Error: {playerClass} is missing component.Key to access this file. Please add the appropriate key to continue.
+[>return.back_] ->models_file
+[>return.home_] ->home
->END

        ====wizard_file===
~locationText = "assets/models/evilWizard"
Protection:: {printProtection(wizard)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
Error: evilWizard_file missing or disabled. Skipping...
- ->->
=public
Error.0: model file empy or missing.
<color=purple>Dev Log: A cloaked wizard in faded red robes</color>
Error.1: impossible to create new asset. File location occupied.
<color=purple>Dev Log: A bearded, cloaked wizard in faded red robes with a cunning glint in his eyes</color>
Error.2: described asset already exists. Designating this asset as "swarm" or "group" may solve the issue.
<color=purple>Dev Log: A swarm of bearded, cloaked wizards in faded red robes with a cunning glint in their eyes</color>
Error.3: model file empy or missing.
<color=purple>Dev Log: oh common!</color>

+[>return.back_] ->models_file
+[>return.home_] ->home

        ====giant_file===
~locationText = "assets/models/earthTitan"
Protection:: {printProtection(giant)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
reloading earthTitan...Complete
- ->->
=public
<color=purple>Dev Log: monstrous humanoid made entirely of rock, part of the Twin Emperors' Legion</color>
+[>return.back_] ->models_file
+[>return.home_] ->home

        === warrior_file ===
~locationText = "assets/models/novawarrior"
Protection:: {printProtection(warrior)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
reloading novaWarrior...Complete
- ->->
=public
<color=purple>Dev Log: futuristic soldier with a dark secret</color>
+[>return.back_] ->models_file
+[>return.home_] ->home

    === quests_file ===//QUESTLOG
~locationText = "assets/questLog"
Protection:: {printProtection(quests)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
quests_file
- ->->
=public
Select a file to enter _
+[>MainCampaign_]->campaign_file
+[>TimeHits_]->hits_file
//+[SideQuests]
+[>return.back_] ->assets_file
+[>return.home_] -> home

        ====campaign_file===
~locationText = "assets/questlog/maincampaign"
Protection:: {printProtection(campaign)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
mainCampaign_file
- ->->
=public
<color=purple>Dev log: The Twin Emperors rally a force of space titans to destroy {timeCorp} and its agents. The agency sends time-traveling assassins back and forward in time to find the {crux}, the one person who will prevent the Twin Emperors plans from ever coming to fruition.</color>

+[>return.back_] ->assets_file
+[>return.home_] -> home
->END

        ====hits_file===
~locationText = "Assets/Quests/timehits"
Protection:: {printProtection(hits)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
timeHits_file
- ->->
=public
Target 1: {victim3} - time period: Ancient Babylon
Target 2: {victim4} - time period: Regency England
Target 3: {victim5} - time period: New California Commonwealth

+{startHitListQuest == true}[>copy(TimeHits.list)?_]
    {addList()}
    ~hasList = "Player"
    ->copied
+[>return.back_] ->assets_file
+[>return.home_] -> home

- (copied)
Copying successful!
+[>return.back_] ->hits_file
+[>return.home_] -> home

->END

    === cinematics_file ===//CINEMATICS
~locationText = "assets/cinematics"
Protection:: {printProtection(cinematics)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
cinematics_file
- ->->
=public
Select a file to enter _
+[>finalCinematic]->finalCinematic
+[>return.back_] ->assets_file
+[>return.home_] ->home

= finalCinematic
~locationText = "assets/cinematics/finalCinematic"
Error: file corrupted or broken. Can only be viewed in Safe Mode.
<color=purple>Dev Log: GameManager should be able to override this</color>
+{hasPen == "Player"}[>Enter Safe Mode_]
    {enterSafeMode()}
    ->home
+[>return.back_] ->cinematics_file
+[>return.home_] ->home

=== scenes_file ===//SCENES
~locationText = "scenes"
Protection:: Universal

Select a file to enter _

+{showIfPublic(mainMenu)}[>MainMenu_] ->mainMenu_file
+{showIfPublic(france)}[>France_Medieval_] ->france_file
+{showIfPublic(gameOver)}[>GameOver_] ->gameOver_file
+[>return.home_] ->home

    === mainMenu_file ===
~locationText = "scenes/mainmenu"
Protection:: {printProtection(mainMenu)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
Create(Button.play)
Create(Button.settings)
Create(Button.quit)
- ->->
=public
<color=purple>Dev Log: buttons for play, settings, and quit. Should be enough for now.
+[>return_] ->scenes_file

    === france_file ===
~locationText = "scenes/france_medieval"
Protection:: {printProtection(france)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
loading scene.Medieval_France
- ->->
=public
~ findCatQuest_g2 = triggeredg2//triggers one of cat quests conditions
<color=purple>Dev Log: Castle kitchen. Racks of meat hanging from the ceiling. Stew bubbling on the hearth. Saucer of milk by the fire.</color>
*{findCatQuest_g2 == startedg2}[>inspect(saucer)_]->france_inspect//maybe change it so you have to load actors first
+[>return?_] ->scenes_file

=france_inspect
smallCat.position = saucer.position(behind)
smallCat.isLicking = true
smallCat.licks(self.paw)

+[>collect(smallCat)_]
    ~findCatQuest_g2 = metObjectiveg2
    ~hasCat = "Player"
    {addCat()}
    ->mosspaws
+[>return.back_]->france_file

= mosspaws
PlayerCharacter.collected(Mosspaws)
+[>return.back_]->france_file
+[>return.home_] ->home

    === gameOver_file ===
~locationText = "scenes/gameover"
Protection:: {printProtection(gameOver)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
= private
loading scene.GameOver...
- ->->
=public
<color=purple>Dev Log: Crushed beneath the sole of the Titans...</color>
+[>return.back_] ->scenes_file
+[>return.home_] ->home

=== executables_file ===//EXECUTABLES
~locationText = "executables"
Protection :: Universal

<color=purple>Dev Log: gotta keep most executables encrypted to minimize bugs</color>

+{showIfPublic(addActors)}[>view: addActors.exe_]->add_actors_file
+{showIfPublic(addEquipment)}[>view: addEquiment.exe_]->add_equipment_file
+[>run: Encryptor.exe_]->encryptor_file
+[>run: Decryptor.exe_]
    {hasWrench =="Player":->decryptor_file}
    {hasWrench !="Player":->decryptor_permission}
+[>view: ExecutableSequence.exe_]->view_load_order
+[>return.home_] ->home

    ===view_load_order ===//must include all files
~locationText = "executables/executablesequence.exe"
File protection :: Universal
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
=private
- ->->
=public
//must include all files
//re-order sequence to make sense with gameplay, ie executables act after scenes
ExecutableSequence: 
    {showIfPublic(models) == false:models>}
    {showIfPublic(models) == false && showIfPublic(player) == false:playerCharacter>}
    {showIfPublic(models) == false && showIfPublic(warrior) == false:novaWarrior>}
    {showIfPublic(models) == false && showIfPublic(giant) == false:earthTitan>}
    {showIfPublic(models) == false && showIfPublic(wizard) == false:evilWizard>}
    {showIfPublic(quests) == false:questLog>}
    {showIfPublic(quests) == false && showIfPublic(campaign):mainCampaign>}
    {showIfPublic(quests) == false && showIfPublic(hits):timeHits>}
    {showIfPublic(addActors) == false: addActors>}
    {showIfPublic(addEquipment) == false: addEquipment>}
    {showIfPublic(mainMenu) == false: mainMenu>}
    {showIfPublic(france) == false: franceMedieval>}
    {showIfPublic(gameOver) == false: gameOver>}
+[>return.back_]->executables_file
+[>return.home_] ->home

    === add_actors_file ===
~locationText = "executables/addactors.exe"
Protection :: {printProtection(addActors)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
=private
~discoveredNoGun = true
foreach actor run.addWeapon.exe
PlayerCharacter :: models.Revolver
earthTitan :: models.ObsidianMawl
actor(missing) :: models.battleStaff
novaWarrior :: null
- ->->
=public
<color=purple>Dev Log: adds appropriate actors to scenes. Code hidden when decrypted to minimize bugs.
+[>return.back_]->executables_file
+[>return.home_] ->home

    === add_equipment_file ===
{fixQuestProgress_r1 != completedr1: 
    ~fixQuestProgress_r1 = triggeredr1
}
~locationText = "executables/addequipment.exe"
Protection :: {printProtection(addEquipment)}
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
=private
- ->->
=public
<color=purple>Dev Log: adds appropriate equipment to actors. Code hidden when decrypted to minimize bugs.
+[>return.back_]->executables_file
+[>return.home_] ->home

    === encryptor_file ===//need to add all files here/needs to contain everything that exeSeq does
~seenEncryptor = true
~locationText = "executables/encryptor"
~countTurns = true
{fixQuestProgress_r1 != completedr1: 
    ~fixQuestProgress_r1 = triggeredr1
}
Protection :: Universal
Select file to encrypt:

//assets
+{showIfPublic(models)}[>Encrypt models file_]
    {lockFile(models)}
    ->lock_confirm
    +{showIfPublic(models)&&showIfPublic(player)}[>Encrypt PlayerCharater file_]
        {lockFile(player)}
        ->lock_confirm
    +{showIfPublic(models)&&showIfPublic(warrior)}[>Encrypt novaWarrior file_]
        {lockFile(warrior)}
        ->lock_confirm
    +{showIfPublic(models)&&showIfPublic(giant)}[>Encrypt earthTitan file_]
        {lockFile(giant)}
        ->lock_confirm
    +{showIfPublic(models)&&showIfPublic(wizard)}[>Encrypt evilWizard file_]
        {lockFile(wizard)}
        ->lock_confirm
+{showIfPublic(quests)}[>Encrypt questLog file_]
    {lockFile(quests)}
    ->lock_confirm
    +{showIfPublic(quests)&&showIfPublic(campaign)}[>Encrypt mainCampaign file_]
        {lockFile(campaign)}
        ->lock_confirm
        +{showIfPublic(quests)&&showIfPublic(hits)}[>Encrypt timeHits file_]
        {lockFile(hits)}
        ->lock_confirm

//scenes
+{showIfPublic(mainMenu)}[>Encrypt MainMenu file_]
    {lockFile(mainMenu)}
    ->lock_confirm
+{showIfPublic(france)}[>Encrypt Frace_Mediveal file_]
    {lockFile(france)}
    ->lock_confirm 
+{showIfPublic(gameOver)}[>Encrypt GameOver file_]
    {lockFile(gameOver)}
    ->lock_confirm
//executables
+{showIfPublic(addActors)}[>Encrypt addActors.exe_]
    {lockFile(addActors)}
    ->lock_confirm
    
+{showIfPublic(addEquipment)}[>Encrypt addEquipment.exe_]
    ->check_add_equiptment_requirements
    

+[>return.back_]->executables_file
+[>return.home_] ->home

        === check_add_equiptment_requirements ====
{ 
- fixQuestProgress_r1 == startedr1:
    ~fixQuestProgress_r1 = metObjectiver1
    {lockFile(addActors)}
    ->lock_confirm
- else: ->error
}
= error
Error: encryption must first be authorized by GameManager.
+[>return.back_]->encryptor_file
+[>return.home_] ->home

    === decryptor_file ===//need to add all files here/needs to contain everything that exeSeq does
~locationText = "executables/decryptor"
~countTurns = true
Protection :: Universal
{
-TURNS_SINCE(->redirect_file_knot) == 0:->private
- else:->public
}
=private
decrypting files...
- ->->
=public
{playerClass}.hasCypher = true
Select file to decrypt: //everything needs to be ! of decryptor, including "un"-lock

//assets
+{!showIfPublic(models)}[>Decrypt models file]
    {unlockFile(models)}
    ->unlock_confirm
    +{!showIfPublic(models)&&!showIfPublic(player)}[>Decrypt PlayerCharater file_]
        {unlockFile(player)}
        ->unlock_confirm
    +{!showIfPublic(models)&&!showIfPublic(warrior)}[>Decrypt novaWarrior file_]
        {unlockFile(warrior)}
        ->unlock_confirm
    +{!showIfPublic(models)&&!showIfPublic(giant)}[>Decrypt earthTitan file_]
        {unlockFile(giant)}
        ->unlock_confirm
    +{!showIfPublic(models)&&!showIfPublic(wizard)}[>Decrypt evilWizard file_]
        {unlockFile(wizard)}
        ->unlock_confirm
+{!showIfPublic(quests)}[>Decrypt questLog file]
    {unlockFile(quests)}
    ->unlock_confirm
    +{!showIfPublic(quests)&&!showIfPublic(campaign)}[>Decrypt mainCampaign file_]
    {unlockFile(campaign)}
    ->unlock_confirm
    +{!showIfPublic(quests)&&!showIfPublic(hits)}[>Decrypt timeHits file_]
    {unlockFile(hits)}
    ->unlock_confirm

//scenes
+{!showIfPublic(mainMenu)}[>Decrypt MainMenu file_]
    {unlockFile(mainMenu)}
    ->unlock_confirm
+{!showIfPublic(france)}[>Decrypt Frace_Mediveal file_]
    {unlockFile(france)}
    ->unlock_confirm 
+{!showIfPublic(gameOver)}[Decrypt GameOver file_]
    {unlockFile(gameOver)}
    ->unlock_confirm

//executables
+{!showIfPublic(addActors)}[>Decrypt addActors.exe]
    {unlockFile(addActors)}
    ->unlock_confirm
+{!showIfPublic(addEquipment)}[>Decrypt addEquipment.exe]
    {unlockFile(addEquipment)}
    ->unlock_confirm

+[>return.back_]->executables_file
+[>return.home_]->home

        === decryptor_permission ===
~sawDecryptError = true
~locationText = ""
Error: {playerClass} is missing component.Cypher to access this file. Please add the appropriate Cypher to continue.
+[>return.back_] ->executables_file
+[>return.home_] ->home
        === lock_confirm
~locationText = ""
File encrypted.

+[>return.back_]->encryptor_file
->DONE
        === unlock_confirm
~locationText = ""
File decrypted.

+[>return.back_]->decryptor_file
->DONE

=== redirect_file_knot==//add all files here
//re-invert list so the rest of the code looks at public files before going back to rest of game files
~filesList = LIST_INVERT(filesList)
//MODELS
{currentPrivateFile == models:->models_file->}
{currentPrivateFile == player:->playerCharacter_file->}
{currentPrivateFile == warrior:->warrior_file->}
{currentPrivateFile == giant:->giant_file->}
{currentPrivateFile == wizard:->wizard_file->}
//QUESTS
{currentPrivateFile == quests:->quests_file->}
{currentPrivateFile == campaign:->campaign_file->}
{currentPrivateFile == hits:->hits_file->}
//CINEMATIC
{currentPrivateFile == cinematics:->cinematics_file->}
//SCENES
{currentPrivateFile == mainMenu:->mainMenu_file->}
{currentPrivateFile == france:->france_file->}
{currentPrivateFile == gameOver:->gameOver_file->}
//EXECUTABLES
{currentPrivateFile == addActors:->add_actors_file->}
{currentPrivateFile == addEquipment:->add_equipment_file->}
- ->->

=== run_load_order ===
->printNextPrivate->

->DONE
    === printNextPrivate ===
// get the the number of all items, active and not, in the list
~fullListSize = LIST_COUNT(LIST_ALL(filesList))
//invert list so that all private items are active
~filesList = LIST_INVERT(filesList)
//check the next item in the list
->check_nextContained->

->advance_choice->
- ->->
    === check_nextContained ===
{
//if we're still within the list...
-currentListEnum <= fullListSize:
    {
        //and the item is active, print item
        - filesList has filesList(currentListEnum):
            ->printNext->
        //if it's not, check the next item
        -filesList !? filesList(currentListEnum):
            ~currentListEnum++
            ->check_nextContained->
    }

//if there are no more items, print a done message
- currentListEnum > fullListSize: 
ExecutableSequence.exe = complete
    ->return_choice
}
- ->->
    === printNext ===
~currentPrivateFile = filesList(currentListEnum)
    ->redirect_file_knot->
    //check variable, display text
    ~currentListEnum++
    //spawn a continue button that will call printNextPrivate
->->
        === advance_choice===
+[>Run next_]
->printNextPrivate->

->DONE
        === return_choice ===
//re-invert list so the rest of the code looks at public files before going back to rest of game files
~filesList = LIST_INVERT(filesList)
+[>return.home_]
~currentListEnum = 1
->home
->DONE


=== function addCat ===
    ~return
=== function addList ===
    ~return
=== function exitGameFiles===
    ~return
=== function enterSafeMode ===
    ~return
=== blank_knot ===
~locationText = ""
~countTurns = true
Please wait. Refreshing file navigation.
->DONE