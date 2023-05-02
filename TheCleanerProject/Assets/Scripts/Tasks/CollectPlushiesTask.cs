using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectPlushiesTask : Task
{
    public List<Plushy> listOfPlushies;
    public override void internalStart() { base.internalStart(); }
    public override void UpdateTask()
    {
        for (int i = 0; i < listOfPlushies.Count; i++) if (!listOfPlushies[i].isInRightPlace) return;
        taskFinished = true;
    }

    public bool CheckIfItsDone() { return taskFinished; }
    private void Update()
    {
        if (CheckIfItsDone()) base.FinishTask();
        else UpdateTask(); 
    }
}
