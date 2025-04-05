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
VAR warriorDesignation = "novaWarrior"
VAR victim1 = "Errol"
VAR victim2  = "Jason"
VAR badGuy = "Will"
VAR seenNovaName = false

//gamefiles
VAR locationText = ""
VAR turns = ""
VAR playerClass = "" //has an SO
VAR privacy = "??"
VAR countTurns = false
VAR visitTestLevel = ""

//giant
VAR giantAffection = 0 //has an SO
VAR startCatQuest = false
VAR foundCat = false
VAR giantHasCat = false


//warrior
VAR warriorAffection = 0 //has an SO
VAR startGunQuest = false
VAR discoveredNoGun = false


//robot
VAR robotAffection = 0 //has an SO

//invnetory
VAR hasAnchor = ""

