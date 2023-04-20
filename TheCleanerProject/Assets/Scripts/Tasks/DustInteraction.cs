using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DustInteraction : MonoBehaviour
{
    public bool hasBeenVacuumed;
    void Start()
    {
        hasBeenVacuumed = false;   
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.TryGetComponent(out VacuumTask vacuumTask))
        {
            if (!vacuumTask.CheckIfItsDone())
            {
                StartCoroutine(isVacuuming());
            }
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.TryGetComponent(out VacuumTask vacuumTask))
        {
            if (!vacuumTask.CheckIfItsDone())
            {
                StopCoroutine(isVacuuming());
            }
        }
    }

    IEnumerator isVacuuming()
    {
        yield return new WaitForSeconds(2);
        hasBeenVacuumed = true;
    }

    private void Update()
    {
        if (hasBeenVacuumed)
        {
            Destroy(gameObject);
        }
    }
}
