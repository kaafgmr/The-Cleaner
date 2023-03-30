using System;
using System.Collections;
using System.Collections.Generic;
using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public string[] ScenesToLoadOnStart;
    public UnityEvent InitGame;
    public UnityEvent OnAllScenesLoaded;
    
    private GameObject player;
    public static GameManager instance;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(this);
        }

        player = FindObjectOfType<XROrigin>().gameObject;
    }


    private void Start()
    {
        for (int i = 0; i < ScenesToLoadOnStart.Length; i++)
        {
            MenuControl.instance.LoadScene(ScenesToLoadOnStart[i], UnityEngine.SceneManagement.LoadSceneMode.Additive);
        }
        
        InitGame.Invoke();
    }

    //private void Update()
    //{
    //    if (Input.GetKeyDown(KeyCode.T))
    //    {
    //        Debug.Log("AAAAAAA");
    //    }
    //}

    public IEnumerator CheckAllScenesLoaded()
    {
        while (SceneManager.sceneCount < ScenesToLoadOnStart.Length)
        {
            yield return null;
        }
        OnAllScenesLoaded.Invoke();

    }


    public GameObject GetPlayer()
    {
        return player;
    }
}
