#if UNITY_EDITOR

using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

[ExecuteAlways]
public class CleanUpScript : MonoBehaviour
{
    //public GameObject parentToClean;
    public GameObject[] objects;
    public Material[] materials;
    public bool Activate = false;

    Dictionary<string, Material> materialDictionary = new Dictionary<string, Material>();

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

        setUpDictionary();

        for (int i = 0; i < objects.Length; i++)
        {
            if (!objects[i].TryGetComponent(out MeshRenderer MR)) continue;
            
            Material[] ObjMaterials = MR.sharedMaterials;

            if (ObjMaterials.Length > 0)
            {
                Debug.Log(ObjMaterials.Length);
                for (int j = 0; j < ObjMaterials.Length; j++)
                {
                    if (!materialDictionary.ContainsKey(ObjMaterials[j].name)) continue;
                    ObjMaterials[j] = materialDictionary[ObjMaterials[j].name];
                }

                MR.sharedMaterials = ObjMaterials;
            }
        }
    }

    void setUpDictionary()
    {
        for (int i = 0; i < materials.Length; i++)
        {
            if (!materialDictionary.ContainsKey(materials[i].name))
            {
                materialDictionary.Add(materials[i].name, materials[i]); 
            }
        }
    }
}

#endif