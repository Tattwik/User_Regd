package tech.csm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import tech.csm.domain.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer> {

	@Query(value = "SELECT * FROM UserTbl WHERE isdelete = 'No' ORDER BY uid", nativeQuery = true)
	List<User> getAllUsers();

	@Transactional
	@Modifying
	@Query(value = "UPDATE UserTbl SET isdelete = 'Yes' WHERE uid = :uId", nativeQuery = true)
	int deleteUser(Integer uId);


}
