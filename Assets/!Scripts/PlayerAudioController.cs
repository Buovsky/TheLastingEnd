using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class PlayerAudioController : MonoBehaviour
{
    [SerializeField] private LifeManagment health;
    [SerializeField] private AudioSource breathingAudioSource;
    [SerializeField] private AudioMixer masterAudioMixer;

    private float healthPoints = 100f;

    void Start()
    {
        StartCoroutine(AudioEffectOnHealthLoss());
    }

    private IEnumerator AudioEffectOnHealthLoss()
    {
        healthPoints = health.playerHealth;

        while (gameObject)
        {
            if (healthPoints < 50)
            {
                breathingAudioSource.Play();
                masterAudioMixer.FindSnapshot("DamagedHealthSnapshot").TransitionTo(5f);
            }
            else if(healthPoints < 30)
            {
                masterAudioMixer.FindSnapshot("LowHealthSnapshot").TransitionTo(5f);
            }
            else
            {
                breathingAudioSource.Stop();
                masterAudioMixer.FindSnapshot("DefaultSnapshot").TransitionTo(5f);
            }
        }
        yield return new WaitForSeconds(.3f);
    }

    void Update()
    {
        
    }
}
