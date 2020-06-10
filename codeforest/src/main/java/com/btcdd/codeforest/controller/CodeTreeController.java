package com.btcdd.codeforest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/codetree")
public class CodeTreeController {
	
	@RequestMapping(value="", method=RequestMethod.GET)
	public String mypage() {
		return "redirect://localhost:9999";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.GET)
	public String saveCode() {
		
		
		return "redirect://localhost:9999";
	}
}
/*
 * @RequestMapping(value="", method=RequestMethod.GET) public String mypage() {
 * return "codetree/codetree"; }
 */