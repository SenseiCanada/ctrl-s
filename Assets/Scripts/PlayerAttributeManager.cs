using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class PlayerAttributeManager : MonoBehaviour
{
    public GameFilesData gameData;
    
    public List<PlayerAttribute> attributes = new List<PlayerAttribute>(); //list of all potential player attributes

    // Start is called before the first frame update
    void Start()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdatePlayerAttributes;
        InventoryManager.OnPlayerCollect += UpdatePlayerInventoryAttribute;
        InventoryManager.OnNPCCollect += UpdateNPCInventoryAttribute;

        foreach (PlayerAttribute attribute in attributes) //add all null attributes to null list at start
        {
            if(attribute.attributeValue == "0" || string.IsNullOrEmpty(attribute.attributeValue))
            {
                if (!gameData.nullAttributes.Contains(attribute))
                {
                    gameData.nullAttributes.Add(attribute);
                }
                // Ensure it's not in the playerAttributes list
                gameData.playerAttributes.Remove(attribute);
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    void UpdatePlayerAttributes(string varName, string varValue)
    {
        foreach (PlayerAttribute attribute in attributes)
        {
            if (attribute.attributeID == varName)
            {
                // If value is "0" or empty, add to nullAttributes
                if (varValue == "0" || string.IsNullOrEmpty(varValue))
                {
                    if (!gameData.nullAttributes.Contains(attribute))
                    {
                        gameData.nullAttributes.Add(attribute);
                    }
                    // Ensure it's not in the playerAttributes list
                    gameData.playerAttributes.Remove(attribute);
                    return;
                }

                // Otherwise, add to playerAttributes
                attribute.attributeValue = varValue;
                if (!gameData.playerAttributes.Contains(attribute))
                {
                    gameData.playerAttributes.Add(attribute);
                }

                // Ensure it's not in the nullAttributes list
                gameData.nullAttributes.Remove(attribute);
            }
        }
    }

    void UpdatePlayerInventoryAttribute(InventoryItem item, int playerItemCount)
    {
        foreach (PlayerAttribute attribute in attributes)
        {
            if(attribute.attributeID == "playerInventory")
            {
                attribute.attributeValue = playerItemCount.ToString();
                if (!gameData.playerAttributes.Contains(attribute))
                {
                    gameData.playerAttributes.Add(attribute);
                }
                gameData.nullAttributes.Remove(attribute);
            }
        }
    }

    void UpdateNPCInventoryAttribute(InventoryItem item, int npcItemCount)
    {
        foreach (PlayerAttribute attribute in attributes)
        {
            if (attribute.attributeID == "npcInventory")
            {
                attribute.attributeValue = npcItemCount.ToString();
                if (!gameData.nullAttributes.Contains(attribute))
                {
                    gameData.nullAttributes.Add(attribute);
                }
                gameData.playerAttributes.Remove(attribute);
            }
        }
    }
}
