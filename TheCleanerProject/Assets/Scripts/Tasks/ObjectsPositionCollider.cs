using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectsPositionCollider : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        ObjectsToOrder _objects = other.GetComponentInParent<ObjectsToOrder>();
        if (other.GetComponentInParent<ObjectsToOrder>() != null)
        {
            _objects.SetIsOnRealPosition(true);
        }
    }
}
