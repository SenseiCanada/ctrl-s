using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using Ink.Runtime;
using TMPro;
using System.Reflection;

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
    int maxAttributeValueIncrement = 0;

    public static event Action<RectTransform, int> OnTurnsElapsed;
    public static event Action<int, int> OnTurnsIncrement;

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
        //attributes remaining set to sum of values of attributes
        foreach (PlayerAttribute attribute in gameFiles.playerAttributes)
        {
            int newAttributeValue;
            if (int.TryParse(attribute.attributeValue, out newAttributeValue))
            {
                totalTurns += newAttributeValue;
                Debug.Log("Added "+ newAttributeValue + " to total turns");
            }
            else totalTurns += 1;
            Debug.Log("Added only 1 to total turns");
        }
        Debug.Log("After parsing attributes, total turns = " +  totalTurns);

        //attributesRemaining = gameFiles.playerAttributes.Count;
        //totalTurns = attributesRemaining;
        turnsTaken = 0;
        attributeListIncrement = 0;
        turnsRemaining = totalTurns - turnsTaken;
        OnTurnsIncrement?.Invoke(totalTurns, turnsTaken);
        
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
                OnTurnsIncrement?.Invoke(totalTurns, turnsTaken);
            }
        }
    }
    void UpdateTurnText()
    {
        //check value of attribute
        PlayerAttribute currentAttribute = gameFiles.playerAttributes[0 + attributeListIncrement]; //get access to player attribute list
        int maxAttributeValue = 0;
        // if value is greater than one, keep making text objects with increasing values until done
        if (int.TryParse(currentAttribute.attributeValue, out maxAttributeValue))
        {
            int currentValue = 1 + maxAttributeValueIncrement;
            if (currentValue <= maxAttributeValue)
            {
                CreateProcessText(currentAttribute, currentValue.ToString(), maxAttributeValue);
                maxAttributeValueIncrement++; // keep going
            }
            else
            {
                // Finished this attribute, move to the next one
                attributeListIncrement++;
                maxAttributeValueIncrement = 0; // reset increment for next attribute
            }
            //CreateProcessText(currentAttribute, currentValue.ToString(), maxAttributeValue);
            //if (maxAttributeValueIncrement <= maxAttributeValue)
            //{
            //    maxAttributeValueIncrement++;

            //}
            //else return;//attributeListIncrement++;
        }
        else
        {
            CreateProcessText(currentAttribute, currentAttribute.attributeValue, maxAttributeValue);
            attributeListIncrement++;
            maxAttributeValueIncrement = 0;
        }
    }

    void CreateProcessText(PlayerAttribute attribute, string value, int maxValue)
    {
        GameObject processessObj = Instantiate(processesPrefab, processesBackground); //instantiate prefab
        processessObj.transform.SetAsLastSibling();
        Debug.Log("current attribute text = " + attribute.attributeText);
        if (maxValue != 0)
        {
            currentProcessText = attribute.attributeText + " " + value + "/" + maxValue;
        } else currentProcessText = attribute.attributeText + " " + value;
        TextMeshProUGUI textComponent = processessObj.GetComponentInChildren<TextMeshProUGUI>();
        textComponent.text = currentProcessText;
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
