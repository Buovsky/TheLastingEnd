using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerZoneEnter : MonoBehaviour
{
    [SerializeField] private Collider _caveTrigger; 
    [SerializeField] private Collider _shrineTrigger;

    private bool _isPlayerInZone;
    
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
            Debug.Log("Player leaves " + other);
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
    }
}
