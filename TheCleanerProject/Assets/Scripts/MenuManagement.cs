using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuManagement : MonoBehaviour
{

    public GameObject optionsPanel;
    public GameObject creditsPanel;
    public GameObject menuPanel;
    bool optionsOpen;
    bool creditsOpen;

    private void Start()
    {
        Close();
    }

    private void Update()
    {
        if ((optionsOpen || creditsOpen) && Input.GetKeyDown(KeyCode.Escape))
        {
            Close();
            Debug.Log("Returning Menu");
        }
    }

public void Options()
    {
        if (optionsPanel != null && menuPanel != null && !optionsOpen)
        {
            menuPanel.SetActive(false);
            optionsPanel.SetActive(true);

            optionsOpen = true;
            Debug.Log("Open Options");
        }
    }

    public void Credits()
    {
        if (creditsPanel != null && menuPanel != null && !creditsOpen)
        {
            menuPanel.SetActive(false);
            creditsPanel.SetActive(true);

            creditsOpen = true;
            Debug.Log("Open Credits");
        }
    }

    public void Close()
    {
        optionsPanel.SetActive(false);
        creditsPanel.SetActive(false);
        menuPanel.SetActive(true);
        
        optionsOpen = false;
        creditsOpen = false;
    }
}

    
