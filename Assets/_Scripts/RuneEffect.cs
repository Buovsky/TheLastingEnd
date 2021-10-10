using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

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
    [SerializeField] private Animator runeAnimator3;

    [SerializeField] private float cooldownSphereTime = 5;
    [SerializeField] private float cooldownVisionTime = 10;
    [SerializeField] private Image[] runeImage;
    [SerializeField] private GameObject[] runeUIContainer;

    private string currentPickUpRune = null;

    private float nextSphereUseTime = 0;
    private float nextVisionUseTime = 0;

    bool isRuneOneOnCooldown = false;
    bool isRuneTwoOnCooldown = false;
    
    void Start()
    {
        GameEvents.current.onRaycastHit += RaycastHitInfo;
        GameEvents.current.onRaycastMiss += RaycastMiss;
        watchTowerMat.SetVector("_EmissionColor", watchTower_color * .7f);
    }
    void Update()
    {
        if(runeCount > 0)
        {
            runeUIContainer[0].SetActive(true);
            if(Time.time > nextSphereUseTime)
            {
                isRuneOneOnCooldown = false;
                if (Input.GetKeyUp(KeyCode.E))
                {
                    Spawn();
                    nextSphereUseTime = Time.time + cooldownSphereTime;
                    isRuneOneOnCooldown = true;
                }
            }
        }
        else
        {
            runeUIContainer[0].SetActive(false);
        }

        if(runeCount > 1)
        {
            runeUIContainer[1].SetActive(true);
            if (Time.time > nextVisionUseTime)
            {
                isRuneTwoOnCooldown = false;
                if (Input.GetKeyUp(KeyCode.R))
                {
                    nightVision.SetActive(true);
                    Invoke("TurnOff", 10);
                    nextVisionUseTime = Time.time + cooldownVisionTime;
                    isRuneTwoOnCooldown = true;
                }
            }
        }
        else
        {
            runeUIContainer[1].SetActive(false);
        }

        if(isRuneOneOnCooldown)
        {
            CooldownUI(runeImage[0], cooldownSphereTime);
        }
        
        if(isRuneTwoOnCooldown)
        {
            CooldownUI(runeImage[1], cooldownVisionTime);
        }
        
        if(currentPickUpRune != null)
        {
            if (Input.GetKeyDown(KeyCode.F))
            {
                runeCount++;
                watchTowerMat.SetVector("_EmissionColor", watchTower_color * .6f);
                Debug.Log("Liczba run" + runeCount);
                if (currentPickUpRune == "Rune1")
                {
                    //runeOne.SetActive(false);
                    text.SetActive(false);
                    animator.enabled = true;
                    animator.SetTrigger("Rune_1_Gather");
                    runeAnimator1.SetBool("Gathered", true);
                }

                if (currentPickUpRune == "Rune2")
                {
                    watchTowerMat.SetVector("_EmissionColor", watchTower_color * .5f);
                    //runeTwo.SetActive(false);
                    animator.enabled = true;
                    animator.SetTrigger("Rune_2_Gather");
                    runeAnimator2.SetBool("Gathered", true);
                    text.SetActive(false);
                }

                if (currentPickUpRune == "Rune3")
                {
                    watchTowerMat.SetVector("_EmissionColor", watchTower_color * .4f);
                    //runeTwo.SetActive(false);
                    animator.enabled = true;
                    animator.SetTrigger("Rune_3_Gather");
                    runeAnimator3.SetBool("Gathered", true);
                    text.SetActive(false);
                }

            }
            
        }

    }

    void Spawn()
    {

        GameObject locationSphere = Instantiate(_sphere, spawnPoint.transform.position, Quaternion.identity);
        
    }

    void CooldownUI(Image sprite, float cooldown)
    {
        sprite.fillAmount += 1/cooldown * Time.deltaTime;

        if(sprite.fillAmount >= 1)
        {
            sprite.fillAmount = 0;
        }
    }

    private void RaycastHitInfo(string hitInfo)
    {
        currentPickUpRune = hitInfo;
        text.SetActive(true);
    }
    private void RaycastMiss()
    {
        currentPickUpRune = null;
        text.SetActive(false);
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

    private void OnDestroy()
    {
        watchTowerMat.SetVector("_EmissionColor", watchTower_color * .7f);
        GameEvents.current.onRaycastHit -= RaycastHitInfo;
        GameEvents.current.onRaycastMiss -= RaycastMiss;
    }


}
