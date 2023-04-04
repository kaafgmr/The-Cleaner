using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Brogos : Ghost
{
    public List<Transform> possibleTpPoints;
    public Vector3 recentTp;
    [SerializeField] float distanceToUpdate = 0.5f;
    NavMeshAgent agent;
    FieldOfView FOV;
    bool MovingTowardsPlayer = false;
    bool timeToHide;
    int recentTpnum = 0;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        resetRandPos();
        agent = GetComponent<NavMeshAgent>();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnViewedByMe.AddListener(StartChanneling);
        FOV.OnStartBeingViewed.AddListener(GhostCounter);
        FOV.OnStopBeingViewed.AddListener(StartInspection);
    }

    private void Update()
    {
        if (agent != null && agent.isStopped || timeToHide) return;

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
            StartCoroutine(Inspection());
        }
    }

    public void StartInspection()
    {
        StartCoroutine(Inspection());
    }

    public override void GhostCounter()
    {
        StopCoroutine(Stalk(null));
        MoveToRecentTp();
    }

    public override void Scream()
    {
        throw new System.NotImplementedException();
    }

    public void StartChanneling(Transform PlayerTransform=null)
    {
        StartCoroutine(Stalk(PlayerTransform));
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
        agent.isStopped = false;
    }
    public void MoveToRandomPoint()
    {
        ResumeMovement();
        if (agent.remainingDistance > distanceToUpdate) return;

        Vector3 pointInsideBounds = CalculateBounds.CalculatePointInsideBounds(CalculateBounds.bounds);
        NavMesh.SamplePosition(pointInsideBounds, out NavMeshHit hit, 100, NavMesh.AllAreas);

        agent.destination = hit.position;
    }

    void MoveToRecentTp()
    {
        agent.destination = recentTp;
    }

    public void SetValueTimeToHide(bool value)
    {
        timeToHide = value;
    }

    public bool CheckIfItsTimeToHide()
    {
        return timeToHide;
    }

    void UpdateVision()
    {
        if (agent.remainingDistance > distanceToUpdate) return;
        MovingTowardsPlayer = false;
    }

    public void resetRandPos()
    {
        int num = Random.Range(0, possibleTpPoints.Count-1);
        if (recentTpnum == num)
        {
            resetRandPos();
        }
        else 
        {
            //agent.isStopped = true;
            transform.position = possibleTpPoints[num].position;
            recentTp = transform.position;
            recentTpnum = num;
            //agent.isStopped = false;
        }
    }

    IEnumerator Stalk(Transform PlayerPos)
    {
        if (timeToHide) { StopCoroutine(Stalk(PlayerPos)); }
        StopMovement();
        yield return new WaitForSeconds(3);
        ResumeMovement();
        MoveToPlayer(PlayerPos);
    }
    
    IEnumerator Inspection()
    {
        MoveToRandomPoint();
        yield return new WaitForSeconds(8);
        timeToHide = true;
        MoveToRecentTp();
    }    
}
