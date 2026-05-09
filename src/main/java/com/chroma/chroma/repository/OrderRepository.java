package com.chroma.chroma.repository;

import com.chroma.chroma.model.Order;
import com.chroma.chroma.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    // All orders for a specific user, newest first
    List<Order> findByUserOrderByPlacedAtDesc(User user);
    // All orders newest first (for admin)
    List<Order> findAllByOrderByPlacedAtDesc();
}
