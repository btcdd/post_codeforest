package com.btcdd.codeforest.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btcdd.codeforest.repository.CodeTreeRepository;
import com.btcdd.codeforest.runlanguage.RunJavaCodeTree;
import com.btcdd.codeforest.vo.CodeVo;
import com.btcdd.codeforest.vo.SavePathVo;
import com.btcdd.codeforest.vo.SubProblemVo;

@Service
public class CodeTreeService {
	
	@Autowired
	private CodeTreeRepository codetreeRepository;
	
	private Process process;

	public Map<String, Object> saveUserCodeAndProblems(Long authUserNo, Long problemNo, List<SavePathVo> savePathVoList, List<CodeVo> codeVoList) {
		Map<String, Object> map = new HashMap<>();
		map.put("authUserNo", authUserNo);
		map.put("problemNo", problemNo);
		
		// 저장 테이블에 회원 번호와 문제 모음 번호를 저장
		codetreeRepository.saveUserAndProblem(map);

		// 저장 경로 테이블에 저장
		map.put("savePathVoList", savePathVoList);
		codetreeRepository.savePath(map);
		
		// 코드 테이블에 저장
		map.put("codeVoList", codeVoList);
		
		codetreeRepository.saveCode(map);
		
		return map;
	}

	public void compilePackage(Long authUserNo, Long problemNo, Long subProblemNo, List<CodeVo> codeVoListTrue) {
		try {
//			process = Runtime.getRuntime().exec("mkdir userDirectory/user" + authUserNo + 
//												"/prob" + problemNo + "/subProb" + savePathVo.getSubProblemNo() + 
//												"/" + codeVoListTrue.get(0).getLanguage() + "\n");
		
			
			RunJavaCodeTree rjct = new RunJavaCodeTree(authUserNo, problemNo, subProblemNo);
			
			for(int i = 0; i < codeVoListTrue.size(); i++) {
				rjct.createFileAsSource(codeVoListTrue.get(i).getCode(), codeVoListTrue.get(i).getFileName());
			}
			
			rjct.execCompile(codeVoListTrue);
//			String result = rjct.execCommand();
//			String errorResult = rjct.execCompile(codeVoListTrue);
//			
//			String[] res = new String[2];
//			res[0] = result;
//			res[1] = errorResult;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public List<CodeVo> findCode(Long subProblemNo) {
		return codetreeRepository.findCode(subProblemNo);
	}

	public void saveUserCodeAndProblems(Long authUserNo, Long problemNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("authUserNo", authUserNo);
		map.put("problemNo", problemNo);
		
		// 저장 테이블에 회원 번호와 문제 모음 번호를 저장
		codetreeRepository.saveUserAndProblem(map);
		Long saveNo = codetreeRepository.findSaveNo(map);
		
		List<SubProblemVo> subProblemList = codetreeRepository.findSubProblemNo(problemNo);
		map.put("saveNo", saveNo);
		map.put("subProblemList", subProblemList);
//		codetreeRepository.insertSavePath(saveNo, subProblemList);

//		// 저장 경로 테이블에 저장
//		map.put("savePathVoList", savePathVoList);
//		codetreeRepository.savePath(map);
//		
//		// 코드 테이블에 저장
//		map.put("codeVoList", codeVoList);
//		
//		codetreeRepository.saveCode(map);
	}
}