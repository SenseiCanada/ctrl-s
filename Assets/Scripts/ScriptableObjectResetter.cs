using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScriptableObjectResetter : MonoBehaviour
{
    public SaveScriptableObject inventorySave;
    public GameFilesData gameData;

    //attributes
    public PlayerAttribute startCompileAttribute;
    public PlayerAttribute sentienceAttribute;
    public PlayerAttribute playerClass;
    public PlayerAttribute playerInventory;
    public PlayerAttribute npcInventory;
    public PlayerAttribute giantAffection;
    public PlayerAttribute robotAffection;
    public PlayerAttribute warriorAffection;
    public PlayerAttribute enemyAdvantage;

    //items
    public InventoryItem hitlist;
    public InventoryItem mosspaws;
    public InventoryItem pen;
    public InventoryItem anchor;
    public InventoryItem wrench;

    // Start is called before the first frame update
    void Start()
    {
        ResetScriptableObjects();
        Debug.Log("scriptable objects reset!");
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void ResetScriptableObjects()
    {
        inventorySave.startVariablesSet = false;
        playerClass.attributeValue = "fileViewer";
        playerInventory.attributeValue = "0";
        npcInventory.attributeValue = "0";
        giantAffection.attributeValue = "0";
        robotAffection.attributeValue = "0";
        warriorAffection.attributeValue= "0";
        enemyAdvantage.attributeValue = "0";
        ResetAttributes();
        hitlist.owner = string.Empty;
        mosspaws.owner = string.Empty;
        pen.owner = "giant";
        anchor.owner = "warrior";
        wrench.owner = "robot";
        
    }

    void ResetAttributes()
    {
        gameData.playerAttributes.Clear();
        gameData.playerAttributes.Add(startCompileAttribute);
        gameData.playerAttributes.Add(sentienceAttribute);
        gameData.playerAttributes.Add(playerClass);

        gameData.nullAttributes.Clear();
        gameData.nullAttributes.Add(playerInventory);
        gameData.nullAttributes.Add(npcInventory);
        gameData.nullAttributes.Add(warriorAffection);
        gameData.nullAttributes.Add(giantAffection);
        gameData.nullAttributes.Add(robotAffection);
        gameData.nullAttributes.Add(enemyAdvantage);

    }
}
