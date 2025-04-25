using JetBrains.Annotations;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

public class InventoryDisplayer : MonoBehaviour
{
    public GameObject inventoryPrefab;
    public Transform inventoryFrame;
    public Image playerItemImage;

    public Transform NPCInventoryFrame;
    public Image NPCItemImage;
    //public TMP_Text NPCName;
    
    private string currentNPC;

    //public GameFilesData gameData;

    public List<GameObject> PlayerDisplayItems = new List<GameObject>();
    public List<GameObject> NPCDisplayItems = new List<GameObject>();


    // Start is called before the first frame update
    void Awake()
    {
        InventoryManager.OnPlayerCollect += AddPlayerInventory;
        InventoryManager.OnNPCCollect += AddNPCInventory;
        GameFilesData.OnUnityRegisterInkVar += UpdateNPCName;
        InventoryInkConnector.OnTradeWindowOpen += UpdateNPCDisplay;
    }
    void Start()
    {
       NPCInventoryFrame = GameObject.Find("NPCInventory").transform;
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void AddPlayerInventory(InventoryItem item, int playerItemCount)
    {
        //first clear the NPCDisplayItem list
        UpdateNPCDisplay();
       
        //then instantiate the visual button in the player inventory
        UpdatePlayerDisplay();
    }

    void OnTraded(InventoryItem item)
    {
        InventoryManager.Instance.NPCCollect(item);
    }

    void OnCollected(InventoryItem item)
    {
        InventoryManager.Instance.PlayerCollect(item);
    }

    void AddNPCInventory(InventoryItem item, int NPCItemCount)
    {
        UpdatePlayerDisplay();
        UpdateNPCDisplay();
        
    }

    void UpdatePlayerDisplay()
    {
        //clear all UI elements in UI inventory
        PlayerDisplayItems.Clear();
        foreach (Transform child in inventoryFrame)
        {
            Destroy(child.gameObject);
        }

        //recreate all UI elements that correspond to items that are still in the inventory manager list
        foreach (InventoryItem PlayerItem in InventoryManager.Instance.PlayerItems)
        {
            GameObject newIcon = Instantiate(inventoryPrefab, inventoryFrame);
            newIcon.transform.SetAsLastSibling();
            Button newIconButton = newIcon.GetComponent<Button>();
            newIconButton.onClick.AddListener(delegate { OnTraded(PlayerItem); });
            TooltipTrigger buttonTrigger = newIconButton.GetComponent<TooltipTrigger>();
            if (buttonTrigger != null)
            {
                buttonTrigger.item = PlayerItem;
            }

            Image newIconImage = newIcon.GetComponent<Image>();

            if (newIconImage != null)
            {
                newIconImage.sprite = PlayerItem.icon;
            }
            if (!PlayerDisplayItems.Contains(newIcon))
            {
                PlayerDisplayItems.Add(newIcon);
            }
        }
    }
    
    void UpdateNPCDisplay()
    {
        //clear all UI elements in UI inventory
        NPCDisplayItems.Clear();

        if (NPCInventoryFrame != null)
        {
            foreach (Transform child in NPCInventoryFrame)
            {
                Destroy(child.gameObject);
                Debug.Log("all NPC item displays cleared");
            }
        }

        foreach (InventoryItem NPCItem in InventoryManager.Instance.NPCItems)
        {
            if (NPCItem.owner == currentNPC)
            {
                Debug.Log("new NPC item display creating, SO owner is " + NPCItem.owner + " and currentNPC is " + currentNPC);
                GameObject newIcon = Instantiate(inventoryPrefab, NPCInventoryFrame);
                newIcon.transform.SetAsLastSibling();
                Button newIconButton = newIcon.GetComponent<Button>();
                newIconButton.onClick.AddListener(delegate { OnCollected(NPCItem); });
                TooltipTrigger buttonTrigger = newIconButton.GetComponent<TooltipTrigger>();
                if (buttonTrigger != null)
                {
                    buttonTrigger.item = NPCItem;
                }

                //NPCItem1.GetComponent<Image>().sprite = null;
                Image newIconImage = newIcon.GetComponent<Image>();
                if (newIconImage != null)
                {
                    newIconImage.sprite = NPCItem.icon;
                }
                if (!NPCDisplayItems.Contains(newIcon))
                {
                    NPCDisplayItems.Add(newIcon);
                }
            }
        }

        
    }
    
    private void UpdateNPCName(string inkVar, string inkValue)
    {
        if (inkVar == "NPCID")
        {
            currentNPC = inkValue;
            Debug.Log("Inventory Displayer stored " + inkValue + " as currentNPC");
        }
    }
    
    private void OnDisable()
    {
        InventoryManager.OnPlayerCollect -= AddPlayerInventory;
        InventoryManager.OnNPCCollect -= AddNPCInventory;
        GameFilesData.OnUnityRegisterInkVar += UpdateNPCName;
    }
}
