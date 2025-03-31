using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.EventSystems;
using System;
using UnityEngine.SceneManagement;

public class IntroGameManager : MonoBehaviour
{
    private bool canInteract;
    private bool sawFirstInterct;

    [SerializeField]
    private RectTransform dialoguePanelPrefab;
    [SerializeField]
    private RectTransform dialogueParent;
    [SerializeField]
    private RectTransform textParent;
    [SerializeField]
    private RectTransform choicesParent;
    [SerializeField]
    private Button closeButtonPrefab;
    [SerializeField]
    private TMP_Text dialogueTextPrefab;

    private RectTransform dialoguePanelObj;
    private TMP_Text dialogueTextlObj;
    private Button dialogueChoicesObj;

    public static event Action OnDialogueStarted;
    public static event Action OnDialogueEnded;
    public static event Action OnFirstDialogueEnded;

    private IntroConsoleText consoleTextVar;

    // Start is called before the first frame update
    void Start()
    {
        InteractCollider.OnIntroColliderEnter += EnableInteract;
        InteractCollider.OnInteractColliderExit += DisableInteract;

        sawFirstInterct = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (canInteract && Input.GetKeyDown(KeyCode.E))
        {
            DisplayDialogue();
        }
    }

    void EnableInteract(IntroConsoleText consoleText)
    {
        canInteract = true;
        consoleTextVar = consoleText;
    }
    void DisableInteract()
    {
        canInteract = false;
    }
    void DisplayDialogue()
    {
        OnDialogueStarted();
        RectTransform newDialoguePanel = Instantiate(dialoguePanelPrefab, dialogueParent);
        newDialoguePanel.transform.SetAsFirstSibling();
        dialoguePanelObj = newDialoguePanel;
        TMP_Text newDialogueText = Instantiate(dialogueTextPrefab, textParent);
        newDialogueText.transform.SetAsFirstSibling();
        newDialogueText.text = consoleTextVar.mainText;
        dialogueTextlObj = newDialogueText;
        Button newCloseButton = Instantiate(closeButtonPrefab, choicesParent);
        newCloseButton.transform.SetAsLastSibling();
        dialogueChoicesObj = newCloseButton;
        newCloseButton.onClick.AddListener(ClosePanel);
        newCloseButton.GetComponentInChildren<TMP_Text>().text = consoleTextVar.leaveButtonText;

        if (consoleTextVar.enterLobbyButton == "Enter")
        {
            Button newEnterButton = Instantiate(closeButtonPrefab, choicesParent);
            newEnterButton.transform.SetAsLastSibling();
            newEnterButton.onClick.AddListener(EnterLobby);
            newEnterButton.GetComponentInChildren<TMP_Text>().text = consoleTextVar.enterLobbyButton;
        }
    }

    void EnterLobby()
    {
        SceneManager.LoadScene("Lobby");
    }
        void ClosePanel()
        {
            if (dialoguePanelObj != null && dialogueTextlObj != null && dialogueChoicesObj != null)
            {
                dialoguePanelObj.gameObject.SetActive(false);
                dialogueChoicesObj.gameObject.SetActive(false);
                dialogueTextlObj.gameObject.SetActive(false);
            }
            if (!sawFirstInterct)
            {
                OnFirstDialogueEnded();
                sawFirstInterct = true;
            }
        }
        void OnDisable()
        {
            InteractCollider.OnIntroColliderEnter -= EnableInteract;
            InteractCollider.OnInteractColliderExit -= DisableInteract;
        }


}

