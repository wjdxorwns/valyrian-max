package com.ict.project.controller;

import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.PersonnelService;
import com.ict.project.vo.management.RequestLoggingVO;
import com.ict.project.vo.personnel.UsersVO; // Assuming UsersVO exists and is used for session user

@Controller
public class PersonnelController {

	@Autowired
	private PersonnelService personnelService;

	// �쑕媛� 由ъ뒪�듃
	@GetMapping("/vacationList")
	public ModelAndView VacationListPageGO(HttpSession session) {

		UsersVO user = (UsersVO) session.getAttribute("userVO");
		if (user == null) {
			System.out.println("No user in session, redirecting to login");
			return new ModelAndView("redirect:/login");
		}

		ModelAndView mv = new ModelAndView("Vacation/vacationList");
		List<Map<String, Object>> vacationList = personnelService.getAllVacations();
		Map<String, Map<String, Object>> vacationMap = new HashMap<>();
		for (Map<String, Object> vacation : vacationList) {
			vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
		}

		// ModelAndView�뿉 Map 異붽�
		mv.addObject("vacationMap", vacationMap);
		return mv;
	}

	// �쑕媛� �듅�씤 諛� ��湲�
	@GetMapping("/vacationApproval")
	public ModelAndView vacationApprovalPageGO(HttpSession session) {

		UsersVO user = (UsersVO) session.getAttribute("userVO");
		if (user == null) {
			System.out.println("No user in session, redirecting to login");
			return new ModelAndView("redirect:/login");
		}

		ModelAndView mv = new ModelAndView("Vacation/vacationApproval");
		List<Map<String, Object>> vacationApproval = personnelService.getAllApprovals();
		Map<String, Map<String, Object>> vacationMap = new HashMap<>();
		for (Map<String, Object> vacation : vacationApproval) {
			vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
		}

		// ModelAndView�뿉 Map 異붽�
		mv.addObject("vacationMap", vacationMap);
		return mv;
	}

	@PostMapping("/updateVacationStatus")
    public ResponseEntity<Map<String, Boolean>> updateVacationStatus(@RequestBody List<Map<String, Object>> approvals) {
        System.out.println("Received /updateVacationStatus request with approvals: " + approvals);
        boolean success = personnelService.updateVacationStatuses(approvals);

        if (success) {
            for (Map<String, Object> approval : approvals) {
                RequestLoggingVO logging = new RequestLoggingVO();

                // 요청 번호 파싱 (중복 선언 제거!)
                Object requestIdxObj = approval.get("request_idx");
                int requestIdx = -1;

                if (requestIdxObj instanceof Number) {
                    requestIdx = ((Number) requestIdxObj).intValue();
                } else if (requestIdxObj != null) {
                    try {
                        requestIdx = Integer.parseInt(String.valueOf(requestIdxObj));
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid request_idx format: " + requestIdxObj);
                        continue;
                    }
                }

                logging.setRequest_idx(requestIdx);
                logging.setLogging_vacation(String.valueOf(approval.get("status"))); // 승인 또는 반려
                logging.setRequest_text(approval.get("comment") != null ? String.valueOf(approval.get("comment")) : ""); // 반려 사유

                personnelService.insertVacationLogging(logging);

                // ✅ 승인 시 request_vacation을 0으로 초기화
                if ("승인".equals(String.valueOf(approval.get("status")))) {
                    boolean resetResult = personnelService.resetVacationRequest(requestIdx);
                    System.out.println("Request reset result for request_idx " + requestIdx + ": " + resetResult);
                }
            }
        }

        Map<String, Boolean> response = new HashMap<>();
        response.put("success", success);
        return ResponseEntity.ok(response);
    }

	@GetMapping("/vacationInquiry")
    public ModelAndView vacationInquiryPageGO(HttpSession session) {

        UsersVO user = (UsersVO) session.getAttribute("userVO");
        if(user == null) {
            System.out.println("No user in session, redirecting to login");
            return new ModelAndView("redirect:/login");
        }

        ModelAndView mv = new ModelAndView("Vacation/vacationInquiry");

        // 사용자별 휴가 기록 조회
        List<Map<String, Object>> vacationInquiry = personnelService.getUserInquiry(user.getUser_idx());
        Map<String, Map<String, Object>> vacationMap = new HashMap<>();
        for (Map<String, Object> vacation : vacationInquiry) {
            vacationMap.put(String.valueOf(vacation.get("vacation_id")), vacation);
        }
        // 사용자별 잔여 연차 정보 조회
        Map<String, Object> vacationDays = personnelService.getUserVacationDays(user.getUser_idx());

        mv.addObject("vacationMap", vacationMap);
        mv.addObject("vacationDays", vacationDays);
        System.out.println(vacationDays);
        mv.addObject("user", user);
        return mv;
    }

