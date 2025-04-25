using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class RelationshipDisplayer : MonoBehaviour
{
    [SerializeField]
    private TMP_Text relationshipText;

    private string relationshipVar;

    private string currentSpeakerID;
    [SerializeField]
    private Animator animator;

    [SerializeField]
    private GameObject relFrame;

    [SerializeField]
    private GameFilesData gameFilesData;

    public Dictionary<string, string> relationshipVars = new Dictionary<string, string>();

    // Start is called before the first frame update
    void OnEnable()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdateDictionary;

        relationshipText = gameObject.GetComponentInChildren<TMP_Text>();

        //add affection scores from ink into local dictionary
        foreach (string varName in gameFilesData.variables.Keys)
        {
            if (varName == "robotAffection" || varName == "giantAffection" || varName == "warriorAffection")
            {
                relationshipVars.Remove(varName);
                relationshipVars.Add(varName, gameFilesData.variables[varName].ToString());
            }
        }
        //pass NPC ID of current NPC to display function
        DisplayRelationship(gameFilesData.variables["NPCID"].ToString());
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void UpdateDictionary(string varName, string varValue)
    {
        if (varName == "robotAffection" || varName == "giantAffection" || varName == "warriorAffection")
        {
            relationshipVars.Remove(varName);
            relationshipVars.Add(varName, varValue);
        }

        DisplayRelationship(gameFilesData.variables["NPCID"].ToString());
    }
    
    void DisplayRelationship(string npcID)
    {
        if (relationshipVars.ContainsKey(npcID + "Affection"))
        {
            relationshipVar = relationshipVars[npcID + "Affection"];
            relationshipText.text = relationshipVar;
            if (relationshipVar != "0")
            {
                StartCoroutine(HighlightChange());
            }
            
            Debug.Log("Displayer shows " +  npcID + "Affection" + " equal to "+ relationshipVar);
        } 
    }

    private IEnumerator HighlightChange()
    {
        animator.SetBool("affectionIncreased", true);
        AnimatorStateInfo stateInfo = animator.GetCurrentAnimatorStateInfo(0);
        yield return new WaitForSeconds(stateInfo.length);
        animator.SetBool("affectionIncreased", false);

    }

    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= UpdateDictionary;
    }
}
