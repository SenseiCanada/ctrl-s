using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class InteractColliderLobby : MonoBehaviour
{
    [SerializeField]
    private GameObject EKey;

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
        if (other.gameObject.CompareTag("Player") && !EKey.activeInHierarchy)
        {
            OnInteractColliderEnter();
            Debug.Log("Tutorial interact collider flagging collision");
        }
            
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            OnInteractColliderExit();
        }
    }


}
