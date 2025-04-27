using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TooltipSystem : MonoBehaviour
{
    private static TooltipSystem instance;

    public static string tooltipHeader;
    public static string tooltipDescription;
    public static string tooltipAbility;

    public Tooltip tooltip;

    public void Awake()
    {
        instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        Hide(tooltipHeader, tooltipDescription, tooltipAbility);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public static void Show(string header, string description, string ability)
    {
        instance.tooltip.SetText(header, description, ability);
        instance.tooltip.gameObject.SetActive(true);
    }

    public static void Hide(string header, string description, string ability)
    {
        instance.tooltip.gameObject.SetActive(false);
        tooltipHeader = string.Empty;
        tooltipDescription = string.Empty;
        tooltipAbility = string.Empty;

    }
}
