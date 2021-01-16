package com.codingdojo.beltreviewer.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.beltreviewer.models.User;
import com.codingdojo.beltreviewer.services.UserService;
import com.codingdojo.beltreviewer.validators.UserValidator;

@Controller
public class UserController {
	@Autowired
	UserService uServ;
	
	@Autowired
	private UserValidator uValid;
	
	@GetMapping("/registration")
	public String registration(@ModelAttribute("user") User user) {
		return "registration.jsp";
	}
	
	@PostMapping("/registration")
	public String processRegister(@Valid @ModelAttribute("user")User user, BindingResult results, HttpSession session) {
		uValid.validate(user, results);
		if(results.hasErrors()) {
			return "registration.jsp";
		} 
		else {
			User newUser= uServ.registerUser(user);
			session.setAttribute("user_id", newUser.getId());
			return "redirect:/events";
		}
	}
	
	@GetMapping("/login")
	public String login() {
		return "login.jsp";
	}
	
	@PostMapping("/login")
	public String proccessLogin(@RequestParam("email") String email, @RequestParam("password") String password, RedirectAttributes redirectAttributes, HttpSession session) {
		if(!uServ.authenticateUser(email, password)) {
			redirectAttributes.addFlashAttribute("error", "Invalid Credentials");
			return "redirect:/login";
		}
		User loggedUser = uServ.findByEmail(email);
		session.setAttribute("user_id", loggedUser.getId());
		 return "redirect:/events";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
