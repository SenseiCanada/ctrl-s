using System;
using Ink.Runtime;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections;

public class GameFilesManager : MonoBehaviour 
{

    [SerializeField]
    private TextAsset mainJSONAsset = null;
    public Story story;

    //UI elements for placing text
    [SerializeField]
    private GameObject gameFilesPanel;
    [SerializeField]
	private GameObject buttonsParentPrefab;
	private GameObject buttonsParentObj;

    // UI Prefabs
    [SerializeField]
    private TMP_Text textPrefab = null;
    [SerializeField]
    private Button buttonPrefab = null;

    [SerializeField]
    private string inkSave = null;

    public GameFilesData gameData; //scriptable object that will store everything

	//public static event Action<Story> OnCreateStory;
    public static event Action OnExitGameFiles;
    public static event Action OnEnterSafeMode;
    public static Action OnClickFileManager;
	public static event Action OnCollectCat;
    public static event Action OnCollectList;
    public static event Action<Story> OnCreateFilesStory;
    public event Action<string, string> OnNewStorySave;

    void Awake () 
	{
		// Remove the default message
		RemoveChildren();
        StartStory();
        CompleteMessageDisplayer.OnCompleteCompilation += SaveInkState;
        //CompleteMessageDisplayer.OnRestartCompile += StartStory; //not needed because complete message displayer will just restart the scene
        
    }

	// Creates a new Story object with the compiled story which we can then play!
	void StartStory () 
	{
        story = new Story (mainJSONAsset.text);
        //check if there's a save state
        if (gameData.dialogueSaves.ContainsKey("gameFiles"))
        {
            Debug.Log($"Game Files is starting from an existing save");
            string inkSave = gameData.dialogueSaves["gameFiles"];
            if (inkSave != string.Empty)
            {
                story.state.LoadJson(gameData.dialogueSaves["gameFiles"]);
                story.ChoosePathString("enter");
                Debug.Log("currentStory state set to save JSON");
            }
        }
        gameData.StartListening(story);//this loads variables from before back in.

        //add a error handling
        story.onError += (msg, type) => {
            if (type == Ink.ErrorType.Warning)
                Debug.LogWarning(msg);
            else
                Debug.LogError(msg);
        };

        story.BindExternalFunction("exitGameFiles", () => { ExitGameFiles(); });
        story.BindExternalFunction("addCat", () => { OnCollectCat(); });
        story.BindExternalFunction("addList", () => { OnCollectList(); });
        story.BindExternalFunction("takeTwoTurns", () => { StartCoroutine(TakeTwoTurns()); });
        story.BindExternalFunction("enterSafeMode", () => { OnEnterSafeMode(); });
        OnCreateFilesStory?.Invoke(story);
        RefreshView();
	}
	
    void RefreshView () 
	{
		// Remove all the UI on screen
		RemoveChildren ();
		
		// Read all the content until we can't continue any more
		while (story.canContinue) 
		{
			string text = story.ContinueMaximally();
			text = text.Trim();
			CreateContentView(text);
		}

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0)
        {
			for (int i = 0;  i < story.currentChoices.Count; i++)
			{
                Choice choice = story.currentChoices[i];
                Button button = CreateChoiceView(choice.text.Trim());
                button.onClick.AddListener(delegate
                {
                    OnClickChoiceButton(choice);
                });
            }
        }
	}

	void OnClickChoiceButton (Choice choice) 
	{
		story.ChooseChoiceIndex (choice.index);
		RefreshView();
        OnClickFileManager?.Invoke();
    }

	// Creates a textbox showing the the line of text
	void CreateContentView(string text)//, string timerText) 
	{
		CreateMainText(text);
		if (story.currentChoices.Count > 0)
		{
			CreateButtons();
		}
	}

	void CreateMainText (string text)
	{
        TMP_Text mainText = Instantiate(textPrefab) as TMP_Text;
        mainText.transform.SetParent(gameFilesPanel.transform, false);
        //mainText.transform.SetAsLastSibling();
        mainText.text = text;
    }

	void CreateButtons()
	{
        GameObject buttonsParent = Instantiate(buttonsParentPrefab, gameFilesPanel.transform);
        buttonsParentObj = buttonsParent;
    }
	
	// Creates a button showing the choice text
	Button CreateChoiceView (string text) {
		// Creates the button from a prefab
		Button choice = Instantiate (buttonPrefab) as Button;
		if (buttonsParentObj != null)
		{
            choice.transform.SetParent(buttonsParentObj.transform, false);
            TMP_Text choiceText = choice.GetComponentInChildren<TMP_Text>();
            choiceText.text = text;
			ResizeButtonPrefab(choice, text);
        }
        return choice;
	}

	void ResizeButtonPrefab(Button buttonPrefab, string buttonText)
	{
        Debug.Log("creating button for text with lenght " + buttonText.Length);
        if (buttonText.Length > 0 && buttonText.Length <= 10)
		{
			RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
			rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 100);
		}
        else if (buttonText.Length > 10 && buttonText.Length <= 14)
        {
            RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
            rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 150);
        }
        else if (buttonText.Length > 14 && buttonText.Length <= 22)
		{
			RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
			rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 230);
		}
        else if (buttonText.Length > 22) //&& buttonText.Length <= 40)
        {
            RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
            rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 270);
        }
    }
	
	// Destroys all the children of this gameobject (all the UI)
	void RemoveChildren () {
		int childCount = gameFilesPanel.transform.childCount;
		for (int i = childCount - 1; i >= 0; --i) 
		{
			Destroy (gameFilesPanel.transform.GetChild (i).gameObject);
		}
	}

	//ink external functions
	void ExitGameFiles()
	{
        OnExitGameFiles();
	}
    
    void SaveInkState()
    {
        string savedJson = story.state.ToJson();
        string NPCID = (string)story.variablesState["NPCID"];
        if (gameData.dialogueSaves.ContainsKey(NPCID))
        {
            gameData.dialogueSaves[NPCID] = savedJson;
        }
        else gameData.dialogueSaves.Add(NPCID, savedJson);
        Debug.Log("Game Manager added ink save to game data SO");
    }

	IEnumerator TakeTwoTurns()
	{
        yield return new WaitForSeconds(0f);
        story.ChoosePathString("blank_knot");
        if (story.canContinue)
        {
            RefreshView();
        }

        yield return new WaitForSeconds(2f);
        OnClickFileManager?.Invoke();
		Debug.Log("TakeTwoTurns called OnClick once");

        yield return new WaitForSeconds(2f);
        OnClickFileManager?.Invoke();
        Debug.Log("TakeTwoTurns called OnClick twice");

        yield return new WaitForSeconds(2f);
        story.ChoosePathString("home");
        if (story.canContinue)
		{
            RefreshView();
        }
        else yield return new WaitForSeconds(.5f);
        Debug.Log("after choosing home, can't continue");
    }

    private void OnDisable()
    {
        CompleteMessageDisplayer.OnCompleteCompilation -= SaveInkState;
    }
}
