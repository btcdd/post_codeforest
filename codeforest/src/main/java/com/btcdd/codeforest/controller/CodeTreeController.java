package com.btcdd.codeforest.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.btcdd.codeforest.service.CodeTreeService;
import com.btcdd.codeforest.vo.UserVo;
import com.btcdd.security.Auth;

@Auth
@Controller
@RequestMapping("/codetree")
public class CodeTreeController {
	@Autowired
	private CodeTreeService codeTreeService;
	

	@Auth
	@RequestMapping("/list")
	public String mypage() {
		return "codetree/list";
	}
	
	
}
/*
 * @RequestMapping(value="", method=RequestMethod.GET) public String mypage() {
 * return "codetree/codetree"; }
 */




/*
 @PostMapping("/list/{userEmail}") //code tree Home화면 띄울때 경로(리스트출력위해 필요)
public JsonResult codeTreeList(@PathVariable("userEmail") String userEmail) {
	Map<String, Object> map = new HashMap<>();
	
	List<SaveVo> saveVoList = trainingService.selectSaveNoList(_authUser.getNo());
	
	List<Long> copy = new ArrayList<>();
	for(SaveVo vo : saveVoList) {
		copy.add(vo.getProblemNo());
	}
	List<Long> problemNoArray = new ArrayList<>();
	for(Long no : copy) {
		if(!problemNoArray.contains(no)) {
			problemNoArray.add(no);
		}
	}
	//List<SubProblemVo> subProblemList = new ArrayList<>();
	Map<Long, Object> subProblemList = new HashMap<>();
	for(Long no : problemNoArray) {
		subProblemList.put(no, mypageService.findSubProblem(no));
	}
	System.out.println(subProblemList);
	map.put("subProblemList", subProblemList);
	map.put("saveVoList", saveVoList);
	return JsonResult.success(map);
} 
 * */
 