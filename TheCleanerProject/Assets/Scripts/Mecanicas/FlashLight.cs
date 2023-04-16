using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashLight : MonoBehaviour
{
    [SerializeField] Light flashlightLight;
    private bool flashLightOn = true;
    void Start()
    {
        flashlightLight.enabled = flashLightOn;

        PlayerInput.input.RightHand.Primarybutton.started += PrimarybuttonDown;
        PlayerInput.input.LeftHand.Primarybutton.started += PrimarybuttonDown;
    }

    private void PrimarybuttonDown(UnityEngine.InputSystem.InputAction.CallbackContext obj)
    {
        flashLightOn = !flashLightOn;
        flashlightLight.enabled = flashLightOn;
    }
}