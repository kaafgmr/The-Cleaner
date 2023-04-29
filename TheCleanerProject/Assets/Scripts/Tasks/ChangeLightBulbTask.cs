using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeLightBulbTask : Task
{
    public LightBulbInteraction lightBulb; //objeto padre de la bombilla
    public override void internalStart() { base.internalStart(); }
    public override void UpdateTask() { }
    public bool CheckIfItsDone() { return taskFinished; }
}
