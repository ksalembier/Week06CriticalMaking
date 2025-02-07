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
            colorResult.SetActive(true);
            colorResult.GetComponent<Animation>().Play();

            GameObject.Find("GameController").GetComponent<GameController>().updateInteractions();
            dingSound.Play();

            gameObject.SetActive(false);
        }
    }
}
