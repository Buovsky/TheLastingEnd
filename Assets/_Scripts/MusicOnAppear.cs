using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicOnAppear : MonoBehaviour
{
    [SerializeField] private AudioSource _appearMusic;
    [SerializeField] private GameObject _secondCharactersContainer;
    
    private void OnBecameVisible() {
        _appearMusic.Play(0);
        Invoke("DeactivateSecondCharacters", 15f);
    }

    void DeactivateSecondCharacters()
    {
        _secondCharactersContainer.SetActive(false);
    }
}
