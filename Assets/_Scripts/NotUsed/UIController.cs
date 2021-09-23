using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIController : MonoBehaviour
{

    void Start()
    {
        //CooldownUI(runeOneImage, cooldownSphereTime);
        UIEvents.current.onRuneOneCooldownStart += CooldownUI;

    }

    void Update()
    {
        
    }

    void CooldownUI(Image sprite, float cooldown)
    {
        sprite.fillAmount += 1/cooldown * Time.deltaTime;

        if(sprite.fillAmount >= 1)
        {
            sprite.fillAmount = 0;
        }
    }
}
