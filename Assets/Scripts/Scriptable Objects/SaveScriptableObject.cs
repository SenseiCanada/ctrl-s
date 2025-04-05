using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Save")]
public class SaveScriptableObject : ScriptableObject
{
    public List<InventoryItem> PlayerItems;
    public List<InventoryItem> NPCItems;

    public InventoryItem anchor;

    public bool startVariablesSet;

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

        startVariablesSet = true; //then blocked from being called subsequently
    }
}
