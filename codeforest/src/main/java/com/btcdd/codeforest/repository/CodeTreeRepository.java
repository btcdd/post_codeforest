package com.btcdd.codeforest.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.btcdd.codeforest.vo.CodeVo;
import com.btcdd.codeforest.vo.SavePathVo;
import com.btcdd.codeforest.vo.SaveVo;
import com.btcdd.codeforest.vo.SubProblemVo;

@Repository
public class CodeTreeRepository {
	
	@Autowired
	private SqlSession sqlSession;

	public void saveUserAndProblem(Map<String, Object> map) {
		sqlSession.update("codetree.saveUserAndProblem", map);
	}

	public void savePath(Map<String, Object> map) {
		sqlSession.update("codetree.savePath", map);
	}

	public void saveCode(Map<String, Object> map) {
		sqlSession.update("codetree.saveCode", map);
	}

	public List<CodeVo> findCode(Long subProblemNo) {
		return sqlSession.selectList("codetree.findCode", subProblemNo);
	}

	public Long findSaveNo(Map<String, Object> map) {
		return sqlSession.selectOne("codetree.findSaveNo", map);
	}

	public List<SubProblemVo> findSubProblemNo(Long problemNo) {
		return sqlSession.selectList("codetree.findSubProblemNo", problemNo);
	}

	// 고치던거!
	public void insertSavePath(Long saveNo, List<SubProblemVo> subProblemList) {
		sqlSession.insert("codetree.insertSavePath");
	}

	public int getTotalCount(String keyword,Long authUserNo) {
		Map<String,Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("authUserNo", authUserNo);
		return sqlSession.selectOne("codetree.totalCount",map);
	}

	public List<SaveVo> selectSaveNoList(int displayPost, int postNum,String keyword,Long authUserNo) {
		Map<String,Object> map = new HashMap<>();
		map.put("displayPost",displayPost);
		map.put("postNum",postNum);
		map.put("keyword", keyword);
		map.put("authUserNo", authUserNo);
		return sqlSession.selectList("codetree.selectSaveNoList", map);
	}


	public SaveVo findSaveVo(Long saveNo) {
		return sqlSession.selectOne("codetree.findSaveVo",saveNo);
	}

	public List<SavePathVo> findSavePathList(Long saveNo) {
		return sqlSession.selectList("codetree.findSavePathList", saveNo);
	}

	public List<CodeVo> findCodeList(Long savePathNo) {
		return sqlSession.selectList("codetree.findCodeList", savePathNo);
	}

	public List<SubProblemVo> findSubProblemList(Long problemNo) {
		return sqlSession.selectList("codetree.findSubProblemList", problemNo);
	}

	public int insertFile(Long savePathNo, String language, String fileName) {
		Map<String,Object> map = new HashMap<>();
		map.put("savePathNo", savePathNo);
		map.put("language", language);
		map.put("fileName", fileName);
		return sqlSession.insert("codetree.insertFile", map);
	}

	public Long findProblemNo(Long subProblemNo) {
		return sqlSession.selectOne("codetree.findProblemNo", subProblemNo);
	}


//	public int getTotalCount(String keyword) {
//		return sqlSession.selectOne("codetree.totalCount",keyword);
//	}

}