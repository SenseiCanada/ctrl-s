using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem.HID;
using UnityEngine.UI;
using static Unity.Burst.Intrinsics.X86.Sse4_2;


public class TutorialUIDisplayer : MonoBehaviour
{
    [SerializeField]
    private Image AKey;
    [SerializeField]
    private Image WKey;
    [SerializeField]
    private Image DKey;
    [SerializeField]
    private Image SKey;
    [SerializeField]
    private Image EKey;


    // Start is called before the first frame update
    void Start()
    {
        AKey.enabled = false;
        DKey.enabled = false;
        SKey.enabled = false;
        EKey.enabled = false;
        
        WCollider.OnWColliderExit += HideW;
        ACollider.OnAColliderEnter += ShowA;
        ACollider.OnAColliderExit += HideA;
        ACollider.OnAColliderExit += HideD;
        InteractCollider.OnIntroColliderEnter += ShowEIntro;
        InteractCollider.OnInteractColliderEnter += ShowE;
        InteractCollider.OnInteractColliderExit += HideE;
        InteractColliderLobby.OnInteractColliderEnter += ShowE;
        InteractColliderLobby.OnInteractColliderExit += HideE;
        IntroGameManager.OnDialogueStarted += HideE;
        IntroGameManager.OnFirstDialogueEnded += ShowD;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void HideW()
    {
        WKey.enabled = false;
    }

    void ShowA()
    {
        AKey.enabled = true;
    }

    void HideA()
    {
        AKey.enabled = false;
    }

    void ShowEIntro(IntroConsoleText consoleText)
    {
        EKey.enabled = true;
    }

    void ShowE()
    {
        EKey.enabled = true;
    }

    void HideE()
    {
        EKey.enabled = false;
    }

    void ShowD()
    {
        DKey.enabled = true;
    }

    void HideD()
    {
        DKey.enabled = false;
    }

    private void OnDisable()
    {
        WCollider.OnWColliderExit -= HideW;
        ACollider.OnAColliderEnter -= ShowA;
        ACollider.OnAColliderExit -= HideA;
        InteractCollider.OnIntroColliderEnter -= ShowEIntro;
        InteractCollider.OnInteractColliderEnter -= ShowE;
        InteractCollider.OnInteractColliderExit -= HideE;
        InteractColliderLobby.OnInteractColliderEnter -= ShowE;
        InteractColliderLobby.OnInteractColliderExit -= HideE;
        IntroGameManager.OnDialogueStarted -= HideE;
        IntroGameManager.OnFirstDialogueEnded -= ShowD;
        ACollider.OnAColliderExit -= HideD;
    }
}
