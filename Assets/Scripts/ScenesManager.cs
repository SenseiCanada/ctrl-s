using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ScenenesManager : MonoBehaviour
{
    [SerializeField]
    private SaveScriptableObject inventorySave;

    [SerializeField]
    private GameFilesData gameData;
    
    // Start is called before the first frame update

    void Awake()
    {
        CompleteMessageDisplayer.OnCompleteCompilation += EnterLobby;
        GameFilesManager.OnExitGameFiles += EnterLobby;
        GameFilesManager.OnEnterSafeMode += EnterSafeMode;
        DialogueManager.OnEnterGameFiles += EnterCode;
    }
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void EnterCode()
    {
        SceneManager.LoadScene("GameFiles");
    }

    public void EnterLobby()
    {
        if (!inventorySave.startVariablesSet)
        {
            inventorySave.SetStartVariables();
        }
        SceneManager.LoadScene("Lobby");
    }

    public void EnterIntro()//called by start button
    {
        if (inventorySave != null)
        {
            inventorySave.startVariablesSet = false;
        }
        SceneManager.LoadScene("Intro");
    }

    public void EnterSafeMode()
    {
        SceneManager.LoadScene("Intro");
    }

    public void EnterEndScreen()
    {
        SceneManager.LoadScene("EndScreen");
    }
    public void ReturnStart()
    {
        SceneManager.LoadScene("StartScreen");
    }

    private void OnDisable()
    {
        CompleteMessageDisplayer.OnCompleteCompilation -= EnterLobby;
        GameFilesManager.OnExitGameFiles -= EnterLobby;
        DialogueManager.OnEnterGameFiles -= EnterCode;
    }
}
