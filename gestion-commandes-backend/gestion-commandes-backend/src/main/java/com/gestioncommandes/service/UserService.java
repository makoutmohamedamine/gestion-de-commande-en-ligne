package com.gestioncommandes.service;

import com.gestioncommandes.entity.User;
import com.gestioncommandes.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // Simuler une connexion simple (à améliorer avec Spring Security)
    public Optional<User> login(String email, String passwordHash) {
        return userRepository.findByEmail(email)
                .filter(user -> user.getPasswordHash().equals(passwordHash)); // Comparaison simple
    }

    public User save(User user) {
        return userRepository.save(user);
    }
}
