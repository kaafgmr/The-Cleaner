using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public abstract class Task : MonoBehaviour
{
    public enum TaskType { waterTask, electricityTask, windTask, cleanTask }
    public float taskDuration;
    public bool taskFinished;
    public UnityEvent onTaskFinished;
    public abstract void UpdateTask();
    public abstract void DoTask();

    public virtual void FinishTask()
    {
        onTaskFinished.Invoke();
    }
}
