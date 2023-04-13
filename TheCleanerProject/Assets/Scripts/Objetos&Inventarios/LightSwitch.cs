using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightSwitch : MonoBehaviour
{
    [SerializeField] Light lightToSwitch;
    private void OnTriggerEnter(Collider other)
    {
        lightToSwitch.enabled = !lightToSwitch.enabled;
    }
}