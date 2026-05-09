package com.chroma.chroma.service;

import com.chroma.chroma.model.Cart;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.repository.ProductRepo;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Optional;

/**
 * Encodes the cart as a cookie value:
 *   chroma-cart = "101:2,203:1,405:3"   (productId:qty pairs, comma-separated)
 * Cookie lasts 30 days; expires on logout.
 */
@Service
@RequiredArgsConstructor
public class CartCookieService {

    public static final String COOKIE_NAME = "chroma-cart";
    private static final int MAX_AGE_SECONDS = 30 * 24 * 60 * 60; // 30 days

    private final ProductRepo productRepo;

    // ── Save cart → cookie ────────────────────────────────────────────────────
    public void saveCartToCookie(Cart cart, HttpServletResponse response) {
        StringBuilder sb = new StringBuilder();
        cart.getProducts().forEach((product, qty) ->
                sb.append(product.getId()).append(":").append(qty).append(","));

        String value = sb.length() > 0
                ? sb.substring(0, sb.length() - 1)   // remove trailing comma
                : "";

        Cookie cookie = new Cookie(COOKIE_NAME, URLEncoder.encode(value, StandardCharsets.UTF_8));
        cookie.setMaxAge(MAX_AGE_SECONDS);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    // ── Load cart ← cookie ────────────────────────────────────────────────────
    public Cart loadCartFromCookie(HttpServletRequest request) {
        Cart cart = new Cart();

        if (request.getCookies() == null) return cart;

        Optional<Cookie> cookieOpt = Arrays.stream(request.getCookies())
                .filter(c -> COOKIE_NAME.equals(c.getName()))
                .findFirst();

        if (cookieOpt.isEmpty()) return cart;

        String raw = URLDecoder.decode(cookieOpt.get().getValue(), StandardCharsets.UTF_8);
        if (raw.isBlank()) return cart;

        for (String pair : raw.split(",")) {
            String[] parts = pair.split(":");
            if (parts.length != 2) continue;
            try {
                Long productId = Long.parseLong(parts[0].trim());
                int qty        = Integer.parseInt(parts[1].trim());
                productRepo.findById(productId).ifPresent(product -> {
                    for (int i = 0; i < qty; i++) cart.addProduct(product);
                });
            } catch (NumberFormatException ignored) {
                // skip malformed entries
            }
        }

        return cart;
    }

    // ── Clear cookie (on logout / after order) ────────────────────────────────
    public void clearCartCookie(HttpServletResponse response) {
        Cookie cookie = new Cookie(COOKIE_NAME, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
