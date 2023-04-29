using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReplaceObj : MonoBehaviour
{
    public void Replace(GameObject newObj) 
    {//codigo en el hijo de la bombilla (el que tiene el modelo)
        GameObject newObject = Instantiate(newObj, transform.position, transform.rotation);
        newObject.transform.SetParent(transform.parent);
        Destroy(gameObject);
    }
}
