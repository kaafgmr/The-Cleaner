using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Ghost : MonoBehaviour
{
    public virtual void Scream()
    {
        transform.position = GameManager.instance.ScreamerPoint.position;
    }
    public virtual void AnimationHashes()
    {

    }
    public abstract void GhostCounter();
    public abstract void GhostAction(Vector3 otherPos);

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.TryGetComponent(out PointingMovement PM))
        Scream();
    }
}
