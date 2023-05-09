using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public abstract class Task : MonoBehaviour
{
    public enum TaskType { waterTask, electricityTask, windTask, cleanTask }
    float taskDuration;
    public bool taskFinished;
    public UnityEvent onTaskFinished;
    public abstract void UpdateTask();
    public virtual void DoTask() { }

    public virtual void FinishTask()
    {
        onTaskFinished.Invoke();
    }

    private void Awake()
    {
        InternalAwake();
    }

    private void Start()
    {
        internalStart();
    }

    public virtual void InternalAwake()
    {

    }

    public virtual void internalStart()
    {
        TaskManager._instance.tasksList.Add(this);
    }
}
