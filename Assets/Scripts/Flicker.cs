using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flicker : MonoBehaviour
{
    private Animation anim;
    public GameObject hide;
    public GameObject show;

    void Awake()
    {
        anim = GetComponent<Animation>();
    }

    public void PlayAnimation()
    {
        anim.Play();
    }

    public void Switcheroo()
    {
        hide.SetActive(false);
        show.SetActive(true);
        show.GetComponent<Animation>().Play();
    }
}
