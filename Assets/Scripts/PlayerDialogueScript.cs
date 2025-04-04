using StarterAssets;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerDialogueScript : MonoBehaviour
{
    [SerializeField]
    Collider interactCollider; //on the player

    [SerializeField]
    protected CharacterController playerController;

    protected bool isTalking;
    public event Action<TextAsset, string, string> SelectDialogue; //NPC Game Object

    [SerializeField]
    private ThirdPersonController thirdPersonController;

    [SerializeField]
    private Animator playerAnimator;
    
    // Start is called before the first frame update
    void Start()
    {
        FindFirstObjectByType<DialogueManager>().FinishedTalking += FinishTalking;
        isTalking = false;

    }

    // Update is called once per frame
    void Update()
    {
        if (!isTalking)
        {
            if (Input.GetKeyDown(KeyCode.E))
            {
                Interact();
            }
        }

    }

    //Activates the hitbox for interacting with NPCs and other objects.
    public void Interact()
    {
        interactCollider.enabled = true;
        Invoke("TurnOffInteract", 0.1f);
    }

    //Deactivates said hitbox.
    void TurnOffInteract()
    {
        interactCollider.enabled = false;
    }

    public void TalkToNPC(TextAsset NPCDialogue, string inkSave, string NPCID)
    {
        isTalking = true;
        playerAnimator.SetBool("isTalking", true);
        thirdPersonController.enabled = false;
        SelectDialogue?.Invoke(NPCDialogue, inkSave, NPCID);
    }

    private void FinishTalking()
    {
        isTalking = false;
        thirdPersonController.enabled = true;
        playerAnimator.SetBool("isTalking", false);
        //playerController.enabled = true;
    }

}
