using UnityEngine;
using System.Collections;

public class SpriteAnimation : MonoBehaviour {
	public Sprite[] frames;
	public float frameInterval = 0.3f;
	SpriteRenderer render;
	// Use this for initialization
	void Start () {
		render = GetComponent<SpriteRenderer> ();
	}
	
	// Update is called once per frame
	void Update () {
		if (frames.Length == 0)
			return;

		int index = Mathf.FloorToInt (Time.time / frameInterval);
		index = index % frames.Length;
		render.sprite = frames [index];
	}
}
