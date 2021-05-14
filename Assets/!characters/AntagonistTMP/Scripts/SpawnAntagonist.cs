using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnAntagonist : MonoBehaviour
{
    [SerializeField] private GameObject _antagonist;
    [SerializeField] private GameObject[] spawnList;
    private int numberOfRunes;

    [SerializeField] private float firstSpawn = 20;
    [SerializeField] private float secondSpawn = 30;
    [SerializeField] private float thirdSpawn = 50;

    private bool antagonistLives = false;
    

    void Start()
    {
        CheckCountOfRunes();
        InvokeRepeating("CheckCountOfRunes", .1f, 4);
        
    }

    private void Update()
    {
       
    }

    void CheckCountOfRunes()
    {
        GameObject player = GameObject.Find("FPSController");
        RuneEffect runeEffect = player.GetComponent<RuneEffect>();
        numberOfRunes = runeEffect.runeCount;

        if(numberOfRunes > 0 && GameObject.FindGameObjectWithTag("Antagonist"))
        {
            GameObject antagonist = GameObject.FindGameObjectWithTag("Antagonist");
            AntagonistBehavor antagonistBehavor = antagonist.GetComponent<AntagonistBehavor>();
            antagonistLives = antagonistBehavor.antagonistLive;
            Debug.Log(antagonistLives);
        }

        if (numberOfRunes > 0 && !antagonistLives)
            Appear();

    }

    void Appear()
    {
        switch (numberOfRunes)
        {
            case 1:
                Debug.Log("Antagonist will appear");
                Invoke("Spawn", firstSpawn);
                antagonistLives = true;
                break;
            case 2:
                Invoke("Spawn", secondSpawn);
                antagonistLives = true;
                break;
            case 3:
                Invoke("Spawn", thirdSpawn);
                antagonistLives = true;
                break;
            default:
                print("No runes");
                break;
        }
    }

    void Spawn()
    {  
        GameObject enemy = Instantiate(_antagonist, spawnList[Random.Range(0, spawnList.Length)].transform.position, Quaternion.identity);
    }
}
