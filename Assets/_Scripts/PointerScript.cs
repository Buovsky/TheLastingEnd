using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PointerScript : MonoBehaviour
{
    [SerializeField] private NavMeshAgent agent;

    [SerializeField] private GameObject[] runeZone;

    private RuneEffect runeEffect;

    private int numberOfRunes = 0;

    private int[] runeCollectedRune = {0, 0, 0, 0, 0, 0};


    // Start is called before the first frame update
    void Awake()
    {
        Destroy(gameObject, 5);
        GameObject player = GameObject.Find("FPSController");
        runeEffect = player.GetComponent<RuneEffect>();
        numberOfRunes = runeEffect.runeCount;
        Debug.Log(numberOfRunes);

        for(int i = 0; i < runeEffect.CollectedRune.Length; i++)
        {
            runeCollectedRune[i] = runeEffect.CollectedRune[i];
        }

        if(runeCollectedRune[0] == 1 && runeCollectedRune[1] == 0 && runeCollectedRune[2] == 1)
        {
            agent.SetDestination(runeZone[0].transform.position);
        }
        else if(runeCollectedRune[1] == 1 && runeCollectedRune[2] == 0)
        {
            agent.SetDestination(runeZone[1].transform.position);
        }
        else if(runeCollectedRune[0] == 1 && runeCollectedRune[1] == 1 && runeCollectedRune[2] == 1)
        {
            agent.SetDestination(runeZone[2].transform.position);
        }
         else if(runeCollectedRune[0] == 1 && runeCollectedRune[1] == 0 && runeCollectedRune[2] == 0)
         {
            agent.SetDestination(runeZone[0].transform.position);
         }
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        // switch(numberOfRunes)
        // {
        //     case 1:
                
        //         break;
        //     case 2:
        //         agent.SetDestination(runeZone[1].transform.position);
        //         break;
        // }
    }
}
