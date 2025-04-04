using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class InteractCollider : MonoBehaviour
{
    public static Action OnInteractColliderEnter;
    public static Action OnInteractColliderExit;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            OnInteractColliderEnter();
        }
        
    }

    private void OnTriggerExit(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            OnInteractColliderExit();
        }
    }


}
