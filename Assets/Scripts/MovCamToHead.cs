using UnityEngine;
using System.Collections;

public class MovCamToHead : MonoBehaviour {
	public Transform headJoint;

	public float distX = -0.5f;

	public float distZ = 0f;
	public float distY = -1f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		Vector3 v = headJoint.position;
		v.x -= distX;
		v.z -= distZ;
		v.y -= distY;
		transform.position = v;
	}
}
