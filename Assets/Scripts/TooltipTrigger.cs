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
        string ability = item.ability;
        TooltipSystem.Show(header, description, ability);
        
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        string header = item.itemName;
        string description = item.description;
        string ability = item.ability;
        TooltipSystem.Hide(header, description, ability);
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        string header = item.itemName;
        string description = item.description;
        string ability = item.ability;
        TooltipSystem.Hide(header, description, ability);
    }


}
