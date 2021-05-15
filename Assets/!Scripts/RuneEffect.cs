using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RuneEffect : MonoBehaviour
{
    public int runeCount = 0;
    [SerializeField] private GameObject text;
    [SerializeField] private GameObject _sphere;
    [SerializeField] private GameObject spawnPoint;

    [SerializeField] private GameObject runeOne;
    [SerializeField] private GameObject runeTwo;

    private bool isCollision = false;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(runeCount > 0)
        {
            if (Input.GetKeyUp(KeyCode.E))
            {
                Spawn();
            }
        }
        if(isCollision)
        {
            if (Input.GetKeyDown(KeyCode.F))
            {
                Debug.Log("Liczba run" + runeCount);
                runeCount++;
                if (runeCount == 1)
                {
                    runeOne.SetActive(false);
                    text.SetActive(false);

                }

                if (runeCount == 2)
                {
                    runeTwo.SetActive(false);
                    text.SetActive(false);
                }

            }
        }
    }

    void Spawn()
    {

        GameObject locationSphere = Instantiate(_sphere, spawnPoint.transform.position, Quaternion.identity);
        
    }

    private void OnTriggerStay(Collider other)
    {
        if(other.gameObject.tag == "Rune")
        {
            text.SetActive(true);
            isCollision = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        text.SetActive(false);
        isCollision = false;
    }


}
