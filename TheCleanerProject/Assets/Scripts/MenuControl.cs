using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;
using UnityEngine.UI;

public class MenuControl : MonoBehaviour
{
    public static MenuControl instance;
    public GameObject loadScreenPanel;
    public TextMeshProUGUI progressPercentage;
    public Slider progressBar;

    private void Awake()
    {
        instance = this;
        if(loadScreenPanel != null)
        {
            loadScreenPanel.SetActive(false);
        }
    }

    public void LoadLevel(int levelNumber)
    {
        SceneManager.LoadScene("Level" + levelNumber);
    }

    public void LoadScene(string name, LoadSceneMode loadMode = LoadSceneMode.Single)
    {
        SceneManager.LoadScene(name, loadMode);
    }

    public void LoadWithProgressBar(string sceneName)
    {
        StartCoroutine(LoadSceneAsync(sceneName));
    }

    IEnumerator LoadSceneAsync(string SceneName)
    {
        AsyncOperation loader = SceneManager.LoadSceneAsync(SceneName);

        loadScreenPanel.SetActive(true);
        while(!loader.isDone)
        {
            //change the value so it goes from 0 to 1 instead of 0 to 0.9f
            float progress = Mathf.Clamp01(loader.progress / 0.9f);
            if (progressBar != null) { progressBar.value = progress; }
            //change the value so it goes from 0 to 100 with 2 decimal places
            progress = Mathf.Round(progress * 10000) / 100;
            if (progressPercentage != null) { progressPercentage.text = progress + "%"; }
            yield return null;
        }
    }

    public void Exit()
    {
        #if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
        #else
        Application.Quit();
        #endif
    }
}
