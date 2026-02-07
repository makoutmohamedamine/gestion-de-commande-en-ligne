package com.gestioncommandes.repository;

import com.gestioncommandes.entity.Addresses;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AddressRepository extends JpaRepository<Addresses, Long> {
}
