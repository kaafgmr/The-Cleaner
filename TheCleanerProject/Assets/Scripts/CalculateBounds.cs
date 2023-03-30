using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class CalculateBounds : MonoBehaviour
{
    public UnityEvent OnInit;

    [Header("Debug")]
    public bool recalculate;
    
    public static Bounds bounds;
    public GameObject[] Floors;
    public static CalculateBounds instance;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(this);
        }

        GameManager.instance.OnAllScenesLoaded.AddListener(Init);
    }

    public void Init()
    {
        InitFloorsList();
        if (Floors.Length > 0)
        {
            CalculateBound(Floors);
        }

        OnInit.Invoke();
    }

    void InitFloorsList()
    {
        GameObject[] initialList = GameObject.FindGameObjectsWithTag("Floor");
        if (initialList.Length > 0)
        {
            Floors = initialList;
        }
    }

    private void OnDrawGizmosSelected()
    {
        if (recalculate)
        {
            InitFloorsList();
            recalculate = false;
        }

        if (Floors?.Length > 0)
        {
            CalculateBound(Floors);
            Gizmos.color = Color.red;
            Vector3 scale = bounds.size;
            Gizmos.DrawWireCube(bounds.center, scale);
        }
    }

    public static Vector3 CalculatePointInsideBounds(Bounds bounds)
    {
        Vector3 MinPos = bounds.center - bounds.extents;
        Vector3 MaxPos = bounds.center + bounds.extents;

        return new Vector3(Random.Range(MinPos.x, MaxPos.x), Random.Range(MinPos.y, MaxPos.y), Random.Range(MinPos.z, MaxPos.z));
    }

    void CalculateBound(GameObject[] objects)
    {
        Vector3 MidPoint = calculateMidPoint(objects);
        bounds = new Bounds(MidPoint, Vector3.zero);
        for (int i = 0; i < objects.Length; i++)
        {
            bounds.Encapsulate(objects[i].GetComponent<MeshRenderer>().bounds);
        }
    }

    Vector3 calculateMidPoint(GameObject[] objects)
    {
        if (objects.Length > 0)
        {
            Vector3 midPoint = Vector3.zero;

            for (int i = 0; i < objects.Length; i++)
            {
                midPoint += objects[i].transform.position;
            }

            return midPoint / objects.Length;
        }
        return Vector3.zero;
    }
}
