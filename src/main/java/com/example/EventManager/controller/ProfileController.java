package com.example.EventManager.controller;

import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class ProfileController {
    @Autowired
    private UserRepo userRepo;


}
