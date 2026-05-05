package com.chroma.chroma.controller;

import com.chroma.chroma.dto.LoginDTO;
import com.chroma.chroma.dto.RegisterDTO;
import com.chroma.chroma.model.User;
import com.chroma.chroma.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class AuthenticationController {

    private final UserService userService;

    // ─── REGISTER ───────────────────────────────────────────────

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "register";
    }

    @PostMapping("/register")
    public String handleRegister(@Valid @ModelAttribute("registerDTO") RegisterDTO dto,
                                 BindingResult result,
                                 Model model) {
        if (result.hasErrors()) {
            return "register";
        }

        if (userService.existsByEmail(dto.getEmail())) {
            model.addAttribute("error", "Email is already registered.");
            return "register";
        }

        User user = new User();
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setPassword(dto.getPassword()); // TODO: BCrypt hash later

        userService.save(user);
        return "redirect:/login?registered";
    }

    // ─── LOGIN ───────────────────────────────────────────────────

    @GetMapping("/login")
    public String showLoginForm(@RequestParam(required = false) String registered,
                                Model model) {
        model.addAttribute("loginDTO", new LoginDTO());
        if (registered != null) {
            model.addAttribute("success", "Account created! Please log in.");
        }
        return "login";
    }

    @PostMapping("/login")
    public String handleLogin(@Valid @ModelAttribute("loginDTO") LoginDTO dto,
                              BindingResult result,
                              Model model) {
        if (result.hasErrors()) {
            return "login";
        }

        var userOpt = userService.findByEmail(dto.getEmail());

        if (userOpt.isEmpty()) {
            model.addAttribute("error", "No account found with that email.");
            return "login";
        }

        User user = userOpt.get();

        if (!user.getPassword().equals(dto.getPassword())) { // TODO: BCrypt later
            model.addAttribute("error", "Incorrect password.");
            return "login";
        }

        return "redirect:/home";
    }
}