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
        while (gameObject)
        {
            healthPoints = health.playerHealth;

            if (healthPoints < 50f && healthPoints > 30f)
            {
                if(!breathingAudioSource.isPlaying)
                    breathingAudioSource.Play();

                masterAudioMixer.FindSnapshot("DamagedHealthSnapshot").TransitionTo(5f);
            }

            if(healthPoints < 30f)
            {
                masterAudioMixer.FindSnapshot("LowHealthSnapshot").TransitionTo(5f);
            }

            if(healthPoints < 100f && healthPoints > 50f)
            {
                masterAudioMixer.FindSnapshot("DefaultSnapshot").TransitionTo(10f);
                if(healthPoints > 70)
                    breathingAudioSource.Stop();
            }

            yield return new WaitForSeconds(.3f);
        }
    }

    void Update()
    {
        
    }
}
