using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class FileLocationDisplayer : MonoBehaviour
{
    [SerializeField]
    private TMP_Text fileLocText;
    [SerializeField]
    private GameFilesData gameFiles;

    string locationText;

    

    // Start is called before the first frame update
    void Start()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdateLocation;
        fileLocText.text = "Drive/Files/GameEditor/MyNewAwesomeGame/";
    }

    // Update is called once per frame
    void Update()
    {
    }

    private void UpdateLocation(string varName, string varValue)
    {
        if (varName == "locationText")
        {
            locationText = gameFiles.variables["locationText"].ToString();
            fileLocText.text = "Drive/Files/GameEditor/MyNewAwesomeGame/" + locationText;
        }
    }
    
    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= UpdateLocation;
    }
}
