using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WizardRevealer : MonoBehaviour
{
    [SerializeField]
    private GameFilesData gameData;

    [SerializeField]
    private GameObject wizardChildObj;
    
    // Start is called before the first frame update
    void Start()
    {
        DialogueManager.OnHideWizard += HideWizard;
        if (gameData.variables.ContainsKey("hasPen"))
        {
            if (gameData.variables["hasPen"].ToString() == "Player")
            {
                wizardChildObj.SetActive(true);
            }
            else wizardChildObj.SetActive(false);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void HideWizard()
    {
        if (wizardChildObj != null)
        {
            wizardChildObj.SetActive(false);
        }
    }

    private void OnDisable()
    {
        DialogueManager.OnHideWizard -= HideWizard;
    }
}
