using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectPlushiesTask : Task
{
    public List<Plushy> listOfPlushies;
    int numberOfPlushiesCollected;

    public override void internalStart()
    {
        base.internalStart();
        numberOfPlushiesCollected = 0;
    }

    public override void UpdateTask()
    {
        for (int i = 0; i < listOfPlushies.Count; i++)
        {
            if (listOfPlushies[i].hasBeenCollected == true) { numberOfPlushiesCollected++; }
        }
        if (numberOfPlushiesCollected == listOfPlushies.Count)
        {
            taskFinished = true;
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
}
