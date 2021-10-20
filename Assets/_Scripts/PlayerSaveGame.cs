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
        LoadWatchTowerColor();
        _charController.enabled = true;
        
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F5))
        {
            SavePosition();
            SaveRunes();
            SaveWatchTowerColor();
        }

        if (Input.GetKeyDown(KeyCode.F9))
        {
            LoadGame();
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

    void SaveWatchTowerColor()
    {
        PlayerPrefs.SetFloat("WatchTowerColor_X", Runes.WatchtowerColorHolderer.x);
        PlayerPrefs.SetFloat("WatchTowerColor_Y", Runes.WatchtowerColorHolderer.y);
        PlayerPrefs.SetFloat("WatchTowerColor_Z", Runes.WatchtowerColorHolderer.z);
        PlayerPrefs.SetFloat("WatchTowerColor_W", Runes.WatchtowerColorHolderer.w);
    }

    void LoadGame()
    {
        SceneManager.LoadScene("MainScene");
    }

    void LoadPosition()
    {
        float xPos = PlayerPrefs.GetFloat("XPosition");
        float yPos = PlayerPrefs.GetFloat("YPosition");
        float zPos = PlayerPrefs.GetFloat("ZPosition");

        if(xPos != 0 && yPos != 0 && zPos != 0)
        {
            _player.transform.position = new Vector3(xPos, yPos, zPos);
        }
    }

    void LoadRunes()
    {
        int runeCount = PlayerPrefs.GetInt("RuneCount", 0);

        Runes.runeCount = runeCount;

        for(int i = 0; i < Runes.CollectedRune.Length; i++)
        {
            Runes.CollectedRune[i] = PlayerPrefs.GetInt("CollectedRune_" + i, 0);
        }
    }

    void LoadWatchTowerColor()
    {
        float x = PlayerPrefs.GetFloat("WatchTowerColor_X", Runes.WatchtowerColorHolderer.x);
        float y = PlayerPrefs.GetFloat("WatchTowerColor_Y", Runes.WatchtowerColorHolderer.y);
        float z = PlayerPrefs.GetFloat("WatchTowerColor_Z", Runes.WatchtowerColorHolderer.z);
        float w = PlayerPrefs.GetFloat("WatchTowerColor_W", Runes.WatchtowerColorHolderer.w);

        Runes.WatchtowerColorHolderer = new Vector4(x, y, z, w);
    }
}
