using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TidyUpRoomTask : Task
{
    public ObjectsTidiedUpController _objectsController;
    public override void UpdateTask()
    {
        if (_objectsController.CheckObjectsRealPosition()) {
            taskFinished = true;
        }
    }
    public bool CheckIfItsDone()
    {
        return taskFinished;
    }
}
