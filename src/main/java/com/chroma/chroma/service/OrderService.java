package com.chroma.chroma.service;

import com.chroma.chroma.model.*;
import com.chroma.chroma.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;

    // ── Place a new order ─────────────────────────────────────────────────────
    @Transactional
    public Order placeOrder(User user,
                            Map<Product, Integer> cartItems,
                            String address,
                            String city,
                            String governorate,
                            String phone,
                            String paymentMethod,
                            boolean leaveAtDoor) {

        Order order = new Order();
        order.setUser(user);
        order.setPlacedAt(LocalDateTime.now());
        order.setAddress(address);
        order.setCity(city);
        order.setGovernorate(governorate);
        order.setPhone(phone);
        order.setPaymentMethod(paymentMethod);
        order.setLeaveAtDoor(leaveAtDoor);
        order.setStatus("PENDING");

        double total = 0;
        for (Map.Entry<Product, Integer> entry : cartItems.entrySet()) {
            Product p  = entry.getKey();
            int qty    = entry.getValue();
            double line = p.getPrice() * qty;
            total += line;

            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProductName(p.getName());
            item.setProductCategory(p.getCategory());
            item.setUnitPrice(p.getPrice());
            item.setQuantity(qty);
            item.setLineTotal(line);
            order.getItems().add(item);
        }

        order.setTotal(total);
        return orderRepository.save(order);
    }

    // ── Fetch orders for a user ───────────────────────────────────────────────
    public List<Order> getOrdersForUser(User user) {
        return orderRepository.findByUserOrderByPlacedAtDesc(user);
    }

    // ── Fetch all orders (admin) ──────────────────────────────────────────────
    public List<Order> getAllOrders() {
        return orderRepository.findAllByOrderByPlacedAtDesc();
    }

    // ── Update status (admin) ─────────────────────────────────────────────────
    @Transactional
    public void updateStatus(Long orderId, String status) {
        orderRepository.findById(orderId).ifPresent(o -> {
            o.setStatus(status);
            orderRepository.save(o);
        });
    }

    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }
}
