package com.btcdd.codeforest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btcdd.codeforest.repository.CodingTestRepository;
import com.btcdd.codeforest.vo.ProblemVo;
import com.btcdd.codeforest.vo.UserVo;

@Service
public class CodingTestService {

	@Autowired
	private CodingTestRepository testRepository;

	public List<ProblemVo> selectTestList() {
		return testRepository.selectTestList();
	}

	public UserVo findUserByEmail(String userEmail) {
		return testRepository.findUserByEmail(userEmail);
	}
}