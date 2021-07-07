using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AntagonistBehavor : MonoBehaviour
{
    [SerializeField] private NavMeshAgent agent;
    private int numberOfRunes;
    private Transform playerPos;

    [SerializeField] private float firstDie = 40;
    [SerializeField] private float secondDie = 60;
    [SerializeField] private float thirdDie = 80;

    public bool antagonistLive = false;

    Animator animator;

    void Awake()
    {
        animator = GetComponent<Animator>();

        CheckCountOfRunes();
        CheckPlayerPosition();
        InvokeRepeating("CheckPlayerPosition", .1f, .1f);
        antagonistLive = true;
        Die();

    }
    void FixedUpdate()
    {
        agent.SetDestination(playerPos.transform.position);
        //Debug.Log("Żyje" + antagonistLive);
    }

    void CheckCountOfRunes()
    {
        GameObject player = GameObject.Find("FPSController");
        RuneEffect runeEffect = player.GetComponent<RuneEffect>();
        numberOfRunes = runeEffect.runeCount;
    }

    void CheckPlayerPosition()
    {
        GameObject player = GameObject.Find("FPSController");
        playerPos = player.transform;
    }

    void Die()
    {
        switch (numberOfRunes)
        {
            case 1:
                Destroy(gameObject, firstDie);
                Invoke("Alive", firstDie -1); // this should be send event to SpawnAntagonist
                Invoke("DisappearAnimation", firstDie -5); // this should be send event to SpawnAntagonist
                break;
            case 2:
                Destroy(gameObject, secondDie);
                Invoke("Alive", secondDie -1);
                Invoke("DisappearAnimation", secondDie -5);
                break;
            case 3:
                Destroy(gameObject, thirdDie);
                Invoke("Alive", thirdDie -1);
                Invoke("DisappearAnimation", thirdDie -5);
                break;
            default:
                Debug.Log("No runes");
                break;
        }
    }

    private void Alive()
    {
        antagonistLive = false;
    }

    private void DisappearAnimation()
    {
        animator.SetBool("Disappear", true);
    }
}

