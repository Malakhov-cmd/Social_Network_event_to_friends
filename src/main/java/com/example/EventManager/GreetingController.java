package com.example.EventManager;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GreetingController {

    @GetMapping("/greeting")
    public String greeting(@RequestParam(name="name", required=false, defaultValue="Hello World") String name, Model model) {
        model.addAttribute("name", name);
        //возвращаем имя файла который мы хотим отобразить
        return "greeting";
    }

}
