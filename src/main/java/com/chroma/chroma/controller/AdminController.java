package com.chroma.chroma.controller;

import com.chroma.chroma.model.Order;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.model.User;
import com.chroma.chroma.repository.ProductRepo;
import com.chroma.chroma.service.OrderService;
import com.chroma.chroma.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

    private final ProductRepo productRepo;
    private final UserService userService;
    private final OrderService orderService;
    private final PasswordEncoder passwordEncoder;

    // ── Dashboard ─────────────────────────────────────────────────────────────
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalProducts", productRepo.count());
        model.addAttribute("totalUsers",    userService.findAll().stream()
                .filter(u -> u.getRole().equals("USER")).count());
        model.addAttribute("totalOrders",   orderService.getAllOrders().size());
        double revenue = orderService.getAllOrders().stream()
                .mapToDouble(Order::getTotal).sum();
        model.addAttribute("totalRevenue", revenue);
        model.addAttribute("recentOrders", orderService.getAllOrders()
                .stream().limit(5).toList());
        return "admin/dashboard";
    }

    // ══ PRODUCTS ══════════════════════════════════════════════════════════════

    @GetMapping("/products")
    public String listProducts(Model model) {
        model.addAttribute("products", productRepo.findAll());
        model.addAttribute("newProduct", new Product());
        return "admin/products";
    }

    @PostMapping("/products/save")
    public String saveProduct(@ModelAttribute Product product,
                              RedirectAttributes ra) {
        productRepo.save(product);
        ra.addFlashAttribute("success",
                product.getId() == null ? "Product added." : "Product updated.");
        return "redirect:/admin/products";
    }

    @GetMapping("/products/edit/{id}")
    public String editProduct(@PathVariable Long id, Model model) {
        model.addAttribute("products", productRepo.findAll());
        model.addAttribute("newProduct",
                productRepo.findById(id).orElseThrow());
        return "admin/products";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id, RedirectAttributes ra) {
        productRepo.deleteById(id);
        ra.addFlashAttribute("success", "Product deleted.");
        return "redirect:/admin/products";
    }

    // ══ USERS ═════════════════════════════════════════════════════════════════

    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.findAll());
        return "admin/users";
    }

    @PostMapping("/users/role/{id}")
    public String changeRole(@PathVariable Long id,
                             @RequestParam String role,
                             RedirectAttributes ra) {
        userService.findById(id).ifPresent(u -> {
            u.setRole(role);
            userService.save(u);
        });
        ra.addFlashAttribute("success", "Role updated.");
        return "redirect:/admin/users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id, RedirectAttributes ra) {
        userService.deleteById(id);
        ra.addFlashAttribute("success", "User deleted.");
        return "redirect:/admin/users";
    }

    // ══ ORDERS ════════════════════════════════════════════════════════════════

    @GetMapping("/orders")
    public String listOrders(Model model) {
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/orders";
    }

    @GetMapping("/orders/{id}")
    public String orderDetail(@PathVariable Long id, Model model) {
        Order order = orderService.findById(id).orElseThrow();
        model.addAttribute("order", order);
        return "admin/order-detail";
    }

    @PostMapping("/orders/{id}/status")
    public String updateStatus(@PathVariable Long id,
                               @RequestParam String status,
                               RedirectAttributes ra) {
        orderService.updateStatus(id, status);
        ra.addFlashAttribute("success", "Order status updated to " + status + ".");
        return "redirect:/admin/orders/" + id;
    }
}
