using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TooltipSystem : MonoBehaviour
{
    private static TooltipSystem instance;

    public static string tooltipHeader;
    public static string tooltipDescription;

    public Tooltip tooltip;

    public void Awake()
    {
        instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        Hide(tooltipHeader, tooltipDescription);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public static void Show(string header, string description)
    {
        instance.tooltip.SetText(header, description);
        instance.tooltip.gameObject.SetActive(true);
    }

    public static void Hide(string header, string description)
    {
        instance.tooltip.gameObject.SetActive(false);
        tooltipHeader = string.Empty;
        tooltipDescription = string.Empty;
    }
}
