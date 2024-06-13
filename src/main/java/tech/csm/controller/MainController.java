package tech.csm.controller;

import java.io.IOException;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tech.csm.domain.Country;
import tech.csm.domain.State;
import tech.csm.domain.User;
import tech.csm.service.CountryService;
import tech.csm.service.StateService;
import tech.csm.service.UserService;
import tech.csm.util.FileDownloadUtil;

@Controller
public class MainController {

	@Autowired
	private CountryService countryService;

	@Autowired
	private StateService stateService;

	@Autowired
	private UserService userService;

	@GetMapping("/getform")
	public String getForm(Model model) {
		List<Country> countyList = countryService.getCountries();
		List<User> userList = userService.getUsers();

		model.addAttribute("countyList", countyList);
		model.addAttribute("userList", userList);
		return "userRegdPage";
	}

	@GetMapping("/findStateByCountryId")
	public void findStateByCountryId(Model model, @RequestParam("countryId") Integer cId, HttpServletResponse resp)
			throws IOException {
		List<State> stateList = stateService.getStateByCId(cId);
		String res = "<option value='0'>-select-</option>";
		for (State s : stateList) {
			res += "<option value='" + s.getSid() + "'" + ">" + s.getName() + "</option>";
		}
		resp.getWriter().println(res);
	}

	@PostMapping("/saveUser")
	public String saveUser(@ModelAttribute User u, RedirectAttributes rd) {
		System.out.println(u);
		User saveUser = userService.saveUser(u);
		System.out.println(saveUser);
		return "redirect:./getform";
	}
	
	@GetMapping("/getImage")
	private String downloadImg(HttpServletRequest req, HttpServletResponse resp) {
		try {
			FileDownloadUtil.downloadFile(req, resp);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:./getform";
	}
	
	@GetMapping("/deleteUser")
	private String deleteUser(@RequestParam ("uId") Integer uid) {
		System.out.println(uid);
		int res = userService.deleteUser(uid);
		System.out.println(res);
		return "redirect:./getform";
	}
}