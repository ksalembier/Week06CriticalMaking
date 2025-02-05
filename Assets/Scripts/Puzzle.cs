using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class Puzzle : MonoBehaviour
{
    public GameObject[] pieces;
    public GameObject colorResult;
    public AudioSource dingSound;
    private int currentInteractions = 0;



    void Start()
    {
        currentInteractions = 0;
    }


    public void checkInteractions()
    {
        currentInteractions += 1;

        if (currentInteractions == pieces.Length)
        {
            foreach (GameObject p in pieces) p.SetActive(false);
            colorResult.SetActive(true);
            colorResult.GetComponent<Animation>().Play();
            dingSound.Play();
        }
    }
}
