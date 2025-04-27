using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Save")]
public class SaveScriptableObject : ScriptableObject
{
    public List<InventoryItem> PlayerItems;
    public List<InventoryItem> NPCItems;

    public List<PlayerAttribute> playerStartAttributes;
    public List<PlayerAttribute> nullStartAttributes;

    public InventoryItem anchor;
    public InventoryItem key;
    public InventoryItem pen;
    public InventoryItem wrench;

    public bool startVariablesSet; //set to false when you start the game

    public void ClearInventory()
    {
        if (PlayerItems != null) PlayerItems.Clear();
        if (NPCItems != null) NPCItems.Clear();
    }

    public void SetStartVariables() //called by LobbyManager once on start
    {
        ClearInventory();
        NPCItems.Add(anchor);
        anchor.owner = "warrior";
        //NPCItems.Add(key);
        //anchor.owner = "giant";
        NPCItems.Add(pen);
        pen.owner = "giant";
        NPCItems.Add(wrench);
        wrench.owner = "robot";

        startVariablesSet = true; //then blocked from being called subsequently
    }
}
