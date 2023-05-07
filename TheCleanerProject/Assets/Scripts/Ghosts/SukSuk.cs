using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class SukSuk : Ghost
{
    NavMeshAgent agent;

    [SerializeField] private float defaultSpeed; //   3.5
    [SerializeField] private float fastSpeed; //      5

    FieldOfView FOV;
    private GameObject flashLight;
    [SerializeField] private Transform restingPos;

    bool SeeingPlayer = false;
    bool ChasingPlayer = false;

    float FLRange;

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
        flashLight = GameObject.Find("Flashlight");
        FLRange = flashLight.GetComponentInChildren<Light>().range;
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
            if (!FOV.isInsideTheFOVOf(flashLight.transform, FLRange, gameObject.transform)) if (!SeeingPlayer) GhostCounter();
            else  Accelarete();  
        }        
        else GhostCounter();
    }

    public void StopMovement() { if (!agent.isStopped) agent.isStopped = true; }

    void ResumeMovement() { if (agent.isStopped) agent.isStopped = false; }

    public override void GhostCounter() { GoBackToRestingPosition(); }

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
     private void StopWatchingPlayer() { SeeingPlayer = false; }
}
