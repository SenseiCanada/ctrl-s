using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Save")]
public class SaveScriptableObject : ScriptableObject
{
    public List<InventoryItem> PlayerItems;
    public List<InventoryItem> NPCItems;

    public void ClearInventory()
    {
        if (PlayerItems != null) PlayerItems.Clear();
        if (NPCItems != null) NPCItems.Clear();
    }
}
