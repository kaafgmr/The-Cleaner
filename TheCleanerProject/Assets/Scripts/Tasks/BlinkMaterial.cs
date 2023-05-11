using System.Collections;
using UnityEngine;

public class BlinkMaterial : MonoBehaviour
{
    public Material material;
    public float fadeSpeed = 1f;
    private float startTime;

    void Start()
    {
        startTime = Time.time;
        SetAlpha(0f);
    }

    public void StartBlink()
    {
        SetAlpha(0f);
        StartCoroutine(Blink());
    }

    public void StopBlink()
    {
        StopAllCoroutines();
        SetAlpha(0f);
    }

    void SetAlpha(float alpha)
    {
        Color color = material.color;
        color.a = (Mathf.Cos(alpha * 2 * 3.141592f) + 1) / 6;

        material.color = color;
    }

    IEnumerator Blink()
    {
        SetAlpha((Time.time - startTime) * fadeSpeed);

        yield return new WaitForFixedUpdate();

        StartCoroutine(Blink());
    }
}
