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
}
