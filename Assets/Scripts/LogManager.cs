using System;
using System.Collections;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

public class LogManager : MonoBehaviour
{
    [SerializeField] private GameObject titleObj;
    [SerializeField] private GameObject subCompileCountObj;
    [SerializeField] private GameObject subConvosObj;
    [SerializeField] private GameObject novaConvoObj, brallConvoObj, shepherdConvoObj, wizardConvoObj;
    [SerializeField] private GameObject subtasksObj;
    [SerializeField] private GameObject mainQuestObj, brallQuest1Obj, brallQuest2Obj, novaQuest1Obj, novaQuest2Obj, shepherdQuest1Obj, shepherdQuest2Obj;
    [SerializeField] private GameObject subAffectionObj;
    [SerializeField] private GameObject novaAffectionObj, brallAffectionObj, shepherdAffectionObj;
    [SerializeField] private GameObject subItemsObj;
    [SerializeField] private GameObject anchorObj, cypherObj, hitlistObj, penObj;

    //reference to game files
    [SerializeField] private GameFilesData gameFilesData;

    //reference to UI objects
    [SerializeField] private GameObject logObj; //parent reference to disable
    [SerializeField] private GameObject npcInteractObj;
    //reference to text items
    [SerializeField] GameObject questContentObj; //content object containing all the text objects

    // Add the names of the UI elements you want to exclude from obfuscation
    public List<string> exemptItemNames;
    private HashSet<string> exemptItems;

    //dictionary to store all UI items with their names and contents
    private Dictionary<string, string> logUIItems = new Dictionary<string, string>();

    private void Awake()
    {
        GameFilesData.OnUnityRegisterInkVar += HandleInkVariableChanged;
    }

