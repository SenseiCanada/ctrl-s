INCLUDE inkVariables_GameFiles.INK
EXTERNAL enterLobby()
VAR enterLobbyAffection = " "
->start

=== start ===
~NPCName = ""
~NPCID = "enterLobby"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Enter {lobby}?

+[Yes]
    {enterLobby()}

+[No] {quitDialogue()}

- ->DONE

===function enterLobby===
~return