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

    public bool startVariablesSet;

    public void ClearInventory()
    {
        if (PlayerItems != null) PlayerItems.Clear();
        if (NPCItems != null) NPCItems.Clear();
    }

    public void SetStartVariables() //called by LobbyManager once on start - still needs to subscribe
    {
        ClearInventory();
        NPCItems.Add(anchor);
        anchor.owner = "warrior";
        NPCItems.Add(key);
        anchor.owner = "giant";
        NPCItems.Add(pen);
        pen.owner = "robot";

        startVariablesSet = true; //then blocked from being called subsequently
    }
}
