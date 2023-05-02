using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Plushy : MonoBehaviour
{
    public bool isInRightPlace;
    void Start() { isInRightPlace = false; }
    private void OnTriggerEnter(Collider obj) { if (obj.TryGetComponent(out CollectPlushiesTask plushiesTask)) if (!plushiesTask.CheckIfItsDone()) isInRightPlace = true; }
    private void OnTriggerExit(Collider obj) { if (obj.TryGetComponent(out CollectPlushiesTask plushiesTask)) if (!plushiesTask.CheckIfItsDone()) isInRightPlace = false; }
}