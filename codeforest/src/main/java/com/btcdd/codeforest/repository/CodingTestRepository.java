package com.btcdd.codeforest.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.btcdd.codeforest.vo.ProblemVo;
import com.btcdd.codeforest.vo.UserVo;

@Repository
public class CodingTestRepository {
	
	@Autowired
	private SqlSession sqlSession;

	public List<ProblemVo> selectTestList() {
		return sqlSession.selectList("codingtest.selectTestList");
	}

	public UserVo findUserByEmail(String userEmail) {
		return sqlSession.selectOne("codingtest.findUserByEmail", userEmail);
	}

	
}