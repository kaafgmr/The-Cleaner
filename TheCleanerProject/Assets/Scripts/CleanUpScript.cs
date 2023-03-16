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

        List<GameObject> all = new List<GameObject>();

        for (int i = 0; i < everything.Length; i++)
        {
            if (everything[i].transform.position.y < transform.position.y)
            {
                if (everything[i].name.Contains("Foundation"))
                {
                    all.Add(everything[i].gameObject);
                }
            }
        }

        GameObject[] select = new GameObject[all.Count];

        for (int i = 0; i < all.Count; i++)
        {
            select[i] = all[i];
        }

        Selection.objects = select;

        if (select.Length == 0)
        {
            Selection.activeObject = gameObject;
        }
    }
}