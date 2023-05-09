using UnityEngine;

public class SpongeBehaviour : MonoBehaviour
{
    Material material;
    bool collidedWithWindow;
    float windowProgress;

    private void Start()
    {
        collidedWithWindow = false;
        material = GetComponent<MeshRenderer>().material;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (!collision.gameObject.TryGetComponent(out WindowInteraction window)) return;

        collidedWithWindow = true;
        windowProgress = window.progress;
    }

    private void OnCollisionStay(Collision collision)
    {
        if (!collidedWithWindow) return;

        material.SetFloat("Smoothness", windowProgress);
    }

    private void OnCollisionExit(Collision collision)
    {
        collidedWithWindow = false;
    }
}