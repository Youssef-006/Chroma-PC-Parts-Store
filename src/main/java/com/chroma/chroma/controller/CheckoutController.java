package com.chroma.chroma.controller;

import com.chroma.chroma.model.Order;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.model.User;
import com.chroma.chroma.service.OrderService;
import com.chroma.chroma.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/checkout")
public class CheckoutController {

    private final JavaMailSender mailSender;
    private final CartController cartController;
    private final UserService userService;
    private final OrderService orderService;

    @GetMapping
    public String showCheckout(HttpSession session, Model model) {
        model.addAttribute("cart", cartController.getCartProducts(session));
        return "checkout";
    }

    @PostMapping("/place-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> placeOrder(
            @RequestBody Map<String, Object> payload,
            HttpSession session,
            HttpServletResponse response,
            Authentication authentication) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "Not logged in."));
        }

        User user = userService.findByEmail(authentication.getName()).orElse(null);
        if (user == null) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "User not found."));
        }

        String address       = str(payload, "address");
        String apt           = str(payload, "apt");
        String city          = str(payload, "city");
        String governorate   = str(payload, "governorate");
        String phone         = str(payload, "phone");
        boolean leaveAtDoor  = Boolean.TRUE.equals(payload.get("leaveAtDoor"));
        String paymentMethod = str(payload, "paymentMethod");
        String fullAddress   = address + (apt.isBlank() ? "" : ", " + apt);

        Map<Product, Integer> cartItems = cartController.getCartProducts(session);
        if (cartItems.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Map.of("success", false, "message", "Cart is empty."));
        }

        // ── Persist order to DB ───────────────────────────────────────────────
        Order order = orderService.placeOrder(
                user, cartItems,
                fullAddress, city, governorate,
                phone, paymentMethod, leaveAtDoor
        );

        // ── Send confirmation email ───────────────────────────────────────────
        try {
            StringBuilder itemLines = new StringBuilder();
            order.getItems().forEach(item -> itemLines.append(String.format(
                    "  • %s (x%d) — EGP %.2f%n",
                    item.getProductName(), item.getQuantity(), item.getLineTotal())));

            String emailBody = String.format("""
                    Hi %s,

                    Thank you for your order with Chroma! 🎉

                    ─────────────────────────────
                    ORDER #%d CONFIRMATION
                    ─────────────────────────────

                    📦 Items Ordered:
                    %s
                    ─────────────────────────────
                    Total: EGP %.2f
                    Shipping: Free
                    ─────────────────────────────

                    📍 Delivery Address:
                       %s, %s, %s

                    📱 Contact Number: %s
                    🚪 Leave at Door: %s
                    💳 Payment: %s

                    Your order is being processed and you'll receive
                    a shipping update soon.

                    Thank you for shopping with Chroma.
                    — The Chroma Team
                    """,
                    user.getFirstName(),
                    order.getId(),
                    itemLines,
                    order.getTotal(),
                    fullAddress, city, governorate,
                    phone,
                    leaveAtDoor ? "Yes" : "No",
                    paymentMethod.equalsIgnoreCase("cash") ? "Cash on Delivery" : "Credit / Debit Card"
            );

            SimpleMailMessage mail = new SimpleMailMessage();
            mail.setTo(user.getEmail());
            mail.setSubject("Chroma — Order #" + order.getId() + " Confirmed");
            mail.setText(emailBody);
            mail.setFrom("no-reply@chroma-store.com");
            mailSender.send(mail);
        } catch (Exception e) {
            System.err.println("[Chroma] Email send failed: " + e.getMessage());
        }

        cartController.clearCart(session, response);

        return ResponseEntity.ok(Map.of(
                "success", true,
                "orderId", order.getId(),
                "email", user.getEmail()
        ));
    }

    private String str(Map<String, Object> map, String key) {
        Object v = map.get(key);
        return v == null ? "" : v.toString().trim();
    }
}
