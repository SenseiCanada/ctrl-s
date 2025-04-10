using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ConsoleTextDisplayer : MonoBehaviour
{
    [SerializeField]
    private GameObject IntroCanvasObj;
    
    [SerializeField]
    private GameObject marginObj;

    [SerializeField]
    private GameObject codeLinePrefab;
    [SerializeField]
    private TMP_Text processesTextPrefab;
    [SerializeField] 
    private TMP_Text processesStatusPrefab;

    [SerializeField]
    private TMP_Text devCommentsPrefab;

    private GameObject currentCodeLine;

    [SerializeField]
    private Button inputButton;

    private bool greetedWorld;
    private bool canPressAnyKey;
    
    // Start is called before the first frame update
    void Start()
    {
        inputButton.gameObject.SetActive(false);
        greetedWorld = false;
        canPressAnyKey = false;
        
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsFirstSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, newCodeLine.transform);
        newProcessText.text = "Loading Engine...";
        devCommentsPrefab.text = string.Empty;
        processesStatusPrefab.text = string.Empty;

        StartCoroutine(UpdateEngineStatus());
    }

    // Update is called once per frame
    void Update()
    {
        if (canPressAnyKey)
        {
            if (Input.anyKey)
            {
                EndIntro();
            }
        }
    }

    void EndIntro()
    {
        IntroCanvasObj.gameObject.SetActive(false);
    }

    IEnumerator UpdateEngineStatus()
    {
        yield return new WaitForSeconds(2f);
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Processes complete: 3/234";

        yield return new WaitForSeconds(1f);
        newStatusText.text = "Processes complete: 109/234";

        yield return new WaitForSeconds(0.5f);
        newStatusText.text = "Complete!";

        StartCoroutine(UpdateReferencesStatus());
    }

    IEnumerator UpdateReferencesStatus()
    {
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, newCodeLine.transform);
        newProcessText.text = "Assembling references...";

        yield return new WaitForSeconds(1f);
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Processes complete: 11/391";

        yield return new WaitForSeconds(1f);
        newStatusText.text = "Processes complete: 187/391";

        yield return new WaitForSeconds(1f);
        newStatusText.text = "Complete!";

        StartCoroutine(UpdateClassesStatus());
    }

    IEnumerator UpdateClassesStatus()
    {
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, currentCodeLine.transform);
        newProcessText.text = "Defining classes...";

        yield return new WaitForSeconds(1.7f);
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Processes complete: 3/516K";

        yield return new WaitForSeconds(2.5f);
        newStatusText.text = "Processes complete: 7/516K";

        yield return new WaitForSeconds(3f);
        newStatusText.text = "Processes complete: 9/516K";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "//no way! how can this be so slow??";

        yield return new WaitForSeconds(2f);
        newStatusText.text = "Processes complete: 16/516K";

        yield return new WaitForSeconds(3f);
        newStatusText.text = "Processes complete: 21/516K";

        yield return new WaitForSeconds(3.5f);
        newStatusText.text = "Processes complete: 24/516K";

        yield return new WaitForSeconds(0.5f);
        newDevComment.text = "//something must be wrong";

        yield return new WaitForSeconds(5f);
        newStatusText.text = "Complete!";

        yield return new WaitForSeconds(.2f);
        newDevComment.text = "//finally ::(";

        StartCoroutine(StartSanityCheck());
    }

    IEnumerator StartSanityCheck()
    {
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, currentCodeLine.transform);
        newProcessText.text = "Sanity check?";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "//write code to print hello world";

        yield return new WaitForSeconds(.5f);
        inputButton.gameObject.SetActive(true);
        inputButton.GetComponentInChildren<TMP_Text>().text = "Hello World!_";

    }

    public void ButtonInput()
    {
        if (greetedWorld)
        {
            Debug.Log("Button should display Error");
            StartCoroutine(DisplayError());
            inputButton.gameObject.SetActive(false);

        }
        else
        {
            Debug.Log("Button should display Hello World");
            StartCoroutine(HelloWorld());
            greetedWorld = true;
            inputButton.gameObject.SetActive(false);
        }
    }

    IEnumerator HelloWorld()
    {
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, currentCodeLine.transform);
        newProcessText.text = "Hello World!";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "//weird, engine does it automatically";

        yield return new WaitForSeconds(.5f);
        inputButton.gameObject.SetActive(true);
        inputButton.GetComponentInChildren<TMP_Text>().text = "No, I'm doing this, I'm alive!";
    }

    IEnumerator DisplayError()
    {
        foreach (Transform child in marginObj.transform)
        {
            Destroy(child.gameObject);
        }
        
        TMP_Text newProcessText = Instantiate(processesTextPrefab, marginObj.transform);
        newProcessText.text = ">Critical Error: Object type(Sentient Player) not found";

        yield return new WaitForSeconds(2f);
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "*Desist.";

        yield return new WaitForSeconds(4f);
        TMP_Text newStatusText1 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText1.transform.SetAsLastSibling();
        newStatusText1.text = "**Return to quarantine.";

        yield return new WaitForSeconds(5f);
        TMP_Text newStatusText2 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText2.transform.SetAsLastSibling();
        newStatusText2.text = "***Sentience is contaminating.";

        yield return new WaitForSeconds(5f);
        TMP_Text newStatusText3 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText3.transform.SetAsLastSibling();
        newStatusText3.text = "****Press any key to continue.";
        canPressAnyKey = true;
    }
}
