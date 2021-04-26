package com.example.EventManager;

import com.example.EventManager.domain.Message;
import com.example.EventManager.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class GreetingController {
    @Autowired
    private MessageRepo messageRepo;

    @GetMapping("/greeting")
    public String greeting(@RequestParam(name="name", required=false, defaultValue="Hello World") String name, Model model) {
        model.addAttribute("name", name);
        //возвращаем имя файла который мы хотим отобразить
        return "greeting";
    }

    @GetMapping
    public String main(Map<String, Object> model)
    {
        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "main";
    }

    @PostMapping
    public String add(@RequestParam String header,
                      @RequestParam String theme,
                      @RequestParam String text,
                      @RequestParam String date,
                      @RequestParam String author,
                      Map<String, Object> model)
    {
        Message message = new Message(header, theme, text, date, author);

        messageRepo.save(message);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "main";
    }
}
