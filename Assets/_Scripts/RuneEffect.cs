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
    [SerializeField] private GameObject nightVision;

    [SerializeField] private GameObject _saveOrb;


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
    public int saveGameCurrency = 3;

    bool isRuneOneOnCooldown = false;
    bool isRuneTwoOnCooldown = false;
    
    void Start()
    {
        GameEvents.current.onRaycastHit += RaycastHitInfo;
        GameEvents.current.onRaycastMiss += RaycastMiss;
        GameEvents.current.onSaveGame += SpawnSaveOrb;

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
                    SpawnSphere();
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

        if(CollectedRune[2] == 1)
        {
            //runeUIContainer[2].SetActive(true);
            //Mechanic for displaying Save Game Currency on UI
        }
        else
        {
            //runeUIContainer[2].SetActive(false);
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
                bool isGameWasLoaded = false;
                runeCount++;

                // Enent to apply proper Envrio
                GameEvents.current.EnviroChanged(isGameWasLoaded);
                Debug.Log("Liczba run" + runeCount);

                if (currentPickUpRune == "Rune1")
                {
                    _text.SetActive(false);
                    animator.enabled = true;
                    
                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            break;
                    }
                    
                    runeAnimator1.SetBool("Gathered", true);
                    CollectedRune[0] = 1;
                }

                if (currentPickUpRune == "Rune2")
                {
                    animator.enabled = true;

                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            break;
                    }

                    runeAnimator2.SetBool("Gathered", true);
                    _text.SetActive(false);
                    CollectedRune[1] = 1;
                }

                if (currentPickUpRune == "Rune3")
                {
                    animator.enabled = true;

                    switch(runeCount)
                    {
                        case 1:
                            animator.SetTrigger("Rune_1_Gather");
                            break;
                        case 2:
                            animator.SetTrigger("Rune_2_Gather");
                            break;
                        case 3:
                            animator.SetTrigger("Rune_3_Gather");
                            break;
                    }

                    runeAnimator3.SetBool("Gathered", true);
                    _text.SetActive(false);
                    CollectedRune[2] = 1;
                    saveGameCurrency ++;
                }
            }
        }
    }

    void SpawnSphere()
    {

        GameObject locationSphere = Instantiate(_sphere, spawnPoint.transform.position, Quaternion.identity);
        
    }
    void SpawnSaveOrb()
    {
        if(saveGameCurrency > 0)
        {
            GameObject existSaveOrb = GameObject.FindGameObjectWithTag("SaveOrb");
            Destroy(existSaveOrb);

            GameObject saveGameOrb = Instantiate(_saveOrb, this.gameObject.transform.position, Quaternion.identity);
            saveGameCurrency --;
            Debug.Log("Save Currency: " + saveGameCurrency);
        }
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
        GameEvents.current.onSaveGame -= SpawnSaveOrb;
    }
}