	// 愿�由ъ옄 硫붿씤 湲됱뿬 �럹�씠吏� �씠�룞
	@GetMapping("/adminPay")
	public ModelAndView goToAdminPay() {
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 愿�由ъ옄 湲됱뿬 由ъ뒪�듃 議고쉶
	@GetMapping("/admin_pay_list")
	public ModelAndView adminPayList() {
		ModelAndView mv = new ModelAndView("Payment/adminPay");
		List<Map<String, Object>> employeeList = personnelService.searchEmployeesByName("");
		mv.addObject("employeeList", employeeList);
		return mv;
	}

	// 吏곸썝 湲됱뿬 �럹�씠吏� 吏꾩엯
	@GetMapping("/PayrollManagement")
	public ModelAndView payrollManagement(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		ModelAndView mv = new ModelAndView("Payment/pay");
		mv.addObject("emp_idx", emp_idx);
		return mv;
	}

	// 吏곸썝 �쟾泥� 湲됱뿬 蹂닿린
	@GetMapping("/payrollList")
	public ModelAndView payrollListRedirect(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		return new ModelAndView("redirect:/paylist?emp_idx=" + emp_idx);
	}

	@GetMapping("/payrollGrade")
	public ModelAndView deprecatedPayrollGradeRedirect() {
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 愿�由ъ옄 湲됱뿬 寃��깋
	@PostMapping("/searchEmployees")
	public ModelAndView searchEmployees(@RequestParam("searchType") String searchType,
			@RequestParam("searchKeyword") String searchKeyword) {
		ModelAndView mv = new ModelAndView("Payment/adminPay");
		List<Map<String, Object>> employeeList = new ArrayList<>();

		switch (searchType) {
		case "name":
			employeeList = personnelService.searchEmployeesByName(searchKeyword);
			break;
		case "department":
			employeeList = personnelService.searchEmployeesByDepartment(searchKeyword);
			break;
		case "position":
			employeeList = personnelService.searchEmployeesByPosition(searchKeyword);
			break;
		default:
			mv.addObject("error", "�옒紐삳맂 寃��깋 湲곗��엯�땲�떎.");
			break;
		}

		mv.addObject("employeeList", employeeList);
		return mv;
	}

	// 湲됱뿬 �닔�젙 吏꾩엯
	@GetMapping("/pay_detail")
	public ModelAndView getPayUpdate(@RequestParam("emp_idx") String emp_idx, HttpSession session) {

		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		Map<String, Object> user = personnelService.serchpaydetail(emp_idx);

		if (user != null && user.get("gender") != null) {
			String genderCode = user.get("gender").toString();
			if ("0".equals(genderCode)) {
				user.put("gender", "�궓�옄");
			} else if ("1".equals(genderCode)) {
				user.put("gender", "�뿬�옄");
			} else {
				user.put("gender", "-");
			}
		}

		Map<String, Object> latestSalary = personnelService.getLatestSalary(emp_idx);

		if (latestSalary != null) {
			user.put("base_salary", latestSalary.get("base_salary"));
			user.put("bonus", latestSalary.get("bonus"));
			user.put("salary_id", latestSalary.get("salary_id"));
		}

		ModelAndView mv = new ModelAndView("Payment/adminPayDetailUpdate");
		mv.addObject("user", user);
		return mv;
	}

	// 湲됱뿬 �궫�엯 吏꾩엯
	@GetMapping("/pay_insert")
	public ModelAndView getPayInsert(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		Map<String, Object> user = personnelService.serchpaydetail(emp_idx);
		if (user != null && user.get("gender") != null) {
			String genderCode = user.get("gender").toString();
			if ("0".equals(genderCode)) {
				user.put("gender", "�궓�옄");
			} else if ("1".equals(genderCode)) {
				user.put("gender", "�뿬�옄");
			} else {
				user.put("gender", "-");
			}
		}

		ModelAndView mv = new ModelAndView("Payment/adminPayDetailInsert");
		mv.addObject("user", user);
		return mv;
	}

	// 湲됱뿬 �닔�젙 泥섎━
	@PostMapping("/admin_Pay_Update_Ok")
	public ModelAndView updatePay(@RequestParam Map<String, String> paramMap, HttpSession session) {
		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		try {
			String emp_idx = paramMap.get("emp_idx");
			int salary_id = Integer.parseInt(paramMap.get("salary_id"));
			double base_salary = Double.parseDouble(paramMap.get("base_salary"));
			double bonus = Double.parseDouble(paramMap.get("bonus"));

			Map<String, Object> updateParams = new HashMap<>();
			updateParams.put("salary_id", salary_id);
			updateParams.put("base_salary", base_salary);
			updateParams.put("bonus", bonus);

			personnelService.updatePayById(updateParams); // �씠 硫붿꽌�뱶濡� 蹂�寃�

			Map<String, Object> empParams = new HashMap<>();
			empParams.put("emp_idx", emp_idx);
			empParams.put("base_salary", base_salary);
			empParams.put("bonus", bonus);
			personnelService.updateEmployeePay(empParams);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 湲됱뿬 �궫�엯 泥섎━
	@PostMapping("/admin_Pay_Insert_Ok")
	public ModelAndView insertPay(@RequestParam Map<String, String> paramMap, HttpSession session) {
		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		try {
			String emp_idx = paramMap.get("emp_idx");
			double base_salary = Double.parseDouble(paramMap.get("base_salary"));
			double bonus = Double.parseDouble(paramMap.get("bonus"));
			Date payment_date = Date.valueOf(paramMap.get("payment_date"));

			if (base_salary <= 0 || personnelService.isPayRecordExists(emp_idx, payment_date)) {
				return new ModelAndView("redirect:/admin_pay_list");
			}

			Map<String, Object> insertParams = new HashMap<>();
			insertParams.put("emp_idx", emp_idx);
			insertParams.put("base_salary", base_salary);
			insertParams.put("bonus", bonus);
			insertParams.put("payment_date", payment_date);

			personnelService.insertPay(insertParams);

			Map<String, Object> empParams = new HashMap<>();
			empParams.put("emp_idx", emp_idx);
			empParams.put("pay", base_salary);
			personnelService.updateEmployeePay(empParams);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 吏곸썝 蹂몄씤 湲됱뿬 議고쉶 (�쟾泥� or �듅�젙 吏�湲됱씪)
	@GetMapping("/paylist")
	public ModelAndView getPayList(@RequestParam("emp_idx") String emp_idx,
			@RequestParam(value = "payment_date", required = false) String payment_date) {
		ModelAndView mv = new ModelAndView("Payment/pay");
		Map<String, Object> params = new HashMap<>();
		params.put("emp_idx", emp_idx);
		params.put("payment_date", payment_date);

		List<Map<String, Object>> paylist;
		if (payment_date != null && !payment_date.isEmpty()) {
			params.put("payment_date", payment_date);
			paylist = personnelService.serchpaylist(params);
		} else {
			paylist = personnelService.serchpaylistAll(emp_idx);
		}
		mv.addObject("emp_idx", emp_idx);
		mv.addObject("paylist", paylist);
		return mv;
	}

	// 湲곕낯 pay.jsp �씠�룞�슜 (�꽭�뀡 媛믩쭔 �쟾�떖)
	@GetMapping("/pay")
	public ModelAndView getPayPage(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		ModelAndView mv = new ModelAndView("Payment/pay");
		mv.addObject("emp_idx", emp_idx);
		return mv;
	}

	@GetMapping("/downloadExcel")
	public void downloadExcel(@RequestParam("emp_idx") String emp_idx, HttpServletResponse response) {
		try {
			// 1. �뜲�씠�꽣 以�鍮� (�삁�떆: 湲됱뿬 由ъ뒪�듃 議고쉶)
			List<Map<String, Object>> payList = personnelService.serchpaylistAll(emp_idx);

			// 2. �뿊�� �깮�꽦
			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet("湲됱뿬�궡�뿭");

			// 3. �뿤�뜑 �옉�꽦
			String[] headers = { "吏�湲됱씪", "湲곕낯湲�", "蹂대꼫�뒪", "珥앹븸" };
			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < headers.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(headers[i]);
			}

			// 4. �뜲�씠�꽣 �옉�꽦
			int rowNum = 1;
			for (Map<String, Object> pay : payList) {
				Row row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(String.valueOf(pay.get("payment_date")));
				row.createCell(1).setCellValue(Double.parseDouble(String.valueOf(pay.get("base_salary"))));
				row.createCell(2).setCellValue(Double.parseDouble(String.valueOf(pay.get("bonus"))));
				row.createCell(3).setCellValue(Double.parseDouble(String.valueOf(pay.get("base_salary")))
						+ Double.parseDouble(String.valueOf(pay.get("bonus"))));
			}

			// 5. �쓳�떟 �뿤�뜑 �꽕�젙 諛� �쟾�넚
			String fileName = "湲됱뿬�궡�뿭_" + emp_idx + ".xlsx";
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition",
					"attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"");

			workbook.write(response.getOutputStream());
			workbook.close();

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	// �븳李ъ슧
	// 愿�由ъ옄�쓽 洹쇰Т吏� �씠�룞 �떊泥��쓣 諛쏆� �뀒�씠釉� 議고쉶
	@GetMapping("/personnelChange")
	public ModelAndView getPersonnelChangeRequests(HttpSession session) {
		try {
			ModelAndView mv = new ModelAndView();
			// �꽭�뀡�뿉�꽌 吏곸젒 emp_idx 媛��졇�삤湲�
			String emp_idx = (String) session.getAttribute("emp_idx");
			// 濡쒓렇�씤 �뿬遺�
			if (emp_idx == null) {
				return new ModelAndView("redirect:/login");
			}
			// �꽌鍮꾩뒪�뿉 DB�뿉�꽌 Data瑜� 媛��졇�삤寃� �쟾�떖
			List<Map<String, Object>> personChangeList = personnelService.getPersonChangeInfor();
			System.out.println("Controller Data: " + personChangeList); // �뜲�씠�꽣 �솗�씤

			if (personChangeList == null) {
				return new ModelAndView("error");
			}

			mv.addObject("personChangeList", personChangeList);
			mv.setViewName("PersonnelManagement/PersonnelChange/personnelChange");
			return mv;

		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error");
		}
	}

	// 洹쇰Т吏� �씠�룞 �듅�씤/諛섎젮 泥섎━
	@PostMapping("/updatePersonChangeStatus")
	public ResponseEntity<Map<String, Boolean>> updatePersonChangeStatus(@RequestBody Map<String, Object> requestData) {
		try {
			// �긽�깭 �뾽�뜲�씠�듃�� �엳�뒪�넗由� 湲곕줉�쓣 �룞�떆�뿉 泥섎━
			boolean updateSuccess = personnelService.updatePersonChangeStatus(requestData);
			// boolean insertSuccess =
			// personnelService.insertPersonChangeHistory(requestData);
			boolean resetSuccess = personnelService.resetPersonChangeStatus(requestData);

			Map<String, Boolean> response = new HashMap<>();
			response.put("success", (updateSuccess && /* insertSuccess && */ resetSuccess));
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	// �옉�꽦�옄: 源��옱寃� (05-13)

	// 洹쇰Т吏� 諛� 洹쇰Т 諛⑹떇 �럹�씠吏�濡� �씠�룞
	@GetMapping("/workingArrangement")
	public ModelAndView getWorkArrangement(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
		ModelAndView mv = new ModelAndView("PersonnelManagement/EmpManagement/workingArrangement");
		Map<String, Object> employeeDetails = personnelService.getEmployeeDetails(emp_idx);
		mv.addObject("employeeDetails", employeeDetails);
		return mv;
	}

	// 洹쇰Т吏� 諛� 洹쇰Т 諛⑹떇 �뜲�씠�꽣 �닔�젙
	@PostMapping("/updateWorkArrangement")
	public ModelAndView updateWorkArrangement(HttpSession session, @RequestParam("emp_idx") String emp_idx,
			@RequestParam("location") String location, @RequestParam("attitude_type") String attitudeType) {

		boolean success = personnelService.updateWorkArrangement(emp_idx, location, attitudeType);

		ModelAndView mv = new ModelAndView();
		if (success) {
			mv.setViewName("PersonnelManagement/EmpManagement/workingArrangement");
			mv.addObject("message", "Update successful");
		} else {
			mv.setViewName("error");
		}

		return mv;
	}

}