package com.example.EventManager.controller;

import com.example.EventManager.domain.*;
import com.example.EventManager.repos.TwitBoardMessageCommentRepo;
import com.example.EventManager.repos.TwitBoardMessageRepo;
import com.example.EventManager.repos.TwitBoardRepo;
import com.example.EventManager.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class TwitBoardConroller {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private TwitBoardRepo twitBoardRepo;

    @Autowired
    private TwitBoardMessageRepo twitBoardMessageRepo;

    @Autowired
    private TwitBoardMessageCommentRepo boardMessageCommentRepo;

    @GetMapping("/twitboard/{user}")
    public String main(@AuthenticationPrincipal User currentUser,
                       @PathVariable User user,
                       Model model) {
        TwitBoard twitBoard = twitBoardRepo.findByid(user.getIdBoard());

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());
        return "twitBoard";
    }

    @PostMapping("/twitboard/{user}")
    public String add(@AuthenticationPrincipal User currentUser,
                      @PathVariable User user,
                      @Valid TwitBoardMessage twitMessage,
                      BindingResult bindingResult,
                      Model model,
                      @RequestParam(required = false) String theme,
                      @RequestParam(required = false) String text) {
        Date date = new Date();
        twitMessage.setAuthor(user);

        TwitBoard twitBoard = twitBoardRepo.findByid(user.getIdBoard());

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("twitMessage", twitMessage);
        } else {
            model.addAttribute("twitMessage", null);

            TwitBoardMessage twitBoardMessage = new TwitBoardMessage(user, theme, text);
            twitBoardMessage.setDate(date.toString());
            twitBoardMessageRepo.save(twitBoardMessage);

            List<TwitBoardMessage> twitBoardMessageList = twitBoard.getTwitBoardMessageList();
            twitBoardMessageList.add(twitBoardMessage);
            twitBoard.setTwitBoardMessageList(twitBoardMessageList);
            twitBoardRepo.save(twitBoard);
        }

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());

        return "twitBoard";
    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(@AuthenticationPrincipal User currentUser,
                             Model model,
                             @RequestParam(required = false) String commentText,
                             @RequestParam(required = false) Long twitMessageRequaredTocomment,
                             @RequestParam(required = false) Long twitBoardreqiaredToComment,
                             @RequestParam(required = false) Long twitUserToreturn) {
        Date date = new Date();

        TwitBoard twitBoard = twitBoardRepo.findByid(twitBoardreqiaredToComment);
        TwitBoardMessage twitBoardMessage = twitBoardMessageRepo.findByid(twitMessageRequaredTocomment);
        TwitBoardMessageComment twitBoardMessageComment = new TwitBoardMessageComment(currentUser, commentText);

        twitBoardMessageComment.setDateComment(date.toString());

        boardMessageCommentRepo.save(twitBoardMessageComment);

        List<TwitBoardMessageComment> twitBoardMessageCommentList = twitBoardMessage.getTwitBoardMessageComments();
        twitBoardMessageCommentList.add(twitBoardMessageComment);
        twitBoardMessage.setTwitBoardMessageComments(twitBoardMessageCommentList);

        twitBoardMessageRepo.save(twitBoardMessage);

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());

        return "redirect:/twitboard/" + twitUserToreturn;
    }

    @RequestMapping(value = "/messageLike", method = RequestMethod.POST)
    public String messageLike(@AuthenticationPrincipal User currentUser,
                              Model model,
                              @RequestParam(required = false) Long twitMessageLiked,
                              @RequestParam(required = false) Long twitUserToReturn
    ) {
        User user = userRepo.findByid(twitUserToReturn);
        TwitBoard twitBoard = twitBoardRepo.findByid(user.getIdBoard());
        TwitBoardMessage twitBoardMessage = twitBoardMessageRepo.findByid(twitMessageLiked);

        boolean liked = false;
        int position = -1;
        List<User> userList = twitBoardMessage.getLikesList();
        for (int i = 0; i < userList.size(); i++) {
            if (userList.get(i).getId().equals(currentUser.getId())) {
                liked = true;
                position = i;
            }
        }

        if (!liked) {
            userList.add(currentUser);
            twitBoardMessage.setLikesList(userList);

            twitBoardMessageRepo.save(twitBoardMessage);
        } else {
            userList.remove(position);
            twitBoardMessage.setLikesList(userList);

            twitBoardMessageRepo.save(twitBoardMessage);
        }

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());

        return "redirect:/twitboard/" + twitUserToReturn;
    }

    @RequestMapping(value = "/commentLike", method = RequestMethod.POST)
    public String commentLike(@AuthenticationPrincipal User currentUser,
                              Model model,
                              @RequestParam(required = false) Long twitCommentLiked,
                              @RequestParam(required = false) Long twitUserToReturn
    ) {
        User user = userRepo.findByid(twitUserToReturn);
        TwitBoard twitBoard = twitBoardRepo.findByid(user.getIdBoard());
        TwitBoardMessageComment twitBoardMessageComment = boardMessageCommentRepo.findByid(twitCommentLiked);

        boolean liked = false;
        int position = -1;
        List<User> userList = twitBoardMessageComment.getLikesListComment();
        for (int i = 0; i < userList.size(); i++) {
            if (userList.get(i).getId().equals(currentUser.getId())) {
                liked = true;
                position = i;
            }
        }
        if (!liked) {
            userList.add(currentUser);
            twitBoardMessageComment.setLikesListComment(userList);

            boardMessageCommentRepo.save(twitBoardMessageComment);
        } else {
            userList.remove(position);
            twitBoardMessageComment.setLikesListComment(userList);

            boardMessageCommentRepo.save(twitBoardMessageComment);
        }

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());
        return "redirect:/twitboard/" + twitUserToReturn;
    }
}
