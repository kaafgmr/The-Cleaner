using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public abstract class Task 
{
    public enum TaskType { waterTask, electricityTask, windTask, cleanTask }
    public float taskDuration;
    public UnityEvent onTaskFinished;
    public abstract void UpdateTask();
    public abstract void DoTask();

    private void FinishTask()
    {
        onTaskFinished.Invoke();
    }
}
