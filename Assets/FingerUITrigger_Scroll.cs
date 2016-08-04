using UnityEngine;
using System.Collections;

public class FingerUITrigger_Scroll : MonoBehaviour
{
	public float minS;
	public float maxS;

	float oldFingerS;
	Transform finger;
	// Use this for initialization
	void Start ()
	{
	}

	// Update is called once per frame
	void Update ()
	{
		if (finger) {
			//Pressed
			float f = finger.position.y - oldFingerS;
			if (f != 0) {
				transform.position += new Vector3 (0, f, 0);
				oldFingerS = finger.position.y;
			}
		}
	}

	void OnTriggerEnter (Collider other)
	{
		print (other);
		if (other.gameObject.layer == 8 && !finger) {
			finger = other.transform;
			oldFingerS = finger.position.y;
		}
	}

	void OnTriggerExit (Collider other)
	{
		if (other.gameObject.layer == 8) {
			finger = null;
		}
	}
}
