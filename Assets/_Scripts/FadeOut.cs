using UnityEngine;
using UnityEngine.UI;

public class FadeOut : MonoBehaviour
{
    private Image _image;
    [SerializeField] private bool fadeOut = false;
    [SerializeField] private float secureDelay = 0;

    private bool isReady = false;
    private void Awake()
    {
        if (_image == null)
        {
            _image = GetComponent<Image>();
            Invoke("FadeOutFunctionality", secureDelay);
        }
    }

    private void FixedUpdate()
    {
        if(isReady)
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
        
    }

    void FadeOutFunctionality()
    {
        isReady = true;
    }
}