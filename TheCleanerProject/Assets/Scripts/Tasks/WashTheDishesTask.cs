using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class WashTheDishesTask : Task
{
    public float percentageOfTask;
    public Slider percentageBar;

    private void Awake()
    {
        percentageOfTask = 0f;
    }

    public override void UpdateTask()
    {
        if (percentageOfTask >= 100f)
        {
            taskFinished = true;
            percentageBar.value = percentageOfTask * 0.01f;
        }
    }

    public bool CheckIfItsDone()
    {
        return taskFinished;
    }

    private void Update()
    {
        if (CheckIfItsDone()) { base.FinishTask(); }
        else { UpdateTask(); }
    }

    private void OnTriggerStay(Collider other)
    {
        if(percentageOfTask < 100f)
        { 
            percentageOfTask += 10 * Time.deltaTime;
        }
        else
        {
            percentageOfTask = 100f;
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = new Color(0, 0, 1, 0.5f);
        Gizmos.DrawCube(transform.position, transform.localScale);       
    }
}
