using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LobbyManager : MonoBehaviour
{
    [SerializeField]
    private SaveScriptableObject saveSO;

    // Start is called before the first frame update
    void Start()
    {
        if (!saveSO.startVariablesSet)
        {
            saveSO.SetStartVariables();
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
