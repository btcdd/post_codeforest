package com.btcdd.codeforest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.btcdd.codeforest.dto.JsonResult;
import com.btcdd.codeforest.runlanguage.RunJava;

@Controller
@RequestMapping("/compile")
public class CompileControllerJava {
	
	StringBuffer buffer = new StringBuffer();

	RunJava rtt = new RunJava();
	
	@ResponseBody
	@PostMapping("/java")
	public JsonResult javaCompile(@RequestParam String code) {
		rtt.createFileAsSource(code);
		
		RunJava rtt = new RunJava();

		rtt.execCompile();
		String result = rtt.execCommand();
		String errorResult = rtt.execCompile();
		
		String[] res = new String[2];
		res[0] = result;
		res[1] = errorResult;
		
		doSomething();
		
		return JsonResult.success(res);
	}
	
	public void doSomething() {
        
        System.out.println("프로세스 시작");
        
        // 현재 Thread 를 변수에 저장
        final Thread currentThread = Thread.currentThread();
        
        // 일정시간 지나면 현재 Thread 를 종료
        Thread killerThread = new Thread() {
            
            @Override
            public void run() {
                try {
                    // 1분 후 종료
                    Thread.sleep(3000);
                    rtt.shutdown();
                    
                } catch (InterruptedException e) {
                    // 킬러 Thread 종료(killerThread.interrupt())하면 이곳에 도달
                    rtt.shutdown();
                	System.out.println("프로세스 종료");
                    return;
                    
                } catch (Exception e) {
                    // 무시
                }
                
                try {
                    // 일정시간이 지나면 이곳에 도달
                    System.out.println("시간초과로 인해 종료합니다.");
                    rtt.shutdown();
                    // 현재 Thread 를 종료
                    currentThread.interrupt();
                    
                } catch (Exception e) {
                    // 무시
                }
            }
        };
            
            
        try {
            // 일정시간 지나면 현재 Thread 를 종료
            killerThread.start();
            
            int limit = 999999;
            for (int i=0; i<limit; i++) {
                System.out.println("진행중... (" + (i+1) + " / " + limit + ")");
                Thread.sleep(1000);
            }
            
        } catch (InterruptedException e) {
        	rtt.shutdown();
            System.out.println("프로세스가 너무 오래 실행되고 있습니다. 프로세스를 종료합니다.");
        } catch (Exception e) {
            e.printStackTrace();
            
        } finally {
            // 킬러 Thread 종료
            try {
                killerThread.interrupt();
            } catch (Exception e) {
                // 무시
            }
        }
    }
	
}