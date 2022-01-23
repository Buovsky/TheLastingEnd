using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnviroController : MonoBehaviour
{
    [SerializeField] public RuneEffect Runes;

    [SerializeField] public Material WatchTowerMat;
    
    [ColorUsage(true, true)]
    [SerializeField] private Color watchTower_color;

    public GameObject[] EnviroRunes;
    public Vector4 WatchtowerColorHolderer;
    
    void Start()
    {
        GameEvents.current.onEnviroChange += PickController;

        if(Runes.runeCount == 0)
        {
            WatchtowerColorHolderer = watchTower_color;
            WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);
        }

    }

    void PickController(bool isGameWasLoaded)
    {
        if(isGameWasLoaded)
        {
            SetEnviro();
            SetRunes();
        }
        else
        {
            SetEnviro();
        }
    }

    void SetEnviro()
    {
        switch(Runes.runeCount)
        {
            case 1:
                Debug.Log("Enviro was set, for FIRST rune count");
                RenderSettings.fogDensity = 0.0115f;
                WatchtowerColorHolderer = watchTower_color * .2f;
                WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);                
                break;
            case 2:
                Debug.Log("Enviro was set, for SECOND rune count");
                RenderSettings.fogDensity = 0.0135f;
                WatchtowerColorHolderer = watchTower_color * .12f;
                WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);                
                break;
            case 3:
                Debug.Log("Enviro was set, for THIRD rune count");
                RenderSettings.fogDensity = 0.018f;
                WatchtowerColorHolderer = watchTower_color * .065f;
                WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);                
                break;
        }
    }

    void SetRunes()
    {
        for(int i = 0; i < 3; i++)
        {
            if(Runes.CollectedRune[i] == 1)
            {
                EnviroRunes[i].SetActive(false);
            }
        }
    }

    void OnDestroy() 
    {
        GameEvents.current.onEnviroChange -= PickController;
    }

}