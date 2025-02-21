using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Draggable : MonoBehaviour
{
    public int uses = 1;

    public GameObject puzzleRef;

    public AudioSource[] soundEffects;

    private SpriteRenderer sr;
    private Animation anim;

    private GameObject currentShadow = null;

    private Vector3 mousePositionOffset;
    private Vector3 initialPosition;
    private float cameraHeight, cameraWidth;
    private bool outOfBoundsX, outOfBoundsY = false;

    private bool locked = false;
    private int currentUses = 0;


    void Awake()
    {
        sr = transform.GetChild(0).GetComponent<SpriteRenderer>();
        anim = GetComponent<Animation>();
    }


    void Start()
    {
        locked = false;
        initialPosition = transform.position;

        cameraHeight = 2f * Camera.main.orthographicSize;
        cameraWidth = cameraHeight * Camera.main.aspect;

        anim.Play();
    }


    private Vector3 GetMouseWorldPosition()
    {
        return Camera.main.ScreenToWorldPoint(Input.mousePosition);
    }


    private void OnMouseDown()
    {
        if (!locked)
        {
            mousePositionOffset = gameObject.transform.position - GetMouseWorldPosition();
            soundEffects[0].Play();
            anim.Stop();
            transform.localScale = Vector3.one;
            transform.GetChild(0).GetComponent<Renderer>().sortingLayerName = "Grabbed";
        }  
    }


    private void OnMouseDrag()
    {
        if (!locked)
        {
            transform.position = GetMouseWorldPosition() + mousePositionOffset;
        }
    }


    private void OnMouseUp()
    {
        if (!locked)
        {
            if (currentShadow != null)
            {
                transform.localScale = Vector3.one;
                transform.position = currentShadow.transform.position;

                transform.GetChild(0).GetComponent<SpriteRenderer>().maskInteraction = SpriteMaskInteraction.VisibleInsideMask;
                transform.GetChild(0).GetComponent<Renderer>().sortingLayerName = "Locked";

                currentShadow.SetActive(false);

                soundEffects[1].Play();

                currentUses += 1;

                if (currentUses >= uses)
                {
                    locked = true;
                    anim.Stop();
                }

                puzzleRef.GetComponent<Puzzle>().checkInteractions();
            }

            else
            {
                transform.GetChild(0).GetComponent<Renderer>().sortingLayerName = "Available";

                anim.Play();
            }

            //outOfBoundsX = transform.position.x > (cameraWidth / 2) || transform.position.x < -(cameraWidth / 2);
            outOfBoundsY = transform.position.y > (cameraHeight / 2) || transform.position.y < -(cameraHeight / 2);

            if (outOfBoundsY)
            {
                transform.position = initialPosition;
            }
        }
    }


    void OnTriggerEnter2D(Collider2D col)
    {
        if (gameObject.tag == col.gameObject.tag && col.gameObject.GetComponent<Draggable>() == null)
        {
            currentShadow = col.gameObject;
        }
    }


    void OnTriggerExit2D(Collider2D col)
    {
        if (gameObject.tag == col.gameObject.tag && col.gameObject.GetComponent<Draggable>() == null)
        {
            currentShadow = null;
        }
    }
}
