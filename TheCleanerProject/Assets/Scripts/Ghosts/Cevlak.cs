using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cevlak : Ghost
{
    [SerializeField] float speed;
    
    public GameObject playerObj;
    public GameObject cevlakParent;
    public PointManager[] taskPoints;
    Transform finalPoint = null;
    public bool isInside;
    public bool speedActivator;
    bool isCounting;
    int lastIndex;
    int actualIndex;

    //Countdown
    public float startMovingTimer;
    float initialStartMovingTimer;

    Vector3 dir;

    private void Awake()
    {
        cevlakParent = GameObject.Find("CevlakParent");
        initialStartMovingTimer = startMovingTimer;
        lastIndex = taskPoints.Length+1;
        dir = new Vector3(0, 1, 0);
    }

    public void Update()
    {
        if(isInside)
        {
            cevlakParent.transform.LookAt(playerObj.transform);
            if(finalPoint != null)
            {
                if (!isCounting)
                {
                    StartCounting();
                }

                if(startMovingTimer > 0)
                {
                    startMovingTimer -= Time.deltaTime;
                }
                else if (startMovingTimer <= 0)
                {
                    SpeedAdjustment(1);
                    speedActivator = false;
                    cevlakParent.transform.position += speed * Time.deltaTime * dir;

                    StopMovement();
                }
            }
        }
        else
        {
            startMovingTimer = initialStartMovingTimer;
        }
    }
    public override void GhostAction()
    {
        for(int i=0; i<taskPoints.Length; i++)
        {
            if(taskPoints[i].isInside)
            {
                actualIndex = i;
                finalPoint = taskPoints[actualIndex].finalTpPoint;
            } 

            if(lastIndex > taskPoints.Length)
            {
                lastIndex = actualIndex;
            }

            if(lastIndex != actualIndex)
            {
                taskPoints[lastIndex].isOnFinalPoint = false;
                lastIndex = actualIndex;
            }
        }

        isCounting = false;
    }

    public override void GhostCounter()
    {
        throw new System.NotImplementedException();
    }

    public override void Scream()
    {
        throw new System.NotImplementedException();
    }

    public void StopMovement()
    {
        if (cevlakParent.transform.position.y >= finalPoint.position.y)
        {
            speed = 0;
            cevlakParent.transform.position = new Vector3(cevlakParent.transform.position.x, finalPoint.position.y, cevlakParent.transform.position.z);
            if (!taskPoints[actualIndex].isOnFinalPoint)
            {
                taskPoints[actualIndex].isOnFinalPoint = true;
            }
            finalPoint = null;
        }
    }

    public void SpeedAdjustment(float initialSpeed)
    {
        if(speedActivator)
        { 
            speed = initialSpeed;
        }

        speed *= 0.995f;

        if(speed <= 0.1f)
        {
            speed = 0.1f;
        }
    }

    void StartCounting()
    {
        startMovingTimer = initialStartMovingTimer;
        startMovingTimer += Random.Range(0, 3);
        Debug.Log(startMovingTimer);
        isCounting = true;
    }
}
