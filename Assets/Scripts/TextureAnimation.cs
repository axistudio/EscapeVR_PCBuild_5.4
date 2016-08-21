using UnityEngine;
using System.Collections;

public class TextureAnimation : MonoBehaviour {
	public Texture[] frames;
	public float frameInterval = 0.3f;
	Renderer render;
	// Use this for initialization
	void Start () {
		render = GetComponent<Renderer> ();
	}
	
	// Update is called once per frame
	void Update () {
		if (frames.Length == 0)
			return;

		int index = Mathf.FloorToInt (Time.time / frameInterval);
		index = index % frames.Length;
		render.material.mainTexture = frames [index];
	}
}
