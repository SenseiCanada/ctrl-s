using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using System;

public class DevInkManipulator : MonoBehaviour
{
    [SerializeField]
    protected TextAsset inkJSONAsset = null;
    [SerializeField]
    protected Story story; //Respective story for each NPC
    [SerializeField]
    protected string NPCID;

    private string inkSave = null;

    public event Action<string> OnSelectStory;
    // Start is called before the first frame update
    void Start()
    {
        FindFirstObjectByType<DialogueManager>().FinishedTalking += FinishTalking;
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
            other.GetComponent<PlayerDialogueScript>().TalkToNPC(inkJSONAsset, inkSave, NPCID);
        }
    }

    protected void FinishTalking()
    {
      
    }
}
