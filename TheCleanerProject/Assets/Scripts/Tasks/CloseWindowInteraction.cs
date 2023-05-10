using UnityEngine;

public class CloseWindowInteraction : MonoBehaviour
{
    public void FinishTask()
    {
        CloseWindowsTask.instance.UpdateTask();
    }
}