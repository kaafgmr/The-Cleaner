#if UNITY_EDITOR
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[ExecuteAlways]
public class CleanUpScript : MonoBehaviour
{
    public GameObject parentToClean;
    public string nameToSelect;
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

        Transform[] objects = parentToClean.GetComponentsInChildren<Transform>(true);
        List<GameObject> all = new List<GameObject>();

        for (int i = 0; i < objects.Length; i++)
        {
            if (objects[i].name.Contains(nameToSelect))
            {
                all.Add(objects[i].gameObject);
            }
        }

        GameObject[] select = all.ToArray();

        Selection.activeGameObject = gameObject;

        if (select.Length > 0)
        {
            Selection.objects = select;
        }
        else
        {
            Debug.Log(select.Length + " objects selected");
        }
    }
}

#endif