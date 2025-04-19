using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem.HID;
using UnityEngine.UI;
using static Unity.Burst.Intrinsics.X86.Sse4_2;


public class TutorialUIDisplayer : MonoBehaviour
{
    [SerializeField]
    private GameObject AKey;
    [SerializeField]
    private GameObject WKey;
    [SerializeField]
    private GameObject DKey;
    [SerializeField]
    private GameObject SKey;
    [SerializeField]
    private GameObject EKey;


    // Start is called before the first frame update
    void Start()
    {
        AKey.SetActive(false);
        DKey.SetActive(false);
        SKey.SetActive(false);
        EKey.SetActive(false);
        
        WCollider.OnWColliderExit += HideW;
        ACollider.OnAColliderEnter += ShowA;
        ACollider.OnAColliderExit += HideA;
        ACollider.OnAColliderExit += HideD;
        InteractCollider.OnInteractColliderEnter += ShowE;
        InteractCollider.OnInteractColliderExit += HideE;
        InteractColliderLobby.OnInteractColliderEnter += ShowE;
        InteractColliderLobby.OnInteractColliderExit += HideE;
        FindFirstObjectByType<DialogueManager>().StartTalking += HideE;
        IntroGameManager.OnDialogueStarted += HideE;
        IntroGameManager.OnFirstDialogueEnded += ShowD;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void HideW()
    {
        WKey.SetActive(false);
    }

    void ShowA()
    {
        AKey.SetActive(true);
    }

    void HideA()
    {
        AKey.SetActive(false);
    }
    void ShowE()
    {
        EKey.SetActive(true);
    }

    void HideE()
    {
        EKey.SetActive(false);
    }

    void ShowD()
    {
        DKey.SetActive(true);
    }

    void HideD()
    {
        DKey.SetActive(false);
    }

    private void OnDisable()
    {
        WCollider.OnWColliderExit -= HideW;
        ACollider.OnAColliderEnter -= ShowA;
        ACollider.OnAColliderExit -= HideA;
        InteractCollider.OnInteractColliderEnter -= ShowE;
        InteractCollider.OnInteractColliderExit -= HideE;
        InteractColliderLobby.OnInteractColliderEnter -= ShowE;
        InteractColliderLobby.OnInteractColliderExit -= HideE;
        IntroGameManager.OnDialogueStarted -= HideE;
        IntroGameManager.OnFirstDialogueEnded -= ShowD;
        ACollider.OnAColliderExit -= HideD;
    }
}
