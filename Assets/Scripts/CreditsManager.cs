using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreditsManager : MonoBehaviour
{

    [SerializeField]
    private GameObject creditsObj;
    // Start is called before the first frame update
    void Start()
    {
        creditsObj.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void ShowCredits()
    {
        creditsObj.SetActive(true);
    }

    public void HideCredits()
    {
        creditsObj.SetActive(false);
    }
}
