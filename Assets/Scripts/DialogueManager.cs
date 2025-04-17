using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using TMPro;
using UnityEngine.UI;
using System;
using System.ComponentModel;
using UnityEngine.ProBuilder.MeshOperations;

public class DialogueManager : MonoBehaviour
{
    //INK Plugin Assets
    [SerializeField]
    private TextAsset inkJSONAsset = null;
    public Story currentStory;
    public string currentNPCID;

    //UI Anchors where dialogue tree appears.
    [SerializeField]
    private RectTransform npcDialogueParent;
    [SerializeField]
    private GameObject npcPrefabContainer;
    [SerializeField]
    private GameObject dialoguePanelAnchor;
    [SerializeField]
    private GameObject npcNameUIparent;
    [SerializeField]
    private GameObject dialogueTextAnchor;
    [SerializeField]
    private GameObject dialogueChoicesAnchorPrefab;
    private GameObject dialogueChoicesAnchorObj;
    [SerializeField]
    private GameObject relationshipAnchor;

    // UI Prefabs
    [SerializeField]
    private GameObject convoPanelPrefab;
    private GameObject convoPanelObj;
    [SerializeField]
    private GameObject spkrNamePrefab = null;
    [SerializeField]
    private TMP_Text spkrTextPrefab = null;
    [SerializeField]
    private Button buttonPrefab = null;
    [SerializeField]
    private GameObject relationshipPrefab;

    //private DialogueVariables dialogueVars;
    public GameFilesData gameFiles;
    private Choice buttonChoice;

    private bool dialogueEnded;
    private bool refusedItem;

    public static event Action<Story> OnCreateStory;
    public static event Action OnShowTradeWindow;
    public event Action FinishedTalking; 
    public event Action StartTalking;
    public static event Action OnEnterGameFiles, OnEnterLobby;
    public event Action<string, string> OnNewStorySave;
    private bool closeDialoguePanel;

    private void OnEnable()
    {
        RemoveChildren(); //clears all UI story elements
        //StartStory();
        
    }

