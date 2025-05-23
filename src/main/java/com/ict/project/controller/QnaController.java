package com.ict.project.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.common.QnaPaeging;
import com.ict.project.service.QnaService;
import com.ict.project.vo.personnel.pFile.QuestionVO;

@Controller
public class QnaController {

		@Autowired
		private QnaService qnaService;
		
	
		@Autowired
		private QnaPaeging paging;
	
		@GetMapping("/qna")
		public ModelAndView getQna(HttpSession session,
		        @RequestParam(value = "nowPage", required = false, defaultValue = "1") int nowPage) {

		    String empIdx = (String) session.getAttribute("emp_idx");
		    String deptName = (String) session.getAttribute("dept_name");

		    QnaPaeging paging = new QnaPaeging();
		    paging.setNowPage(nowPage);
		    
		    int totalCount;
		    List<Map<String, Object>> qnaList;

		    if ("관리자".equals(deptName) || "슈퍼관리자".equals(deptName)) {
		        totalCount = qnaService.getTotalCount();
		    } else {
		        totalCount = qnaService.getTotalCountByEmpIdx(empIdx);
		    }

		    paging.setTotalRecord(totalCount);

		    // 전체 페이지 수 계산
		    int totalPage = totalCount / paging.getNumPerPage();
		    if (totalCount % paging.getNumPerPage() != 0) {
		        totalPage++;
		    }
		    paging.setTotalPage(totalPage);

		    // offset 계산
		    paging.setOffset((nowPage - 1) * paging.getNumPerPage());

		    // 블록 계산
		    int beginBlock = ((nowPage - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1;
		    int endBlock = beginBlock + paging.getPagePerBlock() - 1;
		    if (endBlock > totalPage) endBlock = totalPage;
		    paging.setBeginBlock(beginBlock);
		    paging.setEndBlock(endBlock);
		    

		    
		    // 페이징 처리된 리스트 불러오기
		    if ("관리자".equals(deptName) || "슈퍼관리자".equals(deptName)) {
		        qnaList = qnaService.getAllQnaPaging(paging);
		    } else {
		        qnaList = qnaService.getQnaByEmpIdxPaging(empIdx, paging);
		    }

		    ModelAndView mv = new ModelAndView();
		    mv.addObject("qnaList", qnaList);
		    mv.addObject("paging", paging);
		    mv.setViewName("QnA/Qna");
		    return mv;
		}
	
    @GetMapping("/qnaWrite")
    public ModelAndView getQnaWrite() {
    	return new ModelAndView("QnA/qnaWrite");
    }
    
    @PostMapping("/qnaWriteOk")
    public ModelAndView postQnaWrite(@RequestParam Map<String, Object> param, HttpSession session) {
        String emp_idx = (String) session.getAttribute("emp_idx");

        Map<String, Object> user = qnaService.getUserInfoByEmpIdx(emp_idx);
        param.put("emp_idx", emp_idx);
        param.put("emp_name", user.get("emp_name"));
        
        qnaService.insertQna(param);

        
        ModelAndView mv = new ModelAndView("QnA/qnaWrite");
        mv.addObject("writeComplete", true); 
        return mv;
    }
    
    @GetMapping("/qnaDetail")
    public ModelAndView getQnaDetail(@RequestParam("answer_id") String answer_id) {
    	QuestionVO qna = qnaService.getQnaDetail(answer_id); // 

        ModelAndView mv = new ModelAndView("QnA/qnaDetail");
        mv.addObject("qna", qna);
        return mv;
    }
    
    @PostMapping("/qnaUpdate")
    public ModelAndView getQnaUdate(QuestionVO qnavo) {
    	
    	ModelAndView mv = new ModelAndView();
    	
    	qnaService.updateQna(qnavo);
  
    	
    	mv.setViewName("redirect:/qna");
    	return mv;
    }
    
    
    @GetMapping("/qnaDelete")
    public ModelAndView getdeleteQna(QuestionVO qnavo){
    	ModelAndView mv = new ModelAndView();
    	qnaService.deleteQna(qnavo);
    	
    	mv.setViewName("redirect:/qna");
    	return mv;
    }
    
    
    
}