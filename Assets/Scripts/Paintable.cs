using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Paintable : MonoBehaviour
{
    // public AudioSource[] soundEffects;

    public Texture2D resultTex;
    public Texture2D initialTex;
    private Texture2D currentTex;


    private Vector3 mousePositionOffset;
    private float cameraHeight, cameraWidth;

    private bool complete = false;


    void OnEnable()
    {
        currentTex = new Texture2D(initialTex.width, initialTex.height);
        currentTex.SetPixels(initialTex.GetPixels());
        currentTex.Apply();

        GetComponent<Renderer>().material.mainTexture = currentTex;
    }

    void OnDisable()
    {
        Destroy(currentTex);
    }

    void Start()
    {
        complete = false;

        cameraHeight = 2f * Camera.main.orthographicSize;
        cameraWidth = cameraHeight * Camera.main.aspect;
    }


    private Vector3 GetMouseWorldPosition()
    {
        return Camera.main.ScreenToWorldPoint(Input.mousePosition);
    }


    private void OnMouseDown()
    {
        if (!complete)
        {
            RaycastHit2D hit2D = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);

            if (hit2D.collider != null)
            {
                Destroy(hit2D.transform.gameObject);
            }

            /*if (Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out RaycastHit hit))
            {
                Vector2 pixelUV = hit.textureCoord;

                pixelUV.x *= currentTex.width;
                pixelUV.y *= currentTex.height;

                Debug.Log((int)pixelUV.x + ", " + (int)pixelUV.y);

                currentTex.SetPixel((int)pixelUV.x, (int)pixelUV.y, resultTex.GetPixel((int)pixelUV.x, (int)pixelUV.y));
                currentTex.Apply();
            }

            else
            {
                Debug.Log("Nope");
            }*/
        }
    }


    private void OnMouseDrag()
    {
        if (!complete)
        {
            /*if (Physics.Raycast(GetMouseWorldPosition(), Vector3.down, out RaycastHit hit))
            {
                Vector2 pixelUV = hit.textureCoord;

                pixelUV.x *= currentTex.width;
                pixelUV.y *= currentTex.height;

                currentTex.SetPixel((int)pixelUV.x, (int)pixelUV.y, resultTex.GetPixel((int)pixelUV.x, (int)pixelUV.y));
                currentTex.Apply();
            }*/
        }
    }
}
