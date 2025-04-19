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

    // Start is called before the first frame update
    void Start()
    {
        EKey.SetActive(false);
        
        InteractColliderLobby.OnInteractColliderEnter += ShowE;
        InteractColliderLobby.OnInteractColliderExit += HideE;
        FindFirstObjectByType<DialogueManager>().StartTalking += HideE;
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


    private void OnDisable()
    {
        InteractColliderLobby.OnInteractColliderEnter -= ShowE;
        InteractColliderLobby.OnInteractColliderExit -= HideE;
        FindFirstObjectByType<DialogueManager>().StartTalking -= HideE;
    }
}
