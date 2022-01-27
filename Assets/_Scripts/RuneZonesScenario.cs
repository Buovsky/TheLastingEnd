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
    [SerializeField] private AudioSource _tensionMusic;
    [SerializeField] private Text _uiTutorial;
    private bool _caveCharVisible = false;
    private int _spellCounterHolder = 0;
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
                    _caveEntranceCharacter.SetActive(false);
                    _uiTutorial.enabled = false;
                    _caveCharVisible = false;
                }

                if(!_tensionMusic.isPlaying)
                {
                    _spellCounterHolder = _runeEffect.SpellCounter[1];
                    Invoke("ShowUITutorial", 1f);
                    _tensionMusic.time = 4.5f;
                    _tensionMusic.Play(0);
                }

                if(_caveCharVisible)
                {
                    _lifeManagment.playerHealth -= .15f;
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

    private void OnDestroy() 
    {
        GameEvents.current.onRuneScenarioStart -= ActivateScenario;
    }
}
