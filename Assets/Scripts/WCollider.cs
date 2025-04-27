using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.Playables;

public class WCollider : MonoBehaviour
{
    [SerializeField]
    private GameFilesData gameData;

    private bool firstCollision;
    public static Action OnWColliderExit;

    // Start is called before the first frame update
    void Start()
    {
        firstCollision = false;

        if (gameData.variables.ContainsKey("hasPen"))
        {
            if (gameData.variables["hasPen"].ToString() == "Player")
            {
                GetComponent<Collider>().enabled = false;
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerExit(Collider other)
    {
        if (!firstCollision)
        {
            Debug.Log("Player left W collider");
            OnWColliderExit();
            firstCollision = true;
        }
    }
}
