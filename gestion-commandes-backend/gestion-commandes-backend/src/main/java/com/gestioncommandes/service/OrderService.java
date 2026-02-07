package com.gestioncommandes.service;

import com.gestioncommandes.entity.Order;
import com.gestioncommandes.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }

    public Order save(Order order) {
        return orderRepository.save(order);
    }

    public void deleteById(Long id) {
        orderRepository.deleteById(id);
    }
    
    public Optional<Order> updateStatus(Long id, String newStatus) {
        return orderRepository.findById(id).map(order -> {
            order.setStatus(newStatus);
            return orderRepository.save(order);
        });
    }
}
