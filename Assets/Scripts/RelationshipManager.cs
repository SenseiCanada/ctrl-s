using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RelationshipManager : MonoBehaviour
{
    [SerializeField]
    private Animator animator;
    [SerializeField]
    private GameFilesData gameFilesData;

    public static RelationshipManager Instance { get; private set; }

    private Dictionary<string, int> relationshipVars = new Dictionary<string, int>();

    public static event System.Action<string, int, int> OnAffectionChanged;

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(this.gameObject);
            return;
        }
        Instance = this;
        DontDestroyOnLoad(this.gameObject); // important: survive prefab destruction
    }

    private void OnEnable()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdateDictionary;
        OnAffectionChanged += HandleAffectionChanged;
    }    

    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= UpdateDictionary;
        OnAffectionChanged -= HandleAffectionChanged;
    }

    private void UpdateDictionary(string varName, string varValue)
    {
        if (varName.EndsWith("Affection"))
        {
            int oldValue = 0;
            relationshipVars.TryGetValue(varName, out oldValue);

            if (int.TryParse(varValue, out int newValue))
            {
                if (oldValue != newValue)
                {
                    relationshipVars[varName] = newValue;
                    string npcID = varName.Replace("Affection", "");
                    Debug.Log($"[RelationshipManager] Affection changed for {npcID}: {oldValue} -> {newValue}");
                    OnAffectionChanged?.Invoke(npcID, oldValue, newValue);
                }
                else
                {
                    Debug.Log($"[RelationshipManager] No change in affection for npcID: still {newValue}");
                }
            }
        }
    }

    public int GetAffection(string npcID)
    {
        relationshipVars.TryGetValue(npcID + "Affection", out int value);
        return value;
    }

    private void HandleAffectionChanged(string npcID, int oldValue, int newValue)
    {
        string currentNPCID = gameFilesData.variables["NPCID"].ToString();
        if (npcID == currentNPCID)
        {
            Debug.Log("display relationship is being called from subscribed function");

            if (newValue > oldValue)
            {
                StartCoroutine(HighlightChange());
            }
            else
            {
                Debug.Log($"[RelationshipDisplayer] Affection decreased for {npcID}: {oldValue} -> {newValue}");
            }
        }
    }

    private IEnumerator HighlightChange()
    {
        animator.SetBool("affectionIncreased", true);
        yield return new WaitForSeconds(animator.GetCurrentAnimatorStateInfo(0).length);
        animator.SetBool("affectionIncreased", false);
    }
}
