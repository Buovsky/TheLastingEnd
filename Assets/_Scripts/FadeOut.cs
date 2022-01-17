using UnityEngine;
using UnityEngine.UI;

public class FadeOut : MonoBehaviour
{
    private Image _image;
    private Text _text;
    [SerializeField] private bool fadeOut = false;
    [SerializeField] private bool isText = false;
    [SerializeField] private float secureDelay = 0;

    private bool isReady = false;
    private void Awake()
    {
        if (_image == null && !isText)
        {
            _image = GetComponent<Image>();
            Invoke("FadeOutFunctionality", secureDelay);
        }
        if (_text == null && isText)
        {
            _text = GetComponent<Text>();
            Invoke("FadeOutFunctionality", secureDelay);
        }
    }

    private void FixedUpdate()
    {
        if(isReady && !isText)
        {
            if (fadeOut)
            {
                
                if (_image.color.a > 0)
                {
                    _image.color = new Color(_image.color.r, _image.color.g, _image.color.b, _image.color.a - 0.003f);
                }
            }
            else
            {
                if (_image.color.a < 255)
                {
                    _image.color = new Color(_image.color.r, _image.color.g, _image.color.b, _image.color.a + 0.003f);
                }
            }  
        }

        if(isReady && isText)
        {
            if (fadeOut)
            {
                
                if (_text.color.a > 0)
                {
                    _text.color = new Color(_text.color.r, _text.color.g, _text.color.b, _text.color.a - 0.003f);
                }
            }
            else
            {
                if (_text.color.a < 255)
                {
                    _text.color = new Color(_text.color.r, _text.color.g, _text.color.b, _text.color.a + 0.003f);
                }
            }  
        }
        
    }

    void FadeOutFunctionality()
    {
        isReady = true;
    }
}