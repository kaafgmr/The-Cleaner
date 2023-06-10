using UnityEngine;

public class FlashlightBehaviour : MonoBehaviour
{
    public bool isBeingHeld;
    [SerializeField] private Transform attachPoint;
    
    Light spotLight;

    public void Init()
    {
        spotLight = GetComponentInChildren<Light>();
    }

    public Transform GetAttachPoint()
    {
        return attachPoint;
    }

    public float GetFOV()
    {
        return spotLight.spotAngle;
    }

    public void SetIsBeingHeld(bool value)
    {
        isBeingHeld = value;
    }
}