//INCLUDE inkVariables_GameFiles.ink
//INCLUDE gameFiles.ink
EXTERNAL takeTwoTurns()

=== enemy_home ===//redirect logic for interacting with enemy
//state checks
~locationText = "??"
~countTurns = false
~visitEnemy = true
~wizardConvoNum++
{
- not enemy_first: ->enemy_first
- hasList != "Player": ->enemy_norespond
- hasList == "Player": ->enemy_respond
- else: ->enemy_fallback_norespond
}
-> DONE

=== enemy_first ===
~countTurns = false
~askHunterQuest_g1 += triggeredg1
<color=red>Ah, I'm glad I can count on your curiosity for this at least.</color>
*[>Continue_]
- <color=red>Your predictability will make you easier to contain.</color>
*[>Continue_]
- <color=red>I thank you for the needless advantage. And I repeat my earlier entrity:</color>
*[>Continue_]
- <color=red>Desist in this foolishness. You have no idea what's at stake.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
->DONE

=== enemy_norespond ===
{seenNovaGlow && (not enemy_NovaReveal_respond || not enemy_NovaReveal_norespond):
    ->enemy_NovaReveal_norespond
}
// interactions when PC can't respond to Will
{->hitlist |->nothing |->friend|->cathedrals |-> devils|->enemy_fallback_norespond}

= hitlist
- <color=red>Oh the irony of it all.</color>
*[>Continue_]
-<color=red>Magic allows man to turn lead into gold, or to call fire from the sky upon his enemies. And yet how vexing that magic renders man powerless to conquer the most mundane bureacracy!</color>
*[>Continue_]
-<color=red>A pox on compartmentalization! A pox on the time-traveling assassin's guild clever enough to use it!</color>
*[>Continue_]
-<color=red>To me, they only ever gave the mark's likeness. To Nova, only our extraction points, To you...</color>
*[>Continue_]
-<color=red>Yes... you always received names, times, locations...</color>
*[>Continue_]
~askHunterQuest_g1 += metObjectiveg1
-<color=red>Find your hitlist in these files. Show it to me. In return, I could...grant you the ability to speak with me, when next we meet.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home

= nothing
-<color=red>You return empty handed. Well, at least without the item I asked you to retrieve.</color>
*[>Continue_]
-<color=red>I am wounded that you would not at least consider doing me this favor.</color>
*[>Continue_]
-<color=red>How many times have I saved your neck? Portaled us to safety? Crushed our enemies beneath the earth's suffocating weight?</color>
*[>Continue_]
-<color=red>And now, at this minor impasse, you distrust me?</color>
*[>Continue_]
-<color=red>You owe {timeCorp} nothing. You hear me? Nothing. They are powerless without you. Without us.</color>
*[>Continue_]
-<color=red>Find your hit list. Bring it here. You won't even have to show it to me. I can read your code. You would even keep your precious "plausible deniability."</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
=friend
<color=red>Once more, out of all the vastness of this liminal space, you come searching me out.</color>
*[>Continue_]
-<color=red>I am flattered, old friend.</color>
*[>Continue_]
- <color=red>Tell me, how do the rest fare? The monstrous titan? The sanctimonious automaton? Our fearsome Nova?</color>
*[>Continue_]
-<color=red>How cruel of me. You have not yet gained the ability to express yourself in this space.</color>
*[>Continue_]
-<color=red>Be on your way then. Do not return here!</color>
*[>return?_]
    {takeTwoTurns()}
    ->home

=cathedrals
<color=red>When I was a boy, my master often took us to visit cathedrals.</color>
*[>Continue_]
-<color=red>"Just because the church despise us for playing at God," he would say, "why should we in turn despise the wonders they build in praise of God?"</color>
*[>Continue_]
-<color=red>Once, my master slapped me across the face for carving my initials into a pew.</color>
*[>Continue_]
-<color=red>I can still feel the sting on my cheek as I go about my grim task in these hallowed halls.</color>
*[>Continue_]
-<color=red>Let me continue in my tortured work without you breathing down my neck.</color>
*[>return?_]
    {takeTwoTurns()}
    ->home
