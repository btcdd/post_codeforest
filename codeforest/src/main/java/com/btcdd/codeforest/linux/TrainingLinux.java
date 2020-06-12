package com.btcdd.codeforest.linux;

public class TrainingLinux {
	
	private Process process;
	
	public void saveProblemAndSubProblem(Long authUserNo, Long problemNo, Long[] subProblemNoArray) {
		try {
			process = Runtime.getRuntime().exec("mkdir userDirectory/user" + authUserNo + "/prob" + problemNo);
			
			for(int i = 0; i < subProblemNoArray.length; i++) {
				process = Runtime.getRuntime().exec("mkdir userDirectory/user" + authUserNo + "/prob" + problemNo + "/subProb" + subProblemNoArray[i]);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}