using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DynamicSceneLoader : MonoBehaviour
{
    [Header("Loading")]
    public string[] scenesToLoad;

    [Header("*Optional* unload")]
    public bool unloadForwards = false;
    public string[] scenesToUnload;

    bool forwards
    {
        get
        {
            Vector2 joystickRaw = PlayerInput.input.LeftHand.Joystick.ReadValue<Vector2>();

            Vector3 joystickDir = new Vector3(joystickRaw.x, 0, joystickRaw.y);
            return Vector3.Dot(transform.forward, joystickDir) > 0;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!forwards) return;
        
        LoadScenes();

        if (unloadForwards)
        {
            UnloadScenes();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (forwards) return;
        
        LoadScenes();

        if (!unloadForwards)
        {
            UnloadScenes();
        }
    }

    void LoadScenes()
    {
        if (scenesToLoad.Length <= 0) return;
        for (int i = 0; i < scenesToLoad.Length; i++)
        {
            if (MenuControl.instance.IsAreadyLoaded(scenesToLoad[i])) return;
            
            MenuControl.instance.LoadScene(scenesToLoad[i], UnityEngine.SceneManagement.LoadSceneMode.Additive);    
        }

        CalculateBounds.instance.Recalculate();
    }

    void UnloadScenes()
    {
        if (scenesToUnload.Length <= 0) return;

        for (int i = 0; i < scenesToUnload.Length; i++)
        {
            if (!MenuControl.instance.IsAreadyLoaded(scenesToUnload[i])) return;

            MenuControl.instance.UnloadSceneASYNC(scenesToUnload[i]);
        }

        CalculateBounds.instance.Recalculate();
    }
}
