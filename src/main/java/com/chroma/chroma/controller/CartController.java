package com.chroma.chroma.controller;

import com.chroma.chroma.model.Cart;
import com.chroma.chroma.model.Product;
import com.chroma.chroma.repository.ProductRepo;
import com.chroma.chroma.service.CartCookieService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final ProductRepo productRepo;
    private final CartCookieService cartCookieService;

    public CartController(ProductRepo productRepo, CartCookieService cartCookieService) {
        this.productRepo       = productRepo;
        this.cartCookieService = cartCookieService;
    }

    // ── Helper: get (or restore) cart from session / cookie ──────────────────
    private Cart getCart(HttpServletRequest request, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            // Restore from cookie (e.g. after session expiry / remember-me login)
            cart = cartCookieService.loadCartFromCookie(request);
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // ── GET /cart → cart.html ────────────────────────────────────────────────
    @GetMapping
    public String showCart(HttpServletRequest request, HttpSession session, Model model) {
        Cart cart = getCart(request, session);
        model.addAttribute("cart", cart.getProducts());
        return "cart";
    }

    // ── POST /cart/add/{id} ───────────────────────────────────────────────────
    @PostMapping("/add/{id}")
    @ResponseBody
    public String addProduct(@PathVariable Long id,
                             HttpServletRequest request,
                             HttpServletResponse response,
                             HttpSession session) {
        Optional<Product> product = productRepo.findById(id);
        if (product.isPresent()) {
            Cart cart = getCart(request, session);
            cart.addProduct(product.get());
            session.setAttribute("cart", cart);
            cartCookieService.saveCartToCookie(cart, response);
            return "Added to cart";
        }
        return "Product not found";
    }

    // ── DELETE /cart/remove/{id} ──────────────────────────────────────────────
    @DeleteMapping("/remove/{id}")
    @ResponseBody
    public String removeProduct(@PathVariable Long id,
                                HttpServletRequest request,
                                HttpServletResponse response,
                                HttpSession session) {
        Optional<Product> product = productRepo.findById(id);
        if (product.isPresent()) {
            Cart cart = getCart(request, session);
            cart.removeProduct(product.get());
            session.setAttribute("cart", cart);
            cartCookieService.saveCartToCookie(cart, response);
            return "Removed";
        }
        return "Product not found";
    }

    // ── POST /cart/update/{id}?quantity=N ────────────────────────────────────
    @PostMapping("/update/{id}")
    @ResponseBody
    public String updateQty(@PathVariable Long id,
                            @RequestParam int quantity,
                            HttpServletRequest request,
                            HttpServletResponse response,
                            HttpSession session) {
        Cart cart = getCart(request, session);
        productRepo.findById(id).ifPresent(p -> cart.updateQuantity(p, quantity));
        session.setAttribute("cart", cart);
        cartCookieService.saveCartToCookie(cart, response);
        return "Updated";
    }

    // ── GET /cart/count → returns total item count ───────────────────────────
    @GetMapping("/count")
    @ResponseBody
    public int getCartCount(HttpServletRequest request, HttpSession session) {
        Cart cart = getCart(request, session);
        return cart.getProducts().values().stream().mapToInt(Integer::intValue).sum();
    }

    // ── For CheckoutController ────────────────────────────────────────────────
    public Map<Product, Integer> getCartProducts(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        return cart == null ? Map.of() : cart.getProducts();
    }

    public void clearCart(HttpSession session, HttpServletResponse response) {
        session.removeAttribute("cart");
        cartCookieService.clearCartCookie(response);
    }
}
