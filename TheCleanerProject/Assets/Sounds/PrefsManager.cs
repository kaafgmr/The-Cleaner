using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
public class PrefsManager : MonoBehaviour
{
    
    public Slider Master;
    public Slider Music;
    public Slider SFX;

    // Start is called before the first frame update

    public void Awake()
    {
        WriteSaves();
    }
    public void SaveOptions()
    {
        
        PlayerPrefs.SetFloat("Master", Master.value);
        PlayerPrefs.SetFloat("Music", Music.value);
        PlayerPrefs.SetFloat("SFX", SFX.value);



        PlayerPrefs.Save();
    }
    public void WriteSaves()
    {
        Master.value = PlayerPrefs.GetFloat("Master");
        Music.value = PlayerPrefs.GetFloat("Music");
        SFX.value = PlayerPrefs.GetFloat("SFX");

    }
}
