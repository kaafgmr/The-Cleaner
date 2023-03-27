using System.Collections;
using System.Collections.Generic;
using Unity.XR.CoreUtils;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;


    private GameObject player;

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
        MenuControl.instance.LoadScene("Kelson", UnityEngine.SceneManagement.LoadSceneMode.Additive);
        //MenuControl.instance.LoadScene("Victor", UnityEngine.SceneManagement.LoadSceneMode.Additive);
    }


    public GameObject GetPlayer()
    {
        return player;
    }
}
