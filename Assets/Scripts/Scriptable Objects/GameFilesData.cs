using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using Unity.VisualScripting;
using System;
using static UnityEngine.Rendering.DebugUI;


[CreateAssetMenu(fileName = "New Data", menuName = "Scriptable Objects")]
public class GameFilesData : ScriptableObject
{
    public string location;
    public int totalTurns;
    private Story currentStory;
    private string currentStorySave;

    //diactionary for storing dialogue saves
    public Dictionary<string, string> dialogueSaves = new Dictionary<string, string>();

    //list of scriptable objects to populate timer
    public List<PlayerAttribute> playerAttributes = new List<PlayerAttribute>();
    public List<PlayerAttribute> nullAttributes = new List<PlayerAttribute>();

    public Dictionary<string, Ink.Runtime.Object> variables = new Dictionary<string, Ink.Runtime.Object>();
    public static event Action<string, string> OnUnityRegisterInkVar;
    public static event Action<string> OnInkStateSaved;

    public void StartListening(Story story)
    {
        VariablesToStory(story); //load variable dictionary back into story before listening
        currentStory = story;
        Debug.Log("resume value is " + currentStory.variablesState["robotSaveKnot"]);
        story.variablesState.variableChangedEvent += VariableChanged;
        InventoryManager.OnNPCCollect += NCPInventoryChanged;
    }

    public void StopListening(Story story)
    {
        story.variablesState.variableChangedEvent -= VariableChanged;
        InventoryManager.OnNPCCollect -= NCPInventoryChanged;
        currentStory = null;
    }
    private void VariableChanged(string name, Ink.Runtime.Object value)
    {
        Debug.Log("Variable changed: " + name + " = " + value);

        if (variables.ContainsKey(name))
        {
            variables.Remove(name);
            variables.Add(name, value);
        }
        else variables.Add(name, value);

        RegisterInkVariable(name, value.ToString());

    }
    private void VariablesToStory(Story story)
    {
        if (variables != null)
        {
            foreach (KeyValuePair<string, Ink.Runtime.Object> variable in variables)
            {
                story.variablesState.SetGlobal(variable.Key, variable.Value);
                Debug.Log("ink variables loaded back into story: "+variable.Key+"-"+variable.Value);
            }
        }
    }

    void NCPInventoryChanged(InventoryItem newNPCItem, int npcItemCount)
    {
        if (newNPCItem.itemName == "Mosspaws" && newNPCItem.owner == "Brall")
        {
            currentStory.variablesState["giantHasCat"] = "true";
        }
    }

    public static void RegisterInkVariable(string varName, string varValue)
    {
        if (OnUnityRegisterInkVar != null)
        {
            OnUnityRegisterInkVar.Invoke(varName, varValue);
        }
        else
        {
            //Debug.LogWarning("OnUnityRegisterInkVar has no listeners!");
        }
    }
}