    // Start is called before the first frame update
    void Start()
    {
        //subscribe to select dialogue function in Player script
        FindFirstObjectByType<PlayerDialogueScript>().SelectDialogue += StartStory;
        InventoryManager.OnNPCRefuse += NPCRefuseItem;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void StartStory(TextAsset npcStory, string inkSave, string NPCID)
    {
        dialogueEnded = false;
        refusedItem = false;
        StartTalking?.Invoke();
        currentNPCID = NPCID;
        currentStory = new Story(npcStory.text);
        if (inkSave != string.Empty)
        {
            currentStory.state.LoadJson(inkSave);
            //Debug.Log("currentStory state set to save JSON");
            currentStory.ChoosePathString(currentNPCID + "_resume");
        }
        AddUnityInkFunctionality(); //add variable observer after load
        
        RefreshView();
    }

    void AddUnityInkFunctionality()
    {
        //add a error handling
        currentStory.onError += (msg, type) => {
            if (type == Ink.ErrorType.Warning)
                Debug.LogWarning(msg);
            else
                Debug.LogError(msg);
        };

        //Unity variable dictionary starts recording value changes
        gameFiles.StartListening(currentStory);
        if (OnCreateStory != null)
            OnCreateStory(currentStory);
        closeDialoguePanel = false;

        //bind external functions
        currentStory.BindExternalFunction("quitDialogue", (Func<object>)(() =>
        {
            CloseDialoguePanel();
            return null;
        }), true);
        currentStory.BindExternalFunction("enterGameFiles", () => { EnterGameFiles(); });
        currentStory.BindExternalFunction("enterLobby", () => { EnterLobby(); });
    }

    void RefreshView()
    {
        RemoveChildren();
        while (currentStory.canContinue)
        {
            string text = currentStory.ContinueMaximally()?.Trim(); // Ensure text is not null
            if (dialogueEnded)
            {
                RemoveChildren();

                return;
            }
            else
            {
                CreateContentView(text); //display on screen

                //Creates buttons based on number of options in the INK story.
                if (currentStory.currentChoices.Count > 0)
                {
                    for (int i = currentStory.currentChoices.Count - 1; i >= 0; i--)
                    {
                        Choice choice = currentStory.currentChoices[i];
                        Button button = CreateChoiceView(choice.text.Trim());
                        button.onClick.AddListener(delegate
                        {
                            OnClickChoiceButton(choice);
                        });
                    }
                }
            }
        }
    }

    //Handler for dialogue tree buttons; Wipes current UI & generates new options.
    void OnClickChoiceButton(Choice choice)
    {
        currentStory.ChooseChoiceIndex(choice.index);
        RefreshView();
    }

    //Creates the dialogue box with the passed text.
    void CreateContentView(string text)
    {
        //create background panel
        GameObject dialoguePanelParent = Instantiate(dialoguePanelAnchor, npcPrefabContainer.transform);
        GameObject convoPanel = Instantiate(convoPanelPrefab, dialoguePanelParent.transform);
        convoPanelObj = convoPanel;
        //create speaker name panel
        GameObject speakerNameParent = Instantiate(npcNameUIparent, npcPrefabContainer.transform);
        GameObject speakerName = Instantiate(spkrNamePrefab);
        speakerName.transform.SetParent(speakerNameParent.transform, false);
        TMP_Text spkrNameText = speakerName.GetComponentInChildren<TMP_Text>();
        spkrNameText.text = (string)currentStory.variablesState["NPCName"];

        //add relationship display
        GameObject relationshipObj = Instantiate(relationshipPrefab, relationshipAnchor.transform);

        //create dialogue text
        GameObject dialogueTextParent = Instantiate(dialogueTextAnchor, npcPrefabContainer.transform);
        TMP_Text speakerText = Instantiate(spkrTextPrefab) as TMP_Text;
        speakerText.text = text;
        speakerText.transform.SetParent(dialogueTextParent.transform, false);
        speakerText.transform.SetAsFirstSibling();

        //create choices anchor once
        GameObject choicesParent = Instantiate(dialogueChoicesAnchorPrefab, npcPrefabContainer.transform);
        dialogueChoicesAnchorObj = choicesParent;
    }

    //Creates the buttons for the given dialogue options.
    Button CreateChoiceView(string text)
    {
       Button choice = Instantiate(buttonPrefab) as Button;
        if (convoPanelObj != null)
        {
            choice.transform.SetParent(dialogueChoicesAnchorObj.transform, false);
            choice.transform.SetAsFirstSibling();
            TMP_Text choiceText = choice.GetComponentInChildren<TMP_Text>();
            choiceText.text = text;
            VerticalLayoutGroup choiceLayoutGroup = choice.GetComponentInParent<VerticalLayoutGroup>();
        }
        return choice;
    }

    //Wipes the dialogue tree panel of all assets.
    void RemoveChildren()
    {
        //Debug.Log("Removing children from dialogue UI...");
        int dialogueChildCount = npcPrefabContainer.transform.childCount;
        for (int i = dialogueChildCount - 1; i >= 0; i--)
        {
            Destroy(npcPrefabContainer.transform.GetChild(i).gameObject);
        }
        int relationshipChildCount = relationshipAnchor.transform.childCount;
        for (int i = relationshipChildCount - 1; i >= 0; i--)
        {
            Destroy(relationshipAnchor.transform.GetChild(i).gameObject);
        }
    }

    void CloseDialoguePanel()
    {
        Debug.Log("CloseDialoguePanel was called");
        dialogueEnded = true;
        Debug.Log("after CloseDialoguePanel, dialogueEnded is " + dialogueEnded);

        //save dialogue
        string savedJson = currentStory.state.ToJson();
        string NPCID = (string)currentStory.variablesState["NPCID"];
        OnNewStorySave(savedJson, NPCID);

        //close dialogue
        FinishedTalking?.Invoke();
        RemoveChildren();
    }

    void EnterGameFiles()
    {
        string savedStoryState = currentStory.state.ToJson();
        FinishedTalking?.Invoke();
        OnEnterGameFiles();
    }

    void EnterLobby()
    {
        FinishedTalking?.Invoke();
        OnEnterLobby();
    }

    void NPCRefuseItem(InventoryItem item)
    {
        //refusedItem = true;
        string NPCID = gameFiles.variables["NPCID"].ToString();//(string)currentStory.variablesState["NPCID"];
        string refuseKnot = NPCID + "_refuseItem";
        gameFiles.currentStory.ChoosePathString(NPCID+"_refuseItem");
        if (currentStory.canContinue)
        {
            RefreshView();
        }
        else return;
    }
}
