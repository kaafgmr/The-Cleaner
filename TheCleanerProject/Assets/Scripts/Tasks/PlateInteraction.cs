using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PlateInteraction : MonoBehaviour
{
    public UnityEvent OnPlateOrdered;
    Collider plateCollider;
    bool plateIsOrdered;
    void Start()
    {
        plateCollider = GetComponent<BoxCollider>();
        plateIsOrdered = false;
        WashTheDishesTask._instance.plates.Add(this);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!other.TryGetComponent(out WashTheDishesTask wt)) return;

        transform.position = wt.platesFinalPoints[wt.nextFreePoint].transform.position;
        transform.rotation = Quaternion.identity;
        plateIsOrdered = true;
        OnPlateOrdered.Invoke();
    }

    private void OnTriggerExit(Collider other)
    {
        if(plateIsOrdered)
        {
            plateCollider.enabled = false;
        }
    }
}
