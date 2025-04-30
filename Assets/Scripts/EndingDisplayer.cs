using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EndingDisplayer : MonoBehaviour
{
    [SerializeField]
    private GameObject fixedGameEndObj;
    [SerializeField]
    private GameObject freeWizardEndObj;
    [SerializeField]
    private GameFilesData gameData;
    
    // Start is called before the first frame update
    void Start()
    {
        fixedGameEndObj.SetActive(false);
        freeWizardEndObj.SetActive(false);

        if (gameData != null)
        {
            bool fixedGame = (bool)gameData.variables["fixedGame"];
            if (fixedGame)
            {
                fixedGameEndObj.SetActive(true);
            }
            else freeWizardEndObj.SetActive(true);
        }

    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
