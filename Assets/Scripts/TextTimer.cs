using UnityEngine;
using System.Collections;

public class TextTimer : MonoBehaviour {
	TextMesh textTimer;
	public float secondsLeft = 60;
	// Use this for initialization
	void Start () {
		textTimer = GetComponent<TextMesh> ();
	}
	
	// Update is called once per frame
	void Update () {
		if (secondsLeft > 0) {
			secondsLeft -= Time.deltaTime;
			if (secondsLeft <= 0) {
				//Over
				textTimer.text = "00:00"; 
			} else {
				textTimer.text = TransferTimer (secondsLeft); 
			}
		}
	}

	public string TransferTimer(float t){
		string s = "";
		int tCheck = 0;
		//Timer
		tCheck = Mathf.FloorToInt(t);
		if (tCheck < 10) {
			s += "0" + tCheck;
		} else {
			s += tCheck;
		}
		s += ":" ;
		//0-9
		tCheck = Mathf.FloorToInt ((t - Mathf.FloorToInt (t)) * 100);
		if (tCheck < 10) {
			s += "0" + tCheck;
		} else {
			s += tCheck;
		}
		return s;
	}
}
