using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RunePickUpDebug : MonoBehaviour
{
    RaycastHit hit;
    int layerMask = 1 << 6;

    string hitTag;
    void FixedUpdate()
    {
        //Debug.DrawLine(Camera.main.transform.position, Vector3.zero, Color.red);
         Debug.DrawLine(Camera.main.transform.position, Camera.main.transform.forward * 350, Color.red);
        if (Physics.Raycast(Camera.main.transform.position, Camera.main.transform.forward * 350, out hit, 2, layerMask))
        {
            hitTag = hit.collider.tag.ToString();
            GameEvents.current.RaycastHit(hitTag);
        }
        else
        {
            GameEvents.current.RaycastMiss();
        }
    }
}
