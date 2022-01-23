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
    [SerializeField] GameObject turnOffOnChaise1;
    [SerializeField] GameObject turnOffOnChaise2;
    [SerializeField] GameObject turnOffOnChaise3;

    public bool antagonistLive = false;
    private bool stopChase = false;
    Animator animator;

    private void Start() 
    {
        //GameEvents.current.onPlayerEnterZone += PlayerInZone;        
    }
    void Awake()
    {
        GameEvents.current.AntagonistAppear();

        animator = GetComponent<Animator>();

        CheckCountOfRunes();
        CheckPlayerPosition();
        InvokeRepeating("CheckPlayerPosition", .1f, .1f);
        antagonistLive = true;
        Die();

        GameEvents.current.onPlayerEnterZone += PlayerInZone;

        //SKIP PLAYING AUDIO IF PLAYER IN RUNE ZONE

    }
    void FixedUpdate()
    {
        if(!stopChase)
        {
            agent.isStopped = false;
            agent.SetDestination(playerPos.transform.position);
        }
        else
        {
            agent.isStopped = true;
        }
        
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
        GameEvents.current.AntagonistDisappear();
        animator.SetBool("Disappear", true);
    }

    void PlayerInZone(bool isPlayerInZone)
    {
        Debug.Log("PlayerInZone");
        if(isPlayerInZone)
        {
            stopChase = true;
            turnOffOnChaise1.SetActive(false);
            turnOffOnChaise2.SetActive(false);
            turnOffOnChaise3.SetActive(false);
        }
        else if(!isPlayerInZone)
        {
            stopChase = false;
            turnOffOnChaise1.SetActive(true);
            turnOffOnChaise2.SetActive(true);
            turnOffOnChaise3.SetActive(true);
        }
    }

    private void OnDestroy() 
    {
        GameEvents.current.onPlayerEnterZone -= PlayerInZone;        
    }

}

