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
    [SerializeField] private GameObject _firstDecalTutorial;

    [Header("Second Scenario")]
    [SerializeField] private GameObject _wallCharacters;
    [SerializeField] private GameObject _runningCharacter;
    [SerializeField] private Renderer _rightRenderer;
    [SerializeField] private Renderer _leftRenderer;
    [SerializeField] private AudioSource _tensionMusicSecond;
    [SerializeField] private AudioSource _appearMusicSecond;
    [SerializeField] private GameObject _secondDecalTutorial;





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
        if(_runeIndexHolder == 1)
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
                        Invoke("ShowCharacters", 11f);
                        _caveCharVisible = false;
                    }

                    if(!_tensionMusic.isPlaying)
                    {
                        _spellCounterHolder = _runeEffect.SpellCounter[1];
                        Invoke("ShowUITutorial", 7.5f);
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
        else if(_runeIndexHolder == 2)
        {
            if(_rightRenderer.isVisible || _leftRenderer.isVisible)
            {
                if(!_tensionMusicSecond.isPlaying)
                {
                    Invoke("ShowUITutorial", 14f);
                    Invoke("ShowCharacters", 8f);
                    _appearMusicSecond.Play(0);
                    _tensionMusicSecond.Play(0);
                }
            }

            if(_runeEffect.SpellCounter[2] > _spellCounterHolder)
            {
                _uiTutorial.enabled = false;
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
            case 2:
                _runeIndexHolder = runeIndex;
                _spellCounterHolder = _runeEffect.SpellCounter[2];
                _wallCharacters.SetActive(true);
                break;
        }
    }

    void ShowUITutorial()
    {
       switch(_runeIndexHolder)
        {
            case 1:
                //_uiTutorial.text = "R";
                _firstDecalTutorial.SetActive(true);
                break;
            case 2:
                //_uiTutorial.text = "F5";
                _secondDecalTutorial.SetActive(true);
                break;
        }
        //_uiTutorial.enabled = true;
        Debug.Log("Tutorial showed");
    }

    void ShowCharacters()
    {
        switch(_runeIndexHolder)
        {
            case 1:
                _caveOutsideCharacters.SetActive(true);
                break;
            case 2:
                _runningCharacter.SetActive(true);
                break;
        }

    }

    private void OnDestroy() 
    {
        GameEvents.current.onRuneScenarioStart -= ActivateScenario;
    }
}
