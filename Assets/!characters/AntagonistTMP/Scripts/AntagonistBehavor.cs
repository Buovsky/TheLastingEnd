using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class AntagonistBehavor : MonoBehaviour
{
    [SerializeField] private NavMeshAgent agent;
    private int numberOfRunes;
    private Transform playerPos;

    [SerializeField] private float firstDie = 20;
    [SerializeField] private float secondDie = 60;
    [SerializeField] private float thirdDie = 80;

    public bool antagonistLive = false;

    // Start is called before the first frame update
    void Awake()
    {
        CheckCountOfRunes();
        CheckPlayerPosition();
        InvokeRepeating("CheckPlayerPosition", .1f, .1f);
        antagonistLive = true;
        Die();

    }

    // Update is called once per frame
    void FixedUpdate()
    {
        agent.SetDestination(playerPos.transform.position);
        Debug.Log("Żyje" + antagonistLive);
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
                Invoke("Alive", firstDie -3);
                break;
            case 2:
                Destroy(gameObject, secondDie);
                Invoke("Alive", secondDie -5);
                break;
            case 3:
                Destroy(gameObject, thirdDie);
                Invoke("Alive", thirdDie - 5);
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
}

