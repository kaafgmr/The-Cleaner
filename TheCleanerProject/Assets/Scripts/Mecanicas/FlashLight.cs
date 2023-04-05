using System.Collections;
using System.Collections.Generic;
using Unity.XR.CoreUtils;
using UnityEngine;

public class FlashLight : MonoBehaviour
{
    [SerializeField] GameObject FlashlightLight;
    private bool flashLightOn = false;
    void Start()
    {
        FlashlightLight.gameObject.SetActive(false);
        PlayerInput.input.RightHand.Primarybutton.started += PrimarybuttonDown;
        PlayerInput.input.RightHand.Primarybutton.canceled += PrimarybuttonDown;
        PlayerInput.input.LeftHand.Primarybutton.started += PrimarybuttonDown;
        PlayerInput.input.LeftHand.Primarybutton.canceled += PrimarybuttonDown;
    }

    private void PrimarybuttonDown(UnityEngine.InputSystem.InputAction.CallbackContext obj)
    {
        UpdateFlashLight();
    }

    void UpdateFlashLight()
    {
        flashLightOn = !flashLightOn;
        FlashlightLight.gameObject.SetActive(flashLightOn);
    }
}