package com.chroma.chroma.controller;

import com.chroma.chroma.model.Product;
import com.chroma.chroma.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/product")
@CrossOrigin
public class ProductController {

    @Autowired
    ProductRepo repo;

    @GetMapping
    public String showProducts(Model model) {
        model.addAttribute("products", repo.findAll());
        return "product";
    }

    @GetMapping("/api")
    @ResponseBody
    public List<Product> getAllProducts() {
        return repo.findAll();
    }

    @PostMapping("/api")
    @ResponseBody
    public Product addProduct(@RequestBody Product product) {
        return repo.save(product);
    }
}
