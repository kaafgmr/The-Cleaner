using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Noslek : Ghost
{
    NavMeshAgent agent;
    FieldOfView FOV;

    bool MovingTowardsPlayer = false;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        agent = GetComponent<NavMeshAgent>();
        StopMovement();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnViewedByMe.AddListener(MoveToPlayer);
        FOV.OnStartBeingViewed.AddListener(GhostCounter);
        FOV.OnStopBeingViewed.AddListener(MoveToRandomPoint);
    }

    private void Update()
    {
        if (agent != null && agent.isStopped) return;

        GhostAction();
    }

    public override void GhostAction()
    {
        if (MovingTowardsPlayer)
        {
            UpdateVision();
        }
        else
        {
            MoveToRandomPoint();
        }
    }

    public override void GhostCounter()
    {
        StopMovement();
    }

    public override void Scream()
    {
        throw new System.NotImplementedException();
    }

    public void StopMovement()
    {
        if (!agent.isStopped)
        {
            agent.isStopped = true;
        }
    }

    void ResumeMovement()
    {
        if (agent.isStopped)
        {
            agent.isStopped = false;
        }
    }

    public void MoveToPlayer(Transform PlayerTransform)
    {
        ResumeMovement();
        agent.destination = PlayerTransform.position;
        MovingTowardsPlayer = true;
        agent.isStopped = false;
    }
    public void MoveToRandomPoint()
    {
        ResumeMovement();
        if (agent.remainingDistance > 0.5f) return;

        Vector3 pointInsideBounds = CalculateBounds.CalculatePointInsideBounds(CalculateBounds.bounds);
        NavMesh.SamplePosition(pointInsideBounds, out NavMeshHit hit, 100, NavMesh.AllAreas);
        
        agent.destination = hit.position;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        if(agent != null)
        {
            Gizmos.DrawWireSphere(agent.destination, 0.5f);
        }
    }

    void UpdateVision()
    {
        if (agent.remainingDistance > 0.5f) return;
        MovingTowardsPlayer = false;
    }
}
