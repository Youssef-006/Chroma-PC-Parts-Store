//Update Code
package com.chroma.chroma.controller;

import com.chroma.chroma.dto.RegisterDTO;
import com.chroma.chroma.model.User;
import com.chroma.chroma.service.OrderService;
import com.chroma.chroma.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AuthenticationController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "register";
    }

    @PostMapping("/register")
    public String handleRegister(@Valid @ModelAttribute("registerDTO") RegisterDTO dto,
                                 BindingResult result,
                                 Model model) {
        if (result.hasErrors()) return "register";

        if (userService.existsByEmail(dto.getEmail())) {
            model.addAttribute("error", "Email is already registered.");
            return "register";
        }

        User user = new User();
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setRole("USER");
        userService.save(user);
        return "redirect:/login?registered";
    }

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(required = false) String registered,
                                @RequestParam(required = false) String error,
                                @RequestParam(required = false) String logout,
                                Model model) {
        if (registered != null) model.addAttribute("success", "Account created! Please log in.");
        if (error      != null) model.addAttribute("error",   "Incorrect email or password.");
        if (logout     != null) model.addAttribute("success", "You have been logged out.");
        return "login";
    }

    @GetMapping("/")
    public String root() { return "redirect:/home"; }

    @GetMapping("/home")
    public String home() { return "home"; }

    // ── User order history ────────────────────────────────────────────────────
    @GetMapping("/orders")
    public String myOrders(Authentication authentication, Model model) {
        User user = userService.findByEmail(authentication.getName()).orElseThrow();
        model.addAttribute("orders", orderService.getOrdersForUser(user));
        return "user/orders";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable Long id,
                              Authentication authentication,
                              Model model) {
        User user  = userService.findByEmail(authentication.getName()).orElseThrow();
        var order  = orderService.findById(id).orElseThrow();
        // Users can only see their own orders
        if (!order.getUser().getId().equals(user.getId())) {
            return "redirect:/orders";
        }
        model.addAttribute("order", order);
        return "user/order-detail";
    }
}
