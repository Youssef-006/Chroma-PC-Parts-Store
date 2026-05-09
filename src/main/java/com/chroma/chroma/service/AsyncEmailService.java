package com.chroma.chroma.service;

import com.chroma.chroma.model.Order;
import com.chroma.chroma.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

/**
 * Sends emails asynchronously on a dedicated thread pool (see AsyncConfig).
 * The HTTP response is returned to the user immediately — email delivery
 * happens in the background without blocking the request thread.
 */
@Service
@RequiredArgsConstructor
public class AsyncEmailService {

    private final JavaMailSender mailSender;

    @Async("emailExecutor")
    public void sendOrderConfirmation(User user, Order order, String fullAddress) {
        try {
            StringBuilder itemLines = new StringBuilder();
            order.getItems().forEach(item -> itemLines.append(String.format(
                    "  • %s (x%d) — EGP %.2f%n",
                    item.getProductName(), item.getQuantity(), item.getLineTotal())));

            String emailBody = String.format("""
                    Hi %s,

                    Thank you for your order with Chroma! 🎉

                    ─────────────────────────────
                    ORDER #%d CONFIRMATION
                    ─────────────────────────────

                    📦 Items Ordered:
                    %s
                    ─────────────────────────────
                    Total: EGP %.2f
                    Shipping: Free
                    ─────────────────────────────

                    📍 Delivery Address:
                       %s, %s, %s

                    📱 Contact Number: %s
                    🚪 Leave at Door: %s
                    💳 Payment: %s

                    Your order is being processed and you'll receive
                    a shipping update soon.

                    Thank you for shopping with Chroma.
                    — The Chroma Team
                    """,
                    user.getFirstName(),
                    order.getId(),
                    itemLines,
                    order.getTotal(),
                    fullAddress, order.getCity(), order.getGovernorate(),
                    order.getPhone(),
                    order.isLeaveAtDoor() ? "Yes" : "No",
                    order.getPaymentMethod().equalsIgnoreCase("cash")
                            ? "Cash on Delivery" : "Credit / Debit Card"
            );

            SimpleMailMessage mail = new SimpleMailMessage();
            mail.setTo(user.getEmail());
            mail.setSubject("Chroma — Order #" + order.getId() + " Confirmed");
            mail.setText(emailBody);
            mail.setFrom("no-reply@chroma-store.com");
            mailSender.send(mail);

            System.out.printf("[Chroma] ✅ Confirmation email sent to %s for order #%d%n",
                    user.getEmail(), order.getId());

        } catch (Exception e) {
            System.err.printf("[Chroma] ❌ Email failed for order #%d: %s%n",
                    order.getId(), e.getMessage());
        }
    }
}
