using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class DevPanelGameFiles : MonoBehaviour
{

    public TMP_Text turnState;
    public static event Action<bool> OnPauseTurns;
    public static event Action<bool> OnStartTurns;

    [SerializeField]
    protected GameObject devPanelParent;
    private bool isPanelActive;

    // Start is called before the first frame update
    void Start()
    {
        turnState.text = "turns counted";
        isPanelActive = false;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.L))
        {
            isPanelActive = !isPanelActive;
        }

        if (isPanelActive)
        {
            OpenDevPanel();
        }
        else CloseDevPanel();

    }

    public void OpenDevPanel()
    {
        isPanelActive = true;
        devPanelParent.SetActive(true);
    }
    public void CloseDevPanel()
    {
        isPanelActive = false;
        devPanelParent.SetActive(false);
    }


    public void PauseTurns()
    {
        OnPauseTurns(false);//must pass false because bool isUnityCounting turns in GameManager will then be false
        turnState.text = "turns paused";
    }

    public void StartTurns()
    {
        OnStartTurns(true);//must pass true because bool isUnityCounting turns in GameManager will then be true
        turnState.text = "turns counted";
    }
}
