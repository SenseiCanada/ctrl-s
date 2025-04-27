using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using Ink.Runtime;
using System;

public class TurnTimerDisplayer : MonoBehaviour
{
    //[SerializeField]
    //private TMP_Text turnsText;
    [SerializeField]
    private TMP_Text turnsRemainingText;

    private int turnsTaken;
    private int totalTurns;

    public GameFilesData gameFiles;

    void Awake()
    {
        GameManager.OnTurnsIncrement += UpdateTurns;
    }
    // Start is called before the first frame update
    void Start()
    {
        turnsRemainingText.text = (totalTurns - turnsTaken).ToString();
    }

    // Update is called once per frame
    void Update()
    {

    }
    
    void UpdateTurns(int turnTotal, int turnNum)
    {
        totalTurns = turnTotal;
        turnsTaken = turnNum;
        //turnsText.text = turnsTaken.ToString();
        turnsRemainingText.text = (totalTurns-turnsTaken).ToString();
    }
    private void OnDisable()
    {
        GameManager.OnTurnsIncrement -= UpdateTurns;
        Debug.Log("Turn timer unsuscribed");
    }
}
