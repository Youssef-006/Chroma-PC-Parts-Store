package com.chroma.chroma.model;
import java.util.HashMap;
import java.util.Map;
public class Cart {

    private Map<Product, Integer> products = new HashMap<>();

    public Map<Product, Integer> getProducts() {
        return products;
    }

    public void addProduct(Product product) {
        products.put(product, products.getOrDefault(product, 0) + 1);
    }

    public void removeProduct(Product product) {
        products.remove(product);
    }

    public void updateQuantity(Product product, int quantity) {
        if (quantity <= 0) {
            products.remove(product);
        } else {
            products.put(product, quantity);
        }
    }
}