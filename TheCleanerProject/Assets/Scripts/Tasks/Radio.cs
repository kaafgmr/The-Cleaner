using UnityEngine;

public class Radio : MonoBehaviour
{
    private AudioSource audioSource;

    private void Awake()
    {
        audioSource = GetComponent<AudioSource>();
    }

    public void TurnOff()
    {
        if (audioSource.isPlaying)
        {
            audioSource.Stop();
        }
    }
}
