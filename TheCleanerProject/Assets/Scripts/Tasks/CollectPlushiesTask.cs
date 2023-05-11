using System.Collections.Generic;

public class CollectPlushiesTask : Task
{
    public static CollectPlushiesTask instance;

    public List<Plushy> listOfPlushies;

    int plushiesInRightPlace;

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

    public override void UpdateTask()
    {
        plushiesInRightPlace++;

        if (plushiesInRightPlace >= listOfPlushies.Count)
        {
            base.FinishTask();
        }
    }
}