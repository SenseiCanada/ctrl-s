using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Ink.Runtime;
using TMPro;
using System;

public class InventoryInkConnector : MonoBehaviour
{
    private Story activeStory;

    public GameObject tradeWindowUI;
    public Transform tradeWindowOn;
    public Transform tradeWindowOff;

    public GameFilesData gameData;

    public TMP_Text NPCNameText;

    public static event Action OnTradeWindowOpen;
    public static event Action OnTradeWindowHide;

    // Start is called before the first frame update
    void Start()
    {
        DialogueManager.OnCreateStory += StartListening;
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }

    void StartListening (Story observedStory)
    {
        activeStory = observedStory;
        observedStory.BindExternalFunction("openTradeWindow", () => { OpenTradeWindow(); });
        observedStory.BindExternalFunction("closeTradeWindow", () => { CloseTradeWindow(); });

    }
    public void OpenTradeWindow()
    {
        OnTradeWindowOpen();
        if (activeStory != null)
        {
            NPCNameText.text = gameData.variables["NPCName"].ToString();
        }
        tradeWindowUI.transform.position = tradeWindowOn.transform.position;
    }

    public void CloseTradeWindow()
    {
        tradeWindowUI.transform.position = tradeWindowOff.transform.position;
        OnTradeWindowHide();
        //add function that will navigate to appropriate knot in ink
    }

    private void OnDisable()
    {
        DialogueManager.OnCreateStory -= StartListening;
    }

}
