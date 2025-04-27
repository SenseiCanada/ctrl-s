using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoadOutHintDisplayer : MonoBehaviour
{
    //wizard's advantage
    [SerializeField]
    private PlayerAttribute wizardAdvantageSO;
    [SerializeField]
    private GameObject wizardAdvantageIcon;

    //quantum anchor
    [SerializeField]
    private GameObject anchorIcon;

    //hitlist
    [SerializeField]
    private GameObject hitlistIcon;

    //wrench/cypher
    [SerializeField]
    private GameObject cypherIcon;

    //pen
    [SerializeField]
    private GameObject penIcon;

    [SerializeField]
    private GameFilesData gameData;
    
    // Start is called before the first frame update
    void Start()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdateAnchorIcon;
        GameFilesData.OnUnityRegisterInkVar += UpdateCypherIcon;
        GameFilesData.OnUnityRegisterInkVar += UpdateListIcon;
        GameFilesData.OnUnityRegisterInkVar += UpdatePenIcon;
        wizardAdvantageIcon.SetActive(false);
        anchorIcon.SetActive(false);
        cypherIcon.SetActive(false);
        hitlistIcon.SetActive(false);
        penIcon.SetActive(false);
        if (gameData.variables.ContainsKey("visitEnemy") && gameData.variables["visitEnemy"].ToString() == "true")
        {
            wizardAdvantageIcon.SetActive(true);
        }
        if (gameData.variables.ContainsKey("hasAnchor") && gameData.variables["hasAnchor"].ToString() == "Player")
        {
            anchorIcon.SetActive(true);
        }
        if (gameData.variables.ContainsKey("hasWrench") && gameData.variables["hasWrench"].ToString() == "Player")
        {
            cypherIcon.SetActive(true);
        }
        if (gameData.variables.ContainsKey("hasList") && gameData.variables["hasList"].ToString() == "Player")
        {
            hitlistIcon.SetActive(true);
        }
        if (gameData.variables.ContainsKey("hasPen") && gameData.variables["hasPen"].ToString() == "Player")
        {
            penIcon.SetActive(true);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void UpdateAnchorIcon(string varName, string varValue)
    {
        if (varName == "hasAnchor" && varValue == "Player")
        {
            anchorIcon.SetActive(true);
        } else anchorIcon.SetActive(false);
    }

    void UpdateCypherIcon(string varName, string varValue)
    {
        if (varName == "hasWrench" && varValue == "Player")
        {
            cypherIcon.SetActive(true);
        }
        else cypherIcon.SetActive(false);
    }

    void UpdateListIcon(string varName, string varValue)
    {
        if (varName == "hasWrench" && varValue == "Player")
        {
            hitlistIcon.SetActive(true);
        }
        else hitlistIcon.SetActive(false);
    }
    void UpdatePenIcon(string varName, string varValue)
    {
        if (varName == "hasPen" && varValue == "Player")
        {
            penIcon.SetActive(true);
        }
        else penIcon.SetActive(false);
    }

    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= UpdateAnchorIcon;
        GameFilesData.OnUnityRegisterInkVar -= UpdateCypherIcon;
        GameFilesData.OnUnityRegisterInkVar -= UpdateListIcon;
        GameFilesData.OnUnityRegisterInkVar -= UpdatePenIcon;
    }
}
