using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class PlayerAudioController : MonoBehaviour
{
    [SerializeField] private LifeManagment health;
    [SerializeField] private AudioSource breathingAudioSource;
    [SerializeField] private AudioMixer masterAudioMixer;

    [SerializeField] private AudioSource deathAudio;

    private float healthPoints = 100f;

    void Start()
    {
        masterAudioMixer.FindSnapshot("DefaultSnapshot").TransitionTo(.1f);
        GameEvents.current.onPlayerDeath += PlayDeathSnapshot;
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

            if(healthPoints < 30f && healthPoints > 0f)
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

    void PlayDeathSnapshot()
    {
        if(!deathAudio.enabled)
            masterAudioMixer.FindSnapshot("PlayerDeathSnapshot").TransitionTo(4f);
        deathAudio.enabled = true;
        Debug.Log("DEATH AUDIO");
    }

    private void OnDestroy()
    {
        GameEvents.current.onPlayerDeath -= PlayDeathSnapshot;
    }

}
