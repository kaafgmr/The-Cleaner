using System.Collections;
using UnityEngine;
using UnityEngine.Events;

public class WindowInteraction : MonoBehaviour
{
    public bool finishedCleaning;
    public float progress;
    public float timeToClean = 5;
    public UnityEvent OnFinishedCleaning;

    Material material;
    float timeCleaning;
    Vector3 clothCurrPos;
    Vector3 clothPrevPos;

    private void Start()
    {
        CleanWindowsTask.instance.windowsToClean.Add(this);
        material = GetComponent<MeshRenderer>().material;
        progress = 0;
        timeCleaning = 0;
        material.SetFloat("_Progress", progress);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (finishedCleaning && !other.TryGetComponent(out SpongeBehaviour SB)) return;

        clothPrevPos = other.transform.position;
        StartCoroutine(UpdateProgress(other.transform));
    }

    private void OnTriggerExit(Collider other)
    {
        if (finishedCleaning) return;

        finishedCleaning = false; //probably not needed but it's here just in case XD
        StopCoroutine(UpdateProgress(other.transform));
    }

    IEnumerator UpdateProgress(Transform cloth)
    {
        while (timeCleaning < timeToClean)
        {
            clothCurrPos = cloth.position;

            if (Vector3.Distance(clothPrevPos, clothCurrPos) > 0.2f)
            {
                if (timeCleaning == 0)
                {
                    progress = 0;
                }
                else
                {
                    progress = timeToClean / timeCleaning;
                }

                material.SetFloat("_Progress", progress);
                timeCleaning += Time.fixedDeltaTime;
            }

            clothPrevPos = cloth.position;
            yield return new WaitForSeconds(Time.fixedDeltaTime);
        }

        timeCleaning = timeToClean;
        finishedCleaning = true;
        OnFinishedCleaning.Invoke();
    }
}