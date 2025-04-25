using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem.HID;
using UnityEngine.UI;
using static Unity.Burst.Intrinsics.X86.Sse4_2;


public class TutorialUIDisplayerLobby : MonoBehaviour
{
    [SerializeField]
    private GameObject EKey;
    [SerializeField]
    private GameObject invTutorial;
    private Animator intTutorialAnim;

    // Start is called before the first frame update
    void Start()
    {
        EKey.SetActive(false);
        invTutorial.SetActive(false);
        intTutorialAnim = invTutorial.GetComponent<Animator>();
        
        InteractColliderLobby.OnInteractColliderEnter += ShowE;
        InteractColliderLobby.OnInteractColliderExit += HideE;
        FindFirstObjectByType<DialogueManager>().StartTalking += HideE;
        InventoryInkConnector.OnTradeWindowOpen += ShowInvTutorial;
        InventoryInkConnector.OnTradeWindowHide += HideInvTutorial;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
   
    void ShowE()
    {
        EKey.SetActive(true);
    }

    void HideE()
    {
        EKey.SetActive(false);
    }

    void ShowInvTutorial()
    {
        invTutorial.SetActive(true);
        intTutorialAnim.SetBool("inventoryOpen", true);
    }

    void HideInvTutorial()
    {
        invTutorial.SetActive(false);
        intTutorialAnim.SetBool("inventoryOpen", false);
    }

    private void OnDisable()
    {
        InteractColliderLobby.OnInteractColliderEnter -= ShowE;
        InteractColliderLobby.OnInteractColliderExit -= HideE;
        FindFirstObjectByType<DialogueManager>().StartTalking -= HideE;
        InventoryInkConnector.OnTradeWindowOpen -= ShowInvTutorial;
        InventoryInkConnector.OnTradeWindowHide -= HideInvTutorial;
    }
}
