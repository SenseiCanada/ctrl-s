using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Tooltip : MonoBehaviour
{
    [SerializeField]
    private TMP_Text header;
    [SerializeField]
    private TMP_Text body;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void SetText(string name, string decription)
    {
        header.text = name;
        body.text = decription;
    }
}
