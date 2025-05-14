package com.ict.project.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.ManagerService;

// 작성자 : 김재겸
@Controller
public class ManagerController {
    @Autowired
    private ManagerService managerService;

    // Permission 페이지 호출과 동시에 리스트 보여주기
    @GetMapping("/Permission")
    public ModelAndView goToThePermissionAndView(
            HttpSession session,
            HttpServletResponse response) throws IOException {
    	
    	String emp_idx = (String) session.getAttribute("emp_idx");
        session.setAttribute("emp_idx", emp_idx);
        ModelAndView mv = new ModelAndView("Permission/permission");

        try {
            List<Map<String, String>> userList = managerService.getAllPermissionList();
            if (userList != null && !userList.isEmpty()) {
                mv.addObject("userList", userList);
            } else {
                mv.addObject("userList", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
            mv.setViewName("error");
        }

        return mv;
    }

    /**
     * 권한 업데이트를 처리하는 메서드
     * @param changedPermissions 프론트엔드에서 전달받은 변경된 권한 정보
     *                          Map<String, Map<String, Boolean>> 형태
     *                          - 첫 번째 String: 사용자 ID (emp_idx)
     *                          - 두 번째 Map: 권한 타입과 값 (예: {"canAccessEmployee": true})
     * @return 업데이트 결과를 담은 Map 객체
     */
    @PostMapping("/updatePermissions")
    @ResponseBody
    public Map<String, Object> updatePermissions(@RequestBody Map<String, Map<String, Boolean>> changedPermissions) {
        Map<String, Object> result = new HashMap<>();
        try {
            for (String userId : changedPermissions.keySet()) {
                Map<String, Boolean> permissions = changedPermissions.get(userId);
                Map<String, Integer> intPermissions = new HashMap<>();
                
                // 모든 권한 타입에 대해 기본값 0 설정
                intPermissions.put("can_access_employee", 0);
                intPermissions.put("can_access_worktype", 0);
                intPermissions.put("can_access_personnel", 0);
                intPermissions.put("can_access_salary", 0);
                intPermissions.put("can_access_vacation", 0);
                
                // 변경된 권한만 업데이트
                for (Map.Entry<String, Boolean> entry : permissions.entrySet()) {
                    String key = entry.getKey();
                    String dbColumn;
                    
                    switch (key) {
                        case "canAccessEmployee":
                            dbColumn = "can_access_employee";
                            break;
                        case "canAccessWorktype":
                            dbColumn = "can_access_worktype";
                            break;
                        case "canAccessPersonnel":
                            dbColumn = "can_access_personnel";
                            break;
                        case "canAccessSalary":
                            dbColumn = "can_access_salary";
                            break;
                        case "canAccessVacation":
                            dbColumn = "can_access_vacation";
                            break;
                        default:
                            dbColumn = key;
                    }
                    intPermissions.put(dbColumn, entry.getValue() ? 1 : 0);
                }
                managerService.updatePermissions(userId, intPermissions);
            }
            result.put("status", "success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("status", "error");
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    // 직원의 전자결제 시스템으로 넘어가기
    @GetMapping("/PermissionRequest")
    public ModelAndView goToTheElectronicPaymentAndView(
            HttpSession session,
            HttpServletResponse response) throws IOException {
    	
    	String emp_idx = (String) session.getAttribute("emp_idx");
        session.setAttribute("emp_idx", emp_idx);
        ModelAndView mv = new ModelAndView("Permission/permissionRequest");
        return mv;
    }
    
    
}