package com.gestioncommandes.controller;

import com.gestioncommandes.entity.User;
import com.gestioncommandes.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> loginRequest) {
        String email = loginRequest.get("email");
        String passwordHash = loginRequest.get("passwordHash"); // Utiliser le hash pour la simulation

        return userService.login(email, passwordHash)
                .map(user -> {
                    // En production, on retournerait un JWT ou un token de session
                    return ResponseEntity.ok(Map.of(
                            "message", "Connexion réussie",
                            "id", user.getId(),
                            "email", user.getEmail(),
                            "role", user.getRole()
                    ));
                })
                .orElse(ResponseEntity.status(401).body(Map.of("message", "Identifiants invalides")));
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Map<String, String> registerRequest) {
        String firstName = registerRequest.getOrDefault("firstName", "").trim();
        String lastName = registerRequest.getOrDefault("lastName", "").trim();
        String email = registerRequest.getOrDefault("email", "").trim();
        String passwordHash = registerRequest.getOrDefault("passwordHash", "").trim();
        String role = registerRequest.getOrDefault("role", "client").trim();
        String phoneNumber = registerRequest.getOrDefault("phoneNumber", "").trim();

        if (email.isEmpty() || passwordHash.isEmpty() || firstName.isEmpty() || lastName.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Champs obligatoires manquants"));
        }

        if (userService.findByEmail(email).isPresent()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Email déjà utilisé"));
        }

        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setPasswordHash(passwordHash); // À remplacer par un vrai hash en production
        user.setRole(role);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());

        User saved = userService.save(user);

        return ResponseEntity.ok(Map.of(
                "message", "Inscription réussie",
                "id", saved.getId(),
                "email", saved.getEmail(),
                "role", saved.getRole()
        ));
    }
}
