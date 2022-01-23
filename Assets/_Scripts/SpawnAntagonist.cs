using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnAntagonist : MonoBehaviour
{
    [SerializeField] private GameObject _antagonist;
    [SerializeField] private GameObject _player;
    [SerializeField] private GameObject[] spawnList;
    private int numberOfRunes;

    [SerializeField] private float firstSpawn = 20;
    [SerializeField] private float secondSpawn = 30;
    [SerializeField] private float thirdSpawn = 50;

    private bool antagonistLives = false;

    AudioSource audioData;
    

    void Start()
    {
        CheckCountOfRunes();
        InvokeRepeating("CheckCountOfRunes", .1f, 1);
        GameEvents.current.onPlayerEnterZone += PlayerInZone;
        audioData = GetComponent<AudioSource>();
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
                antagonistLives = true; // send event to spawn antagonist
                audioData.Play(0);
                break;
            case 2:
                Invoke("Spawn", secondSpawn);
                antagonistLives = true;
                audioData.Play(0);
                
                break;
            case 3:
                Invoke("Spawn", thirdSpawn);
                antagonistLives = true;
                audioData.Play(0);
                break;
            default:
                print("No runes");
                break;
        }
    }

    void Spawn()
    {  
        float finalDist = 1000f;
        float[] tmpDist = new float[spawnList.Length];
        Vector3 nearestSpawn = new Vector3(0, 0, 0);

        for(int i = 0; i < spawnList.Length; i++)
        {
            tmpDist[i] = Vector3.Distance(spawnList[i].transform.position, _player.transform.position);
            //Debug.Log("Spawn " + i + " distance is " + tmpDist[i]);
            //Debug.Log("Spawn " + i + " localization is " + spawnList[i].transform.position);
            
            if(tmpDist[i] < finalDist)
            {
                finalDist = tmpDist[i];
            }
        }

        for(int i = 0; i < spawnList.Length; i++)
        {
            if(finalDist == tmpDist[i])
            {
                nearestSpawn = spawnList[i].transform.position;
            }
        }

        //Debug.Log("Nearest spawn localization " + nearestSpawn);
        GameObject enemy = Instantiate(_antagonist, nearestSpawn, Quaternion.identity);
    }

    void PlayerInZone(bool isPlayerInZone)
    {
        if(isPlayerInZone)
        {
            audioData.enabled = false;
        }
        else
        {
            audioData.enabled = true;
        }
    }

    private void OnDestroy() 
    {
        GameEvents.current.onPlayerEnterZone -= PlayerInZone;
    }
}