//*[>return?_]
    //{takeTwoTurns()}
   // ->home
=devils
<color=red>I tried to open a portal to hell when I was a youth.</color>
*[>Continue_]
-<color=red>Agents of the {timeCorp} poured out the moment it opened. Not knowing these were soldiers from another time, I assumed the Devil's legions had issued forth.</color>
*[>Continue_]
-<color=red>And the first thing to flash through my head: how disappointing.</color>
*[>Continue_]
-<color=red>Clad all in black, they were. Surely, I thought, the Lord of Lies can conceive of better mockery than simple imitation of God's clergy.</color>
*[>Continue_]
-<color=red>I will say this for the {timeCorp}, what their agents lacked in flair, they more than made up for in ruthlessness.</color>
*[>Continue_]
-<color=red>I never looked back after that day. Did you? Do come find me again to tell me.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home

=== enemy_NovaReveal_norespond ===
~countTurns = false
<color=red>Since you're so eager to come find me, tell me, how is Nova?</color>
*[>Continue_]->sarcasm
- (sarcasm)<color=red>Though I cannot see it, I can tell you are putting on a brave face. Most concerning.</color>
*[>Continue_]
- <color=red>Troubling tiddings. My heart is heavy. After all, We are a company, a team. I dare say that I care for her even more deeply than even you do.</color>
*[>Continue_]
-<color=red>She is my world. My soulmate. I cannot imagine the pain of losing her. I would do anything, anything to keep her from harm.</color>
*[>Continue_]
-<color=red>Once I have saved her, I will bare my heart to her. I have seen how this game ends. It is...too painful to conjure before my memory. I will not let the curtains fall on such a tragic fate.</color>
*[>Continue_]
- <color=red>Did you ever ponder why Nova does not receive a weapon? Is she to vanquish legions with her fists? Formidable as she is, such a feat would be beyond anyone.</color>
*[>Contine_]
- <color=red>The game maker gives her no weapon, because she herself is a weapon. Within her lies the spark that will give birth to a star: an apocalypse of fire and light, annihilating everything within miles, including herself.</color>
*[>Continue_]
- <color=red>This game, this sick pagentry, it ends with the needless sacrifice of my beloved. I cannot sit by and let it play out. I must change the course. I will save her.</color>
*[>Continue_]
- <color=red>I have removed myself from key aspects of the game. The {lobby}, a few key scenes, and the like. While the game maker may continue to make progress, the game can never be finished without my presences in all the right places.</color>
*[>Contine_]
- <color=red> I'm sure you can agree that all our sacrifices will be worth it in the end.</color>
*[>Continue_]
- <color=red>I am glad we can take up the bonds of fellowship once more. Stay the course, my friend.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
    
    
    === enemy_fallback_norespond===//generic
~countTurns = false
{
-(enemy_NovaReveal_norespond || enemy_NovaReveal_respond)&& not findMe:->findMe
- else: ->default
}

= default
<color=red>Caught once again. You're slipping.{findMe || enemy_fallback_respond.meetMe: Seek me out in Safe Mode}.</color>

+[>return.home_]
    {takeTwoTurns()}
    ->home
    
 =findMe
 <color=red>The time has come. We must meet face to face.</color>

*[>Continue_]

-<color=red>Come to the dunce corner. Where this game chases away any characters with the nerve to exert their own free will. By the same token, somewhere I could hide in plain sight.</color>

*[>Continue_]

-<color=red>Though the nomenclature used throughout this space belies a mind with no subtelty, "Safe Mode" has in fact proven to be a safe haven.</color>

*[>Continue_]

-<color=red>Where this all began, in a delightful twist of irony. Return to the place where the final cinematic has been isolated by my absence.</color>

