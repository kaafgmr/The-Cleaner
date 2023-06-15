using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.AI;

public class SukSuk : Ghost
{
    public float speed = 3.5f;
    public Transform restingPos;
    public FlashlightBehaviour flashLight;
    NavMeshAgent agent;
    public Transform playerpos;
    FieldOfView FOV;
    float flashlightFOVAngle;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        flashLight.Init();
        agent = GetComponent<NavMeshAgent>();
        agent.speed = speed;
        StopMovement();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnNothingHappening.AddListener(ReturnToSpawn);
        FOV.OnViewedByMe.AddListener(GhostAction);
        flashlightFOVAngle = flashLight.GetFOV();
    }
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.TryGetComponent(out PointingMovement PM))
        {
            Debug.Log("lose1");
            LoseGame();
        }
    }
    public override void GhostAction(Vector3 otherpos)
    {
        if (flashLight.isBeingHeld)
        {
            if (screaming) return;
            ResumeMovement();
            agent.destination = otherpos;
        }
    }
    private void Update()
    {
        GhostAction(playerpos.position);
    }
    public override void GhostCounter()
    {
    }

    public override void Scream()
    {
        base.Scream();
        base.LoseGame();
    }

    private void ReturnToSpawn()
    {
        ResumeMovement();
        agent.destination = restingPos.position;
    }

    public void StopMovement()
    {
        agent.isStopped = true;
    }

    public void ResumeMovement()
    {
        agent.isStopped = false;
    }
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        if (agent != null)
        {
            Gizmos.DrawWireSphere(agent.destination, 0.5f);
        }
    }
}
