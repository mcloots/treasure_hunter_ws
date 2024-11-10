using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json;
using UnityEngine;

public class TargetLocation : MonoBehaviour
{
    public Location location;
    // Reference to the GameObject that has the ColorChanger script
    public GameObject arrowObject;

    public class Location
    {
        public int id;
        public string name;
        public string texture;
        public float latitude;
        public float longitude;
    }

    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {

    }

}
