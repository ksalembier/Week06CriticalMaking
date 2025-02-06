using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.SceneManagement;

public class Cinematic : MonoBehaviour
{
    public Animator anim;
    public VideoPlayer vp;

    
    void Start()
    {
        vp.prepareCompleted += OnPrepareCompleted;
        vp.loopPointReached += OnLoopPointReached;

        vp.Prepare();
    }

    void OnPrepareCompleted(VideoPlayer cinematicVideo)
    {
        Invoke("PlayVideo", 1f);
    }

    void PlayVideo()
    {
        vp.Play();
        anim.Play("FadeOut");
    }


    void OnLoopPointReached(VideoPlayer cinematicVideo)
    {
        anim.Play("FadeIn");
        Invoke("ChangeScene", 1f);
    }

    void ChangeScene()
    {
        SceneManager.LoadScene("Menu");
    }
}
