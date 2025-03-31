using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;
using Ink.Runtime;

public class DevPanel : MonoBehaviour
{
    [SerializeField]
    protected string runAttempts;

    [SerializeField]
    protected TMP_Text runAttemptsText;

    [SerializeField]
    protected GameFilesData gameData;

    [SerializeField]
    protected TextAsset inkVarsJSON;
    [SerializeField]
    protected Story inkVarsStory;

    [SerializeField]
    protected GameObject devPanelObj;
    private bool isPanelActive;

    [SerializeField]
    private GameObject inkController;

    // Start is called before the first frame update
    void Start()
    {
        GameFilesData.OnUnityRegisterInkVar += UpdateRunAttempts;
        inkVarsStory = new Story(inkVarsJSON.text);
        isPanelActive = false;
        
    }

    // Update is called once per frame
    void Update()
    {
        runAttemptsText.text = runAttempts;

        if (Input.GetKeyUp(KeyCode.L))
        {
            isPanelActive = !isPanelActive;
        }

        devPanelObj.SetActive(isPanelActive);
    }

    void UpdateRunAttempts(string name, string value)
    {
        if (name == "runAttempts")
        {
            runAttempts = value;
            
        }
    }

    public void OpenDevPanel()
    {
        devPanelObj.SetActive(true);
    }

    public void CloseDevPanel()
    {
        devPanelObj.SetActive(false);
    }

    public void ActivateInkController()
    {
        inkController.SetActive(true);
    }

    public void DeactivateInkController()
    {
        inkController.SetActive(false);
    }
}
