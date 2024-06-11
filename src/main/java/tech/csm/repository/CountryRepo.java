package tech.csm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tech.csm.domain.Country;

public interface CountryRepo extends JpaRepository<Country, Integer> {

}
