using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RuneEffect : MonoBehaviour
{
    public int runeCount = 0;
    [SerializeField] private GameObject _text;
    [SerializeField] private GameObject _sphere;
    [SerializeField] private GameObject spawnPoint;

    [SerializeField] public Material WatchTowerMat;
    
    [ColorUsage(true, true)]
    [SerializeField] private Color watchTower_color;
    private float watchTowerMultiplier = .5f;
    public Vector4 WatchtowerColorHolderer;
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

    public int[] CollectedRune = {0, 0, 0, 0, 0, 0};

    private string currentPickUpRune = null;

    private float nextSphereUseTime = 0;
    private float nextVisionUseTime = 0;

    bool isRuneOneOnCooldown = false;
    bool isRuneTwoOnCooldown = false;
    
    void Start()
    {
        GameEvents.current.onRaycastHit += RaycastHitInfo;
        GameEvents.current.onRaycastMiss += RaycastMiss;
        if(runeCount == 0)
        {
            WatchTowerMat.SetVector("_EmissionColor", watchTower_color);
        }
        else
        {
            WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);
        }

        if(CollectedRune[0] == 1 && CollectedRune[1] == 1)
        {
            runeUIContainer[0].SetActive(true);
            runeUIContainer[1].SetActive(true);
        }
    }
    void Update()
    {
        if(CollectedRune[0] == 1)
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

        if(CollectedRune[1] == 1)
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
                Debug.Log("Liczba run" + runeCount);
                if (currentPickUpRune == "Rune1")
                {
                    //runeOne.SetActive(false);
                    WatchtowerColorHolderer = watchTower_color * watchTowerMultiplier;
                    WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);
                    _text.SetActive(false);
                    animator.enabled = true;
                    
                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            watchTowerMultiplier = .4f;
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            watchTowerMultiplier = .3f;
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            watchTowerMultiplier = .2f;
                            break;
                    }
                    
                    runeAnimator1.SetBool("Gathered", true);
                    CollectedRune[0] = 1;
                }

                if (currentPickUpRune == "Rune2")
                {
                    WatchtowerColorHolderer = watchTower_color * watchTowerMultiplier;
                    WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);
                    //runeTwo.SetActive(false);
                    animator.enabled = true;

                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            watchTowerMultiplier = .4f;
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            watchTowerMultiplier = .3f;
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            watchTowerMultiplier = .2f;
                            break;
                    }

                    runeAnimator2.SetBool("Gathered", true);
                    _text.SetActive(false);
                    CollectedRune[1] = 1;
                }

                if (currentPickUpRune == "Rune3")
                {
                    WatchtowerColorHolderer = watchTower_color * watchTowerMultiplier;
                    WatchTowerMat.SetVector("_EmissionColor", WatchtowerColorHolderer);
                    //runeTwo.SetActive(false);
                    animator.enabled = true;

                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            watchTowerMultiplier = .4f;
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            watchTowerMultiplier = .3f;
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            watchTowerMultiplier = .2f;
                            break;
                    }

                    runeAnimator3.SetBool("Gathered", true);
                    _text.SetActive(false);
                    CollectedRune[2] = 1;
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
        _text.SetActive(true);
    }
    private void RaycastMiss()
    {
        currentPickUpRune = null;
        _text.SetActive(false);
    }
    void TurnOff()
    {
        nightVision.SetActive(false);
    }

    void TurnOffAnimator()
    {
        animator.enabled = false;
        Debug.Log("Animator turned off");
    }

    private void OnDestroy()
    {
        GameEvents.current.onRaycastHit -= RaycastHitInfo;
        GameEvents.current.onRaycastMiss -= RaycastMiss;
    }
}
