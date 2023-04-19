using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cevlak : Ghost
{
    [SerializeField] float speed;
    
    public PointManager[] taskPoints;
    public Transform finalPoint = null;
    int lastIndex;
    int actualIndex;
    Vector3 dir;

    private void Awake()
    {
        lastIndex = taskPoints.Length+1;
        dir = new Vector3(0, 1, 0);
    }

    public void Update()
    {
        if(finalPoint != null)
        {
            SpeedAdjustment(0.5f);

            transform.position += speed * Time.deltaTime * dir;

            StopMovement();
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
        if (transform.position.y >= finalPoint.position.y)
        {
            speed = 0;
            transform.position = new Vector3(transform.position.x, finalPoint.position.y, transform.position.z);
            if (!taskPoints[actualIndex].isOnFinalPoint)
            {
                taskPoints[actualIndex].isOnFinalPoint = true;
            }
            finalPoint = null;
        }
    }

    public void SpeedAdjustment(float initialSpeed)
    {
        if (speed == 0)
        {
            speed = initialSpeed;
        }
        else if (speed <= initialSpeed/5)
        {
            speed = 0.07f;
        }
        else if (speed >= initialSpeed / 5)
        {
            speed -= 0.003f;
        }
    }
}
