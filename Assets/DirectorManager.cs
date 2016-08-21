using UnityEngine;
using System.Collections;

public class DirectorManager : MonoBehaviour {
	float timer = 120;

	Vector3 step1_position;
	public GameObject step2_rightScreen;
	public GameObject step3_light;
	public GameObject step3_middleScreen;
	public GameObject step4_light;
	public GameObject step4_middleScreen;
	public GameObject step5_particle;
	public GameObject step5_rightScreen;
	public GameObject step6_particle;
	public GameObject step6_particle2;
	public GameObject step7_exploder;
	public GameObject step7_colliderForChair;
	public TextTimer step7_timer;
	public GameObject step8_particle;

	int step = 0;
	// Use this for initialization
	void Start () {
		step1_position = transform.localPosition;
		step = 1;
	}
	
	// Update is called once per frame
	void Update () {
		timer -= Time.deltaTime;
		if (timer >= 110) {
			//Step1
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.020f, 0.020f), Random.Range (-0.050f, 0.050f), Random.Range (-0.020f, 0.020f));
		}
		else if(timer >= 109){
			//Step2
			if (step == 1) {
				step = 2;
			}
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.100f, 0.100f), Random.Range (-0.100f, 0.100f), Random.Range (-0.100f, 0.100f));
		}
		else if(timer >= 108.8f){
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.050f, 0.050f), Random.Range (-0.050f, 0.050f), Random.Range (-0.050f, 0.050f));
		}
		else if(timer >= 108.6f){
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.020f, 0.020f), Random.Range (-0.050f, 0.050f), Random.Range (-0.020f, 0.020f));
		}
		else if(timer >= 108){
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.010f, 0.010f), Random.Range (-0.050f, 0.010f), Random.Range (-0.020f, 0.010f));
		}
		else if(timer >= 107.5f){
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.005f, 0.005f), Random.Range (-0.005f, 0.005f), Random.Range (-0.005f, 0.005f));
		}
		else if(timer >= 105){
			//Step3
			if (step == 2) {
				step = 3;
				transform.localPosition = step1_position;
				step3_light.SetActive (true);
				step2_rightScreen.SetActive (false);
			}
			step3_light.SetActive (false);
		}
		else if(timer >= 104.80){
			step3_light.SetActive (true);
		}
		else if(timer >= 104.70){
			step3_light.SetActive (false);
			step3_middleScreen.SetActive (false);
		}
		else if(timer >= 104.1f){
			step3_light.SetActive (true);
		}
		else if(timer >= 103.37f){
			step3_light.SetActive (false);
		}
		else if(timer >= 102.8f){
			step3_light.SetActive (true);
		}
		else if (timer >= 102.3f) {
			//Step4
			if (step == 3) {
				step = 4;
				step1_position = transform.localPosition;
				step4_light.SetActive (true);
				step4_middleScreen.SetActive (true);
			}
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.020f, 0.020f), Random.Range (-0.050f, 0.050f), Random.Range (-0.020f, 0.020f));
		}
		else if(timer >= 100){
			//Step5
			if (step == 4) {
				step = 5;
				transform.localPosition = step1_position;
				step5_particle.SetActive (true);
				step5_rightScreen.SetActive (true);
			}
		}
		else if(timer >= 96){
			//Step6
			if (step == 5) {
				step = 6;
				step6_particle.SetActive (true);
				step6_particle2.SetActive (true);
			}
		}
		else if(timer >= 95.4f){
			//Step7
			if (step == 6) {
				step = 7;
				step1_position = transform.localPosition;
				step7_exploder.SetActive (true);
				step7_colliderForChair.layer = 0;
				step7_timer.secondsLeft = 10;
			}
			transform.localPosition = step1_position + new Vector3 (Random.Range (-0.020f, 0.020f), Random.Range (-0.050f, 0.050f), Random.Range (-0.020f, 0.020f));
		}
		else if(timer >= 93){
			//Step8
			if (step == 7) {
				step = 8;
				transform.localPosition = step1_position;
				step8_particle.SetActive (true);
			}
		}
	}
}
