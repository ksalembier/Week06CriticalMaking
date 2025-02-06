using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Interactable : MonoBehaviour
{
    public GameObject puzzleRef;

    public AudioSource soundEffect;

    private SpriteRenderer sr;
    private Animation anim;

    private bool locked = false;


    void Awake()
    {
        sr = transform.GetChild(0).GetComponent<SpriteRenderer>();
        anim = GetComponent<Animation>();
    }


    void Start()
    {
        locked = false;
        anim.Play();
    }



    private void OnMouseDown()
    {
        if (!locked)
        {
            soundEffect.Play();
            anim.Stop();
            transform.localScale = Vector3.one;
            puzzleRef.SetActive(true);
        }
    }
}
