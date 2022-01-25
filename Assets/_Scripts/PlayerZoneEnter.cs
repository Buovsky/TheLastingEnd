using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerZoneEnter : MonoBehaviour
{
    [SerializeField] private Collider _caveTrigger; 
    [SerializeField] private Collider _shrineTrigger;

    [SerializeField] private Collider _wallTrigger;
    [SerializeField] private Collider _audioTrigger;
    [SerializeField] private GameObject _audioSourceHandler;
    [SerializeField] private AudioSource _audioSource;

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
            _audioSource.volume -= .003f;
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
}
