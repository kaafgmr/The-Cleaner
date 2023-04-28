using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointManager : MonoBehaviour
{
    public bool isInside;
    public bool isOnFinalPoint;
    public Transform tpPoint;
    public Transform finalTpPoint;
    GameObject cevlakObject;
    GameObject cevlakObjectParent;


    void Awake()
    {
        cevlakObject = GameObject.Find("Cevlak");
        cevlakObjectParent = GameObject.Find("CevlakParent");
        tpPoint.gameObject.GetComponent<MeshRenderer>().enabled = false;
        finalTpPoint.gameObject.GetComponent<MeshRenderer>().enabled = false;
    }

    private void OnTriggerEnter(Collider other)
    {
        if(!isOnFinalPoint)
        {
            cevlakObjectParent.transform.position = tpPoint.position;
        }

        isInside = true;
        cevlakObject.GetComponent<Cevlak>().playerObj = other.gameObject;
        cevlakObject.GetComponent<Cevlak>().isInside = true;
        cevlakObject.GetComponent<Cevlak>().speedActivator = true;
        cevlakObject.GetComponent<Cevlak>().GhostAction();
    }

    private void OnTriggerExit(Collider other)
    {
        isInside = false;
        cevlakObject.GetComponent<Cevlak>().isInside = false;
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = new Color(1, 0, 0, 0.5f);
        Gizmos.DrawCube(transform.position, new Vector3(1,0.3095628f, 1));
    }
}
