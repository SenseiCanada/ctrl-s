INCLUDE inkVariables_GameFiles.ink


->home

===home===
~NPCID = "dev"
- Dev Options
+[Increase runAttemtps]
    ~runAttempts++
    ->home
+[Activate Warrior Quest]
    ~startGunQuest = true
    ->home
+[Activate Giant Quest]
    ~startCatQuest = true
    ->home   
+[Exit]
    {quitDialogue()}
    ->home

->DONE


