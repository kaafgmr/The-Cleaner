using UnityEngine;
using UnityEngine.AI;

public class Noslek : Ghost
{
    [SerializeField] float distanceToUpdate = 0.5f;
    [SerializeField] private string walkAnimName;
    [SerializeField] private string idleAnimName;
    [SerializeField] private string screamerAnimName;


    NavMeshAgent agent;
    FieldOfView FOV;
    GhostAnimController gac;

    bool MovingTowardsPlayer = false;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        gac = GetComponent<GhostAnimController>();
        agent = GetComponent<NavMeshAgent>();
        StopMovement();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnViewedByMe.AddListener(MoveToPlayer);
        FOV.ImBeingViewed.AddListener(GhostCounter);
        FOV.OnNothingHappening.AddListener(MoveToRandomPoint);
    }

    private void Update()
    {
        if (agent != null && agent.isStopped) return;

        GhostAction();
    }

    public override void GhostAction(Transform other = null)
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
        base.Scream();
        gac.PlayAnimation(screamerAnimName);
    }

    public void StopMovement()
    {
        if (!agent.isStopped)
        {
            agent.isStopped = true;
            gac.PlayAnimation(idleAnimName);
        }
    }

    void ResumeMovement()
    {
        if (agent.isStopped)
        {
            agent.isStopped = false;
            gac.PlayAnimation(walkAnimName);
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
        if (agent.remainingDistance > distanceToUpdate) return;

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
        if (agent.remainingDistance > distanceToUpdate) return;
        MovingTowardsPlayer = false;
    }
}
