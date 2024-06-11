package tech.csm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tech.csm.domain.Country;
import tech.csm.repository.CountryRepo;

@Service
public class CountryServiceImpl implements CountryService {

	@Autowired
	private CountryRepo countryRepo;
	
	@Override
	public List<Country> getCountries() {
		// TODO Auto-generated method stub
		return countryRepo.findAll();
	}

}
