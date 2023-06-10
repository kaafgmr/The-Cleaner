using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MultipleColliderXTimeController : MonoBehaviour
{
    public float requiredTime = 2f;
    public Task taskToComplete;
    public List<Collider> interactionColliders;
    private List<Collider> currentColliders = new List<Collider>();
    private bool isInteracting = false;
    private float interactionTimer = 0f;

    private void Update()
    {
        if (isInteracting && interactionTimer < requiredTime)
        {
            interactionTimer += Time.deltaTime;
            if (interactionTimer >= requiredTime)
            {
                taskToComplete.DoTask();
                isInteracting = false;
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (interactionColliders.Contains(other))
        {
            currentColliders.Add(other);
            isInteracting = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (currentColliders.Contains(other))
        {
            currentColliders.Remove(other);
            if (currentColliders.Count == 0)
            {
                isInteracting = false;
                interactionTimer = 0f;
            }
        }
    }
}

