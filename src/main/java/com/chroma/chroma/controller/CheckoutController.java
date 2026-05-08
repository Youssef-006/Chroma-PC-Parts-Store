package com.chroma.chroma.controller;

import com.chroma.chroma.model.Cart;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.model.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
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

    // ─── GET /checkout → checkout.html ───────────────────────────────────────
    @GetMapping
    public String showCheckout(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        // Expose the same cart map used by CartController
        model.addAttribute("cart", cartController.getCartProducts());
        return "checkout";
    }

    // ─── POST /checkout/place-order ──────────────────────────────────────────
    @PostMapping("/place-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> placeOrder(
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "Not logged in."));
        }

        // Extract fields
        String address       = str(payload, "address");
        String apt           = str(payload, "apt");
        String city          = str(payload, "city");
        String governorate   = str(payload, "governorate");
        String phone         = str(payload, "phone");
        boolean leaveAtDoor  = Boolean.TRUE.equals(payload.get("leaveAtDoor"));
        String paymentMethod = str(payload, "paymentMethod");

        // Build order summary from cart
        Map<Product, Integer> cartItems = cartController.getCartProducts();
        StringBuilder itemLines = new StringBuilder();
        double total = 0;

        for (Map.Entry<Product, Integer> entry : cartItems.entrySet()) {
            Product p = entry.getKey();
            int qty   = entry.getValue();
            double lineTotal = p.getPrice() * qty;
            total += lineTotal;
            itemLines.append(String.format(
                    "  • %s (x%d) — EGP %.2f%n", p.getName(), qty, lineTotal));
        }

        // ─── Send confirmation email ───────────────────────────────────────
        try {
            String fullAddress = address
                    + (apt.isBlank() ? "" : ", " + apt)
                    + ", " + city + ", " + governorate;

            String emailBody = String.format("""
                    Hi %s,
 
                    Thank you for your order with Chroma! 🎉
 
                    ─────────────────────────────
                    ORDER CONFIRMATION
                    ─────────────────────────────
 
                    📦 Items Ordered:
                    %s
                    ─────────────────────────────
                    Total: EGP %.2f
                    Shipping: Free
                    ─────────────────────────────
 
                    📍 Delivery Address:
                       %s
 
                    📱 Contact Number: %s
                    🚪 Leave at Door: %s
                    💳 Payment: %s
 
                    ─────────────────────────────
 
                    Your order is being processed and you'll receive
                    a shipping update soon.
 
                    Thank you for shopping with Chroma.
                    — The Chroma Team
                    """,
                    user.getFirstName(),
                    itemLines,
                    total,
                    fullAddress,
                    phone,
                    leaveAtDoor ? "Yes" : "No",
                    paymentMethod.equalsIgnoreCase("cash") ? "Cash on Delivery" : "Credit / Debit Card"
            );

            SimpleMailMessage mail = new SimpleMailMessage();
            mail.setTo(user.getEmail());
            mail.setSubject("Chroma — Order Confirmation");
            mail.setText(emailBody);
            mail.setFrom("no-reply@chroma-store.com");

            mailSender.send(mail);

        } catch (Exception e) {
            // Email failed — still confirm the order; log the error
            System.err.println("[Chroma] Email send failed: " + e.getMessage());
        }

        // Clear the cart after successful order
        cartController.clearCart();

        return ResponseEntity.ok(Map.of(
                "success", true,
                "email", user.getEmail()
        ));
    }

    // ── Helper ────────────────────────────────────────────────────────────────
    private String str(Map<String, Object> map, String key) {
        Object v = map.get(key);
        return v == null ? "" : v.toString().trim();
    }
}
