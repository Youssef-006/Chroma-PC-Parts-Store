package com.chroma.chroma.service;

import com.chroma.chroma.model.User;
import com.chroma.chroma.repository.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepo UserRepo;

    public List<User> findAll() {
        return UserRepo.findAll();
    }

    public Optional<User> findById(Long id) {
        return UserRepo.findById(id);
    }

    public Optional<User> findByEmail(String email) {
        return UserRepo.findByEmail(email);
    }

    public boolean existsByEmail(String email) {
        return UserRepo.existsByEmail(email);
    }

    public User save(User user) {
        return UserRepo.save(user);
    }

    public void deleteById(Long id) {
        UserRepo.deleteById(id);
    }
}