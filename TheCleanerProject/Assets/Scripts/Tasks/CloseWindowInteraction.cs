using Oculus.Interaction;
using Oculus.Interaction.HandGrab;
using Oculus.Interaction.Input;
using UnityEngine;

public class CloseWindowInteraction : MonoBehaviour
{
    OneGrabTranslateTransformer ogtt;
    Hand hand;
    Vector3 openPos;

    private void Start()
    {
        ogtt = GetComponent<OneGrabTranslateTransformer>();
        openPos = transform.position;
    }

    private void OnCollisionEnter(Collision collision)
    {
        collision.gameObject.TryGetComponent(out hand);
    }

    private void OnCollisionExit(Collision collision)
    {
        hand = null;
    }

    private void OnCollisionStay(Collision collision)
    {
        if (hand != null && transform.position.y == openPos.y - ogtt.Constraints.MaxY.Value)
        {
            GetComponent<HandGrabInteractable>().enabled = false;
        }
    }
}