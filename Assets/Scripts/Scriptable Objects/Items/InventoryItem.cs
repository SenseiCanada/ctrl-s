using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Item")]
public class InventoryItem : ScriptableObject
{
    public string itemName;
    public Sprite icon;
    public string owner;
    public string inkVariableName;
    public List<string> recipients = new List<string>();
    
}
