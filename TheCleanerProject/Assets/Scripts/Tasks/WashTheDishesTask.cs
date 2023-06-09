using UnityEngine.UI;
using UnityEngine;
using System.Collections;
using System.Collections.Generic;


public class WashTheDishesTask : Task
{
    public static WashTheDishesTask _instance;
    public List<PlateInteraction> plates;
    public List<GameObject> platesFinalPoints;
    public int nextFreePoint;
    //public Slider percentageBar;
    public float progressOfTask;
    int washedPlates;


    public override void InternalAwake()
    {
        base.InternalAwake();
        nextFreePoint = 0;

        if (_instance == null)
        {
            _instance = this;
        }
        else
        {
            Destroy(this);
        }
    }
    public override void internalStart()
    {
        base.internalStart();
        washedPlates = 0;
    }

    public override void UpdateTask()
    {
        washedPlates++;
        nextFreePoint++;
        UpdateProgress();
        if (washedPlates == plates.Count)
        {
            base.FinishTask();
        }
    }

    public void UpdateProgress()
    {
        progressOfTask = washedPlates / plates.Count;

        //percentageBar.value = progressOfTask;
    }

}
