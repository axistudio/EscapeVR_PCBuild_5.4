using UnityEngine;
using System.Collections;
using Exploder;

public class BlowUp : MonoBehaviour {

	public ExploderObject exploder;
	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {
		exploder.ExplodeRadius ();
	}
}
