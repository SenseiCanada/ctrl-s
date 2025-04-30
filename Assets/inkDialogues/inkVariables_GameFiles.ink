//includes


//external functions
EXTERNAL quitDialogue()
EXTERNAL openTradeWindow()
EXTERNAL closeTradeWindow()

===function openTradeWindow===
    ~return

===function closeTradeWindow===
    ~return

===function quitDialogue===
    ~return

//general
VAR runAttempts = 0
VAR NPCName = "??"
VAR NPCID = ""
VAR saveResumeKnot = ""
VAR fixedGame = false

//cinematic
VAR openedCinematic = false
VAR warriorDesignation = "novaWarrior"
VAR victim1 = "Errol"
VAR victim2  = "Jason"
VAR badGuy = "Will"
VAR seenNovaName = false
VAR seenWizardEnd = false
VAR forcedWizard = false

//proper names
VAR timeCorp = "TimeCorp"
VAR crux = "Crux"
VAR victim3 = "Sameth"
VAR victim4 = "Liliana"
VAR victim5 = "Goddard"
VAR victim6 = "Brall"
VAR lobby = "Asset Library"
VAR gameTitle = "The Chronos Protocol"
VAR portal = "Loading Gate"
VAR portals = "Loading Gates"

//gamefiles
VAR seenStartWarning = false
VAR locationText = ""
VAR turns = ""
VAR playerClass = "" //has an SO
VAR privacy = "??"
VAR countTurns = false
VAR visitTestLevel = ""
VAR learnedAboutHunter = false
VAR metEnemy = false
VAR canSpeakToEnemy = false
VAR sawDecryptError = false
VAR seenEncryptor = false
VAR seenSafeMode = true
VAR enemyAdvantage = 0
VAR visitEnemy = false

//giant
VAR giantAffection = 0 //has an SO
LIST askHunterQuest_g1 = triggeredg1, startedg1, metObjectiveg1, completedg1
VAR startCatQuest = false
LIST findCatQuest_g2 = triggeredg2, startedg2, metObjectiveg2, completedg2
VAR hasCat = ""
VAR learnedBrallKey = false
VAR hasKey = ""


//warrior
VAR warriorAffection = 0 //has an SO
VAR startHitListQuest = false
VAR hitQuestComplete = false
VAR startGunQuest = false
VAR discoveredNoGun = false
VAR weaponQuestComplete = false
VAR hasList = ""
VAR seenNovaGlow = false

//robot
VAR robotAffection = 0 //has an SO
VAR hasPen = ""
VAR hasWrench = ""
LIST fixQuestProgress_r1 = triggeredr1, startedr1, metObjectiver1, completedr1
LIST findPenQuest_r2 = triggeredr2, startedr2, metObjectiver2, completer2


//inventory
VAR hasAnchor = ""

