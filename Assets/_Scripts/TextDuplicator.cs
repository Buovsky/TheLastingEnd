using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TextDuplicator : MonoBehaviour
{
    private Text _text;
    [SerializeField] private Text _textToCopy;
    void Start()
    {
        _text = GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        _text.text = _textToCopy.text;
    }
}
