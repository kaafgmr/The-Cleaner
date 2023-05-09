using System.Collections.Generic;

public class CleanWindowsTask : Task
{
    public static CleanWindowsTask instance;

    public List<WindowInteraction> windowsToClean;
    int windowsCleaned;

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
    }

    public override void UpdateTask()
    {
        windowsCleaned = 0;
        for (int i = 0; i < windowsToClean.Count; i++)
        {
            if (!windowsToClean[i].finishedCleaning) return;
            
            windowsCleaned++;
        }

        if (windowsCleaned == windowsToClean.Count)
        {
            base.FinishTask();
            taskFinished = true;
        }
    }
}
