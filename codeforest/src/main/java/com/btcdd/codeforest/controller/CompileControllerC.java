package com.btcdd.codeforest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.btcdd.codeforest.dto.JsonResult;
import com.btcdd.codeforest.runlanguage.RunC;

@Controller
@RequestMapping("/compile")
public class CompileControllerC {
	
	StringBuffer buffer = new StringBuffer();

	RunC rtt = new RunC();
	
	@ResponseBody
	@PostMapping("/c")
	public JsonResult compileC(@RequestParam String code) {
		rtt.createFileAsSource(code);
		
		RunC rtt = new RunC();

		rtt.execCompile();
		String result = rtt.execCommand();
		
		String errorResult = rtt.execCompile();
		
		String[] res = new String[2];
		res[0] = result;
		res[1] = errorResult;
		
		return JsonResult.success(res);
	}
	
	@ResponseBody
	@PostMapping("/c/save")
	public JsonResult compileSaveC(@RequestParam String code) {
		
		String[] token = code.split("\n");
		
		for(int i = 0; i < token.length; i++) {
			buffer.append(token[i] + "\n");
		}
		rtt.createFileAsSource(code);
		
		String test = "success";
		
		return JsonResult.success(test);
	}
	
	@ResponseBody
	@PostMapping("/c/compile")
	public JsonResult cCompileexam() {

		RunC rtt = new RunC();

		String result = rtt.execCompile();

		return JsonResult.success(result);
	}
}