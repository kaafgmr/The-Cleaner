using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class testmanager : MonoBehaviour
{
    private void Start()
    {
        MenuControl.instance.LoadScene("LivingRoom", UnityEngine.SceneManagement.LoadSceneMode.Additive);
        MenuControl.instance.LoadScene("MainCorridor", UnityEngine.SceneManagement.LoadSceneMode.Additive);
        MenuControl.instance.LoadScene("LivingRoom2", UnityEngine.SceneManagement.LoadSceneMode.Additive);
        MenuControl.instance.LoadScene("MainHallway", UnityEngine.SceneManagement.LoadSceneMode.Additive);
        MenuControl.instance.LoadScene("DiningRoom", UnityEngine.SceneManagement.LoadSceneMode.Additive);

    }
}
