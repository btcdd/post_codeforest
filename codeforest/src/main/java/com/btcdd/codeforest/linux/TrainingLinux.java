package com.btcdd.codeforest.linux;

public class TrainingLinux {
	
	private Process process;
	
	public void saveProblemAndSubProblem(Long authUserNo, Long problemNo, Long[] subProblemArray) {
		try {
			process = Runtime.getRuntime().exec("mkdir userDirectory/user10050/prob83");
			
			for(int i = 0; i < subProblemArray.length; i++) {
				process = Runtime.getRuntime().exec("mkdir userDirectory/user" + authUserNo + "/prob" + problemNo + "/subProb" + subProblemArray[i]);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}