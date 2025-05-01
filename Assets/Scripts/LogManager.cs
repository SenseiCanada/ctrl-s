using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LogManager : MonoBehaviour
{
    //reference to game files
    [SerializeField]
    private GameFilesData gameFilesData;

    //reference to UI objects
    [SerializeField]
    private GameObject logObj;
    [SerializeField]
    private GameObject npcInteractObj;
    
    // Start is called before the first frame update
    void Start()
    {
        logObj.SetActive(false);
        DialogueManager.OnOpenLog += ShowLog;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void ShowLog()
    {
        logObj.SetActive(true);
        npcInteractObj.SetActive(false);
    }

    public void HideLog()
    {
        npcInteractObj.SetActive(true);
        logObj.SetActive(false);
    }

    private void OnDisable()
    {
        DialogueManager.OnOpenLog -= ShowLog;
    }
}
