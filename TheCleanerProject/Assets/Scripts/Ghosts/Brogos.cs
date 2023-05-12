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
    public bool timeToHide;
    int recentTpnum = 0;
    Coroutine _coroutine=null;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        agent = GetComponent<NavMeshAgent>();
        resetRandPos();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnViewedByMe.AddListener(StartChanneling);
        FOV.ImBeingViewed.AddListener(GhostCounter);
        FOV.OnNothingHappening.AddListener(StartInspection);
    }

    private void Update()
    {
        if (agent != null && agent.isStopped) return;
        GhostAction(Vector3.zero);
    }

    public override void GhostAction(Vector3 otherPos)
    {
        if (MovingTowardsPlayer)
        {
            UpdateVision();
        }
        else
        {
            if (_coroutine == null)
            {
                _coroutine = StartCoroutine(Inspection());
            }
        }
    }

    public void StartInspection()
    {
        if (_coroutine == null)
            _coroutine = StartCoroutine(Inspection());
    }

    public override void GhostCounter()
    {
        StopCoroutine(Stalk(Vector3.zero));
        MoveToRecentTp();
    }

    public override void Scream()
    {
        throw new System.NotImplementedException();
    }

    public void StartChanneling(Vector3 playerPos)
    {
        StartCoroutine(Stalk(playerPos));
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

    public void MoveToPlayer(Vector3 playerPos)
    {
        ResumeMovement();
        agent.destination = playerPos;
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
            agent.Warp(possibleTpPoints[num].position);
            SetValueTimeToHide(false);
            recentTp = possibleTpPoints[num].position;
            recentTpnum = num;
        }
    }

    IEnumerator Stalk(Vector3 PlayerPos)
    {
        if (timeToHide) { StopCoroutine(Stalk(PlayerPos)); }
        StopMovement();
        yield return new WaitForSeconds(2);
        ResumeMovement();
        MoveToPlayer(PlayerPos);
    }
    
    IEnumerator Inspection()
    {
        Debug.Log("entro");
        MoveToRandomPoint();
        yield return new WaitForSeconds(4);
        Debug.Log("entro despues de los 4");
        timeToHide = true;
        MoveToRecentTp();
        _coroutine = null;
    }    
}
