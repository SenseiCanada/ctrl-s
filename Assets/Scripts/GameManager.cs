using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Ink.Runtime;
using TMPro;

public class GameManager : MonoBehaviour
{
    //timer UI
    [SerializeField]
    private RectTransform processesBackground;
    [SerializeField]
    private GameObject processesPrefab;
    private string currentProcessText;
    //private TMP_Text currentProcessValue;

    public GameFilesData gameFiles;

    private string countTurnsInkBool;
    private bool countTurnsUnityBool; //necessary for dev pannel

    private Story currentStory;

    private InventoryItem item;

    public int turnsTaken;
    public int totalTurns;
    public int turnsRemaining;
    private int attributesRemaining;//how many SO/attributes to display before end
    private int attributeListIncrement;
    private int totalNullAttributes;

    public static event Action<RectTransform, int> OnTurnsElapsed;
    public static event Action<int> OnTurnsIncrement;

    // Start is called before the first frame update
    private void Awake()
    {
        GameFilesManager.OnClickFileManager += UpdateTurns;
        GameFilesData.OnUnityRegisterInkVar += UpdateInkBool;
        DevPanelGameFiles.OnPauseTurns += UpdateUnityBool;
        DevPanelGameFiles.OnStartTurns += UpdateUnityBool;
        InventoryManager.OnPlayerCollect += UpdateItem;
        InventoryManager.OnNPCCollect += UpdateItem;
        
    }
    void Start()
    {
        attributesRemaining = gameFiles.playerAttributes.Count;
        totalTurns = attributesRemaining;
        turnsTaken = 0;
        attributeListIncrement = 0;
        turnsRemaining = totalTurns - turnsTaken;
        OnTurnsIncrement?.Invoke(turnsTaken);
        //countTurnsUnityBool = true; //necessary for dev panel

        //instantiate first process
        //GameObject processessObj = Instantiate(processesPrefab, processesBackground);
        //processessObj.transform.SetAsLastSibling();
        //TextMeshProUGUI[] textComponents = processessObj.GetComponentsInChildren<TextMeshProUGUI>();
        //if (textComponents.Length >= 2)
        //{
        //    currentProcessText = textComponents[0];
        //    currentProcessValue = textComponents[1];
        //}
        //currentProcessText.text = "Compilation will begin momentarily";
        //currentProcessValue.text = "...";

        //store nullAttributes in variable
        totalNullAttributes = gameFiles.nullAttributes.Count;
        Debug.Log("null attribute count: " + totalNullAttributes);


    }

    // Update is called once per frame
    void Update()
    {
        
    }
    void UpdateTurns()
    {
        if (countTurnsInkBool == "true") //&& countTurnsUnityBool)
        {
            Debug.Log("Turns Remaining before 0 check: " + turnsRemaining);
            if (turnsRemaining <= 0)
            {
                Debug.Log("OnTurnsElapsed is being invoked!");
                OnTurnsElapsed?.Invoke(processesBackground, totalNullAttributes);
            }
            else
            {
                turnsTaken++;
                turnsRemaining = totalTurns - turnsTaken;
                Debug.Log("Turns Remaining after turns increase: " + turnsRemaining);
                UpdateTurnText();
                OnTurnsIncrement?.Invoke(turnsTaken);
            }
        }
    }
    void UpdateTurnText()
    {
        GameObject processessObj = Instantiate(processesPrefab, processesBackground); //instantiate prefab
        processessObj.transform.SetAsLastSibling();
        PlayerAttribute currentAttribute = gameFiles.playerAttributes[0+attributeListIncrement]; //get access to player attribute list
        Debug.Log("current attribute text = "+ currentAttribute.attributeText);
        currentProcessText = currentAttribute.attributeText + " " + currentAttribute.attributeValue;
        TextMeshProUGUI textComponent = processessObj.GetComponentInChildren<TextMeshProUGUI>();
        textComponent.text = currentProcessText;
        attributeListIncrement++;
    }
    void UpdateInkBool(string varName, string varValue)
    {
        if(varName == "countTurns")
        {
            countTurnsInkBool = varValue;
            Debug.Log("Unity know Ink var counTurns = " + varValue);
        }
    }

    void UpdateUnityBool(bool isUnityCountingTurns)
    {
        countTurnsUnityBool = isUnityCountingTurns;
    }

    void UpdateItem(InventoryItem newItem, int ItemCount) //add to avoid null object reference in invetory manager
    {
        Debug.Log("New item: " + newItem + " registered by GameManager");
    } 

    private void OnDisable()
    {
        GameFilesManager.OnClickFileManager -= UpdateTurns;
        GameFilesData.OnUnityRegisterInkVar -= UpdateInkBool;
        DevPanelGameFiles.OnPauseTurns -= UpdateUnityBool;
        DevPanelGameFiles.OnStartTurns -= UpdateUnityBool;
        InventoryManager.OnPlayerCollect -= UpdateItem;
        InventoryManager.OnNPCCollect -= UpdateItem;
        Debug.Log("Game Manager unsuscribed");
    }
}
