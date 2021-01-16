package com.codingdojo.beltreviewer.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.beltreviewer.models.Event;
import com.codingdojo.beltreviewer.models.PlannedTrip;
import com.codingdojo.beltreviewer.models.User;
import com.codingdojo.beltreviewer.repositories.EventRepository;
import com.codingdojo.beltreviewer.repositories.PlannedTripRepository;
import com.codingdojo.beltreviewer.repositories.UserRepository;

@Service
public class MainService {
	@Autowired
	private EventRepository eRepo;
	
	@Autowired
	private UserRepository uRepo;
	
	@Autowired
	private PlannedTripRepository planRepo;

	public void createEvent(@Valid Event event) {
		eRepo.save(event);
	}

	public List<Event> getAllEvents() {
		return eRepo.findAll();
	}

	public Event findEvent(Long id) {
		return eRepo.findById(id).orElse(null);
	}

	public void deleteEvent(Long id) {
		eRepo.deleteById(id);
	}
	
	public void createPlannedTrip(PlannedTrip plannedTrip) {
		planRepo.save(plannedTrip);
		
	}

	public void createPlannedTrip(Long id, Long user_id) {
		Event event = this.findEvent(id);
		User user = this.findUserById(user_id);
		PlannedTrip plannedTrip = new PlannedTrip(user, event);
		this.createPlannedTrip(plannedTrip);
		
	}
	
	public User findUserById(Long id) {
		return uRepo.findById(id).orElse(null);
	}

	public List<PlannedTrip> getAllPlannedTrips() {
		return planRepo.findAll();
	}

	
	
	
	//Get all events that are share the state with the host state
	
	//Get all events that are not in the same state as the host
	
	
}
