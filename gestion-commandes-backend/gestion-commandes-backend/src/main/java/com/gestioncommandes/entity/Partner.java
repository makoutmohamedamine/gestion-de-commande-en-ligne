package com.gestioncommandes.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "partners")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Partner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "partner_id")
    private Long id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "partner_type", nullable = false)
    private String partnerType; // enum('restaurant', 'pharmacy', 'grocery', 'retail')

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id", nullable = false)
    private Addresses address;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "admin_user_id", nullable = false)
    private User adminUser;

    @Column(name = "average_rating", precision = 2, scale = 1)
    private BigDecimal averageRating;

    @Column(name = "is_active")
    private Boolean isActive;
}
