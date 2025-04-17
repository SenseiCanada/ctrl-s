using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CatRevealer : MonoBehaviour
{
    [SerializeField]
    private GameObject catModel;

    [SerializeField]
    private GameFilesData gameData;

    private bool catEnabled;

    private void Awake()
    {
        GameFilesData.OnUnityRegisterInkVar +=EnableCat;
        GameFilesData.OnUnityRegisterInkVar += DisableCat;
    }

    // Start is called before the first frame update
    void Start()
    {
        if (gameData.variables.ContainsKey("hasCat"))
        {
            if (gameData.variables["hasCat"].ToString() == "giant")
            {
                catEnabled = true;
            } else { catEnabled = false; }
        }

        if (catEnabled)
        {
            catModel.SetActive(true);
        } else { catModel.SetActive(false); }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void EnableCat(string varName, string VarValue)
    {
        if (varName == "hasCat" && VarValue == "giant")
        {
            catModel.SetActive(true);
            catEnabled = true;
        }
    }

    void DisableCat(string varName, string VarValue)
    {
        if (varName == "hasCat" && VarValue != "giant")
        {
            catModel.SetActive(false);
            catEnabled = false;
        }
    }

    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= EnableCat;
        GameFilesData.OnUnityRegisterInkVar += DisableCat;
    }
}
