using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VacuumTask : Task
{
    public List<DustInteraction> listOfDusts;
    int numberOfDustsVacuumed;
    public override void DoTask()
    {
        throw new System.NotImplementedException();
    }

    private void Start()
    {
        numberOfDustsVacuumed = 0;
    }

    public override void UpdateTask()
    {
        
        for (int i = 0; i < listOfDusts.Count; i++)
        {
            if (listOfDusts[i].hasBeenVacuumed == true) { numberOfDustsVacuumed++; }
        }
        if (numberOfDustsVacuumed == listOfDusts.Count)
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
