package com.example.EventManager.controller;

import com.example.EventManager.domain.Role;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.Map;
import java.util.UUID;

@Controller
public class RegistrationController {
    @Autowired
    private UserRepo userRepo;

    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/registration")
    public String registration()
    {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(User user,
                          Map<String, Object> model,
                          @RequestParam(name = "avatar", required = true) MultipartFile file) throws IOException {
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if(userFromDb != null)
        {
            model.put("message", "User exists");
            return "registration";
        }
        System.out.println("File name: " + file.getOriginalFilename());
        if(file != null && !file.getOriginalFilename().isEmpty())
        {
            File uploadDir = new File(uploadPath);

            if(uploadDir.exists())
            {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFileName));

            user.setAvatarFilename(resultFileName);
        }

        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        userRepo.save(user);

        return "redirect:/login";
    }
}
