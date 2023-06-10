using System.Collections;
using UnityEngine;

public class InteractForXTime : MonoBehaviour
{
    public float interactionTime = 2f;
    public Task taskToComplete;
    public Collider interactionCollider; // task-specific collider

    private bool isHandInside = false;
    private Coroutine interactionCoroutine;

    private void OnTriggerEnter(Collider other)
    {
        if (other == interactionCollider)
        {
            isHandInside = true;
            StartInteraction();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other == interactionCollider)
        {
            isHandInside = false;
            StopInteraction();
        }
    }

    public void StartInteraction()
    {
        if (interactionCoroutine == null)
        {
            interactionCoroutine = StartCoroutine(InteractionCoroutine());
        }
    }

    public void StopInteraction()
    {
        if (interactionCoroutine != null)
        {
            StopCoroutine(interactionCoroutine);
            interactionCoroutine = null;
        }
    }

    private IEnumerator InteractionCoroutine()
    {
        float timeElapsed = 0f;
        while (timeElapsed < interactionTime)
        {
            if (isHandInside)
            {
                timeElapsed += Time.deltaTime;
            }
            else
            {
                timeElapsed = 0f;
            }
            yield return null;
        }
        taskToComplete.DoTask();
        interactionCoroutine = null;
    }
}
