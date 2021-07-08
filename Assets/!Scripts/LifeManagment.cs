using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;


public class LifeManagment : MonoBehaviour
{
    [SerializeField] private PostProcessVolume volume;

    private Vignette _Vignette;

    private bool isAntagonistAlive;
    private GameObject antagonist;
    private Transform antagonistPos;

    [SerializeField] private float minDist = 1f;
    [SerializeField] private float maxDist = 15f;
    [SerializeField] private float closeEffect = 3f;
    [SerializeField] private float farEffect = 0f;

    private float damageMultiplier = 0f;
    public float playerHealth = 100f;

    void Start()
    {
        StartCoroutine(HealthRegeneration());
        GameEvents.current.onAntagonistAppear += AntagonistAppear;
        GameEvents.current.onAntagonistDisappear += AntagonistDisappear;
    }

    private IEnumerator CheckPostion()
    {
        while (isAntagonistAlive)
        {
            Debug.Log("Antagonist alive: " + isAntagonistAlive);
            float dist = Vector3.Distance(antagonistPos.position, transform.position);

            float x = Mathf.Clamp(dist, minDist, maxDist);
            damageMultiplier = (farEffect - closeEffect) * (x - minDist) / (maxDist - minDist) + closeEffect;
            if (dist > maxDist)
                damageMultiplier = 0f;
            else
                playerHealth -= .5f * damageMultiplier;

            Debug.Log("Player Health: " + playerHealth + "Antagonist damage multiplier: " + damageMultiplier);

            yield return new WaitForSeconds(.3f);
        }
    }
    
    private IEnumerator HealthRegeneration()
    {
        while(gameObject)
        {
            if(playerHealth < 100f && damageMultiplier == 0f)
            {
                Debug.Log("HealthRegeneration is ON");
                playerHealth += .8f;
                Mathf.Clamp(playerHealth, 0f, 100f);
            }
            yield return new WaitForSeconds(.5f);
        }
    }

    private void AntagonistAppear()
    {
        antagonist = GameObject.FindGameObjectWithTag("Antagonist");
        antagonistPos = antagonist.transform;
        isAntagonistAlive = true;
        StartCoroutine(CheckPostion());
    }
    private void AntagonistDisappear()
    {
        isAntagonistAlive = false;
        StopCoroutine(CheckPostion());
    }

    private void OnDestroy()
    {
        GameEvents.current.onAntagonistAppear -= AntagonistAppear;
        GameEvents.current.onAntagonistAppear -= AntagonistDisappear;
    }
}
