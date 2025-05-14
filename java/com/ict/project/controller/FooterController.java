package com.ict.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FooterController {
	@RequestMapping("/privacyPolicy")
	public ModelAndView privacyPolicyPageGo() {
		return new ModelAndView("MainPage/privacyPolicy");
	}
	@RequestMapping("/companyIntroduction")
	public ModelAndView companyIntroductionPageGo() {
		return new ModelAndView("MainPage/companyIntroduction");
	}
	@RequestMapping("/customerSupport")
	public ModelAndView customerSupportPageGo() {
		return new ModelAndView("MainPage/customerSupport");
	}
}
