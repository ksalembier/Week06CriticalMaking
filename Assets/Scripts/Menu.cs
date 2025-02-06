using System.Collections;
using System.Collections.Generic;
using UnityEditorInternal;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Menu : MonoBehaviour
{
    private Animator anim;
    public GameObject Transition;

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


    public void PlayButton()
    {
        Transition.SetActive(true);
        anim.Play("FadeIn");
        Invoke("ChangeScene", 1f);
    }

    void ChangeScene()
    {
        SceneManager.LoadScene("Main");
    }

    public void QuitButton()
    {
        Application.Quit();
    }
}
