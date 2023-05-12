using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class FinishGameChecker : MonoBehaviour
{
    public UnityEvent onGameFinished;

    private void OnTriggerEnter(Collider other)
    {
        onGameFinished.Invoke();
    }
}
