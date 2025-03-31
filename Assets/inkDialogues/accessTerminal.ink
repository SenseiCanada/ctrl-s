INCLUDE inkVariables_GameFiles.ink
EXTERNAL enterGameFiles()


->enter

=== enter ===
~NPCName = "Terminal"
~NPCID = "terminal"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Saving initiated... Compile code for Player Character?

+[Compile]
    {enterGameFiles()}
    {quitDialogue()}
    ->DONE
+[Not yet]
    {quitDialogue()}
    ->DONE
    

    
=== function enterGameFiles ===
    ~return