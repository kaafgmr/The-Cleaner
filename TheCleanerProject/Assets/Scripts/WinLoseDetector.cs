using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class WinLoseDetector : MonoBehaviour
{
    public TextMeshProUGUI winLoseText;

    void Start()
    {
        if (PlayerPrefs.GetInt("Win") == 1)
        {
            winLoseText.text = "You Win";
        }
        else
        {
            winLoseText.text = "Game Over";
        }
    }
}
