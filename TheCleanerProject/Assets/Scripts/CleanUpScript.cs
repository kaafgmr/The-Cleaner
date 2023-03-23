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
            if (everything[i].name.Contains("WallIn_A_3x_doordouble"))
            {
                BoxCollider bc = everything[i].AddComponent<BoxCollider>();
                bc.center = new Vector3(-0.5f, 1.4f, 0);
                bc.size = new Vector3(1, 2.8f, 0.3f);

                bc = everything[i].AddComponent<BoxCollider>();
                bc.center = new Vector3(-2.5f, 1.4f, 0);
                bc.size = new Vector3(1, 2.8f, 0.3f);
            }
        }
    }
}