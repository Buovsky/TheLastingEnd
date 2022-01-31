using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class LifeManagment : MonoBehaviour
{
    private bool isAntagonistAlive;
    private GameObject antagonist;
    private Transform antagonistPos;

    private CharacterController _charController;
    private Rigidbody _rigidbody;
    private CapsuleCollider _capsuleCollider;

    private bool isPlayerDead = false;

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

        _charController = gameObject.GetComponent(typeof(CharacterController)) as CharacterController;
        _rigidbody = gameObject.GetComponent(typeof(Rigidbody)) as Rigidbody;
        _capsuleCollider = gameObject.GetComponent(typeof(CapsuleCollider)) as CapsuleCollider;
    }

    private void Update()
    {
        if(playerHealth < 0 && !isPlayerDead)
        {
            isPlayerDead = true;
            PlayerDeath();
            
        }
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
                playerHealth -= .8f * damageMultiplier;

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

    private void PlayerDeath()
    {
        _charController.enabled = false;
        _rigidbody.isKinematic = false;
        _rigidbody.AddForce(transform.forward * 50);
        _rigidbody.AddForce(transform.up * 20);
        _capsuleCollider.enabled = true;

        GameEvents.current.PlayerDeath();
        Invoke("RestartScene", 2.5f);
    }

    private void RestartScene()
    {
        SceneManager.LoadScene("MainScene");
    }

    private void OnDestroy()
    {
        GameEvents.current.onAntagonistAppear -= AntagonistAppear;
        GameEvents.current.onAntagonistAppear -= AntagonistDisappear;
    }
}
