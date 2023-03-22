using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashLight : MonoBehaviour
{
    [SerializeField] GameObject FlashlightLight;
    private bool flashLightOn = false;
    void Start()
    {
        FlashlightLight.gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F))
        {
            if (!flashLightOn)
            {
                FlashlightLight.gameObject.SetActive(true);
                flashLightOn = true;
            }
            else
            {
                FlashlightLight.gameObject.SetActive(false);
                flashLightOn = false;
            }
        }
    }
}
