package com.codingdojo.beltreviewer.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.codingdojo.beltreviewer.models.Event;
import com.codingdojo.beltreviewer.models.User;
import com.codingdojo.beltreviewer.services.MainService;

@Controller
public class MainController {
	@Autowired
	private MainService mainServ;
	
	@GetMapping("/")
	public String index(HttpSession session) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/login";
		}
		return "redirect:/events";
	}
	
	@GetMapping("/events")
	public String dashboard(@ModelAttribute("event")Event event, HttpSession session, Model model) {
		if(session.getAttribute("user_id") == null) {
			return "redirect:/login";
		}
		Long user_id = (Long) session.getAttribute("user_id");
		List<Event> allEvents = mainServ.getAllEvents();
		User user = mainServ.findUserById(user_id);
		model.addAttribute("user", user);
		model.addAttribute("events", allEvents);
		model.addAttribute("user_id", user_id);
		return "dashboard.jsp";
	}
	
	@PostMapping("/events/new")
	public String newEvent(@Valid @ModelAttribute("event")Event event, BindingResult results, Model model,HttpSession session) {
		if(results.hasErrors()) {
			Long user_id = (Long) session.getAttribute("user_id");
			List<Event> allEvents = mainServ.getAllEvents();
			model.addAttribute("events", allEvents);
			model.addAttribute("user_id", user_id);
			return "dashboard.jsp";
		}
		mainServ.createEvent(event);
		Long event_id = event.getId();
		Long user_id = (Long) session.getAttribute("user_id");
		mainServ.createPlannedTrip(event_id , user_id);
		return "redirect:/events";
	}
	
	@GetMapping("/events/{id}/edit")
	public String editShow(@PathVariable("id") Long id, Model model) {
		Event editEvent = mainServ.findEvent(id);
		model.addAttribute("event", editEvent);
		return "edit.jsp";
	}
	
	@PutMapping("/events/{id}/edit")
	public String proccessEditShow(@Valid @ModelAttribute("event")Event event, BindingResult results, Model model,HttpSession session) {
		if(results.hasErrors()) {
			return "edit.jsp";
		}
		mainServ.createEvent(event);
		return "redirect:/events";
	}
	
	@GetMapping("/events/{id}/delete")
	public String deleteEvent(@PathVariable("id")Long id) {
		mainServ.deleteEvent(id);
		return "redirect:/events";
	}
	
	@GetMapping("/events/{id}/show")
	public String showEvent(@PathVariable("id")Long id, Model model) {
		Event event = mainServ.findEvent(id);
		model.addAttribute("event", event);
		return "show.jsp";
	}
	
	@GetMapping("/events/{id}/join")
	public String join(@PathVariable("id")Long id, HttpSession session) {
		Long user_id = (Long) session.getAttribute("user_id");
		mainServ.createPlannedTrip(id , user_id);
		return "redirect:/events";
	}
	
	@GetMapping("/events/{id}/cancel")
	public String cancelTrip(@PathVariable("id")Long id, HttpSession session){
		Long user_id = (Long) session.getAttribute("user_id");
		User user = mainServ.findUserById(user_id);
		Event event = mainServ.findEvent(id);
		event.getUser().remove(user);
		mainServ.createEvent(event);
		return "redirect:/events";
		
	}
}
