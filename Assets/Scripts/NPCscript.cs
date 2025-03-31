using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using System;

public class NPCscript : MonoBehaviour
{
    [SerializeField]
    protected TextAsset inkJSONAsset = null;

    [SerializeField]
    protected Story story; //Respective story for each NPC

    [SerializeField]
    protected Animator animator;

    [SerializeField]
    private GameObject convoAlertObj;

    private bool isTalking;

    [SerializeField]
    protected string NPCID;

    [SerializeField]
    private string inkSave = null;

    [SerializeField]
    private GameFilesData gameData;

    public event Action<TextAsset> OnSelectStory;
    public event Action<string> OnLoadInkSave;
    // Start is called before the first frame update
    void Start()
    {
        if (convoAlertObj != null)
        {
            convoAlertObj.SetActive(true);
        } else Debug.Log("NPC object doesn't have a convoAlert");

        FindFirstObjectByType<DialogueManager>().FinishedTalking += FinishTalking;
        FindFirstObjectByType<DialogueManager>().OnNewStorySave += RegisterInkSave;

        if (gameData.dialogueSaves.ContainsKey(NPCID))
        {
            inkSave = gameData.dialogueSaves[NPCID];
        }
        story = new Story(inkJSONAsset.text);
    }

    // Update is called once per frame
    void Update()
    {

    }
    protected void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            isTalking = true;
            if (animator != null)
            {
                animator.SetBool("isTalking", true);
            }
            
            //send ink file as JSON to dialogue manager + story save state
            other.GetComponent<PlayerDialogueScript>().TalkToNPC(inkJSONAsset, inkSave, NPCID);

            convoAlertObj.SetActive(false);
        }
    }

    protected void FinishTalking()
    {
        isTalking = false;
        if (animator != null)
        {
            animator.SetBool("isTalking", false);
        }
    }

    void RegisterInkSave(string newInkSave, string currentNPCID)
    {
        if(currentNPCID == NPCID)
        {
            inkSave = newInkSave;
            if (gameData.dialogueSaves.ContainsKey(currentNPCID))
            {
                gameData.dialogueSaves[currentNPCID] = newInkSave;
                
            } else gameData.dialogueSaves.Add(currentNPCID, newInkSave);
        }
    }
}
