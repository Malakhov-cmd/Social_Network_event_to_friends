package com.example.EventManager.controller;

import com.example.EventManager.domain.*;
import com.example.EventManager.repos.*;
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
    @Autowired
    private VoteMessageRepo voteMessageRepo;
    @Autowired
    private VoteRepo voteRepo;


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
                       Model model) {
        Iterable<Message> messages = messageRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
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
        Date date = new Date();
        Message message = new Message(header, theme, activityType, text, user);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFileName));

            message.setFilename(resultFileName);
        }

        message.setDate(date.toString());

        VoteMessage voteMessage = new VoteMessage(user);

        Vote autoVotedAuthor = new Vote(user);
        autoVotedAuthor.setDecision("Agree");
        autoVotedAuthor.setDate(date.toString());
        voteRepo.save(autoVotedAuthor);

        List<Vote> votedUser = voteMessage.getVotedUsers();
        votedUser.add(autoVotedAuthor);
        voteMessageRepo.save(voteMessage);

        messageRepo.save(message);

        model.put("activity", activityType);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);

        return "main";
    }

    @PostMapping("filter")
    public String filter(@RequestParam String filter,
                         Map<String, Object> model) {
        return "main";
    }

    @GetMapping("/profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable("user") User user,
                             Model model) {
        if (currentUser == null) {
            return "main";
        }

        HashMap<User, Integer> userIdDialog = new HashMap<>();
        List<User> userList = userRepo.findAll();
        for (int i = 0; i < userList.size(); i++) {
        }

        user.setDialogList(dialogRepo.findAll());
        for (int i = 0; i < user.getDialogList().size(); i++) {
        }

        for (int i = 0; i < userList.size(); i++) {
            if (!user.getId().equals(userList.get(i).getId())) {
                userIdDialog.put(userList.get(i), user.getIdDialog(user, userList.get(i)));
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
                            Model model) {
        Dialog newDialog;
        if (dialogId == null || dialogId < 1) {
            newDialog = new Dialog(firstUser, secondUser, new ArrayList<>());
        } else {
            newDialog = dialogRepo.findByid(dialogId);
        }
        dialogRepo.save(newDialog);
        dialogRepo.flush();

        Dialog dialog = dialogRepo.findByid(newDialog.getId());
        System.out.println("GET:" + dialog.getId());
        if (!dialog. getDialogMessageList().isEmpty()
                || dialog.getDialogMessageList() != null) {
            System.out.println("GET not null");
            model.addAttribute("dialog", dialog);
            model.addAttribute("dialogSize", dialog.getDialogMessageList().size());

            model.addAttribute("user", firstUser.getId());
            model.addAttribute("target", secondUser.getId());
            model.addAttribute("dialogMessList", dialog.getDialogMessageList());
        } else {
            System.out.println("GET true null");
            model.addAttribute("dialog", null);
        }
        return "dialog";
    }

    @PostMapping("/dialog/{dialogId}/{user1}/{user2}")
    public String printDialog(@RequestParam String MessageText,
                              @PathVariable("dialogId") Integer dialogId,
                              @PathVariable("user1") User firstUser,
                              @PathVariable("user2") User secondUser,
                              Model model) {
        if(dialogId == -1){
            List<Dialog> list = dialogRepo.findAll();
            for (Dialog dialog:
                 list) {
                if(dialog.getFirstUser().getId().equals(firstUser.getId())
                        && dialog.getSecondUser().getId().equals(secondUser.getId()))
                {
                    dialogId = dialog.getId();
                }
            }
        }

        System.out.println("POST: " + dialogId);

        Dialog dialogFirst = dialogRepo.findByid(dialogId);
        if (dialogFirst.getDialogMessageList().isEmpty()
                || dialogFirst.getDialogMessageList() == null) {
            System.out.println("First was empty");
            dialogFirst.setDialogMessageList(new ArrayList<>());
        }
        List<DialogMessage> dialogMes = dialogFirst.getDialogMessageList();

        Date dateMess = new Date();
        String currentDate = dateMess.toString();

        DialogMessage newDialogMessage = new DialogMessage(firstUser, secondUser, MessageText);
        newDialogMessage.setDate(currentDate);

        dialogMessageRepo.save(newDialogMessage);
        dialogMessageRepo.flush();

        dialogMes.add(newDialogMessage);
        dialogFirst.setDialogMessageList(dialogMes);

        dialogRepo.save(dialogFirst);
        dialogRepo.flush();

        System.out.println("First add message(size): " + dialogRepo.findByid(dialogFirst.getId()).getDialogMessageList().size());
        System.out.println("Message from first: " + dialogMessageRepo.findByid(newDialogMessage.getId()).getText());

        Dialog secondDialog = null;
        for (Dialog dialog2:
             dialogRepo.findAll()) {
            if (dialog2.getFirstUser().getId().equals(secondUser.getId())
                && dialog2.getSecondUser().getId().equals(firstUser.getId())) {
               secondDialog = dialog2;
                System.out.println("Found second dialog side");
            }
        }

        if(secondDialog == null) {
            System.out.println("Not Found");
            secondDialog = new Dialog(secondUser, firstUser, new ArrayList<>());
            dialogRepo.save(secondDialog);
            dialogRepo.flush();
        }

        DialogMessage newSecondDialogMessage = new DialogMessage(firstUser, secondUser, MessageText);
        newSecondDialogMessage.setDate(currentDate);
        List<DialogMessage> dialogMesSecond = secondDialog.getDialogMessageList();
        dialogMesSecond.add(newSecondDialogMessage);
        secondDialog.setDialogMessageList(dialogMesSecond);


        dialogRepo.save(secondDialog);
        dialogRepo.flush();

        dialogMessageRepo.save(newSecondDialogMessage);
        dialogMessageRepo.flush();

        System.out.println("Dialog check: " + dialogRepo.findByid(secondDialog.getId()).getId());
        System.out.println("Second add message: " + dialogMessageRepo.findByid(newSecondDialogMessage.getId()).getText());

        model.addAttribute("dialogSize", dialogFirst.getDialogMessageList().size());
        model.addAttribute("user", firstUser.getId());
        model.addAttribute("target", secondUser.getId());
        model.addAttribute("dialogMessList", dialogFirst.getDialogMessageList());
        model.addAttribute("NewDialogMessage", newDialogMessage);

        return "dialog";
    }
}
