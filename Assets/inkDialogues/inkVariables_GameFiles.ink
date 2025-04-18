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

//cinematic
VAR openedCinematic = false
VAR warriorDesignation = "novaWarrior"
VAR victim1 = "Errol"
VAR victim2  = "Jason"
VAR badGuy = "Will"
VAR seenNovaName = false

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

//giant
VAR giantAffection = 0 //has an SO
VAR startCatQuest = false
VAR hasCat = ""
VAR learnedBrallKey = false


//warrior
VAR warriorAffection = 0 //has an SO
VAR startHitListQuest = false
VAR startGunQuest = false
VAR discoveredNoGun = false
VAR hasList = ""
VAR seenNovaGlow = false

//robot
VAR robotAffection = 0 //has an SO

//inventory
VAR hasAnchor = ""

