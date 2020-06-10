package com.btcdd.codeforest.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.btcdd.codeforest.service.CodeTreeService;
import com.btcdd.codeforest.service.CodingTestService;
import com.btcdd.codeforest.service.MypageService;
import com.btcdd.codeforest.service.TrainingService;

@RestController("CodeTreeController")
@RequestMapping("/api/codetree")
public class CodeTreeController {
	@Autowired
	private TrainingService trainingService;
	
	@Autowired 
	private CodeTreeService codetreeService;
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired 
	private CodingTestService testService;
	
}



/*
UserVo _authUser = null;
@GetMapping("")// main-header에서 처음 열때
public JsonResult codeTree(HttpSession session) {
	Map<String, Object> map = new HashMap<>();
	UserVo authUser = (UserVo)session.getAttribute("authUser");
	_authUser = authUser;
	map.put("authUser", authUser);
	return JsonResult.success(map);
}	
@PostMapping("/auth/{userEmail}") //리액트에서 CodeTreeErrorPage와 통신하는 위치
public JsonResult codeTreeAccess(@PathVariable("userEmail") String userEmail) {
	
	Map<String, Object> map = new HashMap<>();
	
	boolean exist = trainingService.existUser(userEmail); //유저가 있는지 체크
	if(!exist || userEmail=="undifiend") {
		System.out.println("유저가 존재하지 않는다!!!");
		map.put("result", "emptyUser");
		return JsonResult.success(map);
	}
	System.out.println("_authUser>>>>"+_authUser);
	if(_authUser == null) {
		System.out.println("잘못된 접근 경로 !!!");
		map.put("result", "wrongAccess");
		return JsonResult.success(map);
	}
	System.out.println("정상 경로 !!!");
	map.put("result", "ok");
	
	return JsonResult.success(map);
}
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
@PostMapping("/list/{userEmail}/{saveNo}") //패키지안의 파일을 클릭했을때 오는 경로
public JsonResult codeFile(
		@PathVariable("userEmail") String userEmail
		,@PathVariable("saveNo") Long saveNo) {
	System.out.println("userEmail>>"+userEmail);
	System.out.println("saveNo>>"+saveNo);
	
	Map<String, Object> map = new HashMap<>();
	
	List<SavePathVo> savePathVoList = trainingService.selectSavePath(saveNo);
	Long[] savePathNoArray = new Long[savePathVoList.size()];
	for(int i = 0; i < savePathVoList.size(); i++) {
	savePathNoArray[i] = savePathVoList.get(i).getNo();
	}
	List<CodeVo> codeVoList = trainingService.selectCode(savePathNoArray);
	map.put("savePathVoList",savePathVoList);
	map.put("codeVoList",codeVoList);		
	
	return JsonResult.success(map);
}
@PostMapping("/list/save/{userEmail}/{problemNo}")//저장 버튼 누를때 오는 경로
public JsonResult codeSave(
		@PathVariable("userEmail") String userEmail,
		@PathVariable("problemNo") Long problemNo,
		@RequestBody Map<String, Object> saveDB) {
	System.out.println("userEmail>>"+userEmail);
	System.out.println("problemNo>>"+problemNo);
	System.out.println("codeSave  왔다!!");
	JSONParser parser = new JSONParser();
	JSONObject obj = null;
	try {
		obj = (JSONObject) parser.parse((String) saveDB.get("body"));
	} catch (ParseException e) {
		e.printStackTrace();
	}		
	
	String code = (String) obj.get("code");
	String language = (String) obj.get("language");
	List<SavePathVo> savePathVoList = (List<SavePathVo>) obj.get("savePathVoList");
	List<CodeVo> codeVoList = (List<CodeVo>) obj.get("codeVoList");
	System.out.println("code>>>"+code);
	System.out.println("language>>>"+language);
	System.out.println("savePathVoList>>>"+savePathVoList);
	System.out.println("codeVoList>>>"+codeVoList);
	
	//////////////////////////////////
	// 관우 유진 코드
	
	UserVo authUser = testService.findUserByEmail(userEmail);
	
	Map<String, Object> map = codetreeService.saveUserCodeAndProblems(authUser.getNo(), problemNo, savePathVoList, codeVoList);
	
	
	// 컴파일 부분
	//////////////////////////////
	
	Long subProblemNo = 4L;
	
	List<CodeVo> codeVoListTrue = codetreeService.findCode(subProblemNo);
	
	codetreeService.compilePackage(authUser.getNo(), problemNo, subProblemNo, codeVoListTrue);
	
	
	///////////////////////
	
	////////////////////////////////////
	
	
	return JsonResult.success(null); 
}
*/