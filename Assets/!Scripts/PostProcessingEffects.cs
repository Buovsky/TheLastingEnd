using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class PostProcessingEffects : MonoBehaviour
{
    [SerializeField] private Volume volume;
    [SerializeField] public LifeManagment health;

    private Vignette _Vignette;
    private DepthOfField _DepthOfField;

    private float healthPoints = 100f;

    // Start is called before the first frame update
    void Start()
    {
        volume.profile.TryGet<Vignette>(out _Vignette);
        volume.profile.TryGet<DepthOfField>(out _DepthOfField);
        StartCoroutine(PostEffectOnHealthLoss());
    }

    private IEnumerator PostEffectOnHealthLoss()
    {
        while(gameObject)
        {
            healthPoints = health.playerHealth;

            if (healthPoints < 100)
            {
                float vignetteValue = (1f - (healthPoints / 100f) + .219f) * .7f;
                _Vignette.intensity.value = Mathf.Clamp(vignetteValue, .219f, .6f);

                float depthOfFieldValue = 1f - (healthPoints / 100f);
                _DepthOfField.focalLength.value = Mathf.Clamp(depthOfFieldValue, 1f, 20f);
            }
          
            yield return new WaitForSeconds(.1f);
        }
        
    }
}
