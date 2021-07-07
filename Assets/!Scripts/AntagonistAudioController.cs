using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AntagonistAudioController : MonoBehaviour
{
    private GameObject player;
    private Transform playerPos;

    [SerializeField] private AudioSource audioSource;
    [SerializeField] private float minDist = 1f;
    [SerializeField] private float maxDist = 25f;
    [SerializeField] private float closePitch = 2.5f;
    [SerializeField] private float farPitch = .6f;

    // Start is called before the first frame update
    void Start()
    {
        //GameEvents.current.onAntagonistAppear += 
        player = GameObject.Find("FPSController");
        playerPos = player.transform;

        StartCoroutine(CheckPostion());
    }

    void OnAntagonistAppear()
    {

    }


    void FixedUpdate()
    {
        
    }

    private IEnumerator CheckPostion()
    {
        while(gameObject)
        {
            float dist = Vector3.Distance(playerPos.position, transform.position);
            Debug.Log(dist);
            
            float x = Mathf.Clamp(dist, minDist, maxDist);
            float pitch = (farPitch - closePitch) * (x - minDist) / (maxDist - minDist) + closePitch;
            audioSource.pitch = pitch;

            yield return new WaitForSeconds(.3f);
        }
    }
}
