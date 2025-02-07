using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wind : MonoBehaviour
{
    
    public GameObject[] wind;
    public GameObject[] boundaries;

    public void SetWindActive(int puzzle)
    {
        wind[puzzle-1].SetActive(true);
        //GetComponent<AudioSource>().volume = 1;
    }

    public void SetWindInactive(int puzzle)
    {
        wind[puzzle-1].SetActive(false);
        //GetComponent<AudioSource>().volume = 0;
    }

    public void SetBoundaryInactive(int puzzle)
    {
        boundaries[puzzle-1].SetActive(false);
    }
}
