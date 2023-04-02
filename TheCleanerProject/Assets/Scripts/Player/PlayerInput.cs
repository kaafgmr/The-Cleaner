using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInput : MonoBehaviour
{
    public static PlayerInputActions input;
    public static PlayerInput instance;
    private void Start()
    {
        if (instance == null)
        {
            instance = this;
            input = new PlayerInputActions();
        }
        else
        {
            Destroy(this);
        }
    }
}
