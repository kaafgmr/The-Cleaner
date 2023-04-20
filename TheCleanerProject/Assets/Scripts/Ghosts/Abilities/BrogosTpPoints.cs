using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BrogosTpPoints : MonoBehaviour
{
    bool booleanChecker;
    private void OnTriggerEnter(Collider other)
    {
        if (other.TryGetComponent(out Brogos brogos)) {
            if (brogos.CheckIfItsTimeToHide())
            {
                booleanChecker = brogos.CheckIfItsTimeToHide();
                brogos.SetValueTimeToHide(false);
                Debug.Log("Despues de setear a false el time to hide, ahora mismo es igual a " + booleanChecker);
                brogos.resetRandPos();
                Debug.Log("EntroEnElCheckHideFalse");
            }
        }
    }
}
