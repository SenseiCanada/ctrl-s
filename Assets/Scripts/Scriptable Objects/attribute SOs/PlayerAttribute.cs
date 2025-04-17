using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;


[CreateAssetMenu(fileName = "New Player Attribute", menuName = "Player Attribute")]
public class PlayerAttribute : ScriptableObject
{
    public string attributeID; //same as associated (Ink) variable name
    public string attributeText;
    public string attributeValue;

    public GameFilesData gameFilesData;

    
    
}
