using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Puzzle : MonoBehaviour
{
    public int pieces = 0;
    public Animation colorAnimation;
    public AudioSource dingSound;
    private int currentInteractions = 0;



    void Start()
    {
        currentInteractions = 0;
    }


    public void checkInteractions()
    {
        currentInteractions += 1;

        if (currentInteractions == pieces)
        {
            colorAnimation.Play();
            dingSound.Play();
        }
    }
}
