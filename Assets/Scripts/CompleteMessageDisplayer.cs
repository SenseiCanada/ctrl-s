using Ink.Runtime;
using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CompleteMessageDisplayer : MonoBehaviour
{
    private RectTransform completeMessageTransform;

    [SerializeField]
    private RectTransform background;
    [SerializeField]
    private RectTransform margins;
    [SerializeField]
    private Button buttonPrefab;
    [SerializeField]
    private TMP_Text nullProcessesText;
    [SerializeField]
    private TMP_Text nullProcessesVal;
    private Button finishButton;

    public static event Action OnCompleteCompilation;
    
    // Start is called before the first frame update
    
    void Awake()
    {
        GameManager.OnTurnsElapsed += DisplayCompleteMessage;
        Debug.Log("DisplayCompleteMessage successfully subscribed!");
    }
    void Start()
    {
        
        margins.gameObject.SetActive(false);
        background.gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void DisplayCompleteMessage(RectTransform messageTransform, int nullProcessCount)
    {
        Debug.Log("DisplayCompleteMessage invoked successfully!");

        //processes that allow player to stay longer
        background.gameObject.SetActive(true);
        margins.gameObject.SetActive(true);
        completeMessageTransform = Instantiate(messageTransform, margins);
        completeMessageTransform.SetAsFirstSibling();
        completeMessageTransform.anchorMin = new Vector2(0f, 1f);
        completeMessageTransform.anchorMax = new Vector2(0f, 1f);
        completeMessageTransform.anchoredPosition = Vector2.zero;
        //completeMessageTransform.GetComponent<VerticalLayoutGroup>().childAlignment = TextAnchor.LowerLeft;
        
        //processes that are still null
        nullProcessesVal.text = nullProcessCount.ToString();

        //exit button
        Button finishButton = Instantiate(buttonPrefab, margins);
        finishButton.transform.SetAsLastSibling();
        RectTransform finishButtonTransform = finishButton.GetComponentInChildren<RectTransform>();
        finishButtonTransform.anchoredPosition = Vector2.zero;
        finishButton.GetComponentInChildren<TMP_Text>().text = ">End Compilation_";
        RectTransform rt = finishButton.GetComponent<RectTransform>();
        rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 150);
        finishButton.onClick.AddListener(EnterLobby);
    }

    private void EnterLobby()
    {
        OnCompleteCompilation();
    }
    
    private void OnDisable()
    {
        GameManager.OnTurnsElapsed -= DisplayCompleteMessage;
    }
}
