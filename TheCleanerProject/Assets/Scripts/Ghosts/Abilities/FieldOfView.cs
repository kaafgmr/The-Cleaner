using UnityEngine;
using UnityEngine.Events;

public class FieldOfView : MonoBehaviour
{
    [Range(0f,179f)]
    [SerializeField] float fovAngle;
    [SerializeField] LayerMask collisionLayer;

    public UnityEvent<Transform> OnViewedByMe;
    public UnityEvent ImBeingViewed;
    public UnityEvent OnNothingHappening;

    GameObject player;
    float playerFOV;
    Transform playerTransform;

    bool wanderingOnce = false;

#if UNITY_EDITOR
    [Header("Debug")]
    [SerializeField]float maxDistanceView = 30;
#endif

    private void Start()
    {
        player = GameManager.instance.GetPlayer();
        playerFOV = GameManager.instance.GetPlayerFOV();
        playerTransform = GameManager.instance.GetPlayerTransform();
    }

    private void FixedUpdate()
    {
        Vector3 myDir = (playerTransform.position - transform.position).normalized;

        if (ICouldBeSeenBy(player, myDir))
        {
            if (IsInsideMyFOV(myDir))
            {
                OnViewedByMe.Invoke(playerTransform);
                wanderingOnce = false;
            }

            Vector3 itsDir = -myDir;
            if (ImInsideItsFOV(itsDir, playerTransform.forward, playerFOV))
            {
                ImBeingViewed.Invoke();
                wanderingOnce = false;
            }
        }
        else
        {
            if (wanderingOnce) return;

            OnNothingHappening.Invoke();
            wanderingOnce = true;
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

    /// <summary>
    /// Calculates if "to" is inside the FOV of "from"
    /// </summary>
    /// <param name="from"> The object that has the FOV that "to" could be inside of</param>
    /// <param name="fromFOVAngle"> The FOV it self that "from" have</param>
    /// <param name="to"> The objects that could me inside "from"s FOV</param>
    /// <returns>True if "to" is inside "from"s FOV</returns>
    public bool isInsideTheFOVOf(Transform from, float fromFOVAngle, Transform to)
    {
        Vector3 dir = (to.position - from.position).normalized;

        return (Vector3.Angle(dir, from.forward) < (fromFOVAngle * 0.5f));
    }

    Vector3 debugRay = Vector3.zero;
    bool ICouldBeSeenBy(GameObject obj, Vector3 dir)
    {
        if(Physics.Raycast(transform.position, dir, out RaycastHit hit, 1000, collisionLayer))
        {
            debugRay = hit.point;
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

        Gizmos.color = Color.blue;
        Gizmos.DrawRay(transform.position, debugRay);
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