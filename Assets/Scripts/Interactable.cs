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

    public GameObject gameController;
    private GameController controller;
    public GameObject windObjects;
    private Wind wind;

    void Awake()
    {
        sr = transform.GetChild(0).GetComponent<SpriteRenderer>();
        anim = GetComponent<Animation>();

        controller = gameController.GetComponent<GameController>();
        wind = windObjects.GetComponent<Wind>();
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
            locked = true;
            soundEffect.Play();
            anim.Stop();
            transform.localScale = Vector3.one;
            puzzleRef.SetActive(true);
            int currentInteractions = controller.GetCurrentInteractions();
            if (currentInteractions == 0) { wind.SetWindInactive(1); }
            if (currentInteractions == 1) { wind.SetWindInactive(2); }
            if (currentInteractions == 2) { wind.SetWindInactive(3); }
        }
    }
}