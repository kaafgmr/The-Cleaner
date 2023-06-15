using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightBulbInteraction : MonoBehaviour // Script para la bombilla que hay que coger y llevar a donde la bombilla rota
{
    public Renderer[] bulbsRenderers;
    public GameObject grabInteractor;

    public void ChangeBulb()
    {
        foreach (Renderer bulbRenderer in bulbsRenderers)
        {
            bulbRenderer.enabled = false;
        }
        grabInteractor.SetActive(false);
    }
}
