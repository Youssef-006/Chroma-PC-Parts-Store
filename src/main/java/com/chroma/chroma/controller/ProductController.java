package com.chroma.chroma.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

import com.chroma.chroma.model.Product;
import com.chroma.chroma.repository.ProductRepo;

@Controller
@RequestMapping("/product")
@CrossOrigin
public class ProductController {

    @Autowired
    ProductRepo repo;

    // Thymeleaf view — GET /product → product.html.


    // JSON API — GET /product/api
    @GetMapping("/api")
    @ResponseBody
    public List<Product> getAllProducts() {
        return repo.findAll();
    }

    // JSON API — POST /product/api
    @PostMapping("/api")
    @ResponseBody
    public Product addProduct(@RequestBody Product product) {
        return repo.save(product);
    }

    @GetMapping
    public String showProducts(HttpSession session, Model model) {
        if (session.getAttribute("loggedInUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("products", repo.findAll());
        return "product";
    }
}