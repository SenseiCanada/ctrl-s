using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class AffectionHighlighter : MonoBehaviour
{
    [SerializeField]
    private TMP_Text affectionNum;

    [SerializeField]
    private GameFilesData gameData;

    // Start is called before the first frame update
    void Start()
    {
        GameFilesData.OnUnityRegisterInkVar += HighlightAffection;
    }

    // Update is called once per frame
    void Update()
    {

    }

    void HighlightAffection(string varName, string varValue)
    {
        //if { varName = }
        affectionNum.color = Color.red;
    }
}