    //Start is called before the first frame update
    void Start()
    {
        exemptItems = new HashSet<string>(exemptItemNames);
        AddExemptItems(exemptItems);

        logObj.SetActive(false);
        DialogueManager.OnOpenLog += ShowLog;

        //adding all UI elements into the dictionary
        foreach (Transform logItem in questContentObj.transform)
        {
            TMP_Text textComponent = logItem.GetComponent<TextMeshProUGUI>();
            if (textComponent != null)
            {
                string key = logItem.name;
                string value = textComponent.text;
                logUIItems[key] = value;

                // Only obfuscate if the key is not in the exempt list
                if (!exemptItems.Contains(key))
                {
                    textComponent.text = ObfuscateText(value);
                }
            }
        }
        ReadStartVariables();
    }

    
    void ReadStartVariables()
    {
        
        //compile count
        if (gameFilesData.variables.ContainsKey("runAttempts"))
        {
            subCompileCountObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>().text = gameFilesData.variables["runAttempts"].ToString();
        }

        //warrior convo count
        if (gameFilesData.variables.ContainsKey("warriorConvoNum"))
        {
            novaConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Nova:";
            TMP_Text warriorConvoCount = shepherdConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            warriorConvoCount.text = gameFilesData.variables["runAttempts"].ToString();

        }

        //giant convo count
        if (gameFilesData.variables.ContainsKey("giantConvoNum"))
        {
            brallConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Brall:";
            TMP_Text giantConvoCount = shepherdConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            giantConvoCount.text = gameFilesData.variables["giantConvoNum"].ToString();

        }

        //robot convo count
        if (gameFilesData.variables.ContainsKey("robotConvoNum"))
        {
            shepherdConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Shepherd:";
            TMP_Text robotConvoCount = shepherdConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            robotConvoCount.text = gameFilesData.variables["robotConvoNum"].ToString();

        }

        //wizard convo count
        if (gameFilesData.variables.ContainsKey("visitEnemy") && gameFilesData.variables["visitEnemy"].ToString() == "true")
        {
            wizardConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Asset Missing:";
            if (gameFilesData.variables.ContainsKey("wizardConvoNum"))
            {
                TMP_Text wizardConvoCount = wizardConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
                wizardConvoCount.text = gameFilesData.variables["wizardConvoNum"].ToString();
            }
        }

        //tasks

        //meet in safe mode quest
        if (gameFilesData.variables.ContainsKey("startSafeQuest") && gameFilesData.variables["startSafeQuest"].ToString() == "true")
        {
            mainQuestObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Fix bug isolated in safe mode: started";
        }

        //Nova task 1
        if (gameFilesData.variables.ContainsKey("startHitListQuest") && gameFilesData.variables["startHitListQuest"].ToString() == "true")
        {
            novaQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Hitlist: started";
        }
        if (gameFilesData.variables.ContainsKey("hitQuestComplete") && gameFilesData.variables["hitQuestComplete"].ToString() == "true")
        {
            novaQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Hitlist: completed";
        }

        //Nova task 2
        if (gameFilesData.variables.ContainsKey("startGunQuest") && gameFilesData.variables["startGunQuest"].ToString() == "true")
        {
            novaQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   confirm Nova's Weapon: started";
        }
        if (gameFilesData.variables.ContainsKey("weaponQuestComplete") && gameFilesData.variables["weaponQuestComplete"].ToString() == "true")
        {
            novaQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   confirm Nova's Weapon: completed";
        }

        //robot task 1
        if (gameFilesData.variables.ContainsKey("startFixQuest") && gameFilesData.variables["startFixQuest"].ToString() == "true")
        {
            shepherdQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   encrypt AddEquipment: started";
        }
        if (gameFilesData.variables.ContainsKey("endFixQuest") && gameFilesData.variables["endFixQuest"].ToString() == "true")
        {
            shepherdQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   encrypt AddEquipment: completed";
        }

        //robot task 2
        if (gameFilesData.variables.ContainsKey("startPenQuest") && gameFilesData.variables["startPenQuest"].ToString() == "true")
        {
            shepherdQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Pen to Shepherd: started";
        }
        if (gameFilesData.variables.ContainsKey("endPenQuest") && gameFilesData.variables["endPenQuest"].ToString() == "true")
        {
            shepherdQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Pen to Shepherd: completed";
        }

        //bral task1
        if (gameFilesData.variables.ContainsKey("startLearnQuest") && gameFilesData.variables["startLearnQuest"].ToString() == "true")
        {
            brallQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   discover the third Hunter's goal: started";
        }
        if (gameFilesData.variables.ContainsKey("endLearnQuest") && gameFilesData.variables["endLearnQuest"].ToString() == "true")
        {
            brallQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   discover the third Hunter's goal: completed";
        }

        //brall task2
        if (gameFilesData.variables.ContainsKey("startCatQuest") && gameFilesData.variables["startCatQuest"].ToString() == "true")
        {
            brallQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   retrieve Mosspaws: started";
        }
        if (gameFilesData.variables.ContainsKey("endCatQuest") && gameFilesData.variables["endCatQuest"].ToString() == "true")
        {
            brallQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   retrieve Mosspaws: completed";
        }

        //affection

        //novaAffection
        if (gameFilesData.variables.ContainsKey("warriorAffection"))
        {
            
            novaAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Nova: " + gameFilesData.variables["warriorAffection"].ToString();
        }

        //brallAffection
        if (gameFilesData.variables.ContainsKey("giantAffection"))
        {
            subAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "NPC Affection";
            brallAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Brall: " + gameFilesData.variables["giantAffection"].ToString();
        }

        //brallAffection
        if (gameFilesData.variables.ContainsKey("robotAffection"))
        {
            subAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "NPC Affection";
            shepherdAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Shepherd: " + gameFilesData.variables["robotAffection"].ToString();
        }

        //items

        //anchor
        if (gameFilesData.variables.ContainsKey("hasAnchor") && gameFilesData.variables["hasAnchor"].ToString() == "Player")
        {
            anchorObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Anchor";
        }

        //cypher
        if (gameFilesData.variables.ContainsKey("hasWrench") && gameFilesData.variables["hasWrench"].ToString() == "Player")
        {
            cypherObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Cypher";
        }

        //hitlist
        if (gameFilesData.variables.ContainsKey("hasList") && gameFilesData.variables["hasList"].ToString() == "Player")
        {
            hitlistObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Hitlist";
        }

        // pen
        if (gameFilesData.variables.ContainsKey("hasPen") && gameFilesData.variables["hasPen"].ToString() == "Player")
        {
            penObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Pen";
        }
    }
    //react to Ink Variable changes:
    void HandleInkVariableChanged(string varName, string varValue)
    {
        //compile count
        if (varName == "runAttempts")
        {
            subCompileCountObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>().text = varValue;
        }
        
        //warrior convo count
        if (varName == "warriorConvoNum")
        {
            novaConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Nova:";
            TMP_Text warriorConvoCount = novaConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            warriorConvoCount.text = varValue;

        }

        //giant convo count
        if (varName == "giantConvoNum")
        {
            brallConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Brall:";
            TMP_Text giantConvoCount = brallConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            giantConvoCount.text = varValue;

        }

        //robot convo count
        if (varName == "robotConvoNum")
        {
            shepherdConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Shepherd:";
            TMP_Text robotConvoCount = shepherdConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
            robotConvoCount.text = varValue;

        }

        //wizard convo count
        if (varName == "visitEnemy" && varValue == "true")
        {
            wizardConvoObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Asset Missing:";
            if (gameFilesData.variables.ContainsKey("wizardConvoNum"))
            {
                TMP_Text wizardConvoCount = wizardConvoObj.transform.GetChild(0).GetComponentInChildren<TextMeshProUGUI>();
                wizardConvoCount.text = gameFilesData.variables["wizardConvoNum"].ToString();
            }
        }

        //tasks

        //meet in safe mode quest
        if (varName == "startSafeQuest" && varValue == "true")
        {
            mainQuestObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Fix bug isolated in safe mode: started";
        }

        //Nova task 1
        if (varName == "startHitListQuest" && varValue == "true")
        {
            novaQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Hitlist: started";
        }
        if (varName == "hitQuestComplete" && varValue == "true")
        {
            novaQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Hitlist: completed";
        }

        //Nova task 2
        if (varName == "startGunQuest" && varValue == "true")
        {
            novaQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   confirm Nova's Weapon: started";
        }
        if (varName == "weaponQuestComplete" && varValue == "true")
        {
            shepherdQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   confirm Nova's Weapon: completed";
        }

        //robot task 1
        if (varName == "startFixQuest" && varValue == "true")
        {
            shepherdQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   encrypt AddEquipment: started";
        }
        if (varName == "endFixQuest" && varValue == "true")
        {
            shepherdQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   encrypt AddEquipment: completed";
        }

        //robot task 2
        if (varName == "startPenQuest" && varValue == "true")
        {
            shepherdQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Pen to Shepherd: started";
        }
        if (varName == "endPenQuest" && varValue == "true")
        {
            shepherdQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   return Pen to Shepherd: completed";
        }

        //brall task1
        if (varName == "startLearnQuest" && varValue == "true")
        {
            brallQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   discover the third Hunter's goal: started";
        }
        if (varName == "endLearnQuest" && varValue == "true")
        {
            brallQuest1Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   discover the third Hunter's goal: completed";
        }

        //brall task2
        if (varName == "startCatQuest" && varValue == "true")
        {
            brallQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   retrive Mosspaws: started";
        }
        if (varName == "endCatQuest" && varValue == "true")
        {
            brallQuest2Obj.GetComponentInChildren<TextMeshProUGUI>().text = "   retrive Mosspaws: completed";
        }

        //affection

        //novaAffection
        if (varName == "warriorAffection")
        {

            subAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "NPC Affection";
            novaAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Nova: " + varValue;
        }

        //brallAffection
        if (varName == "giantAffection")
        {
            subAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "NPC Affection";
            brallAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Brall: " + varValue;
        }

        //brallAffection
        if (varName == "robotAffection")
        {
            subAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "NPC Affection";
            shepherdAffectionObj.GetComponentInChildren<TextMeshProUGUI>().text = "   Shepherd: " + varValue;
        }

        //items

        //anchor
        if (varName == "hasAnchor" && varValue == "Player")
        {
            anchorObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Anchor";
        }

        //cypher
        if (varName == "hasWrench" && varValue == "Player")
        {
            cypherObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Cypher";
        }

        //hitlist
        if (varName == "hasList" && varValue == "Player")
        {
            hitlistObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Hitlist";
        }

        // pen
        if (varName == "hasPen" && varValue == "Player")
        {
            penObj.GetComponentInChildren<TextMeshProUGUI>().text = "  Pen";
        }

    }

