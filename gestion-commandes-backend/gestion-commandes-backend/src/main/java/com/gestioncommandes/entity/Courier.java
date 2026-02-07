package com.gestioncommandes.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "couriers")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Courier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "courier_id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "transport_type", nullable = false)
    private String transportType; // enum('bike', 'scooter', 'car', 'on_foot')

    @Column(name = "availability_status", nullable = false)
    private String availabilityStatus; // enum('available', 'on_delivery', 'offline')

    @Column(name = "current_latitude", precision = 10, scale = 7)
    private BigDecimal currentLatitude;

    @Column(name = "current_longitude", precision = 10, scale = 7)
    private BigDecimal currentLongitude;

    @Column(name = "average_rating", precision = 2, scale = 1)
    private BigDecimal averageRating;
}
