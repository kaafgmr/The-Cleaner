using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class TaskManager : MonoBehaviour
{
    public List<Task> tasksList;
    public bool allTasksDone;
    public UnityEvent OnAllTasksCompleted;
    int numberTasksDone;
    public static TaskManager _instance;
    void Awake()
    {
        if (_instance == null)
        {
            _instance = this;
        }
        else { Destroy(this); }
    }

    public void UpdateTasksCounter()
    {
        numberTasksDone++;

        if (numberTasksDone >= tasksList.Count)
        {
            allTasksDone = true;
        }
    }

    private void Update()
    {
        if (allTasksDone)
        {
            OnAllTasksCompleted.Invoke();
        }
    }
}
