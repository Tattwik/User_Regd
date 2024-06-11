package tech.csm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import tech.csm.domain.State;

@Repository
public interface StateRepo extends JpaRepository<State, Integer> {

	@Query(value = "SELECT * FROM State WHERE cid = :cId", nativeQuery = true)
	List<State> getStateByCId(Integer cId);

	

	

}
