using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IntroCanvasDisabler : MonoBehaviour
{
    [SerializeField]
    private GameFilesData gameData;

    [SerializeField]
    private GameObject introCanvasObj;

    // Start is called before the first frame update
    void Start()
    {
        if (gameData.variables.ContainsKey("hasPen"))
        {
            if (gameData.variables["hasPen"].ToString() == "Player")
            {
                introCanvasObj.SetActive(false);
            }
            else introCanvasObj.SetActive(true);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
