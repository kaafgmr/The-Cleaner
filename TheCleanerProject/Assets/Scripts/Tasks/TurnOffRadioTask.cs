using UnityEngine;

public class TurnOffRadioTask : Task
{
    public Radio radio;
    public MultipleColliderXTimeController MultipleColliderXTime;

    public override void UpdateTask()
    {
    }

    public override void DoTask()
    {
        taskFinished = true;
        radio.TurnOff();
        FinishTask();
    }
}
