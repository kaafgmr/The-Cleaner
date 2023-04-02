using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashLight : MonoBehaviour
{
    [SerializeField] GameObject FlashlightLight;
    private bool flashLightOn = false;
    void Start()
    {
        FlashlightLight.gameObject.SetActive(true);
    }
    void Update()
    {
        if (PlayerInput.input.RightHand.Primarybutton.IsPressed() || PlayerInput.input.LeftHand.Primarybutton.IsPressed())
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
