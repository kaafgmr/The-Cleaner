using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using UnityEngine.SceneManagement;

public class MissingScriptFinder : MonoBehaviour
{
    [MenuItem("WxlfGames/Tools/Select GameObjects With Missing Scripts")]
    static void SelectGameObjects()
    {
        Scene currentScene = SceneManager.GetActiveScene();
        GameObject[] rootObjs = currentScene.GetRootGameObjects();

        List<Object> objectsWithMissingScripts = new List<Object>();

        for (int i = 0; i < rootObjs.Length; i++)
        {
            Component[] script = rootObjs[i].GetComponents<Component>();
            for (int j = 0; j < script.Length; j++)
            {
                Component currentScript = script[i];

                if (currentScript == null)
                {
                    objectsWithMissingScripts.Add(rootObjs[i]);
                    Selection.activeGameObject = rootObjs[i];
                    Debug.Log(rootObjs[i] + " is missing a script");
                    break;
                }
            }
        }
        if (objectsWithMissingScripts.Count > 0)
        {
            Selection.objects = objectsWithMissingScripts.ToArray();
        }
        else
        {
            Debug.Log("No missing scripts in " + currentScene.name);
        }
    }
}
