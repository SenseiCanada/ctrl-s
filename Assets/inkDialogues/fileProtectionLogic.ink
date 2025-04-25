
//every file in the game needs a protection variable on this list
LIST filesList = (models), (player), (warrior), (giant), wizard, quests, campaign, hits, cinematics, (mainMenu), france, (gameOver), (addActors), (addEquipment)
VAR fullListSize = 0
VAR currentPrivateFile = ""
VAR currentListEnum = 1

//->main_menu

=== function lockFile(file)
~filesList -= file

=== function unlockFile(file)
~filesList += file

=== function printProtection(file)
{
- filesList ? file: decrypted
- else: encrypted
}

=== function showIfPublic(file)
{
- filesList ? file:
    ~return true
- else:
    ~return false
}

=== function invertList (List)
    ~List = LIST_INVERT(List)









