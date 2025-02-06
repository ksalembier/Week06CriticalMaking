using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 5f;
    private Vector2 movement;
    private Rigidbody2D rb; 
    private Animator animator;
    private const string horizontal = "Horizontal";
    private const string lastHorizontal = "LastHorizontal";

    void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
    }

    private void Update()
    {
        movement.Set(InputManager.movement.x, InputManager.movement.y);
        rb.velocity = movement * moveSpeed;
        animator.SetFloat(horizontal, movement.x);

        if (movement != Vector2.zero)
        {
            animator.SetFloat(lastHorizontal, movement.x);
        }
    }
}