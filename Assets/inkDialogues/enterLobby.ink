INCLUDE inkVariables_GameFiles.INK
EXTERNAL enterLobby()
EXTERNAL enterEnd()
VAR enterLobbyAffection = " "
->start

=== start ===
~NPCName = ""
~NPCID = "enterLobby"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Enter {lobby}?

+[Yes]->enter_lobby_check
    {enterLobby()}

+[No] {quitDialogue()}

- ->DONE

=== enter_lobby_check ====
{
- seenWizardEnd == true && forcedWizard == true:
    ~fixedGame = true
    {enterEnd()}
- seenWizardEnd == true &&  forcedWizard == false:
    ~fixedGame = false
    {enterEnd()}
- else: {enterLobby()}
}
    
->DONE

=== function enterEnd ===
~return

===function enterLobby===
~return