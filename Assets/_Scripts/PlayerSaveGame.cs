using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerSaveGame : MonoBehaviour
{
    [SerializeField] private GameObject _player;
    private CharacterController _charController;
    [SerializeField] public RuneEffect Runes;
    void Start()
    {
        _charController = gameObject.GetComponent(typeof(CharacterController)) as CharacterController;
        _charController.enabled = false;
        LoadPosition();
        LoadRunes();
        if(Runes.runeCount == 0)
        {
            bool isSaveWasLoaded = false;
            GameEvents.current.SaveLoaded(isSaveWasLoaded);
        }
        _charController.enabled = true;
        
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F5))
        {
            if(Runes.saveGameCurrency > 0)
            {
                SavePosition();
                SaveRunes();
                GameEvents.current.SaveGame();
            }
        }

        if (Input.GetKeyDown(KeyCode.F9))
        {
            LoadGame();
        }

        if (Input.GetKeyDown(KeyCode.F12))
        {
            PlayerPrefs.DeleteAll();
        }
    }

    void SavePosition()
    {
        float xPos = _player.transform.position.x;
        float yPos = _player.transform.position.y;
        float zPos = _player.transform.position.z;

        PlayerPrefs.SetFloat("XPosition", xPos);
        PlayerPrefs.SetFloat("YPosition", yPos);
        PlayerPrefs.SetFloat("ZPosition", zPos);
        Debug.Log("Game was saved " + xPos + yPos + zPos);
    }

    void SaveRunes()
    {
        PlayerPrefs.SetInt("RuneCount", Runes.runeCount);

        for(int i = 0; i < Runes.CollectedRune.Length; i++)
        {
            PlayerPrefs.SetInt("CollectedRune_" + i, Runes.CollectedRune[i]);
        }
    }

    void LoadGame()
    {
        SceneManager.LoadScene("MainScene");
    }

    void LoadPosition()
    {
        bool isSaveWasLoaded = true;
        float xPos = PlayerPrefs.GetFloat("XPosition");
        float yPos = PlayerPrefs.GetFloat("YPosition");
        float zPos = PlayerPrefs.GetFloat("ZPosition");

        if(xPos != 0 && yPos != 0 && zPos != 0)
        {
            _player.transform.position = new Vector3(xPos, yPos, zPos);
            
            // Send event to GameplayFlowController to turn off intro cinematic
            GameEvents.current.SaveLoaded(isSaveWasLoaded);
        }
    }

    void LoadRunes()
    {
        bool isGameWasLoaded = true;
        int runeCount = PlayerPrefs.GetInt("RuneCount", 0);
        Runes.runeCount = runeCount;

        for(int i = 0; i < Runes.CollectedRune.Length; i++)
        {
            Runes.CollectedRune[i] = PlayerPrefs.GetInt("CollectedRune_" + i, 0);
        }

        // Enent to apply proper Envrio
        GameEvents.current.EnviroChanged(isGameWasLoaded);
    }

}
