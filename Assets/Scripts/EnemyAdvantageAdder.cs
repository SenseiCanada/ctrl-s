using Ink.Runtime;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyAdvantageAdder : MonoBehaviour
{
    [SerializeField]
    private GameFilesData gameFiles;

    [SerializeField]
    private PlayerAttribute enemyAdvantageSO;

    private string visitedEnemy;

    private Story localStoryRef;

    // Start is called before the first frame update
    void Start()
    {
        GameManager.OnTurnsElapsed += AddEnemyAdvantage;
        GameFilesData.OnUnityRegisterInkVar += CheckVisitedEnemy;
        GameFilesManager.OnCreateFilesStory += StoreStory;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void StoreStory(Story currentStory)
    {
        localStoryRef = currentStory;
    }
    
    void CheckVisitedEnemy(string varName, string varValue)
    {
        if (varName == "visitEnemy")
        {
            visitedEnemy = varValue;
        }
    }

    void AddEnemyAdvantage(RectTransform rt, int num)
    {

        if (visitedEnemy == "true")
        {
            enemyAdvantageSO.attributeValue = "2";
            if (!gameFiles.playerAttributes.Contains(enemyAdvantageSO))
            {
                gameFiles.playerAttributes.Add(enemyAdvantageSO);
                gameFiles.nullAttributes.Remove(enemyAdvantageSO);
            }
        }
        else
        {
            enemyAdvantageSO.attributeValue = "0";
            if (gameFiles.playerAttributes.Contains(enemyAdvantageSO))
            {
                gameFiles.playerAttributes.Remove(enemyAdvantageSO);
                gameFiles.playerAttributes.Add(enemyAdvantageSO);
            }
        }

    }

    private void OnDisable()
    {
        GameManager.OnTurnsElapsed -= AddEnemyAdvantage;
        GameFilesData.OnUnityRegisterInkVar -= CheckVisitedEnemy;
        GameFilesManager.OnCreateFilesStory -= StoreStory;
    }

}
