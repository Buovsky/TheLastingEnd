using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RuneZonesScenario : MonoBehaviour
{
    [Header("First Scenario")]
    public LifeManagment _lifeManagment;
    public RuneEffect _runeEffect;
    [SerializeField] private GameObject _caveEntranceCharacter;
    [SerializeField] private Renderer _caveEntranceRenderer;
    [SerializeField] private GameObject _caveOutsideCharacters;
    [SerializeField] private AudioSource _tensionMusic;
    [SerializeField] private AudioSource _appearMusic;
    [SerializeField] private Text _uiTutorial;
    private bool _caveCharVisible = false;
    private int _spellCounterHolder = 0;
    private int _runeIndexHolder;
    void Start()
    {
        GameEvents.current.onRuneScenarioStart += ActivateScenario;
    }

    // Update is called once per frame
    void Update()
    {
        if(_caveEntranceCharacter.activeSelf)
        {
            if(_caveEntranceRenderer.isVisible)
            {
                _caveCharVisible = true;
                if(_runeEffect.SpellCounter[1] > _spellCounterHolder)
                {
                    _uiTutorial.enabled = false;
                    _caveEntranceCharacter.SetActive(false);
                    Invoke("ShowSecondOutsideCharacters", 11f);
                    _caveCharVisible = false;
                }

                if(!_tensionMusic.isPlaying)
                {
                    _spellCounterHolder = _runeEffect.SpellCounter[1];
                    Invoke("ShowUITutorial", 6f);
                    _tensionMusic.time = 3.5f;
                    _appearMusic.Play(0);
                    _tensionMusic.Play(0);
                }

                if(_caveCharVisible)
                {
                    _lifeManagment.playerHealth -= .13f;
                }
            }
        }
        else
        {
            if(!_caveCharVisible && _runeEffect.SpellCounter[1] > _spellCounterHolder)
            {
                _tensionMusic.volume -= .01f;
            }
        }
    }

    void ActivateScenario(int runeIndex)
    {
        switch(runeIndex)
        {
            case 1:
                _runeIndexHolder = runeIndex;
                _caveEntranceCharacter.SetActive(true);
                break;
        }
    }

    void ShowUITutorial()
    {
       
        _uiTutorial.text = "R";
        _uiTutorial.enabled = true;
         Debug.Log("Tutorial showed");
    }

    void ShowSecondOutsideCharacters()
    {
        _caveOutsideCharacters.SetActive(true);
    }

    private void OnDestroy() 
    {
        GameEvents.current.onRuneScenarioStart -= ActivateScenario;
    }
}
