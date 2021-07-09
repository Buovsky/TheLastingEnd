using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RuneEffect : MonoBehaviour
{
    public int runeCount = 0;
    [SerializeField] private GameObject text;
    [SerializeField] private GameObject _sphere;
    [SerializeField] private GameObject spawnPoint;

    [SerializeField] private Material watchTowerMat;
    [SerializeField] private Color watchTower_color;

    [SerializeField] private GameObject runeOne;
    [SerializeField] private GameObject runeTwo;

    [SerializeField] private GameObject nightVision;

    [SerializeField] private Animator animator;
    [SerializeField] private Animator runeAnimator1;
    [SerializeField] private Animator runeAnimator2;



    private bool isCollision = false;

    // Start is called before the first frame update
    void Start()
    {
        watchTowerMat.SetVector("_EmissionColor", watchTower_color * .7f);
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
        if(runeCount > 1)
        {
            if (Input.GetKeyUp(KeyCode.R))
            {
                nightVision.SetActive(true);
                Invoke("TurnOff", 10);
                
            }
        }
        if(isCollision)
        {
            if (Input.GetKeyDown(KeyCode.F))
            {
                
                runeCount++;
                watchTowerMat.SetVector("_EmissionColor", watchTower_color * .6f);
                Debug.Log("Liczba run" + runeCount);
                if (runeCount == 1)
                {
                    //runeOne.SetActive(false);
                    text.SetActive(false);
                    animator.enabled = true;
                    animator.SetTrigger("Rune_1_Gather");
                    runeAnimator1.SetBool("Gathered", true);
                }

                if (runeCount == 2)
                {
                    watchTowerMat.SetVector("_EmissionColor", watchTower_color * .5f);
                    //runeTwo.SetActive(false);
                    animator.enabled = true;
                    animator.SetTrigger("Rune_2_Gather");
                    runeAnimator2.SetBool("Gathered", true);
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

    void TurnOff()
    {
        nightVision.SetActive(false);
    }

    void TurnOffAnimator()
    {
        animator.enabled = false;
        Debug.Log("Wyłącznie animnatora");
    }


}
