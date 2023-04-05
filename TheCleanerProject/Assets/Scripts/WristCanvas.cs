using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WristCanvas : MonoBehaviour
{
    [SerializeField] GameObject rayInteractor;
    private Canvas _wristCanvas;
    private void Start()
    {
        _wristCanvas = GetComponent<Canvas>();
        PlayerInput.input.LeftHand.Menu.performed += ToggleMenu;
        rayInteractor.SetActive(false);
    }

    private void OnDestroy()
    {
        PlayerInput.input.LeftHand.Menu.performed -= ToggleMenu;
        rayInteractor.SetActive(false);
    }

    public void ToggleMenu(UnityEngine.InputSystem.InputAction.CallbackContext context)
    {
        _wristCanvas.enabled = !_wristCanvas.enabled;
        rayInteractor.SetActive(_wristCanvas.enabled);
    }
}
