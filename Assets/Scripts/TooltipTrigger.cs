using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class TooltipTrigger : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler, IPointerClickHandler
{
    public InventoryItem item;

    public void OnPointerEnter(PointerEventData eventData)
    {
        string header = item.itemName;
        string description = item.description;
        TooltipSystem.Show(header, description);
        
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        string header = item.itemName;
        string description = item.description;
        TooltipSystem.Hide(header, description);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        string header = item.itemName;
        string description = item.description;
        TooltipSystem.Hide(header, description);
    }


}
