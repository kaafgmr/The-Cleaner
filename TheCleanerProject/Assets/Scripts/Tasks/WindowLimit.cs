using Oculus.Interaction.HandGrab;
using UnityEngine;
using UnityEngine.Events;

public class WindowLimit : MonoBehaviour
{
    public UnityEvent OnLimit;
    private void OnTriggerEnter(Collider other)
    {
        if (other.TryGetComponent(out CloseWindowInteraction cwi))
        {
            OnLimit.Invoke();
            cwi.FinishTask();
            cwi.GetComponent<HandGrabInteractable>().enabled = false;
        }
    }
}