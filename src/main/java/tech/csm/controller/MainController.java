package tech.csm.controller;

import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;
import tech.csm.domain.Country;
import tech.csm.domain.State;
import tech.csm.service.CountryService;
import tech.csm.service.StateService;

@Controller
public class MainController {

	@Autowired
	private CountryService countryService;

	@Autowired
	private StateService stateService;

	@GetMapping("/getform")
	public String getForm(Model model) {
		List<Country> countyList = countryService.getCountries();
		model.addAttribute("countyList", countyList);
		return "userRegdPage";
	}

	@GetMapping("/findStateByCountryId")
	public void findStateByCountryId(Model model, @RequestParam("countryId") Integer cId,HttpServletResponse resp) throws IOException {
		List<State> stateList = stateService.getStateByCId(cId);
		String res = "<option value='0'>-select-</option>";
		for (State s : stateList) {
			res += "<option value='" + s.getSid() + "'>" + s.getName() + "</option>";
		}
		resp.getWriter().println(res);
	}
	
	
	
}