package com.chroma.chroma.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.chroma.chroma.model.Product;

public interface ProductRepo extends JpaRepository<Product, Long> {
}