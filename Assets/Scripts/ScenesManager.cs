using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ScenenesManager : MonoBehaviour
{
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
        SceneManager.LoadScene("Lobby");
    }

    public void EnterIntro()
    {
        SceneManager.LoadScene("Intro");
    }

    public void EnterSafeMode()
    {
        SceneManager.LoadScene("Intro");
    }

    private void OnDisable()
    {
        CompleteMessageDisplayer.OnCompleteCompilation -= EnterLobby;
        GameFilesManager.OnExitGameFiles -= EnterLobby;
        DialogueManager.OnEnterGameFiles -= EnterCode;
    }
}
