using UnityEngine;

public class ChangeLightBulbTask : Task
{
    public LightBulbInteraction lightBulb;
    public InteractForXTime interactForXTime;

    public override void UpdateTask()
    {
    }

    public override void DoTask()
    {
        taskFinished = true;
        lightBulb.ChangeBulb();
        FinishTask();
    }
}

