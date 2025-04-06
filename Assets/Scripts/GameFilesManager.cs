using System;
using Ink.Runtime;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Security;

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

	public GameFilesData gameFiles; //scriptable object that will store everything

	//public static event Action<Story> OnCreateStory;
    public static event Action OnExitGameFiles;
    public static Action OnClickFileManager;
	public static event Action OnCollectCat;
    public static event Action OnCollectList;

    void Awake () 
	{
		// Remove the default message
		RemoveChildren();
        StartStory();
    }

	// Creates a new Story object with the compiled story which we can then play!
	void StartStory () 
	{
		story = new Story (mainJSONAsset.text);
        gameFiles.StartListening(story);

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
        //OnCreateStory?.Invoke(story);
        RefreshView();
	}
	
	void RefreshView () 
	{
		// Remove all the UI on screen
		RemoveChildren ();
		
		// Read all the content until we can't continue any more
		while (story.canContinue) 
		{
			string text = story.Continue ();
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
        else if (buttonText.Length > 14 && buttonText.Length <= 30)
		{
			RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
			rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 230);
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

	void ExitGameFiles()
	{
		OnExitGameFiles();
	}
}
