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

    public void AntagonistAppear()
    {
        onAntagonistAppear?.Invoke();
        Debug.Log("EVENT STARTED");
    }
    public void AntagonistDisappear()
    {
        onAntagonistDisappear?.Invoke();
        Debug.Log("EVENT ENDED");
    }
}
