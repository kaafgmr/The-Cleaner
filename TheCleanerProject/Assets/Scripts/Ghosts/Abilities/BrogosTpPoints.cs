using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BrogosTpPoints : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.TryGetComponent(out Brogos brogos)) {
            if (brogos.CheckIfItsTimeToHide())
            {
                brogos.SetValueTimeToHide(false);
                brogos.resetRandPos();
                //Debug.Log("Test");
            }
        }
    }
}
