using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using static UnityEditor.Progress;

public class InventoryManager : MonoBehaviour
{
    public static InventoryManager Instance { get; private set; }
    public InventoryItem tradedItem;

    public List<InventoryItem> PlayerItems = new List<InventoryItem>();
    public List<InventoryItem> NPCItems = new List<InventoryItem>();
    //public Dictionary<string, string> NPCItems = new Dictionary<string, string>();

    public static event Action<InventoryItem, int> OnPlayerCollect;
    public static event Action<InventoryItem, int> OnNPCCollect;
    public static event Action<InventoryItem> OnNPCRefuse;

    //reference to dictionary where ink variables get updated
    public GameFilesData gameData;

    public SaveScriptableObject ItemSaveScript;
    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this);
        }
        else
        {
            Instance = this;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        PlayerItems = ItemSaveScript.PlayerItems;
        foreach (InventoryItem item in PlayerItems)
        {
            if (PlayerItems.Contains(item))
            {
                OnPlayerCollect(item, PlayerItems.Count);
            }
        }
        NPCItems = ItemSaveScript.NPCItems;
        foreach (InventoryItem item in NPCItems)
        {
            if (NPCItems.Contains(item))
            {
                OnNPCCollect(item, NPCItems.Count);
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void PlayerCollect(InventoryItem item)
    {
        Debug.Log("Collecting item: " + item.itemName);

        if (NPCItems.Contains(item))
        {
            NPCItems.Remove(item);
        }
        Debug.Log("NPC Item removed: " + item.name);
        item.owner = "Player";
        if (!PlayerItems.Contains(item))
        {
            PlayerItems.Add(item);
        }
        UpdateSOLists();
        OnPlayerCollect(item, PlayerItems.Count);
    }

    public void NPCCollect(InventoryItem item)
    {
        if (item.recipients.Contains(gameData.variables["NPCID"].ToString()))
        {
            if (PlayerItems.Contains(item))
            {
                PlayerItems.Remove(item);
            }
            item.owner = gameData.variables["NPCName"].ToString();
            if (!NPCItems.Contains(item))
            {
                NPCItems.Add(item);

            }
            UpdateSOLists();
            OnNPCCollect(item, NPCItems.Count);
        }
        else
        {
            OnNPCRefuse(item);
        } 
            
    }

    public void ClearInventoryLists()
    {
        for (int i = PlayerItems.Count - 1; i >= 0; i--)
        {
            InventoryItem item = PlayerItems[i];
            PlayerItems[i].owner = null;
            PlayerItems.RemoveAt(i);
            OnNPCCollect(item, NPCItems.Count);
        }
        for (int i = NPCItems.Count - 1; i >= 0; i--)
        {
            InventoryItem item = NPCItems[i];
            NPCItems[i].owner = null;
            NPCItems.RemoveAt(i);
            OnPlayerCollect(item, PlayerItems.Count);
        }


        //if (PlayerItems != null) PlayerItems.Clear();

        //if (NPCItems != null) NPCItems.Clear();
        //foreach (InventoryItem item in NPCItems)
        //{
        //    OnPlayerCollect(item);
        //}
        UpdateSOLists();

    }
    private void UpdateSOLists()
    {
        ItemSaveScript.PlayerItems = PlayerItems;
        ItemSaveScript.NPCItems = NPCItems;
    }
}
