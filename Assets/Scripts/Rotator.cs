using UnityEngine;
using System.Collections;

public class Rotator : MonoBehaviour {
	public Vector3 v3;
	// Update is called once per frame
	void Update () {
		transform.Rotate (v3 * Time.deltaTime);
	}
}
