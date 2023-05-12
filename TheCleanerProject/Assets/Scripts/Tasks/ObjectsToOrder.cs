using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Oculus.Interaction.HandGrab;

public class ObjectsToOrder : MonoBehaviour
{
    public Transform realPosition;
    public bool isOnRealPosition;
    public HandGrabInteractable _handGrabInteractable;
    void Start()
    {
        isOnRealPosition = false;
    }

    private void Update()
    {
        if (isOnRealPosition)
        {
            _handGrabInteractable.enabled = false;
        }
    }
    public void SetIsOnRealPosition(bool value)
    {
        isOnRealPosition = true;
    }
}
