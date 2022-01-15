using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class GameplayFlowController : MonoBehaviour
{
    [SerializeField] private Animator _playerAnimator;
    [SerializeField] private PlayableDirector _cinematicIntroDirector;

    void Start() 
    {
        GameEvents.current.onSaveLoaded += TurnOffCinematicCompoments;
    }

    void TurnOffCinematicCompoments(bool isGameWasLoaded)
    {
        if(!isGameWasLoaded)
        {
            _cinematicIntroDirector.enabled = true;
            _playerAnimator.enabled = true;
        }
    }

    private void OnDestroy() 
    {
        GameEvents.current.onSaveLoaded -= TurnOffCinematicCompoments;
    }

}
