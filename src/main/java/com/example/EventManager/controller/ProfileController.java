package com.example.EventManager.controller;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.User;
import com.example.EventManager.repos.DialogMessageRepo;
import com.example.EventManager.repos.DialogRepo;
import com.example.EventManager.repos.UserRepo;
import org.graalvm.compiler.lir.LIRInstruction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ProfileController {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private DialogRepo dialogRepo;
    @Autowired
    private DialogMessageRepo dialogMessageRepo;

    @GetMapping("/profile/{user}")
    public String getProfile(@AuthenticationPrincipal User currentUser,
                             @PathVariable("user") User user,
                             Model model) {
        User userUpdated = userRepo.findByid(user.getId());

        List<User> friendList = userUpdated.getFriendList();

        boolean isFriend = false;

        for (User usr :
                friendList) {
            if (usr.getId().equals(currentUser.getId())) {
                isFriend = true;
            }
        }
        if (isFriend) {
            model.addAttribute("isFriend", true);
        } else {
            model.addAttribute("isFriend", false);
        }

        model.addAttribute("userToCreateDialogNotFounded", false);
        model.addAttribute("friendList", friendList);
        model.addAttribute("user", userUpdated);
        model.addAttribute("requestFriendCount", userUpdated.getFriendRequestList().size());
        model.addAttribute("respondFriendCount", userUpdated.getFriendRespondList().size());
        model.addAttribute("FriendListSize", userUpdated.getFriendList().size());
        return "profile";
    }


    @PostMapping("/profile/{user}")
    public String postProfile(@AuthenticationPrincipal User currentUser,
                              @PathVariable("user") User user,
                              @RequestParam(required = false) Long friendId,
                              @RequestParam(required = false) Long userToDialog,
                              Model model) {
        User futureFriend = userRepo.findByid(friendId);

        //удаление из друзей
        if (!currentUser.getId().equals(user.getId())) {
            User currentUserUpdated = userRepo.findByid(currentUser.getId());

            List<User> currentFriend = currentUserUpdated.getFriendList();
            currentFriend.remove(user);
            currentUserUpdated.setFriendList(currentFriend);

            List<User> userFriend = user.getFriendList();
            userFriend.remove(currentUserUpdated);
            user.setFriendList(userFriend);

            userRepo.save(currentUserUpdated);
            userRepo.save(user);

            User updatedUser = userRepo.findByid(user.getId());

            model.addAttribute("userToCreateDialogNotFounded", false);
            model.addAttribute("isFriend", false);
            model.addAttribute("friendList", updatedUser.getFriendList());
            model.addAttribute("friend", futureFriend);
            model.addAttribute("user", updatedUser);
            model.addAttribute("requestFriendCount", updatedUser.getFriendRequestList().size());
            model.addAttribute("respondFriendCount", updatedUser.getFriendRespondList().size());
            model.addAttribute("FriendListSize", updatedUser.getFriendList().size());
        } else {
            //создание диалога
            if (userToDialog != null
                    && userToDialog >= 1) {
                User dialogUser = userRepo.findByid(userToDialog);

                if (dialogUser == null) {
                    model.addAttribute("userToCreateDialogNotFounded", true);
                } else {

                    Integer dialogFromFirstId = null;
                    Integer dialogFromSecondId = null;

                    for (Dialog dialog
                            : dialogRepo.findAll()) {
                        if (dialog.getFirstUser().getId().equals(user.getId())
                                && dialog.getSecondUser().getId().equals(dialogUser.getId())) {
                            dialogFromFirstId = dialog.getId();
                        } else {
                            if (dialog.getFirstUser().getId().equals(dialogUser.getId())
                                    && dialog.getSecondUser().getId().equals(user.getId())) {
                                dialogFromSecondId = dialog.getId();
                            }
                        }
                    }

                    if (dialogFromFirstId == null || dialogFromSecondId == null) {
                        Dialog uploadedDialogFromFirst = null;
                        Dialog uploadedDialogFromSecond = null;

                        Dialog newDialogFromFirst = new Dialog(user, dialogUser, new ArrayList<>());
                        dialogRepo.save(newDialogFromFirst);
                        uploadedDialogFromFirst = dialogRepo.findByid(newDialogFromFirst.getId());

                        Dialog newDialogFromSecond = new Dialog(dialogUser, user, new ArrayList<>());
                        dialogRepo.save(newDialogFromSecond);
                        uploadedDialogFromSecond = dialogRepo.findByid(newDialogFromSecond.getId());


                        List<Dialog> userDialogList = user.getDialogList();
                        List<Dialog> secondUserToDialogList = dialogUser.getDialogList();

                        userDialogList.add(uploadedDialogFromFirst);
                        secondUserToDialogList.add(uploadedDialogFromSecond);

                        user.setDialogList(userDialogList);
                        dialogUser.setDialogList(secondUserToDialogList);

                        userRepo.save(dialogUser);
                        userRepo.save(user);
                    }
                }
            } else {
                //добавление друга
                if (futureFriend == null) {
                    model.addAttribute("userToCreateDialogNotFounded", false);
                    model.addAttribute("friendList", user.getFriendList());
                    model.addAttribute("friend", null);
                    model.addAttribute("user", user);
                    model.addAttribute("requestFriendCount", user.getFriendRequestList().size());
                    model.addAttribute("respondFriendCount", user.getFriendRespondList().size());
                    model.addAttribute("FriendListSize", user.getFriendList().size());

                    return "profile";
                } else {
                    if (!user.getFriendList().contains(futureFriend)
                            || !user.getFriendRespondList().contains(futureFriend)) {
                        List<User> listRespond = user.getFriendRespondList();
                        listRespond.add(futureFriend);

                        List<User> listRequest = futureFriend.getFriendRequestList();
                        listRequest.add(user);

                        userRepo.save(user);
                        userRepo.save(futureFriend);
                    }
                }
            }
        }
        model.addAttribute("userToCreateDialogNotFounded", false);
        model.addAttribute("friendList", user.getFriendList());
        model.addAttribute("friend", futureFriend);
        model.addAttribute("user", user);
        model.addAttribute("requestFriendCount", user.getFriendRequestList().size());
        model.addAttribute("respondFriendCount", user.getFriendRespondList().size());
        model.addAttribute("FriendListSize", user.getFriendList().size());
        return "profile";
    }

    @GetMapping("/confirmationrequest/{user}")
    public String getConfirmation(@PathVariable("user") User user,
                                  Model model) {
        List<User> userRequest = user.getFriendRequestList();

        model.addAttribute("futureFriendRequest", userRequest);

        return "confirmationFriendRequest";
    }

    @PostMapping("/confirmationrequest/{user}")
    public String postConfirmation(@PathVariable("user") User user,
                                   @RequestParam String design,
                                   @RequestParam Long secondUser,
                                   Model model) {
        User potentialFriend = userRepo.findByid(secondUser);

        switch (design) {
            case ("add"):
                List<User> userFriend = user.getFriendList();
                List<User> potentialFriendList = potentialFriend.getFriendList();
                userFriend.add(potentialFriend);
                potentialFriendList.add(user);

                user.setFriendList(userFriend);
                potentialFriend.setFriendList(potentialFriendList);

                List<User> userRequest = user.getFriendRequestList();
                List<User> potentialFriendRespond = potentialFriend.getFriendRespondList();
                if (userRequest.contains(potentialFriend)) {
                    userRequest.remove(potentialFriend);
                    user.setFriendRequestList(userRequest);
                    potentialFriendRespond.remove(user);
                    potentialFriend.setFriendRespondList(potentialFriendRespond);
                }

                List<User> userRespond = user.getFriendRespondList();
                List<User> potentialRequest = potentialFriend.getFriendRequestList();
                if (userRespond.contains(potentialFriend)) {
                    userRespond.remove(potentialFriend);
                    user.setFriendRespondList(userRespond);
                    potentialRequest.remove(user);
                    potentialFriend.setFriendRequestList(potentialRequest);
                }
                userRepo.save(user);
                userRepo.save(potentialFriend);
                break;
            case ("reject"):
                userRequest = user.getFriendRequestList();
                potentialFriendRespond = potentialFriend.getFriendRespondList();

                if (userRequest.contains(potentialFriend)) {
                    userRequest.remove(potentialFriend);
                    user.setFriendRequestList(userRequest);
                    potentialFriendRespond.remove(user);
                    potentialFriend.setFriendRespondList(potentialFriendRespond);
                }

                userRespond = user.getFriendRespondList();
                potentialRequest = potentialFriend.getFriendRequestList();
                if (userRespond.contains(potentialFriend)) {
                    userRespond.remove(potentialFriend);
                    user.setFriendRespondList(userRespond);
                    potentialRequest.remove(user);
                    potentialFriend.setFriendRequestList(potentialRequest);
                }
                userRepo.save(user);
                userRepo.save(potentialFriend);
                break;
            case ("noting"):
                break;
        }

        List<User> userRequest = user.getFriendRequestList();

        model.addAttribute("futureFriendRequest", userRequest);

        return "confirmationFriendRequest";
    }

    @GetMapping("/respondlist/{user}")
    public String getRespond(@PathVariable("user") User user,
                             Model model) {
        List<User> userRespond = user.getFriendRespondList();

        model.addAttribute("userRespond", userRespond);

        return "respond";
    }
}
