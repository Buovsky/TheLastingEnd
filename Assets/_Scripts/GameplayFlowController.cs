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

    void TurnOffCinematicCompoments(bool isSaveWasLoaded)
    {
        if(!isSaveWasLoaded)
        {
            _cinematicIntroDirector.enabled = true;
            _playerAnimator.enabled = true;
            Invoke("SavePositionAfterIntro", 17f);
        }
    }

    void SavePositionAfterIntro()
    {
        GameEvents.current.SaveGame();
    }

    private void OnDestroy() 
    {
        GameEvents.current.onSaveLoaded -= TurnOffCinematicCompoments;
    }

}
