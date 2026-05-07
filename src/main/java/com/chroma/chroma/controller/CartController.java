package com.chroma.chroma.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.*;

import com.chroma.chroma.model.Cart;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.repository.ProductRepo;

@Controller
@RequestMapping("/cart")
@CrossOrigin
public class CartController {

    private Cart cart = new Cart();

    private final ProductRepo productRepo;

    public CartController(ProductRepo productRepo) {
        this.productRepo = productRepo;
    }

    // Thymeleaf view — GET /cart → cart.html
    @GetMapping
    public String showCart(Model model) {
        model.addAttribute("cart", cart.getProducts());
        return "cart";
    }

    // add product
    @PostMapping("/add/{id}")
    @ResponseBody
    public String addProduct(@PathVariable Long id) {
        Optional<Product> product = productRepo.findById(id);
        if (product.isPresent()) {
            cart.addProduct(product.get());
            return "Added to cart";
        }
        return "Product not found";
    }

    // remove product
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public String removeProduct(@PathVariable Long id) {
        Optional<Product> product = productRepo.findById(id);
        if (product.isPresent()) {
            cart.removeProduct(product.get());
            return "Removed";
        }
        return "Product not found";
    }

    // update quantity
    @PostMapping("/update/{id}")
    @ResponseBody
    public String updateQty(@PathVariable Long id, @RequestParam int quantity) {
        productRepo.findById(id).ifPresent(p -> cart.updateQuantity(p, quantity));
        return "Updated";
    }
}