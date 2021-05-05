package com.example.EventManager.controller;

import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Controller
public class ProfileController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;

    @GetMapping("/profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable("user") User user,
                             Model model)
    {
        if (currentUser == null) {
            return "main";
        }

        List<User> friendList = user.getFriendList();

        model.addAttribute("friendList", friendList);
        model.addAttribute("user", user);
        return "profile";
    }

    @PostMapping("/profile/{user}")
    public String postProfile(@AuthenticationPrincipal User currentUser,
                              @PathVariable("user") User user,
                              @RequestParam String friendId,
                              Model model)
    {
        User futureFriend = userRepo.findByid(Long.getLong(friendId));

        if(futureFriend == null)
        {
            model.addAttribute("friend" , null);
        } else {
            List<User> listRespond = user.getFriendRespondList();
            listRespond.add(futureFriend);

            List<User> listRequest = futureFriend.getFriendRequestList();
            listRequest.add(user);

            userRepo.save(user);
            userRepo.save(futureFriend);

            model.addAttribute("friend", futureFriend);
        }

        return "profile";
    }
}
