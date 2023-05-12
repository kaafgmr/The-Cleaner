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
        TidyUpRoomTask.instance.objesctsList.Add(this);
    }

    public void SetIsOnRealPosition(bool value)
    {
        isOnRealPosition = true;
        _handGrabInteractable.enabled = false;
        TidyUpRoomTask.instance.UpdateTask();
    }
}
