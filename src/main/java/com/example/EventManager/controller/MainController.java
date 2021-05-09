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
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
    @Autowired
    private RoomRepo roomRepo;

    //получение значение properties
    @Value("${upload.path}")
    private String uploadPath;

    @GetMapping("/")
    public String greeting(Model model) {
        return "greeting";
    }

    @GetMapping("/room/{roomName}/{room}/{user}")
    public String main(@AuthenticationPrincipal User currentUser,
                       @PathVariable String roomName,
                       @PathVariable Room room,
                       @PathVariable User user,
                       @RequestParam(required = false) String filter,
                       Model model) {
        List<Message> roomMessage = room.getRoomMessage();

        if (filter != null && !filter.isEmpty()) {
            roomMessage = messageRepo.findByHeader(filter);
        }

        model.addAttribute("messages", roomMessage);
        model.addAttribute("filter", filter);
        model.addAttribute("user", user);
        return "main";
    }

    @PostMapping("/room/{roomName}/{room}/{user}")
    public String add(@AuthenticationPrincipal User currentUser,
                      @PathVariable String roomName,
                      @PathVariable Room room,
                      @PathVariable User user,
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

        List<Message> roomMessage = room.getRoomMessage();
        roomMessage.add(message);
        room.setRoomMessage(roomMessage);
        roomRepo.save(room);

        model.put("activity", activityType);

        Iterable<Message> messages = room.getRoomMessage();
        model.put("messages", messages);
        model.put("user", user);
        return "main";
    }

    @PostMapping("filter")
    public String filter(@RequestParam String filter,
                         Map<String, Object> model) {
        return "main";
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
