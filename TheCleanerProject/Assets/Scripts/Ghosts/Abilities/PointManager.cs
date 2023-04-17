using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointManager : MonoBehaviour
{
    public bool isInside;
    public Transform tpPoint;
    public Transform finalTpPoint;
    GameObject cevlakObject;


    void Awake()
    {
        cevlakObject = GameObject.Find("Cevlak");
        tpPoint.gameObject.GetComponent<MeshRenderer>().enabled = false;
        finalTpPoint.gameObject.GetComponent<MeshRenderer>().enabled = false;
    }

    private void OnTriggerEnter(Collider other)
    {
        cevlakObject.transform.position = tpPoint.position;
        isInside = true;
        cevlakObject.GetComponent<Cevlak>().GhostAction();
    }

    private void OnTriggerExit(Collider other)
    {
        isInside = false;
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = new Color(1, 0, 0, 0.5f);
        Gizmos.DrawCube(transform.position, new Vector3(1,0.3095628f, 1));
    }
}
