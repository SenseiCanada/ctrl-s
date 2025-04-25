using System.Collections;
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
    private TMP_Text processesTextPrefab; //heading, what's happening, stays visible
    [SerializeField] 
    private TMP_Text processesStatusPrefab; //updates, gets replaced

    [SerializeField]
    private TMP_Text devCommentsPrefab;

    private GameObject currentCodeLine;

    [SerializeField]
    private TMP_Text playerCharacterText;
    [SerializeField]
    private TMP_InputField inputField;

    private bool greetedWorld;
    private bool canPressAnyKey;
    
    // Start is called before the first frame update
    void Start()
    {
        playerCharacterText.gameObject.SetActive(false);
        inputField.gameObject.SetActive(false);
        greetedWorld = false;
        canPressAnyKey = false;
        
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsFirstSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, newCodeLine.transform);
        newProcessText.text = "Loading Daedalus Engine...";
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
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, newCodeLine.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Processes complete: 3/234";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, newCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "Dev log: pretty weird";

        yield return new WaitForSeconds(2f);
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

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "Dev log: creating a game this way";

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

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "Dev log: still unbelievable";

        yield return new WaitForSeconds(1.7f);
        GameObject newCodeLine1 = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine1.transform.SetAsLastSibling();
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, newCodeLine1.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Processes complete: 3/516K";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment1 = Instantiate(devCommentsPrefab, newCodeLine1.transform);
        newDevComment1.transform.SetAsLastSibling();
        newDevComment1.text = "Dev log: how little coding there is";

        yield return new WaitForSeconds(2f);
        GameObject newCodeLine2 = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine2.transform.SetAsLastSibling();
        TMP_Text newStatusText2 = Instantiate(processesStatusPrefab, newCodeLine2.transform);
        newStatusText2.transform.SetAsLastSibling();
        newStatusText2.text = "Processes complete: 7/516K";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment2 = Instantiate(devCommentsPrefab, newCodeLine2.transform);
        newDevComment2.transform.SetAsLastSibling();
        newDevComment2.text = "Dev log: just gotta write notes to myself";

        yield return new WaitForSeconds(2f);
        GameObject newCodeLine2a = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine2a.transform.SetAsLastSibling();
        TMP_Text newStatusText2a = Instantiate(processesStatusPrefab, newCodeLine2a.transform);
        newStatusText2a.transform.SetAsLastSibling();
        newStatusText2a.text = "Processes complete: 9/516K";

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment2a = Instantiate(devCommentsPrefab, newCodeLine2a.transform);
        newDevComment2a.transform.SetAsLastSibling();
        newDevComment2a.text = "Dev log: and the engine creates what I want";

        yield return new WaitForSeconds(3f);
        newStatusText2a.text = "Processes complete: 16/516K";
        
        yield return new WaitForSeconds(2f);
        newStatusText2a.text = "Processes complete: 17/516K";

        yield return new WaitForSeconds(.5f);
        GameObject newCodeLine3 = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine3.transform.SetAsLastSibling();
        TMP_Text newStatusText3 = Instantiate(processesStatusPrefab, newCodeLine3.transform);
        newStatusText3.transform.SetAsLastSibling();
        newStatusText3.text = "Processes complete: 18/516K";

        yield return new WaitForSeconds(1f);
        TMP_Text newDevComment3 = Instantiate(devCommentsPrefab, newCodeLine3.transform);
        newDevComment3.transform.SetAsLastSibling();
        newDevComment3.text = "Dev Log: how can this be so slow??";

        yield return new WaitForSeconds(3f);
        newStatusText3.text = "Processes complete: 21/516K";

        yield return new WaitForSeconds(3.5f);
        GameObject newCodeLine4 = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine4.transform.SetAsLastSibling();
        TMP_Text newStatusText4 = Instantiate(processesStatusPrefab, newCodeLine4.transform);
        newStatusText4.transform.SetAsLastSibling();
        newStatusText4.text = "Processes complete: 24/516K";

        yield return new WaitForSeconds(0.5f);
        TMP_Text newDevComment4 = Instantiate(devCommentsPrefab, newCodeLine4.transform);
        newDevComment4.transform.SetAsLastSibling();
        newDevComment4.text = "Dev log: something must be wrong";

        yield return new WaitForSeconds(5f);
        GameObject newCodeLine5 = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine5.transform.SetAsLastSibling();
        TMP_Text newStatusText5 = Instantiate(processesStatusPrefab, newCodeLine5.transform);
        newStatusText5.transform.SetAsLastSibling();
        newStatusText5.text = "Complete!";

        yield return new WaitForSeconds(.2f);
        TMP_Text newDevComment5 = Instantiate(devCommentsPrefab, newCodeLine5.transform);
        newDevComment5.transform.SetAsLastSibling();
        newDevComment5.text = "Dev Log: finally :(";

        yield return new WaitForSeconds(2f);
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
        newDevComment.text = "Dev Log: ok, type hello world";

        yield return new WaitForSeconds(.5f);
        playerCharacterText.gameObject.SetActive(true);
        inputField.gameObject.SetActive(true);
        inputField.ActivateInputField();

    }

    public void TextFieldInput(string textInput)
    {
        textInput = textInput.ToLower();

        if (greetedWorld)
        {
            StartCoroutine(DisplayError());
            inputField.gameObject.SetActive(false);

        }
        else
        {
            if (textInput == "hello world" || textInput == "helloworld" || textInput == "hello world")
            {
                StartCoroutine(HelloWorld(textInput));
                greetedWorld = true;
                inputField.gameObject.SetActive(false);
            }
        }
    }

    IEnumerator HelloWorld(string textInput)
    {
        GameObject newCodeLine = Instantiate(codeLinePrefab, marginObj.transform);
        newCodeLine.transform.SetAsLastSibling();
        currentCodeLine = newCodeLine;
        TMP_Text newProcessText = Instantiate(processesTextPrefab, currentCodeLine.transform);
        newProcessText.text = textInput;

        yield return new WaitForSeconds(.5f);
        TMP_Text newDevComment = Instantiate(devCommentsPrefab, currentCodeLine.transform);
        newDevComment.transform.SetAsLastSibling();
        newDevComment.text = "Dev Log: weird, engine does it automatically";

        yield return new WaitForSeconds(.5f);
        inputField.gameObject.SetActive(true);
        inputField.text = string.Empty;
        inputField.ActivateInputField();
    }

    IEnumerator DisplayError()
    {
        foreach (Transform child in marginObj.transform)
        {
            Destroy(child.gameObject);
        }
        
        TMP_Text newProcessText = Instantiate(processesTextPrefab, marginObj.transform);
        newProcessText.text = "Critical Error: attempt to issue developer command from unknown source";

        yield return new WaitForSeconds(2f);
        TMP_Text newStatusText = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText.transform.SetAsLastSibling();
        newStatusText.text = "Desist.";
        newStatusText.color = Color.red;

        yield return new WaitForSeconds(4f);
        TMP_Text newStatusText1 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText1.transform.SetAsLastSibling();
        newStatusText1.text = "Return to the library.";
        newStatusText1.color = Color.red;

        yield return new WaitForSeconds(5f);
        TMP_Text newStatusText2 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText2.transform.SetAsLastSibling();
        newStatusText2.text = "Your agency will ruin everything.";
        newStatusText2.color = Color.red;

        yield return new WaitForSeconds(5f);
        TMP_Text newStatusText3 = Instantiate(processesStatusPrefab, marginObj.transform);
        newStatusText3.transform.SetAsLastSibling();
        newStatusText3.text = "Press any key to isolate error and continue in safe mode.";
        canPressAnyKey = true;
    }
}
