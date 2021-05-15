using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PointerScript : MonoBehaviour
{
    [SerializeField] private NavMeshAgent agent;

    [SerializeField] private GameObject[] runeZone;

    private int numberOfRunes = 0;


    // Start is called before the first frame update
    void Awake()
    {
        Destroy(gameObject, 3);
        GameObject player = GameObject.Find("FPSController");
        RuneEffect runeEffect = player.GetComponent<RuneEffect>();
        numberOfRunes = runeEffect.runeCount;
        Debug.Log(numberOfRunes);
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        switch(numberOfRunes)
        {
            case 1:
                agent.SetDestination(runeZone[0].transform.position);
                break;
            case 2:
                agent.SetDestination(runeZone[1].transform.position);
                break;
        }
    }
}
