using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class GameController : MonoBehaviour
{
    public int interactionsNeeded = 3;
    public GameObject Transition;

    private int currentInteractions = 0;
    private Animator anim;

    void Awake()
    {
        anim = Transition.GetComponent<Animator>();
    }

    void Start()
    {
        anim.Play("FadeOut");
        Invoke("HideTransition", 1f);
    }

    void HideTransition()
    {
        Transition.SetActive(false);
    }

    public void updateInteractions()
    {
        currentInteractions += 1;

        if (currentInteractions == interactionsNeeded)
        {
            Transition.SetActive(true);
            Invoke("FadeIn", 5f);
        }
    }

    void FadeIn()
    {
        anim.Play("FadeIn");
        Invoke("ChangeScene", 2f);
    }

    void ChangeScene()
    {
        SceneManager.LoadScene("Cinematic");
    }
}
