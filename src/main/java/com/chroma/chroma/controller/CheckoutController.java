//Checkout
package com.chroma.chroma.controller;

import com.chroma.chroma.dto.CheckoutDTO;
import com.chroma.chroma.model.Order;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.model.User;
import com.chroma.chroma.service.AsyncEmailService;
import com.chroma.chroma.service.OrderService;
import com.chroma.chroma.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/checkout")
    public class CheckoutController {

    private final CartController cartController;
    private final UserService userService;
    private final OrderService orderService;
    private final AsyncEmailService asyncEmailService;   // ← async, non-blocking

    @GetMapping
    public String showCheckout(HttpSession session, Model model) {
        model.addAttribute("cart", cartController.getCartProducts(session));
        return "checkout";
    }

    @PostMapping("/place-order")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> placeOrder(
            @Valid @RequestBody CheckoutDTO dto,
            BindingResult bindingResult,
            HttpSession session,
            HttpServletResponse response,
            Authentication authentication) {

        // ── Auth check ────────────────────────────────────────────────────────
        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "Not logged in."));
        }

        // ── Bean Validation errors → return field-level messages ──────────────
        if (bindingResult.hasErrors()) {
            Map<String, Object> errors = new HashMap<>();
            errors.put("success", false);
            errors.put("message", "Please fix the errors below.");
            Map<String, String> fieldErrors = new HashMap<>();
            bindingResult.getFieldErrors()
                    .forEach(e -> fieldErrors.put(e.getField(), e.getDefaultMessage()));
            errors.put("fieldErrors", fieldErrors);
            return ResponseEntity.badRequest().body(errors);
        }

        // ── Resolve user ──────────────────────────────────────────────────────
        User user = userService.findByEmail(authentication.getName()).orElse(null);
        if (user == null) {
            return ResponseEntity.status(401)
                    .body(Map.of("success", false, "message", "User not found."));
        }

        // ── Cart check ────────────────────────────────────────────────────────
        Map<Product, Integer> cartItems = cartController.getCartProducts(session);
        if (cartItems.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Map.of("success", false, "message", "Cannot Order, your cart is empty!"));
        }

        // ── Build full address ────────────────────────────────────────────────
        String fullAddress = dto.getAddress()
                + (dto.getApt() == null || dto.getApt().isBlank() ? "" : ", " + dto.getApt());

        // ── Persist order ─────────────────────────────────────────────────────
        Order order = orderService.placeOrder(
                user, cartItems,
                fullAddress, dto.getCity(), dto.getGovernorate(),
                dto.getPhone(), dto.getPaymentMethod(), dto.isLeaveAtDoor()
        );

        // ── Send email on background thread (multithreading) ──────────────────
        // Returns immediately — email is dispatched to the emailExecutor pool
        asyncEmailService.sendOrderConfirmation(user, order, fullAddress);

        // ── Clear cart ────────────────────────────────────────────────────────
        cartController.clearCart(session, response);

        return ResponseEntity.ok(Map.of(
                "success", true,
                "orderId", order.getId(),
                "email",   user.getEmail()
        ));
    }
}