    //add titles and subtitles to exempt hashset
    void AddExemptItems(HashSet<string> exemptItems)
    {
        exemptItems.Add("Title");
        exemptItems.Add("Sub: CompileCount");
        exemptItems.Add("Sub: conversations");
        exemptItems.Add("countNum");
        exemptItems.Add("Subtitle: affection");
        exemptItems.Add("Sub: items");
        exemptItems.Add("Sub: Tasks");
        //exemptItems.Add("NovaConvo");
        //exemptItems.Add("BrallConvo");
        //exemptItems.Add("ShepherdConvo");
    }

    // Replaces all alphanumeric characters (letters and digits) with 'X'
    private string ObfuscateText(string input)
    {
        return Regex.Replace(input, "[a-zA-Z0-9]", "X");
    }

    void ShowLog()
    {
        logObj.SetActive(true);
        npcInteractObj.SetActive(false);
    }

    public void HideLog()
    {
        npcInteractObj.SetActive(true);
        logObj.SetActive(false);
    }

    private void OnDisable()
    {
        DialogueManager.OnOpenLog -= ShowLog;
        GameFilesData.OnUnityRegisterInkVar -= HandleInkVariableChanged;
    }
}


//[Serializable]
//public class VariableTextMapping
//{
//    public string variableValue; // The value of the Ink variable
//    public string displayedText; // The text to display for that variable value
//    public bool mirrorsInk;         // If true, displayedText should match the variable value exactly
//}

