using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectsTidiedUpController : MonoBehaviour
{
    public List<ObjectsToOrder> objects;
    bool allObjectsTidiedUp;
    int numberOfObjects;
    void Start()
    {
        allObjectsTidiedUp = false;
        numberOfObjects = 0;
    }


    public bool CheckObjectsRealPosition()
    {
        return allObjectsTidiedUp;
    }

    void Update()
    {
        CheckIfObjectsAreTidiedUp();
        if (numberOfObjects == objects.Count) { allObjectsTidiedUp = true; }
    }

    public void CheckIfObjectsAreTidiedUp()
    {
        for (int i = 0; i < objects.Count; i++) 
        {
            if (!objects[i].isOnRealPosition) { return; }
            else { numberOfObjects++; }
        }
    }
}
