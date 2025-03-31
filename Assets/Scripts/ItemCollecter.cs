using Ink.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemCollecter : MonoBehaviour
{
    public InventoryItem magnifyingGlass;
    public InventoryItem backpack;
    public InventoryItem mosspaws;

    [SerializeField]
    private TextAsset gameFilesJSON;
    private Story gameFilesStory;
    private Story currentStory;

    //for reference
    //currentStory.BindExternalFunction("quitDialogue", () => { CloseDialoguePanel(); });

    // Start is called before the first frame update
    void Start()
    {
        //GameFilesManager.OnCreateStory += AssignCurrentStory;
        DialogueManager.OnCreateStory += AssignCurrentStory;
        GameFilesManager.OnCollectCat += CollectCat;
        gameFilesStory = new Story(gameFilesJSON.text);
    }

    // Update is called once per frame
    void Update()
    {

    }

    void AssignCurrentStory(Story story)
    {
        currentStory = story;

    }
    
    public void PlayerCollect(InventoryItem item)
    {

    }
    public void CollectCat()
    {
        InventoryManager.Instance.PlayerCollect(mosspaws);
    }

    public void CollectGlass()
    {
        InventoryManager.Instance.PlayerCollect(magnifyingGlass);
    }

    public void CollectBackpack()
    {
        InventoryManager.Instance.PlayerCollect(backpack);
    }

    public void GiveGlass()
    {
        InventoryManager.Instance.NPCCollect(magnifyingGlass);
    }

    public void GiveBackpack()
    {
        InventoryManager.Instance.NPCCollect(backpack);
    }

    private void OnDisable()
    {
        //GameFilesManager.OnCreateStory -= AssignCurrentStory;
        DialogueManager.OnCreateStory -= AssignCurrentStory;
        GameFilesManager.OnCollectCat -= CollectCat;
    }
}
