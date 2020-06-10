package com.btcdd.codeforest.runlanguage;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

public class RunJava {
	
	private Long authUserNo = 1L;
	private Long problemNo = 2L;
	private Long subProblemNo = 4L;
	
	private StringBuffer buffer;
	private Process process;
	private BufferedReader bufferedReader;
	private BufferedReader bufferedReader2;
	private StringBuffer readBuffer;
	
	private File file;
	private BufferedWriter bufferWriter;
	
	private final String FILENAME = "Test.java";
	
	public void createFileAsSource(String source) {
		try {
			file = new File(FILENAME);
			bufferWriter = new BufferedWriter(new FileWriter(file, false));
			
			bufferWriter.write(source);
			bufferWriter.flush();
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(1);
		} finally {
			try {
				bufferWriter.close();
				file = null;
			} catch (IOException e) {
				e.printStackTrace();
				System.exit(1);
			}
		}
	}
	
	public void createFileAsSource(String source, String fileName) {
		try {
			file = new File(fileName);
			bufferWriter = new BufferedWriter(new FileWriter(file, false));
			
			bufferWriter.write(source);
			bufferWriter.flush();
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(1);
		} finally {
			try {
				bufferWriter.close();
				file = null;
			} catch (IOException e) {
				e.printStackTrace();
				System.exit(1);
			}
		}
	}
	
	public String execCompile() {
		try {
			process = Runtime.getRuntime().exec("javac -d . Test.java");
			
			bufferedReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
			String line = null;
			readBuffer = new StringBuffer();
			
			while((line = bufferedReader.readLine()) != null) {
				readBuffer.append(line);
				readBuffer.append("\n");
			}
			return readBuffer.toString();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String execCommand() {
		long start = System.currentTimeMillis();
		long end = start + 3*1000; // 60 seconds * 1000 ms/sec
		
		
		try {
			while (System.currentTimeMillis() < end) {
				process = Runtime.getRuntime().exec(runClass());
				
				bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
				bufferedReader2 = new BufferedReader(new InputStreamReader(process.getErrorStream()));
							
				String line = null;
				readBuffer = new StringBuffer();
				
				while((line = bufferedReader.readLine()) != null) {
					readBuffer.append(line);
					readBuffer.append("\n");
				}
				while((line = bufferedReader2.readLine()) != null) {
					readBuffer.append(line);
					readBuffer.append("\n");
				}
			return readBuffer.toString();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	private String runClass() {
		buffer = new StringBuffer();
		
		buffer.append("java -cp . Test");
		
		return buffer.toString();
	}
	
	public String execSave(String cmd) {
		try {
			process = Runtime.getRuntime().exec(cmd);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}