using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class SukSuk : Ghost
{
    [SerializeField] float distanceToUpdate = 0.5f;
    NavMeshAgent agent;

    [SerializeField] private float slowSpeed; //      2
    [SerializeField] private float defaultSpeed; //   3.5
    [SerializeField] private float fastSpeed; //      5

    FieldOfView FOV;
    [SerializeField] private Light flashLight;
    [SerializeField] LayerMask collisionLayer; //comprobar la collisionlayer
    bool flashlightPointingToMe = false;
    [SerializeField] private Transform restingPos;

    bool SeeingPlayer = false;
    bool ChasingPlayer = false;

    private void Start()
    {
        Init();
        CalculateBounds.instance.OnInit.AddListener(ResumeMovement);
    }

    private void Init()
    {
        agent = GetComponent<NavMeshAgent>();
        GoBackToRestingPosition();
        FOV = GetComponentInChildren<FieldOfView>();
        FOV.OnViewedByMe.AddListener(ChasePlayer);
        FOV.OnStopBeingViewed.AddListener(StopWatchingPlayer);
    }

    private void Update()
    {
        if (agent != null && agent.isStopped) return;
        GhostAction();
    }

    public override void GhostAction() //chasear si lo ves pero ir lento aunque te mire, correr si lleva linterna puesta, correr bastante si te apunta con la linterna. si le dejas de ver y no lleva linterna dejar de chasear.
    {
        if (ChasingPlayer)
        {
            if (!flashLight.isActiveAndEnabled)
            { 
                if (!SeeingPlayer && !flashLight.isActiveAndEnabled) GoBackToRestingPosition();
                else GhostCounter();
            }
            else
            {
                CheckFlashLightHit();
                if (flashlightPointingToMe) Accelarete();
            }            
        }        
        else GoBackToRestingPosition();
    }

    public void StopMovement() { if (!agent.isStopped) agent.isStopped = true; }

    void ResumeMovement() { if (agent.isStopped) agent.isStopped = false; }

    public override void GhostCounter() { agent.speed = slowSpeed; }

    public override void Scream() { throw new System.NotImplementedException(); }

    public void ChasePlayer(Transform PlayerTransform)
    {
        agent.destination = PlayerTransform.position;
        SeeingPlayer = true;
        ChasingPlayer = true;
        agent.speed = defaultSpeed;
    }

    private void Accelarete() { agent.speed = fastSpeed; } //acelerar el chase; aumentarle el speed al agent del navmesh y quitarselo al resetear el fantasma;
    
    public void GoBackToRestingPosition()
    {
        ChasingPlayer = false;
        agent.destination = restingPos.position;
    }

    private void CheckFlashLightHit() { flashlightPointingToMe = Physics.Raycast(flashLight.transform.position, flashLight.transform.forward, out RaycastHit hit, 1000, collisionLayer); }
    private void StopWatchingPlayer() { SeeingPlayer = false; }
}
