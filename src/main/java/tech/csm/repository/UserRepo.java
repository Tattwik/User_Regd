package tech.csm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import tech.csm.domain.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer> {

}
