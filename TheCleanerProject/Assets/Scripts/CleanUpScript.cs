using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

[ExecuteAlways]
public class CleanUpScript : MonoBehaviour
{
    public GameObject ParentToClean;
    public bool Activate = false;

    private void Update()
    {
        if (Activate)
        {
            CleanUP();
        }
    }

    void CleanUP()
    {
        if (Activate == false) return;

        Activate = false;

        Transform[] everything = ParentToClean.GetComponentsInChildren<Transform>();

        for (int i = 0; i < everything.Length; i++)
        {
            if (everything[i].name.Contains("Floor"))
            {
                BoxCollider a = everything[i].gameObject.AddComponent<BoxCollider>();
                a.size = new Vector3(a.size.x, 0.01f, a.size.z);
                everything[i].gameObject.layer = 3;
            }
        }
    }
}