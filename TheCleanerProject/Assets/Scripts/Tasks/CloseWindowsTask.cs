using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CloseWindowsTask : Task
{
    public static CloseWindowsTask instance;
    public List<CloseWindowInteraction> windowsToClose;
    int closedWindows;

    public override void InternalAwake()
    {
        base.InternalAwake();

        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(this);
        }
    }

    public override void internalStart()
    {
        base.internalStart();

        closedWindows = 0;
    }

    public override void UpdateTask()
    {
        closedWindows++;

        if (closedWindows >= windowsToClose.Count)
        {
            base.FinishTask();
            taskFinished = true;
        }
    }
}
