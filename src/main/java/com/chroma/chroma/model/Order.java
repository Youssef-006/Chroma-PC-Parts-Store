package com.chroma.chroma.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // The user who placed the order
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private LocalDateTime placedAt = LocalDateTime.now();

    // Shipping info
    @Column(nullable = false)
    private String address;

    private String city;
    private String governorate;
    private String phone;
    private String paymentMethod;   // "cash" or "card"
    private boolean leaveAtDoor;

    // Total in EGP
    @Column(nullable = false)
    private double total;

    // Status: PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
    @Column(nullable = false)
    private String status = "PENDING";

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items = new ArrayList<>();
}