////maps Ink variables to Text Objects
//[Serializable]
//public class InkToUITextMapping
//{
//    public List<string> inkVariableNames; // List of variable names to check
//    public TextMeshProUGUI targetText; // The UI Text component to change

//    // List of variable values and their corresponding text to display
//    public List<VariableTextMapping> variableTextMappings;
//}
//public class LogManager : MonoBehaviour
//{
//    //reference to game files
//    [SerializeField]
//    private GameFilesData gameFilesData;

//    //reference to text items
//    [SerializeField]
//    private GameObject questContentObj;

//    //map of Ink variables to text items
//    public List<InkToUITextMapping> inkToTextMappings;

//    //reference to UI objects
//    [SerializeField]
//    private GameObject logObj;
//    [SerializeField]
//    private GameObject npcInteractObj;

//    // Add the names of the UI elements you want to exclude from obfuscation
//    public List<string> exemptItemNames;
//    private HashSet<string> exemptItems;

//    private Dictionary<string, string> logItems = new Dictionary<string, string>();
//    private Dictionary<string, List<TMP_Text>> variableToTextComponents = new Dictionary<string, List<TMP_Text>>();
//    private Dictionary<string, TMP_Text> nameToTextComponent = new Dictionary<string, TMP_Text>();
//    private HashSet<TMP_Text> revealedTextComponents = new HashSet<TMP_Text>();

//    private void Awake()
//    {
//        GameFilesData.OnUnityRegisterInkVar += HandleInkVariableChanged;
//    }

//    // Start is called before the first frame update
//    void Start()
//    {
//        exemptItems = new HashSet<string>(exemptItemNames);
//        AddExemptItems(exemptItems);

//        logObj.SetActive(false);
//        DialogueManager.OnOpenLog += ShowLog;

//        //adding all UI elements into the dictionary
//        foreach (Transform logItem in questContentObj.transform)
//        {
//            TMP_Text textComponent = logItem.GetComponent<TextMeshProUGUI>();
//            if (textComponent != null)
//            {
//                string key = logItem.name;
//                string value = textComponent.text;
//                logItems[key] = value;
//                nameToTextComponent[key] = textComponent;

//                // Only obfuscate if the key is not in the exempt list
//                if (!exemptItems.Contains(key))
//                {
//                    textComponent.text = ObfuscateText(value);
//                }
//            }
//        }

//        // Map multiple Ink variables to TMP_Text components
//        foreach (var mapping in inkToTextMappings)
//        {
//            if (mapping.targetText == null || mapping.inkVariableNames == null || mapping.inkVariableNames.Count == 0) continue;

//            // For each variable name in the list, add it to the dictionary
//            foreach (string inkVarName in mapping.inkVariableNames)
//            {
//                if (!variableToTextComponents.ContainsKey(inkVarName))
//                {
//                    variableToTextComponents[inkVarName] = new List<TMP_Text>();
//                }

//                variableToTextComponents[inkVarName].Add(mapping.targetText);
//            }
//        }
//        UpdateTextFromInkVariables();
//    }

