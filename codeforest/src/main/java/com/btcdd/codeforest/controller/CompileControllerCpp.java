package com.btcdd.codeforest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.btcdd.codeforest.dto.JsonResult;
import com.btcdd.codeforest.runlanguage.RunCpp;

@Controller
@RequestMapping("/compile")
public class CompileControllerCpp {
	
	StringBuffer buffer = new StringBuffer();

	RunCpp rtt = new RunCpp();
	
	@ResponseBody
	@PostMapping("/cpp")
	public JsonResult compileCpp(@RequestParam String code) {
		rtt.createFileAsSource(code);
		rtt.execCompile();
		String result = rtt.execCommand();
		String errorResult = rtt.execCompile();
		
		String[] res = new String[2];
		res[0] = result;
		res[1] = errorResult;
		
		return JsonResult.success(res);
	}
}