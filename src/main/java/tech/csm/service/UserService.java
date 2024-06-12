package tech.csm.service;

import java.util.List;

import tech.csm.domain.User;

public interface UserService {

	User saveUser(User u);

	List<User> getUsers();

	User updateUser(User user);

}
