using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TaskManager : MonoBehaviour
{
    public List<Task> tasksList;
    public static TaskManager _instance;
    void Awake()
    {
        if (_instance == null)
        {
            _instance = this;
        }
        else { Destroy(this); }
    }
}
