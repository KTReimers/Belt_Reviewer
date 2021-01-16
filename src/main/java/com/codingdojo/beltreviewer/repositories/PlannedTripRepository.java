package com.codingdojo.beltreviewer.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.beltreviewer.models.PlannedTrip;

@Repository
public interface PlannedTripRepository extends CrudRepository<PlannedTrip, Long>{
	List<PlannedTrip> findAll();
}