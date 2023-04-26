using Unity.XR.CoreUtils;
using UnityEngine;
using UnityEngine.Events;

public class GameManager : MonoBehaviour
{
    public GameObject player;
    public string[] ScenesToLoadOnStart;
    public UnityEvent InitGame;
    public UnityEvent OnAllScenesLoaded;
    
    private Transform playerTransform;
    private float playerFOV;
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

        playerTransform = Camera.main.transform;
        playerFOV = Camera.main.fieldOfView;
    }


    private void Start()
    {
        for (int i = 0; i < ScenesToLoadOnStart.Length; i++)
        {
            MenuControl.instance.LoadScene(ScenesToLoadOnStart[i], UnityEngine.SceneManagement.LoadSceneMode.Additive);
        }
        
        InitGame.Invoke();
        InitOculusSettings();
    }

    void InitOculusSettings()
    {
        OVRManager.foveatedRenderingLevel = OVRManager.FoveatedRenderingLevel.High;
    }

    public GameObject GetPlayer()
    {
        return player;
    }

    public float GetPlayerFOV()
    {
        return playerFOV;
    }

    public Transform GetPlayerTransform()
    {
        return playerTransform;
    }
}
