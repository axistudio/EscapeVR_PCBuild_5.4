using UnityEngine;
using System.Collections;

public class FingerUITrigger : MonoBehaviour
{
	Transform finger;
	public GameObject currentPage;
	public GameObject nextPage;
	// Use this for initialization
	void Start ()
	{
	
	}
	
	// Update is called once per frame
	void Update ()
	{
	
	}

	void OnTriggerEnter (Collider other)
	{
		print (other);
		if (other.gameObject.layer == 8 && !finger) {
			finger = other.transform;
			buttonPressed ();
		}
	}

	void OnTriggerExit (Collider other)
	{
		if (other.gameObject.layer == 8) {
			finger = null;
		}
	}

	void buttonPressed ()
	{
		currentPage.SetActive (false);
		nextPage.SetActive (true);
	}
}
