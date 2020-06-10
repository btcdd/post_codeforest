package com.btcdd.codeforest.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.btcdd.codeforest.service.CodingTestService;
import com.btcdd.codeforest.vo.ProblemVo;
import com.btcdd.security.Auth;

@Controller
@RequestMapping("/codingtest")
public class CodingTestController {

	@Autowired
	private CodingTestService testService;

	@Auth
	@RequestMapping(value="", method=RequestMethod.GET)
	public String training(Model model) {
		List<ProblemVo> list = testService.selectTestList();
		
		List<ProblemVo> list1 = new ArrayList<ProblemVo>();
		List<ProblemVo> list2 = new ArrayList<ProblemVo>();
		List<ProblemVo> list3 = new ArrayList<ProblemVo>();
		for(ProblemVo vo : list) {
			if(vo.getPriority() == 1) {
				list1.add(vo);
			}
			if(vo.getPriority() == 2) {
				list2.add(vo);
			}
			if(vo.getPriority() == 3) {
				list3.add(vo);
			}
		}
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
		model.addAttribute("list3", list3);

		HashMap<Long, Long> map = new HashMap<Long, Long>();

		Calendar today = Calendar.getInstance();
		Calendar d = Calendar.getInstance();
		today.set(Calendar.MONTH, today.get(Calendar.MONTH)+1);

		String[] fake_token = null;
		String[] token = null;

		long l_today = today.getTimeInMillis() / (24*60*60*1000);
		long l_dday = 0;
		long result = 0;
		
		for(ProblemVo vo : list) {
			if(vo.getPriority() == 2) {
				fake_token = (vo.getStartTime()+"").split(" ");
				token = fake_token[0].split("-");
				d.set(Integer.parseInt(token[0]), Integer.parseInt(token[1]), Integer.parseInt(token[2]));
				l_dday = d.getTimeInMillis() / (24*60*60*1000);
				result = l_today - l_dday;
				map.put(vo.getNo(), result);
			}
		}
		
		model.addAttribute("dday", map);

		return "codingtest/list";
	}
	
	@Auth
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String testWrite() {

		return "codingtest/write";
	}
	
	@Auth
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String testWritePost() {

		return "codingtest/write";
	}
}