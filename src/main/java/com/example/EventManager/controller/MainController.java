package com.example.EventManager.controller;

import com.example.EventManager.domain.Message;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.MessageRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    @Autowired
    private UserRepo userRepo;

    //получение значение properties
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model) {
        //возвращаем имя файла который мы хотим отобразить
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter,
                        Model model)
    {
        Iterable<Message> messages = messageRepo.findAll();

        if(filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByText(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);

        return "main";
    }

    @PostMapping("/main")
    public String add(@AuthenticationPrincipal User user,
                      @RequestParam String header,
                      @RequestParam String theme,
                      @RequestParam String activityType,
                      @RequestParam String text,
                      Map<String, Object> model,
                      @RequestParam("file") MultipartFile file) throws IOException {
        Message message = new Message(header, theme, activityType, text, user);

        System.out.println(activityType);

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

            message.setFilename(resultFileName);
        }
        Date date = new Date();
        message.setDate(date.toString());
        messageRepo.save(message);

        model.put("activity", activityType);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "main";
    }

    @PostMapping("filter")
    public String filter(@RequestParam String filter,
                         Map<String, Object> model)
    {
        return "main";
    }

    @GetMapping("/profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable("user") User user,
                             Model model)
    {
        System.out.println(currentUser.getUsername());
        System.out.println(user.getUsername());
        return "profile";
    }
}
