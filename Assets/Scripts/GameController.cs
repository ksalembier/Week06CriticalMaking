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

    public GameObject windObjects;
    private Wind wind;

    void Awake()
    {
        anim = Transition.GetComponent<Animator>();
        wind = windObjects.GetComponent<Wind>();
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

        if (currentInteractions == 1)
        {
            wind.SetBoundaryInactive(1);
            wind.SetWindActive(2);
        }

        if (currentInteractions == 2)
        {
            wind.SetBoundaryInactive(2);
            wind.SetWindActive(3);
        }

        if (currentInteractions == interactionsNeeded)
        {
            Transition.SetActive(true);
            Invoke("FadeIn", 5f);
        }
    }

    public int GetCurrentInteractions()
    {
        return currentInteractions;
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
