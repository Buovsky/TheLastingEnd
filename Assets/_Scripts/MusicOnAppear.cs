using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicOnAppear : MonoBehaviour
{
    [SerializeField] private AudioSource _appearMusic;
    [SerializeField] private GameObject _secondCharactersContainer;
    
    private void OnBecameVisible() {
        if(!_appearMusic.isPlaying)
        {
            _appearMusic.Play(0);
        }
        Invoke("DeactivateSecondCharacters", 14.5f);
    }

    void DeactivateSecondCharacters()
    {
        _secondCharactersContainer.SetActive(false);
    }
}
