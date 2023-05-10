using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BlinkMaterial : MonoBehaviour
{
    public Material cubeMaterial;
    public float fadeSpeed = 1f;
    private float startTime;

    void Start()
    {
        startTime = Time.time;
    }

    public void StartBlink()
    {
        StartCoroutine(Blink());
    }

    public void StopBlink()
    {
        StopCoroutine(Blink());
    }

    void SetAlpha(float alpha)
    {
        Color color = cubeMaterial.color;
        color.a = (Mathf.Cos(alpha * 2 * 3.141592f) + 1) / 6;

        cubeMaterial.color = color;
    }

    IEnumerator Blink()
    {
        SetAlpha((Time.time - startTime) * fadeSpeed);

        yield return new WaitForFixedUpdate();

        StartCoroutine(Blink());
    }
}
