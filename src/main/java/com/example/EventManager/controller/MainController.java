package com.example.EventManager.controller;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.DialogMessage;
import com.example.EventManager.domain.Message;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogMessageRepo;
import com.example.EventManager.repos.DialogRepo;
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
import java.util.*;

@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;
    @Autowired
    private DialogMessageRepo dialogMessageRepo;


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
        if(currentUser == null)
        {
            return "main";
        }

        HashMap<User, Integer> userIdDialog = new HashMap<>();
        List<User> userList = userRepo.findAll();
        for (int i=0; i<userList.size(); i++){
            System.out.println("UserList: " + userList.get(i).getUsername());
        }

        user.setDialogList(dialogRepo.findAll());
        for (int i=0; i< user.getDialogList().size(); i++){
            System.out.println("dialogId: " + user.getDialogList().get(i).getId());
        }

        for(int i = 0; i < userList.size(); i++)
        {
            if(!user.getId().equals(userList.get(i).getId()))
            {
                userIdDialog.put(userList.get(i), user.getIdDialog(user, userList.get(i)));
                System.out.println("User to connect name: " + userList.get(i).getUsername());
                System.out.println("Id dialog: " + user.getIdDialog(user, userList.get(i)));
                System.out.println();
            }
        }

        model.addAttribute("userList", userList);
        model.addAttribute("userIdDialog", userIdDialog);
        model.addAttribute("user", user);

        return "profile";
    }

    @GetMapping("/dialog/{dialogId}/{user1}/{user2}")
    public String getDialog(@PathVariable("dialogId") Integer dialogId,
                            @PathVariable("user1") User firstUser,
                            @PathVariable("user2") User secondUser,
                            Model model)
    {
        Dialog newDialog;
        if(dialogId == null || dialogId < 1)
        {
            newDialog = new Dialog(firstUser, secondUser, new ArrayList<>());
        } else {
            newDialog = dialogRepo.findByid(dialogId);
        }
        dialogRepo.save(newDialog);

        dialogRepo.flush();

        Dialog dialog = dialogRepo.findByid(newDialog.getId());

        if(!dialog.getDialogMessageList().isEmpty()
            || dialog.getDialogMessageList() != null) {
            model.addAttribute("dialog", dialog.getDialogMessageList());
        } else {
            model.addAttribute("dialog", false);
        }
        return "dialog";
    }

    @PostMapping("/dialog/{dialogId}/{user1}/{user2}")
    public String printDialog(@RequestParam String MessageText,
                              @PathVariable("dialogId") Integer dialogId,
                              @PathVariable("user1") User firstUser,
                              @PathVariable("user2") User secondUser,
                              Model model)
    {
        if(dialogId != -1)
        {
            Dialog dialog = dialogRepo.findByid(dialogId);

            if(dialog.getDialogMessageList().isEmpty()
                || dialog.getDialogMessageList() == null)
            {
                dialog.setDialogMessageList(new ArrayList<>());
            }
            List<DialogMessage> dialogMes = dialog.getDialogMessageList();
            DialogMessage newDialogMessage = new DialogMessage(firstUser, secondUser, MessageText);
            dialogMes.add(newDialogMessage);

            if(dialogRepo.findByid(secondUser.getId().intValue()) == null)
            {
                Dialog newSecondMessage = new Dialog(secondUser, firstUser, new ArrayList<>());
                dialogRepo.save(newSecondMessage);
                dialogRepo.flush();
            }

            Dialog secondDialog = dialogRepo.findByid(secondUser.getId().intValue());
            DialogMessage newSecondDialogMessage = new DialogMessage(secondUser, firstUser, MessageText);
            secondDialog.getDialogMessageList().add(newSecondDialogMessage);

            dialogRepo.save(dialog);
            dialogRepo.flush();
            dialogRepo.save(secondDialog);
            dialogRepo.flush();
            dialogMessageRepo.save(newDialogMessage);
            dialogMessageRepo.flush();
            dialogMessageRepo.save(newSecondDialogMessage);
            dialogMessageRepo.flush();

            model.addAttribute("dialogMessList", dialog.getDialogMessageList());
            model.addAttribute("NewDialogMessage", newDialogMessage);
        }
        return "dialog";
    }
}