//    // Update the text items based on the current Ink variable values
//    private void UpdateTextFromInkVariables()
//    {
//        foreach (var mapping in inkToTextMappings)
//        {
//            // Check each variable name in the mapping
//            foreach (string inkVarName in mapping.inkVariableNames)
//            {
//                // Check if the Ink variable is assigned and exists in the GameFilesData dictionary
//                if (gameFilesData != null && gameFilesData.variables.ContainsKey(inkVarName))
//                {
//                    string variableValue = gameFilesData.variables[inkVarName].ToString();

//                    // Loop through the text items that are mapped to this Ink variable
//                    foreach (var textComponent in variableToTextComponents[inkVarName])
//                    {
//                        bool updated = false;
//                        // Find the corresponding mapping for this variable and text component
//                        foreach (var variableTextMapping in mapping.variableTextMappings)
//                        {
//                            if (variableTextMapping.variableValue == variableValue)
//                            {
//                                if (variableTextMapping.mirrorsInk)
//                                {
//                                    textComponent.text = variableValue;
//                                }
//                                else
//                                {
//                                    textComponent.text = variableTextMapping.displayedText;
//                                }
//                                updated = true;
//                                break;
//                            }
//                        }

//                        // If no predefined mapping is found, just display the variable value directly
//                        if(!updated)
//                            {
//                            // Handle numeric values for counters or other types of variables
//                            if (int.TryParse(variableValue, out int numberValue))
//                            {
//                                textComponent.text = numberValue.ToString("F0"); // Display with two decimal places (if numeric)
//                            }
//                            else
//                            {
//                                textComponent.text = variableValue; // Display the string value directly
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }

//    // Update is called once per frame
//    void Update()
//    {

//    }

//    //add titles and subtitles to exempt hashset
//    void AddExemptItems(HashSet<string> exemptItems)
//    {
//        exemptItems.Add("Title");
//        exemptItems.Add("Sub: CompileCount");
//        exemptItems.Add("Sub: conversations");
//        exemptItems.Add("countNum");
//        exemptItems.Add("NovaConvo");
//        exemptItems.Add("BrallConvo");
//        exemptItems.Add("ShepherdConvo");
//    }

//    // Replaces all alphanumeric characters (letters and digits) with 'X'
//    private string ObfuscateText(string input)
//    {
//        return Regex.Replace(input, "[a-zA-Z0-9]", "X");
//    }

//    // Called when Ink variable changes
//    private void HandleInkVariableChanged(string variableName, string variableValue)
//    {
//        if (!variableToTextComponents.ContainsKey(variableName)) return;

//        foreach (TMP_Text textComponent in variableToTextComponents[variableName])
//        {
//            if (textComponent == null) continue;

//            // Find the correct mapping for this variable and text component
//            foreach (var mapping in inkToTextMappings)
//            {
//                if (mapping.targetText == textComponent)
//                {
//                    // Check if we should update this text component with the variable's value
//                    bool updated = false;

//                    // First, try to match the variable value in the variableTextMappings list
//                    foreach (var variableTextMapping in mapping.variableTextMappings)
//                    {
//                        if (variableTextMapping.variableValue == variableValue)
//                        {
//                            if (variableTextMapping.mirrorsInk)
//                            {
//                                textComponent.text = variableValue;
//                            }
//                            else
//                            {
//                                textComponent.text = variableTextMapping.displayedText;
//                            }
//                            updated = true;
//                            break;
//                        }
//                    }

//                    // If no specific mapping was found, we will just show the variable's value directly
//                    if (!updated)
//                    {
//                        // Check if the variable value is a number
//                        if (int.TryParse(variableValue, out int numberValue))
//                        {
//                            // Update the text to display the number (e.g., for a counter)
//                            textComponent.text = numberValue.ToString();
//                        }
//                        else
//                        {
//                            // Otherwise, just display the string value
//                            textComponent.text = variableValue;
//                        }
//                    }

//                    return; // Exit after updating the text for this variable
//                }
//            }
//        }
//    }

//    void ShowLog()
//    {
//        logObj.SetActive(true);
//        npcInteractObj.SetActive(false);
//    }

//    public void HideLog()
//    {
//        npcInteractObj.SetActive(true);
//        logObj.SetActive(false);
//    }

//    private void OnDisable()
//    {
//        DialogueManager.OnOpenLog -= ShowLog;
//    }
//}
