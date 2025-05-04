using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class RelationshipDisplayer : MonoBehaviour
{
    [SerializeField]
    private TMP_Text relationshipText;
    [SerializeField]
    private Animator animator;
    [SerializeField]
    private GameFilesData gameFilesData;

    private int relationshipVar = 0;
    private string currentSpeakerID;

    private void OnEnable()
    {
        RelationshipManager.OnAffectionChanged += HandleAffectionChanged;
        relationshipText = GetComponentInChildren<TMP_Text>();

        currentSpeakerID = gameFilesData.variables["NPCID"].ToString();
        
        DisplayRelationship(currentSpeakerID);
        Debug.Log("display relationship is being called on enable");
    }

    private void OnDisable()
    {
        RelationshipManager.OnAffectionChanged -= HandleAffectionChanged;
    }

    private void DisplayRelationship(string npcID)
    {
        relationshipVar = RelationshipManager.Instance.GetAffection(npcID);
        if (relationshipVar.ToString() != null)
        {
            relationshipText.text = relationshipVar.ToString();
            Debug.Log($"[RelationshipDisplayer] Showing {npcID} affection: {relationshipVar}");
        }
    }

    private void HandleAffectionChanged(string npcID, int oldValue, int newValue)
    {
        string currentNPCID = gameFilesData.variables["NPCID"].ToString();
        if (npcID == currentNPCID)
        {
            DisplayRelationship(npcID);
            Debug.Log("display relationship is being called from subscribed function");

            
        }
    }

    //private IEnumerator HighlightChange()
    //{
    //    animator.SetBool("affectionIncreased", true);
    //    yield return new WaitForSeconds(animator.GetCurrentAnimatorStateInfo(0).length);
    //    animator.SetBool("affectionIncreased", false);
    //}

    //[SerializeField]
    //private TMP_Text relationshipText;

    //private int relationshipVar = 0;

    //private string currentSpeakerID;
    //[SerializeField]
    //private Animator animator;

    //[SerializeField]
    //private GameObject relFrame;

    //[SerializeField]
    //private GameFilesData gameFilesData;

    //public Dictionary<string, int> relationshipVars = new Dictionary<string, int>();

    //public static event System.Action<string, int, int> OnAffectionChanged;

    //// Start is called before the first frame update
    //void OnEnable()
    //{
    //    GameFilesData.OnUnityRegisterInkVar += UpdateDictionary;
    //    Debug.Log("Subscribed to OnUnityRegisterInkVar event.");
    //    OnAffectionChanged += HandleAffectionChanged;

    //    relationshipText = gameObject.GetComponentInChildren<TMP_Text>();

    //    //add affection scores from ink into local dictionary
    //    foreach (string varName in gameFilesData.variables.Keys)
    //    {
    //        if (varName == "robotAffection" || varName == "giantAffection" || varName == "warriorAffection")
    //        {
    //            int value;
    //            if (int.TryParse(gameFilesData.variables[varName].ToString(), out value))
    //            {
    //                relationshipVars[varName] = value;
    //            }
    //            //relationshipVars.Remove(varName);
    //           //relationshipVars.Add(varName, gameFilesData.variables[varName].ToString());
    //        }
    //    }
    //    //pass NPC ID of current NPC to display function
    //    DisplayRelationship(gameFilesData.variables["NPCID"].ToString());

    //}

    //// Update is called once per frame
    //void Update()
    //{

    //}

    //void UpdateDictionary(string varName, string varValue)
    //{
    //    //check if variable is an affection variable
    //    Debug.Log("relationship displayer knows that passed ink var is " + varName + " and value is "+ varValue);
    //    if (varName == "robotAffection" || varName == "giantAffection" || varName == "warriorAffection")
    //    {
    //        int oldValue = 0;
    //        relationshipVars.TryGetValue(varName, out oldValue);

    //        int newValue;
    //        if (int.TryParse(varValue, out newValue))
    //        {
    //            if (oldValue != newValue)
    //            {
    //                relationshipVars[varName] = newValue;

    //                Debug.Log("Before raising event, old rel value was " + oldValue + ", and new value is: " + newValue);
    //                // Raise the event
    //                string npcID = varName.Replace("Affection", ""); // extract "robot" from "robotAffection"
    //                OnAffectionChanged?.Invoke(npcID, oldValue, newValue);
    //            }
    //            else
    //            {
    //                Debug.Log($"Affection for {varName} did not change ({newValue}), skipping update.");
    //            }
    //        }
    //    }
    //}
    //private void HandleAffectionChanged(string npcID, int oldValue, int newValue)
    //{
    //    string currentNPCID = gameFilesData.variables["NPCID"].ToString();
    //    if (npcID == currentNPCID)
    //    {
    //        DisplayRelationship(npcID);

    //        if (newValue > oldValue)
    //        {
    //            StartCoroutine(HighlightChange());
    //        }
    //        else
    //        {
    //            // You could even trigger "affectionDecreased" animation here if you want
    //            Debug.Log($"Affection decreased for {npcID} (old {oldValue} -> new {newValue})");
    //        }
    //    }
    //}


    //void DisplayRelationship(string npcID)
    //{
    //    string affectionKey = npcID + "Affection";

    //    if (relationshipVars.TryGetValue(affectionKey, out int currentValue))
    //    {
    //        relationshipVar = currentValue;
    //        relationshipText.text = relationshipVar.ToString();

    //        Debug.Log($"Displaying {npcID} affection: {relationshipVar}");
    //    }
    //    else
    //    {
    //        relationshipVar = 0;
    //        relationshipText.text = "0";  // or hide it if you want
    //        Debug.LogWarning($"No affection value found for {npcID}.");
    //    }
    //}

    //private IEnumerator HighlightChange()
    //{
    //    animator.SetBool("affectionIncreased", true);
    //    AnimatorStateInfo stateInfo = animator.GetCurrentAnimatorStateInfo(0);
    //    yield return new WaitForSeconds(stateInfo.length);
    //    animator.SetBool("affectionIncreased", false);

    //}

    //private void OnDisable()
    //{
    //    Debug.Log("Unsubscribing from OnUnityRegisterInkVar event.");
    //    GameFilesData.OnUnityRegisterInkVar -= UpdateDictionary;
    //    OnAffectionChanged -= HandleAffectionChanged;
    //}
}
