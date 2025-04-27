using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WizardRevealer : MonoBehaviour
{
    [SerializeField]
    private GameFilesData gameData;

    [SerializeField]
    private GameObject wizardChildObj;

    [SerializeField]
    private GameObject wizardCollider;
    [SerializeField]
    private GameObject wizardAlert;

    // Start is called before the first frame update
    void Start()
    {
        DialogueManager.OnHideWizard += HideWizard;
        wizardChildObj.SetActive(false);
        wizardCollider.SetActive(false);
        wizardAlert.SetActive(false);

        if (gameData.variables.ContainsKey("hasPen"))
        {
            if (gameData.variables["hasPen"].ToString() == "Player")
            {
                wizardChildObj.SetActive(true);
                wizardCollider.SetActive(true);
                wizardAlert.SetActive(true);
            }
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
