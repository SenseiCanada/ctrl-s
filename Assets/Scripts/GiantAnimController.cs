using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

public class GiantAnimController : MonoBehaviour
{
    [SerializeField]
    protected Animator animator;

    private float idleTimer;

    // Start is called before the first frame update
    void Start()
    {
        idleTimer = Random.Range(6f, 15f);
    }

    // Update is called once per frame
    void Update()
    {
        UpdateIdle();
    }

    void UpdateIdle()
    {
        if (idleTimer > 0f)
        {
            idleTimer -= Time.deltaTime;
            animator.SetBool("isSad", false);
        }
        else
        {
            animator.SetBool("isSad", true);
            idleTimer = Random.Range(6f, 15f);
        }
           
    }
   
}
