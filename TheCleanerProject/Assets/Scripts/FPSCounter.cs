using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class FPSCounter : MonoBehaviour
{
    [SerializeField] float updateDelay = 0.2f;
    [SerializeField] float targetFPS = 72f;

    [HideInInspector] public float currentFPS = 0f;
    float deltaTime = 0f;

    [SerializeField] TextMeshProUGUI textFPS;


    private void Start()
    {
        StartCoroutine(UpdateFPSAndDisplay());
    }

    private void Update()
    {
        CalcFPS();
    }

    public void CalcFPS()
    {
        deltaTime += (Time.unscaledDeltaTime - deltaTime) * 0.01f;

        if (deltaTime > 0.0001f)
        {
            currentFPS = 1f / deltaTime;
        }
        else
        {
            currentFPS = 1f / 0.0001f;
        }
    }

    private IEnumerator UpdateFPSAndDisplay()
    {
        while (true)
        {
            if (currentFPS >= targetFPS)
            {
                textFPS.color = Color.green;
            }
            else
            {
                textFPS.color = Color.red;
            }

            textFPS.text = "FPS: " + currentFPS.ToString(".0");
            yield return new WaitForSeconds(updateDelay);
        }
    }
}
