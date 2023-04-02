using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.InputSystem;

public class WristCanvas : MonoBehaviour
{
    private Canvas _wristCanvas;
    private InputAction _menu;

    public GameObject panelOptions;
    public GameObject panelMain;
    
    private bool openOptions;

    private void Start()
    {
        _wristCanvas = GetComponent<Canvas>();
        _menu = PlayerInput.input.LeftHand.Menu;
        _menu.Enable();
        _menu.performed += ToggleMenu;
        Close();
    }

    public void Options()
    {
        if (panelOptions != null && panelMain != null && !openOptions)
        {
            panelMain.SetActive(false);
            panelOptions.SetActive(true);

            openOptions = true;
            Debug.Log("Open Options Wrist");
        }
    }

    public void Close()
    {
        panelOptions.SetActive(false);
        panelMain.SetActive(true);

        openOptions = false;
    }

    public void ExitGame()
    {
        SceneManager.LoadScene("MainMenu");
    }

    private void OnDestroy()
    {
        _menu.performed -= ToggleMenu;
    }

    public void ToggleMenu(InputAction.CallbackContext context)
    {
        _wristCanvas.enabled = !_wristCanvas.enabled;
    }
}
