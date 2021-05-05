package com.example.EventManager.controller;

import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class DialogController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;

    @GetMapping("/dialogs/{user}")
    public String getDialogList(@PathVariable("user") User user,
                                Model model)
    {
        return "dialogList";
    }
}
