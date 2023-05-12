using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TidyUpRoomTask : Task
{
    public ObjectsTidiedUpController _objectsController;

    public List<ObjectsToOrder> objesctsList;

    public static TidyUpRoomTask instance;

    int objectsInPlace = 0;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(this);
        }
    }
    public override void UpdateTask()
    {
        objectsInPlace++;

        if(objectsInPlace >= objesctsList.Count)
        {
            base.FinishTask();
        }
    }
    public bool CheckIfItsDone()
    {
        return taskFinished;
    }
}
