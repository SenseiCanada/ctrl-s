INCLUDE inkVariables_GameFiles.INK
EXTERNAL enterLobby()

->start

=== start ===
~NPCName = ""
~NPCID = "enterLobby"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Enter Game Lobby?

+[Yes]
    {enterLobby()}

+[No] {quitDialogue()}

- ->DONE

===function enterLobby===
~return