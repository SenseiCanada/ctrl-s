using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ACollider : MonoBehaviour
{
    private bool firstCollision;
    public static Action OnAColliderEnter;
    public static Action OnAColliderExit;

    // Start is called before the first frame update
    void Start()
    {
        firstCollision = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other != null && !firstCollision)
        {
            OnAColliderEnter();
            firstCollision = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other != null)
        {
            OnAColliderExit();
        } 
    }
}
