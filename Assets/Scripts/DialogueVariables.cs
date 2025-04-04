using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using System;

public class DialogueVariables : MonoBehaviour
{
    private Dictionary<string, Ink.Runtime.Object> variables = new Dictionary<string, Ink.Runtime.Object>();
    public static event Action<string, Ink.Runtime.Object> OnUnityRegisterInkVar;

    public void StartListening(Story story)
    {
        VariablesToStory(story); //load variable dictionary back into story before listening
        story.variablesState.variableChangedEvent += VariableChanged;
    }
    public void StopListening(Story story)
    {
        story.variablesState.variableChangedEvent -= VariableChanged;
    }

    //Ink Variables --> Unity Dictionary.
    private void VariableChanged(string name, Ink.Runtime.Object value)
    {
        
        if (variables.ContainsKey(name))
        {
            variables.Remove(name);
            variables.Add(name, value);
        }
        else variables.Add(name, value);
        OnUnityRegisterInkVar(name, value);
    }

    //Unity Dictionary --> Ink Variables
    private void VariablesToStory(Story story)
    {
        if (variables != null)
        {
            foreach (KeyValuePair<string, Ink.Runtime.Object> variable in variables)
            {
                story.variablesState.SetGlobal(variable.Key, variable.Value);
            }
        }
    }
}
