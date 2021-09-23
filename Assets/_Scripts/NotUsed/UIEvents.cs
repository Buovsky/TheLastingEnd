using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

public class UIEvents : MonoBehaviour
{
    public static UIEvents current;
    
    public event Action<Image, float> onRuneOneCooldownStart;
    public event Action onRuneOneCooldownFinish;

    private void Awake()
    {
        current = this;
    }

    public void RuneOneCooldownStart(Image sprite, float cooldown)
    {
        onRuneOneCooldownStart?.Invoke(sprite, cooldown);
    }
    public void RuneOneCooldownFinish()
    {
        onRuneOneCooldownFinish?.Invoke();
    }
    
}
