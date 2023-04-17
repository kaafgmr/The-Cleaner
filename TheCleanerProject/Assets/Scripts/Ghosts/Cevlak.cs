using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cevlak : Ghost
{
    [SerializeField] float speed;
    
    public PointManager[] taskPoints;
    public Transform finalPoint = null;
    Vector3 dir;

    private void Awake()
    {
        dir = new Vector3(0, 1, 0);
    }
    public void Update()
    {
        if(finalPoint != null)
        {
            speed = 0.5f;
            transform.position += speed * Time.deltaTime * dir;

            if (transform.position.y >= finalPoint.position.y)
            {
                speed = 0;
                finalPoint = null;
            }

        }


    }
    public override void GhostAction()
    {
        for(int i=0; i<taskPoints.Length; i++)
        {
            if(taskPoints[i].isInside)
            {
                finalPoint = taskPoints[i].finalTpPoint;
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
}
