using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class WCollider : MonoBehaviour
{
    private bool firstCollision;
    public static Action OnWColliderExit;

    // Start is called before the first frame update
    void Start()
    {
        firstCollision = false;
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
