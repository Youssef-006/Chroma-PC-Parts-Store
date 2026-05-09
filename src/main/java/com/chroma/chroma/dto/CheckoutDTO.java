package com.chroma.chroma.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CheckoutDTO {

    @NotBlank(message = "Street address is required")
    @Size(max = 300, message = "Address is too long")
    private String address;

    private String apt; // optional

    @NotBlank(message = "City is required")
    @Size(max = 100, message = "City name is too long")
    private String city;

    @NotBlank(message = "Governorate is required")
    @Size(max = 100, message = "Governorate name is too long")
    private String governorate;

    @NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^[0-9+\\-\\s()]{7,20}$", message = "Enter a valid phone number")
    private String phone;

    private boolean leaveAtDoor;

    @NotBlank(message = "Please select a payment method")
    @Pattern(regexp = "^(cash|card)$", message = "Invalid payment method")
    private String paymentMethod;
}
