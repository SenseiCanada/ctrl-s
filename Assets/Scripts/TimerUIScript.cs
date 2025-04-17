using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class TimerUIScript : MonoBehaviour
{
    //Unity UI elements
    [SerializeField]
    private TMP_Text standbyText;

    //game data SO
    [SerializeField]
    private GameFilesData gameData;

    private void Awake()
    {
        GameFilesData.OnUnityRegisterInkVar += DisableStandby;
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void DisableStandby(string varName, string varValue)
    {
        if (varName == "countTurns" && varValue == "true")
        {
            standbyText.gameObject.SetActive(false);
        }
    }

    private void OnDisable()
    {
        GameFilesData.OnUnityRegisterInkVar -= DisableStandby;
    }
}
