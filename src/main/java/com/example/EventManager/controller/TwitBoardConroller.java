package com.example.EventManager.controller;

import com.example.EventManager.domain.TwitBoard;
import com.example.EventManager.domain.TwitBoardMessage;
import com.example.EventManager.domain.TwitBoardMessageComment;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.TwitBoardMessageCommentRepo;
import com.example.EventManager.repos.TwitBoardMessageRepo;
import com.example.EventManager.repos.TwitBoardRepo;
import com.example.EventManager.repos.UserRepo;
import com.example.EventManager.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class TwitBoardConroller {
    @Autowired
    private StorageService service;

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

        Collections.sort(twitBoard.getTwitBoardMessageList(), Collections.reverseOrder(TwitBoardMessage.CompareTwitsByDate));

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
                      @RequestParam(required = false) String text,
                      @RequestParam(required = false) MultipartFile twitFileMessageFile) {
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

            if (twitFileMessageFile != null && !twitFileMessageFile.getOriginalFilename().isEmpty()) {
                String resultFileName = service.uploadFile(twitFileMessageFile);
                twitBoardMessage.setFilename(resultFileName);
            }

            twitBoardMessage.setDate(date.toString());
            twitBoardMessageRepo.save(twitBoardMessage);

            List<TwitBoardMessage> twitBoardMessageList = twitBoard.getTwitBoardMessageList();
            twitBoardMessageList.add(twitBoardMessage);

            Collections.sort(twitBoardMessageList, Collections.reverseOrder(TwitBoardMessage.CompareTwitsByDate));

            twitBoard.setTwitBoardMessageList(twitBoardMessageList);
            twitBoardRepo.save(twitBoard);
        }

        model.addAttribute("twitMessageSize", twitBoard.getTwitBoardMessageList().size());
        model.addAttribute("twitMessage", twitBoard.getTwitBoardMessageList());

        return "twitBoard";
    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(@AuthenticationPrincipal User currentUser,
                             @Valid TwitBoardMessageComment twitMessageComment,
                             BindingResult bindingResult,
                             Model model,
                             @RequestParam(required = false) String commentText,
                             @RequestParam(required = false) Long twitMessageRequaredTocomment,
                             @RequestParam(required = false) Long twitBoardreqiaredToComment,
                             @RequestParam(required = false) Long twitUserToreturn,
                             @RequestParam(required = false) MultipartFile twitFileMessageCommentFile) {
        Date date = new Date();

        TwitBoard twitBoard = twitBoardRepo.findByid(twitBoardreqiaredToComment);
        TwitBoardMessage twitBoardMessage = twitBoardMessageRepo.findByid(twitMessageRequaredTocomment);
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("twitMessageComment", twitMessageComment);
        } else {
            model.addAttribute("twitMessageComment", null);

            TwitBoardMessageComment twitBoardMessageComment = new TwitBoardMessageComment(currentUser, commentText);

            if (twitFileMessageCommentFile != null && !twitFileMessageCommentFile.getOriginalFilename().isEmpty()) {
                String resultFileName = service.uploadFile(twitFileMessageCommentFile);
                twitBoardMessageComment.setFilename(resultFileName);
            }

            twitBoardMessageComment.setDateComment(date.toString());

            boardMessageCommentRepo.save(twitBoardMessageComment);

            List<TwitBoardMessageComment> twitBoardMessageCommentList = twitBoardMessage.getTwitBoardMessageComments();
            twitBoardMessageCommentList.add(twitBoardMessageComment);

            Collections.sort(twitBoardMessageCommentList, Collections.reverseOrder(TwitBoardMessageComment.CompareTwitsCommentsByDate));

            twitBoardMessage.setTwitBoardMessageComments(twitBoardMessageCommentList);

            twitBoardMessageRepo.save(twitBoardMessage);
        }

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
