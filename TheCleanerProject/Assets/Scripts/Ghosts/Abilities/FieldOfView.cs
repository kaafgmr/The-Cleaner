using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.Events;

public class FieldOfView : MonoBehaviour
{
    [Range(0f,179f)]
    [SerializeField] float fovAngle;
    [SerializeField] LayerMask collisionLayer;

    public UnityEvent<Transform> OnViewedByMe;
    public UnityEvent OnStartBeingViewed;
    public UnityEvent OnStopBeingViewed;

    GameObject player;
    bool wandering = false;

    [Header("Debug")]
    [SerializeField]float maxDistanceView = 30;

    private void Start()
    {
        player = GameManager.instance.GetPlayer();
    }

    private void FixedUpdate()
    {
        Vector3 myDir = (player.transform.position - transform.position).normalized;

        if (ICouldBeSeenBy(player, myDir))
        {
            Vector3 itsDir = -myDir;
            if (ImInsideItsFOV(itsDir, player.transform.forward, 60))
            {
                OnStartBeingViewed.Invoke();
                wandering = false;
            }
            else
            {
                if (IsInsideMyFOV(myDir))
                {
                    OnViewedByMe.Invoke(player.transform);
                    wandering = false;
                }
                else
                {
                    if (wandering) return;
                    
                    OnStopBeingViewed.Invoke();
                    wandering = true;
                }
            }
        }
        else
        {
            if (!wandering)
            {
                OnStopBeingViewed.Invoke();
                wandering = true;
            }
        }
    }

    bool IsInsideMyFOV(Vector3 dir)
    {
        return (Vector3.Angle(dir, transform.forward) < (fovAngle * 0.5f));
    }

    bool ImInsideItsFOV(Vector3 dir, Vector3 itsForward, float itsFOV)
    {
        return (Vector3.Angle(dir, itsForward) < (itsFOV * 0.5f));
    }

    bool ICouldBeSeenBy(GameObject obj, Vector3 dir)
    {
        if(Physics.Raycast(transform.position, dir, out RaycastHit hit, 1000, collisionLayer))
        {
            if (hit.collider.gameObject == obj)
            {
                return true;
            }
        }
        return false;
    }

#if UNITY_EDITOR
    private void OnDrawGizmosSelected()
    {
        DrawFOV();
    }

    void DrawFOV()
    {
        float catetoOpuesto = maxDistanceView * Mathf.Tan(fovAngle * 0.5f * Mathf.Deg2Rad);
        Vector3 viewingPosR = transform.right * catetoOpuesto + transform.forward * maxDistanceView;
        Vector3 viewingPosL = (transform.right * catetoOpuesto * -1) + transform.forward * maxDistanceView;

        Gizmos.color = Color.red;
        Gizmos.DrawLine(transform.position, transform.position + viewingPosR.normalized * maxDistanceView);
        Gizmos.DrawLine(transform.position, transform.position + viewingPosL.normalized * maxDistanceView);
    }
#endif
}