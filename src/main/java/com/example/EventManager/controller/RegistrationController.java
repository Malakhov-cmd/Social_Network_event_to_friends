package com.example.EventManager.controller;

import com.example.EventManager.domain.Role;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;

@Controller
public class RegistrationController {
    @Autowired
    private UserRepo userRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/registration")
    public String registration()
    {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@Valid User user,
                          BindingResult bindingResult,
                          Model model,
                          @RequestParam(name = "avatar", required = true) MultipartFile avatar) throws IOException {
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if(userFromDb != null)
        {
            model.addAttribute("message", "User exists");
            return "registration";
        }
        if (bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("userError", user);
        } else {
            System.out.println("File name: " + avatar.getOriginalFilename());
            if (avatar != null && !avatar.getOriginalFilename().isEmpty()) {
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                String uuidFile = UUID.randomUUID().toString();
                String resultFileName = uuidFile + "." + avatar.getOriginalFilename();

                File f = new File(uploadPath + "/" + resultFileName);

                avatar.transferTo(f);

                user.setAvatarFilename(resultFileName);
            }

            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setActive(true);
            user.setRoles(Collections.singleton(Role.USER));

            model.addAttribute("userError", null);

            userRepo.save(user);

            return "redirect:/login";
        }
        return "registration";
    }
}
