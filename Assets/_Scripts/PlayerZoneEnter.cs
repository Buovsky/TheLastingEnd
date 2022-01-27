using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Audio;


public class PlayerZoneEnter : MonoBehaviour
{
    [SerializeField] private Collider _caveTrigger; 
    [SerializeField] private Collider _shrineTrigger;

    [SerializeField] private Collider _wallTrigger;
    [SerializeField] private Collider _audioTrigger;
    [SerializeField] private GameObject _audioSourceHandler;
    [SerializeField] private AudioSource _audioSource;
    [SerializeField] private AudioSource _passThroughAudioSource;

    [Space] 
    [Header("Difficulity Wall")]
    // end demo scenario
    [SerializeField] private RuneEffect _runes;
    [SerializeField] private GameObject _blackScreen;
    [SerializeField] private GameObject _logo;
    [SerializeField] private GameObject _runeUIContainer;
    [SerializeField] private GameObject _watchtowerAudioSource;
    [SerializeField] private AudioMixer _masterAudioMixer;


    private bool _isPlayerInZone = false;
    private bool _isPlayerInAudioZone;

    private void Update() 
    {
        if(_isPlayerInAudioZone && _audioSource.volume <= .8f)
        {
            _audioSource.volume += .001f;
        }
        else if(!_isPlayerInAudioZone && _audioSource.volume >= .1f)
        {
            _audioSource.volume -= .002f;
        }
        else if(_audioSource.volume <= .1f)
        {
            _audioSource.Stop();
        }
    }
    
    private void OnTriggerStay(Collider other) 
    {

        if(other == _caveTrigger)
        {
            _isPlayerInZone = true;
            GameEvents.current.PlayerEnterZone(_isPlayerInZone);
            Debug.Log("Player enters " + other);
        }
        else if(other == _shrineTrigger)
        {
            _isPlayerInZone = true;
            GameEvents.current.PlayerEnterZone(_isPlayerInZone);
            Debug.Log("Player enter " + other);
        }
        else if(other == _audioTrigger && !_audioSource.isPlaying)
        {
            _audioSource.Play(0);
            _isPlayerInAudioZone = true;
        }
    }

    private void OnTriggerEnter(Collider other) 
    {
        // TO DO: REWORK THIS INTO EVENTS!!!!!!!!!!!
        if(other == _audioTrigger)
        {
            Debug.Log("ENTERED END GAME WALL TRIGGER");
            float xValue = this.transform.position.x;
            float yValue = _audioSourceHandler.transform.position.y;
            float zValue = _audioSourceHandler.transform.position.z;
            _audioSourceHandler.transform.position = new Vector3(xValue, yValue, zValue);

            _isPlayerInAudioZone = true;
            _audioSource.Play(0);
        }
        else if(other == _wallTrigger)
        {
            // save currency = 0
            _runes.saveGameCurrency = 0;
            //play sound
            _passThroughAudioSource.Play(0);
            //black screen/invoke 2s logo and watchtower sound
            _blackScreen.SetActive(true);
            _runeUIContainer.SetActive(false);
            _masterAudioMixer.FindSnapshot("EndDemoSnapshot").TransitionTo(1f);
            Invoke("LogoAppear", 4f);
            Invoke("LoadMenuScene", 12f);
        }
    }


    private void OnTriggerExit(Collider other) 
    {
        if(other == _caveTrigger)
        {
            _isPlayerInZone = false;
            GameEvents.current.PlayerEnterZone(_isPlayerInZone);
            Debug.Log("Player enters " + other);
        }
        else if(other == _shrineTrigger)
        {
            _isPlayerInZone = false;
            GameEvents.current.PlayerEnterZone(_isPlayerInZone);
            Debug.Log("Player leaves " + other);
        }
        else if(other == _audioTrigger)
        {
            Debug.Log("EXITED END GAME WALL TRIGGER");
            _isPlayerInAudioZone = false;
        }
    }

    void LogoAppear()
    {
        _logo.SetActive(true);
        _watchtowerAudioSource.SetActive(true);
    }

    void LoadMenuScene()
    {
        SceneManager.LoadScene("MainScene");
    }
}
