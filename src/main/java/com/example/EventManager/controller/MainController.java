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
    @Autowired
    private VoteMessageDialogRepo voteMessageDialogRepo;
    @Autowired
    private VoteMessageDialogMesRepo voteMessageDialogMesRepo;

    //получение значение properties
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model) {
        //возвращаем имя файла который мы хотим отобразить
        return "greeting";
    }

    @GetMapping("/main")
    public String main(@AuthenticationPrincipal User user,
                        @RequestParam(required = false, defaultValue = "") String filter,
                       Model model) {
        Iterable<Message> messages = messageRepo.findAll();

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByText(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", filter);
        model.addAttribute("user", user);
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
        voteMessage.setVotedUsers(votedUser);

        VoteMessageDialog voteMessageDialog = new VoteMessageDialog(user);
        voteMessage.setVoteMessageDialog(voteMessageDialog);

        voteMessageRepo.save(voteMessage);

        message.setVoteMessage(voteMessage);
        messageRepo.save(message);

        model.put("activity", activityType);

        Iterable<Message> messages = messageRepo.findAll();
        model.put("messages", messages);
        model.put("user", user);
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

    @GetMapping("/vote/{messageId}/{user}")
    public String getVoted(@PathVariable Integer messageId,
                           @PathVariable User user,
                           Model model)
    {
        Message message = messageRepo.findById(messageId);
        VoteMessage thisVoteMessage = message.getVoteMessage();

        model.addAttribute("message", message);
        model.addAttribute("user", user);

        boolean isAlreadyVoted = false;
        for (Vote vote:
             thisVoteMessage.getVotedUsers()) {
            if(vote.getUser().getId().equals(user.getId()))
            {
                isAlreadyVoted = true;
            }
        }

        if(isAlreadyVoted || message.getAuthor().getId().equals(user.getId())){
            System.out.println("Status:" + false);
            model.addAttribute("voteItems", false);
        } else {
            System.out.println("Status:" + true);
            model.addAttribute("voteItems", true);
        }

        List<Vote> listAgree = thisVoteMessage.getVoteAgree();
        List<Vote> listAgainst = thisVoteMessage.getVoteAgainst();
        List<Vote> listAbstain = thisVoteMessage.getVoteAbstain();


        model.addAttribute("usersVotedAgree", listAgree);
        model.addAttribute("usersVotedAgainst", listAgainst);
        model.addAttribute("usersVotedAbstain", listAbstain);
        int unVoted = userRepo.findAll().size() - listAgree.size()
                -  listAgainst.size() - listAbstain.size();

        model.addAttribute("usersUnVoted", unVoted);
        model.addAttribute("countUsers", userRepo.findAll().size());
        model.addAttribute("showDiagram", true);
        model.addAttribute("voteMessageDialog", thisVoteMessage.getVoteMessageDialog());
        return "vote";
    }

    @PostMapping("/vote/{messageId}/{user}")
    public String setVote(@PathVariable Integer messageId,
                          @PathVariable User user,
                          @RequestParam("voteChoose") String voteChoose,
                          Model model)
    {
        Date dateMess = new Date();

        Message message = messageRepo.findById(messageId);
        VoteMessage thisVoteMessage = message.getVoteMessage();

        if(!message.getAuthor().getId().equals(user.getId())) {
            Vote vote = new Vote(user);
            vote.setDecision(voteChoose);
            vote.setDate(dateMess.toString());

            voteRepo.save(vote);

            List<Vote> voteList = thisVoteMessage.getVotedUsers();
            voteList.add(vote);
            thisVoteMessage.setVotedUsers(voteList);

            voteMessageRepo.save(thisVoteMessage);
        }
        model.addAttribute("message", message);
        model.addAttribute("user", user);
        model.addAttribute("usersVotedAgree", thisVoteMessage.getVoteAgree());
        model.addAttribute("usersVotedAgainst", thisVoteMessage.getVoteAgainst());
        model.addAttribute("usersVotedAbstain", thisVoteMessage.getVoteAbstain());
        int unVoted = userRepo.findAll().size() - thisVoteMessage.getVoteAgree().size()
                -  thisVoteMessage.getVoteAgainst().size() - thisVoteMessage.getVoteAbstain().size();

        model.addAttribute("usersUnVoted", unVoted);
        model.addAttribute("countUsers", userRepo.findAll().size());
        model.addAttribute("showDiagram", true);

        boolean isAlreadyVoted = false;
        for (Vote vote:
                thisVoteMessage.getVotedUsers()) {
            if(vote.getUser().getId().equals(user.getId()))
            {
                isAlreadyVoted = true;
            }
        }

        if(isAlreadyVoted || message.getAuthor().getId().equals(user.getId())){
            System.out.println("Status:" + false);
            model.addAttribute("voteItems", false);
        } else {
            System.out.println("Status:" + true);
            model.addAttribute("voteItems", true);
        }
        model.addAttribute("voteMessageDialog", thisVoteMessage.getVoteMessageDialog());
        return "vote";
    }

    @GetMapping("/vote/discussion/{messageId}/{voteMessageDialogId}/{user}")
    public String getVoteMessageDialog(@PathVariable Integer messageId,
                                       @PathVariable Integer voteMessageDialogId,
                                       @PathVariable User user,
                                       Model model)
    {
        Message message = messageRepo.findById(messageId);
        VoteMessageDialog voteMessageDialog = voteMessageDialogRepo.findById(voteMessageDialogId);

        List<VoteMessageDialogMes> listMessage = voteMessageDialog.getDialogMessageList();

        model.addAttribute("user", user);
        model.addAttribute("message", message);
        model.addAttribute("dialog", voteMessageDialog);
        model.addAttribute("listMessages", listMessage);
        model.addAttribute("dialogSize", listMessage.size());
        return "voteDialog";
    }

    @PostMapping("/vote/discussion/{messageId}/{voteMessageDialogId}/{user}")
    public String postVoteMessageDialog(@PathVariable Integer messageId,
                                        @PathVariable Integer voteMessageDialogId,
                                        @PathVariable User user,
                                        Model model,
                                        @RequestParam String MessageText)
    {
        Date dateMes = new Date();

        Message message = messageRepo.findById(messageId);
        VoteMessageDialog voteMessageDialog = voteMessageDialogRepo.findById(voteMessageDialogId);

        VoteMessageDialogMes dialogMessage = new VoteMessageDialogMes(user);
        dialogMessage.setText(MessageText);
        dialogMessage.setDate(dateMes.toString());
        voteMessageDialogMesRepo.save(dialogMessage);

        List<VoteMessageDialogMes> listMessage = voteMessageDialog.getDialogMessageList();
        listMessage.add(dialogMessage);
        voteMessageDialog.setDialogMessageList(listMessage);
        voteMessageDialogRepo.save(voteMessageDialog);

        model.addAttribute("user", user);
        model.addAttribute("message", message);
        model.addAttribute("dialog", voteMessageDialog);
        model.addAttribute("listMessages", listMessage);
        model.addAttribute("dialogSize", listMessage.size());

        return "voteDialog";
    }
}
