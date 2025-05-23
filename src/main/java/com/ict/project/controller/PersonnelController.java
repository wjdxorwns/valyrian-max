package com.ict.project.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
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

	// 휴가 리스트
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

		// ModelAndView에 Map 추가
		mv.addObject("vacationMap", vacationMap);
		return mv;
	}
	
	
	
	@GetMapping("/vacationApprovals")
	public ModelAndView showVacationApprovalPage(@RequestParam("emp_idx") int empIdx) {
	    ModelAndView mv = new ModelAndView("Vacation/vacationApprovals"); // 이동할 JSP 이름
	    mv.addObject("emp_idx", empIdx); // JSP에서 사용할 값 추가
	    return mv;
	}
	
	

	// 휴가 승인 및 대기
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

		// ModelAndView에 Map 추가
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
                logging.setReject(approval.get("comment") != null ? String.valueOf(approval.get("comment")) : ""); // 반려 사유

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
		if (user == null) {
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
		mv.addObject("user", user);
		return mv;
	}
	

	@PostMapping("/submitVacation")
    public ResponseEntity<Map<String, Boolean>> submitVacation(
            @RequestParam("vacation_type") String vacationType,
            @RequestParam("start_date") String startDate,
            @RequestParam("end_date") String endDate,
            @RequestParam("comment") String comment,
            HttpSession session) {

        String emp_idx = (String) session.getAttribute("emp_idx");
        if (emp_idx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        Map<String, Object> vacationData = new HashMap<>();
        vacationData.put("emp_idx", emp_idx);
        vacationData.put("vacation_type", vacationType);
        vacationData.put("start_date", startDate);
        vacationData.put("end_date", endDate);
        vacationData.put("comment", comment);

        boolean success = personnelService.submitVacation(vacationData);

        Map<String, Boolean> response = new HashMap<>();
        response.put("success", success);
        return ResponseEntity.ok(response);
    }
	
	
	
	// 관리자 메인 급여 페이지 이동
	@GetMapping("/adminPay")
	public ModelAndView goToAdminPay() {
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 관리자 급여 리스트 조회
	@GetMapping("/admin_pay_list")
	public ModelAndView adminPayList() {
		ModelAndView mv = new ModelAndView("Payment/adminPay");
		List<Map<String, Object>> employeeList = personnelService.searchEmployeesByName("");
		mv.addObject("employeeList", employeeList);
		return mv;
	}

	// 직원 급여 페이지 진입
	@GetMapping("/PayrollManagement")
	public ModelAndView payrollManagement(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		ModelAndView mv = new ModelAndView("Payment/pay");
		mv.addObject("emp_idx", emp_idx);
		return mv;
	}

	// 직원 전체 급여 보기
	@GetMapping("/payrollList")
	public ModelAndView payrollListRedirect(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		return new ModelAndView("redirect:/paylist?emp_idx=" + emp_idx);
	}

	@GetMapping("/payrollGrade")
	public ModelAndView deprecatedPayrollGradeRedirect() {
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 관리자 급여 검색
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
			mv.addObject("error", "잘못된 검색 기준입니다.");
			break;
		}

		mv.addObject("employeeList", employeeList);
		return mv;
	}

	// 급여 수정 진입
	@GetMapping("/pay_detail")
	public ModelAndView getPayUpdate(@RequestParam("emp_idx") String emp_idx, HttpSession session) {

		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		Map<String, Object> user = personnelService.serchpaydetail(emp_idx);

		if (user != null && user.get("gender") != null) {
			String genderCode = user.get("gender").toString();
			if ("0".equals(genderCode)) {
				user.put("gender", "남자");
			} else if ("1".equals(genderCode)) {
				user.put("gender", "여자");
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

	// 급여 삽입 진입
	@GetMapping("/pay_insert")
	public ModelAndView getPayInsert(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		Map<String, Object> user = personnelService.serchpaydetail(emp_idx);
		if (user != null && user.get("gender") != null) {
			String genderCode = user.get("gender").toString();
			if ("0".equals(genderCode)) {
				user.put("gender", "남자");
			} else if ("1".equals(genderCode)) {
				user.put("gender", "여자");
			} else {
				user.put("gender", "-");
			}
		}

		
		
		
		ModelAndView mv = new ModelAndView("Payment/adminPayDetailInsert");
		mv.addObject("user", user);
		return mv;
	}

	// 급여 수정 처리
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
			updateParams.put("emp_idx",emp_idx);
			
			
			
			System.out.println("emp_idx: " + updateParams.get("emp_idx"));
			System.out.println("payment_date: " + updateParams.get("payment_date"));
			System.out.println("base_salary: " + updateParams.get("base_salary"));
			System.out.println("bonus: " + updateParams.get("bonus"));
			
			
			
			
			personnelService.updatePayById(updateParams); // 이 메서드로 변경

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

	// 급여 삽입 처리
	@PostMapping("/admin_Pay_Insert_Ok")
	public ModelAndView insertPay(@RequestParam Map<String, String> paramMap, HttpSession session) {
		if (!"ok".equals(session.getAttribute("admin"))) {
			return new ModelAndView("redirect:/index");
		}
		try {
			String emp_idx = paramMap.get("emp_idx");
			int base_salary = Integer.parseInt(paramMap.get("base_salary"));
			int bonus = Integer.parseInt(paramMap.get("bonus"));

			String paymentDateStr = paramMap.get("payment_date");
			if (paymentDateStr != null && paymentDateStr.length() == 7) {
				paymentDateStr += "-01";  
			}
			Date payment_date = Date.valueOf(paymentDateStr);

			// 중복 방지 또는 base_salary가 0 이하일 때 막기
			if (base_salary <= 0 || personnelService.isPayRecordExists(emp_idx, payment_date)) {
				return new ModelAndView("redirect:/admin_pay_list");
			}

			Map<String, Object> insertParams = new HashMap<>();
			insertParams.put("emp_idx", emp_idx);
			insertParams.put("base_salary", base_salary);
			insertParams.put("bonus", bonus);
			insertParams.put("payment_date", payment_date);

			System.out.println("emp_idx: " + emp_idx);
			System.out.println("base_salary: " + base_salary);
			System.out.println("bonus: " + bonus);
			System.out.println("payment_date: " + payment_date);

			personnelService.insertPay(insertParams);

			Map<String, Object> empParams = new HashMap<>();
			empParams.put("emp_idx", emp_idx);
			empParams.put("pay", base_salary + bonus); // 총액으로 업데이트하려면 이렇게
			personnelService.updateEmployeePay(empParams);

		} catch (Exception e) {
			e.printStackTrace();  // 예외 발생 시 콘솔 확인
		}
		return new ModelAndView("redirect:/admin_pay_list");
	}

	// 직원 본인 급여 조회 (전체 or 특정 지급일)
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

	// 기본 pay.jsp 이동용 (세션 값만 전달)
	@GetMapping("/pay")
	public ModelAndView getPayPage(HttpSession session) {
		String emp_idx = (String) session.getAttribute("emp_idx");
		ModelAndView mv = new ModelAndView("Payment/pay");
		mv.addObject("emp_idx", emp_idx);
		return mv;
	}

	@PostMapping("/downloadExcelMultiple")
	public void downloadExcelMultiple(
	        @RequestParam(value = "salary_ids", required = false) List<Integer> salaryIds,
	        HttpServletResponse response) throws IOException {

	    System.out.println("▶ 받은 salary_ids: " + salaryIds);

	    if (salaryIds == null || salaryIds.isEmpty()) {
	        System.out.println("⛔ salary_ids가 null 또는 비어 있습니다.");
	        response.setContentType("text/plain");
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("선택된 항목이 없습니다.");
	        return;
	    }

	    List<Map<String, Object>> salaryList = personnelService.getSalaryListByIds(salaryIds);
	    System.out.println("▶ 조회된 급여 수: " + salaryList.size());

	    response.setContentType("application/zip");
	    response.setHeader("Content-Disposition", "attachment; filename=\"급여명세서.zip\"");

	    try (ZipOutputStream zipOut = new ZipOutputStream(response.getOutputStream())) {

	        for (Map<String, Object> salary : salaryList) {
	            System.out.println(" 급여 Map: " + salary);

	            String empName = String.valueOf(salary.get("emp_name"));
	            String position = String.valueOf(salary.get("position"));
	            String team = String.valueOf(salary.get("team"));
	            String paymentDate = String.valueOf(salary.get("payment_date"));
	            Number baseSalary = (Number) salary.get("base_salary");
	            Number bonus = (Number) salary.get("bonus");

	            if (empName == null || baseSalary == null || paymentDate == null) {
	                System.out.println(" 필수 데이터 누락: emp_name=" + empName + ", base_salary=" + baseSalary + ", payment_date=" + paymentDate);
	                continue;
	            }

	            ByteArrayOutputStream baos = new ByteArrayOutputStream();
	            XSSFWorkbook workbook = new XSSFWorkbook();
	            XSSFSheet sheet = workbook.createSheet("급여명세서");

	            // 스타일
	            CellStyle titleStyle = workbook.createCellStyle();
	            XSSFFont titleFont = workbook.createFont();
	            titleFont.setFontHeightInPoints((short) 16);
	            titleFont.setBold(true);
	            titleStyle.setFont(titleFont);
	            titleStyle.setAlignment(HorizontalAlignment.CENTER);

	            CellStyle labelStyle = workbook.createCellStyle();
	            XSSFFont labelFont = workbook.createFont();
	            labelFont.setBold(true);
	            labelStyle.setFont(labelFont);
	            labelStyle.setAlignment(HorizontalAlignment.RIGHT);

	            CellStyle borderStyle = workbook.createCellStyle();
	            borderStyle.setBorderTop(BorderStyle.THIN);
	            borderStyle.setBorderBottom(BorderStyle.THIN);
	            borderStyle.setBorderLeft(BorderStyle.THIN);
	            borderStyle.setBorderRight(BorderStyle.THIN);
	            borderStyle.setAlignment(HorizontalAlignment.CENTER);

	            // 제목
	            Row titleRow = sheet.createRow(0);
	            Cell titleCell = titleRow.createCell(0);
	            titleCell.setCellValue("급여 명세서");
	            titleCell.setCellStyle(titleStyle);
	            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));

	            // 인적사항
	            Row infoRow1 = sheet.createRow(2);
	            infoRow1.createCell(0).setCellValue("이름:");
	            infoRow1.createCell(1).setCellValue(empName);
	            infoRow1.createCell(2).setCellValue("부서:");
	            infoRow1.createCell(3).setCellValue(team);

	            Row infoRow2 = sheet.createRow(3);
	            infoRow2.createCell(0).setCellValue("직책:");
	            infoRow2.createCell(1).setCellValue(position);
	            infoRow2.createCell(2).setCellValue("지급일:");
	            infoRow2.createCell(3).setCellValue(paymentDate);

	            // 표 헤더
	            Row headerRow = sheet.createRow(5);
	            Cell h1 = headerRow.createCell(1);
	            Cell h2 = headerRow.createCell(2);
	            h1.setCellValue("급여 항목");
	            h2.setCellValue("지급 금액(원)");
	            h1.setCellStyle(labelStyle);
	            h2.setCellStyle(labelStyle);

	            // 급여 항목들
	            Row r1 = sheet.createRow(6);
	            r1.createCell(0).setCellValue("기본급");
	            r1.createCell(1).setCellValue(baseSalary.doubleValue());

	            Row r2 = sheet.createRow(7);
	            r2.createCell(0).setCellValue("보너스");
	            r2.createCell(1).setCellValue(bonus.doubleValue());

	            Row r3 = sheet.createRow(8);
	            r3.createCell(0).setCellValue("실수령액");
	            r3.createCell(1).setCellValue(baseSalary.doubleValue() + bonus.doubleValue());

	            for (int i = 6; i <= 8; i++) {
	                sheet.getRow(i).getCell(0).setCellStyle(borderStyle);
	                sheet.getRow(i).getCell(1).setCellStyle(borderStyle);
	            }

	            for (int i = 0; i <= 3; i++) {
	                sheet.autoSizeColumn(i);
	            }

	            workbook.write(baos);
	            workbook.close();

	            String filename = "명세서_" + empName + "_" + paymentDate + ".xlsx";
	            System.out.println(" 파일 생성: " + filename);

	            zipOut.putNextEntry(new ZipEntry(filename));
	            zipOut.write(baos.toByteArray());
	            zipOut.closeEntry();
	        }

	        zipOut.finish();
	        System.out.println(" ZIP 생성 완료");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// 작성자: 김재겸 (05-13)

	// 근무지 및 근무 방식 페이지로 이동
	@GetMapping("/workingArrangement")
	public ModelAndView getWorkArrangement(@RequestParam("emp_idx") String emp_idx, HttpSession session) {
		ModelAndView mv = new ModelAndView("PersonnelManagement/EmpManagement/workingArrangement");
		Map<String, Object> employeeDetails = personnelService.getEmployeeDetails(emp_idx);
		mv.addObject("employeeDetails", employeeDetails);
		return mv;
	}

	// 근무지 및 근무 방식 데이터 수정
    @PostMapping("/updateWorkArrangement")
    public ModelAndView updateWorkArrangement(HttpSession session, @RequestParam("emp_idx") String emp_idx,
            @RequestParam("location") String location, @RequestParam("attitude_type") String attitudeType,
            @RequestParam("team") String team) {

        boolean success = personnelService.updateWorkArrangement(emp_idx, location, attitudeType, team);

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