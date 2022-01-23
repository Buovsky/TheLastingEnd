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
    [SerializeField] private GameObject[] runeMainUIContainer;
    [SerializeField] private Text saveGameCurrencyCounter;


    public int[] CollectedRune = {0, 0, 0, 0, 0, 0};

    private string currentPickUpRune = null;

    private float nextSphereUseTime = 0;
    private float nextVisionUseTime = 0;
    public int saveGameCurrency = 0;

    bool isRuneOneOnCooldown = false;
    bool isRuneTwoOnCooldown = false;
    bool _isPlayerinZone;
    public bool isAntagonistAlive = false;
    
    void Start()
    {
        GameEvents.current.onRaycastHit += RaycastHitInfo;
        GameEvents.current.onRaycastMiss += RaycastMiss;
        GameEvents.current.onSaveGame += SpawnSaveOrb;
        GameEvents.current.onAntagonistAppear += AntagonistAliveTrue;
        GameEvents.current.onAntagonistDisappear += AntagonistAliveFalse;
        GameEvents.current.onPlayerEnterZone += PlayerInZone;
        // Remember to unsubscribe this ^^^ event when Player passes difficulity wall
        // To do: Make some system to let/block Player abilities in zones!

        if(CollectedRune[0] == 1 && CollectedRune[1] == 1)
        {
            // check if necessary
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

        if(CollectedRune[2] == 1 && !isAntagonistAlive || CollectedRune[2] == 1 && _isPlayerinZone)
        // || player in runeZone[1]
        {
            runeUIContainer[2].SetActive(true);
            runeMainUIContainer[1].SetActive(true);
            runeMainUIContainer[2].SetActive(true);
            saveGameCurrencyCounter.text = "" + saveGameCurrency;
        }
        else if(CollectedRune[2] == 1 && isAntagonistAlive)
        {
            runeUIContainer[2].SetActive(true);
            runeMainUIContainer[1].SetActive(false);
            runeMainUIContainer[2].SetActive(false);
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
                    saveGameCurrency = 3;
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
        if(saveGameCurrency > 0 && !isAntagonistAlive || CollectedRune[2] == 1 && _isPlayerinZone)
        {
            GameObject existSaveOrb = GameObject.FindGameObjectWithTag("SaveOrb");
            Destroy(existSaveOrb);

            GameObject saveGameOrb = Instantiate(_saveOrb, this.gameObject.transform.position, Quaternion.identity);
            saveGameCurrency --;
            Debug.Log("Save Currency: " + saveGameCurrency);
        }
        else
        {
            Debug.Log("Antagonist is alive, or you don't have enough save currency!");
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

    void AntagonistAliveTrue()
    {
        isAntagonistAlive = true;
    }

    void AntagonistAliveFalse()
    {
        isAntagonistAlive = false;
    }

    void PlayerInZone(bool isPlayerInZone)
    {
        if(isPlayerInZone)
        {
            _isPlayerinZone = true;
        }
        else
        {
            _isPlayerinZone = false;
        }
    }

    private void OnDestroy()
    {
        GameEvents.current.onRaycastHit -= RaycastHitInfo;
        GameEvents.current.onRaycastMiss -= RaycastMiss;
        GameEvents.current.onSaveGame -= SpawnSaveOrb;
        GameEvents.current.onAntagonistAppear -= AntagonistAliveTrue;
        GameEvents.current.onAntagonistDisappear -= AntagonistAliveFalse;
        GameEvents.current.onPlayerEnterZone -= PlayerInZone;

    }
}
