using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class GameplayFlowController : MonoBehaviour
{
    [SerializeField] public RuneEffect Runes;
    [SerializeField] private Animator _playerAnimator;
    [SerializeField] private PlayableDirector _cinematicIntroDirector;

    void Start() 
    {
        GameEvents.current.onSaveLoaded += TurnOffCinematicCompoments;
    }

    void TurnOffCinematicCompoments()
    {
        _cinematicIntroDirector.enabled = false;
        _playerAnimator.enabled = false;
    }

    private void OnDestroy() 
    {
        GameEvents.current.onSaveLoaded -= TurnOffCinematicCompoments;
    }

}
