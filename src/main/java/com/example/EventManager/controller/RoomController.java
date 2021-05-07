package com.example.EventManager.controller;

import com.example.EventManager.domain.User;
import com.example.EventManager.repos.RoomRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class RoomController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private RoomRepo roomRepo;

    @GetMapping("/rooms/{user}")
    public String getRooms(@AuthenticationPrincipal User currentUser,
                           @PathVariable("user") User user,
                           Model model)
    {
        model.addAttribute("user", user);
        model.addAttribute("rooms", user.getRooms());
        model.addAttribute("roomsSize", user.getRooms().size());
        return "rooms";
    }
}
