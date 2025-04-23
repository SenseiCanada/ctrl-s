using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class ButtonColorChanger : MonoBehaviour
{
    [SerializeField]
    private Button button;
    [SerializeField]
    private Image buttonImage;
    [SerializeField]
    private TMP_Text buttonText;

    // Start is called before the first frame update

    void Start()
    {
        Button button = GetComponent<Button>();
        if (button == null) return;

        TMP_Text text = GetComponentInChildren<TextMeshProUGUI>();
        if (text == null) return;

        if (text.text.ToLower().Contains("color=red"))
        {
            ColorBlock cb = button.colors;
            cb.highlightedColor = Color.red;
            button.colors = cb;
        }
        ResizeButtonPrefab(button, text.text);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void ResizeButtonPrefab(Button buttonPrefab, string buttonText)
    {
        if (buttonText.Length > 0 && buttonText.Length <= 10)
        {
            RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
            rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 100);
        }
        else if (buttonText.Length > 10 && buttonText.Length <= 14)
        {
            RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
            rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 150);
        }
        else if (buttonText.Length > 14 && buttonText.Length <= 30)
        {
            RectTransform rt = buttonPrefab.GetComponent<RectTransform>();
            rt.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 230);
        }
    }
}
