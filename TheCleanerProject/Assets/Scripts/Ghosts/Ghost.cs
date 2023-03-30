using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public abstract class Ghost : MonoBehaviour
{
    public abstract void Scream();
    public virtual void AnimationHashes()
    {

    }
    public abstract void GhostCounter();
    public abstract void GhostAction();
}
