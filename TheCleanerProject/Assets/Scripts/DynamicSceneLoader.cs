using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

public class DynamicSceneLoader : MonoBehaviour
{
    [SerializeField] string firstSceneToLoad;
    [SerializeField] float distanceToLoad;
    [SerializeField] SceneLoadPoint[] ScenePointsList;

    [Serializable]
    public struct SceneLoadPoint
    {
        public string sceneToLoad;
        public Transform transform;
    }

    string currentScene;



    void Start()
    {
        testSceneNumber = 0;
        ChangeSceneTo(firstSceneToLoad);
    }

    int testSceneNumber;
    bool once = false;
    private void Update()
    {
        if (PlayerInput.instance.rightController.activateAction.action.IsPressed() && !once)
        {
            testSceneNumber = testSceneNumber + 1 >= ScenePointsList.Length ? 0 : testSceneNumber + 1;
            ChangeSceneTo(ScenePointsList[testSceneNumber].sceneToLoad);
            once = true;
        }
        else
        {
            once = false;
        }
    }

    void ChangeSceneTo(string name)
    {
        if (currentScene != null)
        {
            MenuControl.instance.UnloadSceneASYNC(currentScene);
        }

        MenuControl.instance.LoadScene(name, UnityEngine.SceneManagement.LoadSceneMode.Additive);
        currentScene = name;
    }
}
