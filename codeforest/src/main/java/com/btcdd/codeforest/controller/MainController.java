package com.btcdd.codeforest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.btcdd.security.Auth;

@Controller
public class MainController {
	
	@RequestMapping({"", "/main"})
	public String index(Model model) {
		return "main/main-out";
	}
	
	@Auth
	@RequestMapping("/main-in")
	public String indexA(Model model) {
		return "main/main";
	}
}