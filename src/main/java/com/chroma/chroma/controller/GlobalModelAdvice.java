package com.chroma.chroma.controller;

import com.chroma.chroma.model.User;
import com.chroma.chroma.repository.UserRepo;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalModelAdvice {

    private final UserRepo userRepo;

    public GlobalModelAdvice(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @ModelAttribute
    public void addUserAttributes(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()
                && !"anonymousUser".equals(auth.getPrincipal())) {
            userRepo.findByEmail(auth.getName()).ifPresent(user -> {
                model.addAttribute("firstName", user.getFirstName());
                model.addAttribute("lastName", user.getLastName());
            });
        }
    }
}
