package com.gestioncommandes.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        
        // Autoriser toutes les origines (pour le développement)
        config.addAllowedOriginPattern("*");
        
        // Autoriser toutes les méthodes HTTP
        config.addAllowedMethod("*");
        
        // Autoriser tous les headers
        config.addAllowedHeader("*");
        
        // Autoriser les credentials (cookies, etc.)
        config.setAllowCredentials(true);
        
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}