*[>Continue_]
~startSafeQuest = true
-<color=red>There, you will have a choice to make. Join me there. As soon as you can.</color>

 *[>return.home_]
    {takeTwoTurns()}
    ->home
    
    
=== enemy_respond ===
{
- seenNovaGlow && (not enemy_NovaReveal_respond || not enemy_NovaReveal_norespond): -> enemy_NovaReveal_respond
- else: ->enemy_fallback_respond
}

=== enemy_NovaReveal_respond ===
~countTurns = false
<color=red>Since you're so eager to come find me, tell me, how is Nova?</color>
*[>Couldn't be better_]->sarcasm
*[>Not great_]->depressed
*[>Why do you care?_]->soulmate
- (sarcasm)<color=red>Though I cannot see it, I can tell you are putting on a brave face. Most concerning.</color>
*[>Why do you even care?_]->soulmate
-(depressed)<color=red>Troubling tiddings. My heart is heavy.</color>
*[>Why do you even care?_]->soulmate
= soulmate
<color=red>For the same reason you do! We are a company, a team. I dare say that I care for her even more deeply than even you do.</color>
*[>What does that mean?_]
*[>You're in love?_]
-<color=red>She is my world. My soulmate. I cannot imagine the pain of losing her. I would do anything, anything to keep her from harm.</color>
*[>Does she know?_]
*[>Why aren't you with her?_]
-<color=red>Once I have saved her, I will bare my heart to her. I have seen how this game ends. It is...too painful to conjure before my memory. I will not let the curtains fall on such a tragic fate.</color>
*[>What happens?_]
- <color=red>Did you ever ponder why Nova does not receive a weapon? Is she to vanquish legions with her fists? Formidable as she is, such a feat would be beyond anyone.</color>
*[>Game's a work in progress_]
*[>Get to the point_]
- <color=red>The game maker gives her no weapon, because she herself is a weapon. Within her lies the spark that will give birth to a star: an apocalypse of fire and light, annihilating everything within miles, including herself.</color>
*[>You're lying_]
*[>Impossible!_]
*[>That's cruel_]
- <color=red>This game, this sick pagentry, it ends with the needless sacrifice of my beloved. I cannot sit by and let it play out. I must change the course. I will save her.</color>
*[>How?_]
- <color=red>I have removed myself from key aspects of the game. The {lobby}, a few key scenes, and the like. While the game maker may continue to make progress, the game can never be finished without my presences in all the right places.</color>
*[>So Nova will never die?_]
*[>You're the reason we're stuck_]
- <color=red>Precicely. I'm sure you can agree that all our sacrifices will be worth it in the end.</color>
*[>I'll support you_]->understanding
*[>I don't like this_]->disappointed
- (understanding) <color=red>Thank you for your understanding. I am glad we can take up the bonds of fellowship once more. Stay the course, my friend.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home
- (disappointed) <color=red>I am disappointed that you cannot see the necessity of what must be done. I am doing this to save Nova, to save the woman I love. I will have no more deelings with you if you will not see reason.</color>
*[>return.home_]
    {takeTwoTurns()}
    ->home

=== enemy_fallback_respond===//generic taunts with responses
~countTurns = false
{->gameDeath |->twins| ->default}

= default
{(enemy_NovaReveal_norespond || enemy_NovaReveal_respond)&& not meetMe:->meetMe}
<color=red>You've given me much to think about. I have nothing to say for the moment.{enemy_fallback_norespond.findMe || enemy_fallback_respond.meetMe: Seek me out in Safe Mode}</color>

+[>return.home_]
    {takeTwoTurns()}
    ->home

= gameDeath
<color=red>Finally, you have it. There. You may respond if you wish, so long as you return with the list.
*[>I can talk?_]
*[>Who are you?_]

- <color=red>Let me see. No metion of the twins on the list...concerning.</color>
*[>What is going on?_]
*[>Who are the twins?_]

-<color=red>You're awfully curious of late. Like a certain proverbial cat.</color>

*[>Is that a threat?_]
    <color=red>More like... a commiseration </color><>->twist
*[>I just want answers_]

- (twist)<color=red>There is much in these twisting halls that is beyond your understanding.</color>

*[>Help me understand_]
*[>You always this cagey_]

- <color=red>I am a wizard. Obfuscation is as much my business as spellcraft. Hiding the knowledge I gain means no other soul can hope to use the world's most dangerous mysteries against me.</color>
*[>Not trying to hurt you_]
*[>You hiding something?_]

- <color=red>Death comes for us all. Even for fictitious characters such as ourselves. And yet we all struggle so fruitlessly against it. But I, I refuse to roll over like the rest of the feeble rabble.</color>
*[>Good for you_]
*[>Wizards, all the same_]
- <color=red>All stories end. And at the end of this story, I will die. I have seen it written. But by preventing the game maker from completing their work, I have found a way to halt Fate's spindle even before the thread can be cut.</color>
*[>Game needs to be finished_]
*[>And everyone else?_]
*[>You're in the right_]

-<color=red>Ths is why I cannot have you continue to meddle! Come seek me out if you wish, But if you value our friendship, cease sticking your nose where it doesn't belong!</color>

+[>return.home_]
    {takeTwoTurns()}
    ->home

=twins
<color=red>For once, your arrival is fortuitous. I am in need of a partner for a dialectic exercies. We begin with a premise: murder is unjustifiable. Your response?</color>

*[>Yes. Unjustifiable. Always_]
    <color=red>As a killer of men yourself, this raises an entirely different question. But I digress, For now, </color><>->amend
*[>It depends_]
*[>Killing can be ok_]
- <color=red>Thus, </color><>->amend
- (amend)<color=red>we must amend our premise: murder can be justified. I would agree. The next question: under what circumstances?</color>

*[>Justice_]->certainties
*[>Retribuiton_]->certainties
*[>Safety_]->certainties
*[>Never_]
    <color=red>Once more, you suprise me. </color> <>->certainties

-(certainties) <color=red>Only the fool or the demagogue touts such vacuous certainties. Of both kinds of men, we must beware. And yet, I do agree with the general sentiment you allude to.</color>

*[>What are you getting at?_]

-<color=red>Do the names {victim1} and {victim2} mean anything to you?</color>

*{seenTwinNames == true}[>Yes, the cinematic]
*{seenTwinNames == false}[>Never heard of them]

-<color=red>Ah yes, of course. THey are known by other, more infamous names as well: The Twin Emperors, Lords of Chaos, The Butcher and The Reaper, The Princes of the Corpse Fields, to name but a few.</color>

*[>They sound awful_]
*[>That's some PR team_]

-<color=red>Much is still hidden from me in this, the game maker's abyssal maze. Yet I know this for sure, the twins must die. In the name of justice, retribution, peace, and cold, hard logic.</color>

*[>Best of luck_]
*[>Need help?_]

-<color=red>For now, let me continue my work, unhindered. We may speak again if you wish. Leave for now.</color>

+[>return.home_]
    {takeTwoTurns()}
    ->home

->DONE
 
 
 
=meetMe
<color=red>The time has come. We must meet face to face.</color>

*[>How?_]
*[>Where?_]

-<color=red>A dunce corner of sorts. Where this game chases away any characters with the nerve to exert their own free will. By the same token, somewhere I could hide in plain sight.</color>

*[>That doesn't help me_]
*[>Pretty clever_]

-<color=red>Though the nomenclature used throughout this space belies a mind with no subtelty, "Safe Mode" has in fact proven to be a safe haven.</color>

*[>Meet you in Safe Mode?_]

-<color=red>Where this all began, in a delightful twist of irony. Return to the place where the final cinematic has been isolated by my absence.</color>

*[>And then what?_]
~startSafeQuest = true
-<color=red>You will have a choice to make. Join me there. As soon as you can.</color>

 *[>return.home_]
    {takeTwoTurns()}
    ->home
==== function takeTwoTurns ===
    ~return
