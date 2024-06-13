package tech.csm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tech.csm.domain.User;
import tech.csm.repository.UserRepo;
import tech.csm.util.FileUploadUtil;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepo userRepo;
	
	@Override
	public User saveUser(User u) {
		u.setPhoto(u.getFile().getOriginalFilename());
		FileUploadUtil.uploadFile(u.getFile());
		System.out.println(u);
		return userRepo.save(u);
	}

	@Override
	public List<User> getUsers() {
		return userRepo.getAllUsers();
	}

	@Override
	public User updateUser(User user) {
		return userRepo.save(user);
	}

	@Override
	public int deleteUser(Integer uid) {
		return userRepo.deleteUser(uid);
	}

	

	

}
