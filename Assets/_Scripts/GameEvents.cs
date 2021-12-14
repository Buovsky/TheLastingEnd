using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class GameEvents : MonoBehaviour
{
    public static GameEvents current;

    private void Awake()
    {
        current = this;
    }

    public event Action onAntagonistAppear;
    public event Action onAntagonistDisappear;

    public event Action onPlayerDeath;

    public event Action<String> onRaycastHit;
    public event Action onRaycastMiss;
    public event Action onSaveLoaded;


    public void AntagonistAppear()
    {
        onAntagonistAppear?.Invoke();
    }
    public void AntagonistDisappear()
    {
        onAntagonistDisappear?.Invoke();
    }
    public void PlayerDeath()
    {
        onPlayerDeath?.Invoke();
    }

    public void RaycastHit(string hitTag)
    {
        onRaycastHit?.Invoke(hitTag);
    }
    
    public void RaycastMiss()
    {
        onRaycastMiss?.Invoke();
    }
    public void SaveLoaded()
    {
        onSaveLoaded?.Invoke();
    }
}
