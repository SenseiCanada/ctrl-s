INCLUDE inkVariables_GameFiles.ink
EXTERNAL enterGameFiles()
EXTERNAL openLog()
VAR terminalAffection ="  "

->enter

=== enter ===
~NPCName = "Terminal"
~NPCID = "terminal"

{playerClass == "": //null check for PC class
    ~playerClass = "fileViewer"
}

Saving initiated... Compile code for PlayerCharacter?

+[Compile]->warning_check
    ->DONE
+{seenStartWarning}[Review instructions]->first_warning
+{seenStartWarning}[Open PlayerCharacter.log]
    {openLog()}
    ->enter
+[Not yet]
    {quitDialogue()}
    ->DONE

=== warning_check===
{
- seenStartWarning == false: ->first_warning
- else: ->start_compile
}
->DONE

=== start_compile ===
{enterGameFiles()}
    {quitDialogue()}
    ->DONE

===first_warning===
~seenStartWarning = true
Entering game files. Click on >interactables_ to navigate.

+[Continue]->complexity

= complexity
Warning: increasing asset complexity will increase compilation times.

+[Start Compile]->start_compile
    
+[Not yet]
    {quitDialogue()}
    ->DONE

=== function openLog ===
~return
    
=== function enterGameFiles ===
    ~return